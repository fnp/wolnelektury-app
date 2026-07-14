# Wolne Lektury

Aplikacja mobilna do czytania i słuchania książek z serwisu [wolnelektury.pl](https://wolnelektury.pl).

---

## Spis treści

- [Uruchamianie](#uruchamianie)
- [Generowanie lokalizacji](#generowanie-lokalizacji)
- [Architektura czytnika](#architektura-czytnika)

---

## Uruchamianie

```bash
flutter pub get
flutter run
```

---

## Generowanie lokalizacji

```bash
flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart --source-dir ./assets/translations
```

---

## Architektura czytnika

Poniżej opisano blokowy przepływ renderowania widoku czytnika (`ReaderPage`).

### 1. Wejście — `ReaderPage`

- Przyjmuje `BookModel` lub `slug` książki.
- Jeśli brak `BookModel` → `SingleBookCubit` pobiera dane z API.
- Tworzy `ReaderPageCubit` oraz `BookmarksCubit`.
- Przekazuje `ItemScrollController` do głębszych warstw widżetów.

---

### 2. Ładowanie danych — `ReaderPageCubit.init()`

| Krok           | Opis                                                                                   |
| -------------- | -------------------------------------------------------------------------------------- |
| ① Ustawienia   | Wczytuje rozmiar/typ czcionki i interlinię z `AppStorageSettingsService`               |
| ② JSON książki | Pobiera `GET /books/{slug}.json` (online) lub lokalny plik (offline)                   |
| ③ Sync audio   | Pobiera `GET /books/{slug}/sync` → `List<BookTextAudioSyncModel>` (timestamp → anchor) |
| ④ Emisja stanu | Emituje `ReaderPageState` z `readerBook`, ustawieniami czcionki itd.                   |

---

### 3. Model danych — `ReaderBookModel`

Struktura danych jest drzewem rekurencyjnym:

```
ReaderBookModel
├── headerLeft   (ReaderBookModelContent)  — lewa strona nagłówka
├── headerRight  (ReaderBookModelContent)  — prawa strona nagłówka
└── masterContent → contents: List<ReaderBookModelContent>

ReaderBookModelContent
├── tag: ReaderBookTag  (p, h2, h3, div, em, img, …)
├── id: String?         (anchor do przewijania i synchronizacji audio)
├── attr: Map?          (class, src, href, …)
├── paragraphIndex, visibleNumber
└── contents: List<ReaderBookContentItem>
    ├── ReaderBookText          (liść — czysty tekst)
    └── ReaderBookModelContent  (zagnieżdżony węzeł)
```

---

### 4. Lista elementów — `ReaderListViewBuilder`

Wirtualizowana lista oparta na `ScrollablePositionedList`:

```
item[0]   → _Header          (front1 / front2 z ReaderBookModel)
item[n]   → contents[n-1]

Każdy element:
SelectionArea
└── Stack
    ├── ReaderYellowBackground   (podświetlenie zaznaczonego akapitu)
    ├── ReaderBreathingBackground (animacja tła przy synchronizacji audio)
    └── ReaderParagraph        (właściwy tekst)

VisibilityDetector → przy wejściu w widok: cubit.setProgress(anchor)
```

---

### 5. Renderowanie tekstu — 3-poziomowy system spanów

`ReaderParagraph` buduje `RichText` z listy `InlineSpan` zwróconej przez rekurencyjny pipeline:

```
buildReaderBase          [poziom 0 — klasy specjalne, obrazy]
└── buildReaderTagLevelModifiers    [poziom tag — h2/h3/p/em/…]
    └── buildReaderClassLevelModifiers  [poziom CSS class]
```

Wynikiem jest `List<InlineSpan>` (`TextSpan` + `WidgetSpan`). Każdy węzeł drzewa jest przetwarzany rekurencyjnie.

---

### 6. Synchronizacja audio / podświetlanie

Komponent `_HighlightedParagraphListener` nasłuchuje `AudioCubit`:

- Co 3 sekundy pozycji audio → `cubit.highlightParagraph()`
  - Szuka pary `timestamp → anchor` w `audioSyncPairs`
  - `findElementIndexByElementId(anchor)` → `ScrollablePositionedList.scrollTo()`
- Po zatrzymaniu audio → `cubit.stopHighlighting()`

---

### 7. Postęp czytania

| Mechanizm               | Działanie                                                                                           |
| ----------------------- | --------------------------------------------------------------------------------------------------- |
| `VisibilityDetector`    | Przy wejściu elementu w widok → `setProgress(anchor)` → zapis w `ProgressRepository` (debouncowany) |
| `ItemPositionsListener` | Śledzi ostatni widoczny indeks → `setVisualProgress()` → pasek w `ReaderPageProgressIndicator`      |
| Inicjalizacja           | `getProgressByBook()` → `scrollTo(anchor)` — przywrócenie miejsca czytania                          |

---

### Kluczowe zależności

| Warstwa | Klasa                                          | Odpowiedzialność                 |
| ------- | ---------------------------------------------- | -------------------------------- |
| State   | `ReaderPageCubit` / `ReaderPageState`          | Cały stan czytnika               |
| Dane    | `BooksRepository`                              | Pobieranie JSON + sync audio     |
| Model   | `ReaderBookModel` / `ReaderBookModelContent`   | Drzewo treści książki            |
| Lista   | `ReaderListViewBuilder`                        | Wirtualizowana lista elementów   |
| Tekst   | `buildReaderBase` → tag → class                | Rekurencyjny render spanów       |
| Audio   | `_HighlightedParagraphListener`                | Mapowanie pozycji audio → akapit |
| Postęp  | `VisibilityDetector` + `ItemPositionsListener` | Zapis i wizualizacja postępu     |
