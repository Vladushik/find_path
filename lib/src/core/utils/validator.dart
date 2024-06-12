abstract final class Validator {
  static bool isUrlValid(String url) {
    const baseUrl = 'https://flutter.webspark.dev/flutter/api';
    return url == baseUrl;
    // final Uri? uri = Uri.tryParse(url);
    // final bool result = uri != null &&
    //     uri.isAbsolute &&
    //     (uri.scheme == 'https' || uri.scheme == 'http');
    // return result;
  }
}
