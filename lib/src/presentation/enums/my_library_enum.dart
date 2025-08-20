enum MyLibraryEnum { lists, liked, bookmarks, audiobooks, readers, login }

extension MyLibraryEnumExtension on MyLibraryEnum {
  String get title {
    switch (this) {
      case MyLibraryEnum.audiobooks:
        return 'Audiobooki';
      case MyLibraryEnum.readers:
        return 'Książki';
      case MyLibraryEnum.bookmarks:
        return 'Moje zakładki';
      case MyLibraryEnum.liked:
        return 'Polubione';
      case MyLibraryEnum.lists:
        return 'Moje listy';
      case MyLibraryEnum.login:
        return 'Zaloguj się';
    }
  }
}

List<MyLibraryEnum> get availableOfflineEnums {
  return [
    MyLibraryEnum.audiobooks,
    MyLibraryEnum.readers,
    MyLibraryEnum.bookmarks,
  ];
}

List<MyLibraryEnum> get availableOnlineAuthEnums {
  return [
    MyLibraryEnum.audiobooks,
    MyLibraryEnum.readers,
    MyLibraryEnum.lists,
    MyLibraryEnum.liked,
    MyLibraryEnum.bookmarks,
  ];
}

List<MyLibraryEnum> get availableOnlineNoAuthEnums {
  return [MyLibraryEnum.audiobooks, MyLibraryEnum.readers, MyLibraryEnum.login];
}
