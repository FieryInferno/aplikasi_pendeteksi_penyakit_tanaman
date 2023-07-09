class Constants {
  static String baseUrl = 'toko-dizital.et.r.appspot.com';
  static Map<String, Uri> url = {
    'login': Uri.https(baseUrl, '/api/v1/auth/login/'),
    'getAuth': Uri.https(baseUrl, '/api/v1/auth/user/'),
    'editProfile': Uri.https(baseUrl, '/api/v1/auth/edit-profile/'),
    'detectDisease': Uri.https(baseUrl, '/api/v1/disease/'),
    'blogs': Uri.https(baseUrl, '/api/v1/blog'),
  };
}
