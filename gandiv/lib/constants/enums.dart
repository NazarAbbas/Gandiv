enum ButtonAction { submit, update }

class Status {
  static String get created => "Created";
  static String get drafted => "Drafted";
  static String get published => "Published";
  static String get all => "All";
  static String get approved => "Approved";
  static String get submitted => "Submitted";
}

class Language {
  static int get hindi => 1;
  static int get english => 2;
}

class Location {
  static String get varanasi => 'Varanasi';
  static String get agra => 'Agra';
}

class AppFontFamily {
  static String get hindiFontStyle => 'Poppins';
  static String get englishFontStyle => 'domine';
}

// class AppFontFamily {
//   static String get hindiFontStyle => '';
//   static String get englishFontStyle => '';
// }
