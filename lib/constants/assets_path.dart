final String imageAssetsRoot = "assets/images/";

final String login = _getImagePath("login.svg");
final String register = _getImagePath("register.svg");

String _getImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}
