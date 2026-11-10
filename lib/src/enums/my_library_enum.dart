enum MyLibraryEnum {
  lists,
  liked,
  bookmarks,
  quotes,
  audiobooks,
  readers,
  login,
}

extension MyLibraryEnumExtension on MyLibraryEnum {
  String get title {
    switch (this) {
      case MyLibraryEnum.audiobooks:
        return 'Audiobooki';
      case MyLibraryEnum.readers:
        return 'Książki';
      case MyLibraryEnum.bookmarks:
        return 'Moje zakładki';
      case MyLibraryEnum.quotes:
        return 'Moje cytaty';
      case MyLibraryEnum.liked:
        return 'Polubione';
      case MyLibraryEnum.lists:
        return 'Moje listy';
      case MyLibraryEnum.login:
        return 'Logowanie';
    }
  }
}

List<MyLibraryEnum> get availableOfflineEnums {
  return [MyLibraryEnum.audiobooks, MyLibraryEnum.readers];
}

List<MyLibraryEnum> get availableOnlineAuthEnums {
  return [
    MyLibraryEnum.audiobooks,
    MyLibraryEnum.readers,
    MyLibraryEnum.lists,
    MyLibraryEnum.liked,
    MyLibraryEnum.bookmarks,
    MyLibraryEnum.quotes,
  ];
}

List<MyLibraryEnum> get availableOnlineNoAuthEnums {
  return [MyLibraryEnum.audiobooks, MyLibraryEnum.readers, MyLibraryEnum.login];
}
