class Endpoints {
  Endpoints._();
  static const String accessKey = "ZFmSAS55aUNa5fBW9fQusq1ST110tp-uhqOFdYaDvU4";
  static const String baseUrl = "https://api.unsplash.com";
  static String getPhotoUrl(int limit) => baseUrl + "/photos/random?client_id=" + accessKey + "&count=$limit";
}