import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  static GetStorage getStorage = GetStorage();
  static String isUserLoggedIn = 'isUserLoggedIn';
  static String tokens = 'tokens';
  static String userId = 'userId';
  static String organization = 'organization';

  /// FOR LOG IN
  static setUserLoggedIn() async {
    await getStorage.write(isUserLoggedIn, true);
  }

  static getUserLoggedInStatus() {
    return getStorage.read(isUserLoggedIn);
  }

  /// FOR EMAIL
  static setUserId(String value) async {
    await getStorage.write(userId, value);
  }

  static getUserId() {
    return getStorage.read(userId);
  }

  ///token
  static setToken(String? token) {
    getStorage.write(tokens, token);
  }

  static getToken() {
    return getStorage.read(tokens);
  }

  ///Organization
  static setOrganization(String? token) {
    getStorage.write(organization, token);
  }

  static getOrganization() {
    return getStorage.read(organization);
  }

  static logOut() {
    getStorage.erase();
  }
}
