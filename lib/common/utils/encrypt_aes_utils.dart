
//只有一个加密这么导入就行了
//如果同时使用了两个加密，很容易冲突，使用模块化导出即可
import 'package:encrypt/encrypt.dart' as encrypt;

import 'utils.dart';


class EncryptAesUtils{

  // /content：被加密数据，keyStr：加密key， ivStr
  static String encryptAES(String content, String keyStr, String ivStr) {
    logPrint("AES加密前的文本:$content");
    final plainText = content;
    final key = encrypt.Key.fromUtf8(keyStr);
    final iv = encrypt.IV.fromUtf8(ivStr);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final encryptStr = encrypted.base64;
    logPrint("AES加密后的文本:$encryptStr");
    return encryptStr;
  }

  static decryptAES(String content, String keyStr, String ivStr) {
    logPrint("AES解密前的文本:$content");
    final key = encrypt.Key.fromUtf8(keyStr);
    final iv = encrypt.IV.fromUtf8(ivStr);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final decrypted = encrypter.decrypt64(content, iv: iv);
    logPrint("AES解密后的文本:$decrypted");
  }

}