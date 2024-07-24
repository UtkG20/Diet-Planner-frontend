import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  //using underscore in the start makes your variable or methods private
  AuthService._privateConstructor();

  //using static final means the variable can not be instantiated again , and the variable belongs to class not any specific instance
  static final AuthService _instance = AuthService._privateConstructor();

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  //factory takes care that the instance is created only once and next time same instance is being shared
  factory AuthService() {
    return AuthService._privateConstructor();
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
    print("inside write");
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
