class LocalServiceKeys {
  // indikator open landing page hanya sekali
  static const String ARGUMENT_FIRST_LANDING = "first_landing";

  // menyimpan bahasa aplikasi
  static const String ARGUMENT_LANG = "lang";

  // usahakan mqtt client identifier tidak berubah saat login lagi ya
  // jika usernya tetap sama
  static const String ARGUMENT_MQTT_CLIENT_ID = "mqtt_client_identifier";

  // menyimpan user id
  static const String ARGUMENT_LOGGED_USER_ID = "logged_user_id";

  // save path background dashboard
  static const String ARGUMENT_PATH_DASHBOARD = "path_dashboard_background";

  // untuk save refresh token
  static const String ARGUMENT_REFRESH_TOKEN_USER = "refresh_token_user";
  static const String ARGUMENT_REFRESH_TOKEN_APP = "refresh_token_app";
  static const String ARGUMENT_REFRESH_TOKEN_DEVICE = "refresh_token_device";

  // untuk show hide menu alice
  static const String ARGUMENT_SHOW_HIDDEN_MENU = "show_hidden_menu";

  // save theme id agar waktu buka ulang aplikasi tidak berubah
  static const String ARGUMENT_THEME_ID = "theme_id";

  static const String SHOW_TIPS_ON_STARTUP = "show_tips_on_startup";


  /*
    int minDays; // berapa hari setelah install
  int minLaunches; // berapa kali launch
  int minuteDuration; // berapa menit durasi memakai aplikasi

  int addedDevices; // berapa devices yang sudah ditambahkan
  int createdWidgets; // berapa widgets yang sudah dibuat
   */

  static const String RATE_FIRST_LAUNCH_DATE = "rate_first_launch_date";
  static const String RATE_LAUNCH_COUNTER = "rate_launch_counter";
  static const String RATE_REVIEW_LAUNCH_DATE = "rate_review_launch_date";

  static const String RATE_DEVICES_ADDED = "rate_devices_added";
  static const String RATE_WIDGETS_CREATED = "rate_widgets_created";
}
