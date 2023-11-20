import 'package:encrypt/encrypt.dart';

class EncryptionPassword {
  final key = Key.fromUtf8('12345678912345678912345678912345');
  final iv = IV.fromLength(16);

  encryptPassword(text, encrypter) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }
  decryptPassword(encrypted, Encrypter encrypter) {
    final decrypted = encrypter.decrypt64(encrypted, iv: iv);
    return decrypted;
  }


}
