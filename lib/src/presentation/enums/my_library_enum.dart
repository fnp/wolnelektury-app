enum MyLibraryEnum { lists, liked, bookmarks, audiobooks, readers }

extension MyLibraryEnumExtension on MyLibraryEnum {
  String get title {
    switch (this) {
      case MyLibraryEnum.audiobooks:
        return 'Audiobooki';
      case MyLibraryEnum.readers:
        return 'Czytniki';
      case MyLibraryEnum.bookmarks:
        return 'Moje zakładki';
      case MyLibraryEnum.liked:
        return 'Polubione';
      case MyLibraryEnum.lists:
        return 'Moje listy';
    }
  }

  bool get isAvailableOffline {
    switch (this) {
      case MyLibraryEnum.audiobooks:
      case MyLibraryEnum.readers:
        return true;
      case MyLibraryEnum.bookmarks:
      case MyLibraryEnum.liked:
      case MyLibraryEnum.lists:
        return false;
    }
  }
}
