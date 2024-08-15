import '../entity/entities.dart';
import '../utils/encrypt_utils.dart';
import '../utils/utils.dart';
import '../values/values.dart';

/// 用户
class CsgAPI {

  static const SecretKey="4CTZ7892m8xOba48efnN4PBgqXKEKU5J";

  /// 登录
  static Future<UserCsgLoginResponseEntity> login({
    UserCsgLoginRequestEntity? params,
  }) async {
    var timeStamp = AppUtils.getTime();
    var nonce = AppUtils.getNonce();
    Map<String, String> formData = {};
    formData["from"] = "App";
    formData["grant_type"] = "password";
    formData["loginType"] = "1";
    formData["nonce"] = nonce;
    formData["password"] = params!.password.toString();
    formData["scope"] = "app";
    formData["timestamp"] = timeStamp.toString();
    formData["username"] = params!.username.toString();
    var signStr = "";
    for (var key in formData.keys) {
      var value = formData[key];
      signStr = "${"$signStr$key=${value!}"}&";
    }
    signStr = "${signStr}secret_key=$SecretKey";
    formData["sign"] = EncryptUtils.encryptMd5(signStr).toUpperCase();

    var response = await HttpUtil().post(
      csgApiLogin,
      data: formData,
      baseUrl: csgHost,
    );
    return UserCsgLoginResponseEntity.fromJson(
        response as Map<String, dynamic>);
  }

  /// 图书列表  （含分组）
  static Future<PageListResponseEntity<UploadBook>> getBooks({
    PageListRequestEntity? params,
  }) async {
    var timeStamp = AppUtils.getTime();
    var nonce = AppUtils.getNonce();
    Map<String, String> formData = {};
    formData["current"] = params!.current.toString();
    formData["nonce"] = nonce;
    formData['size'] = params.size.toString();
    formData["timestamp"] = timeStamp.toString();

    var signStr = "";
    for (var key in formData.keys) {
      var value = formData[key];
      signStr = "$signStr$key=$value&";
    }
    signStr = "${signStr}secret_key=$SecretKey";
    formData["sign"] = EncryptUtils.encryptMd5(signStr).toUpperCase();
    var response = await HttpUtil().post(
      csgUploadBookInfo,
      data: formData,
      queryParameters: formData,
      baseUrl: csgHost,
    );

    return PageListResponseEntity.fromJson(
      response as Map<String, dynamic>,
      onDataFormat: (p1) {
        return List<UploadBook>.from(p1.map((x) => UploadBook.fromJson(x)));
      },
    );
  }

  /// 分组列表
  static Future<PageListResponseEntity> getGroupList() async {
    var timeStamp = AppUtils.getTime();
    var nonce = AppUtils.getNonce();
    Map<String, String> formData = {};
    formData["nonce"] = nonce;
    formData["timestamp"] = timeStamp.toString();
    var signStr = "";
    for (var key in formData.keys) {
      var value = formData[key];
      signStr = "$signStr$key=$value&";
    }
    signStr = "${signStr}secret_key=$SecretKey";
    formData["sign"] = EncryptUtils.encryptMd5(signStr).toUpperCase();

    var response = await HttpUtil().post(
      csgUploadBookGroupList,
      data: formData,
      queryParameters: formData,
      baseUrl: csgHost,
    );

    return PageListResponseEntity.fromJson(
      response as Map<String, dynamic>,
      onDataFormat: (p1) {
        return List<Group>.from(p1.map((x) => Group.fromJson(x)));
      },
    );
  }



  /// 分组列表
  static Future<PageListResponseEntity> getGroupBookList(String groupId) async {
    var timeStamp = AppUtils.getTime();
    var nonce = AppUtils.getNonce();
    Map<String, String> formData = {};
    formData["groupId"] = groupId;
    formData["nonce"] = nonce;
    formData['size'] = "30";
    formData["timestamp"] = timeStamp.toString();

    var signStr = "";
    for (var key in formData.keys) {
      var value = formData[key];
      signStr = "$signStr$key=$value&";
    }
    signStr = "${signStr}secret_key=$SecretKey";
    formData["sign"] = EncryptUtils.encryptMd5(signStr).toUpperCase();

    var response = await HttpUtil().post(
      csgUploadBookGroupBooks,
      data: formData,
      queryParameters: formData,
      baseUrl: csgHost,
    );

    return PageListResponseEntity.fromJson(
      response as Map<String, dynamic>,
      onDataFormat: (p1) {
        return List<UploadBook>.from(p1.map((x) => UploadBook.fromJson(x)));
      },
    );
  }


  /// 登录
  static Future<DownloadBookResponseEntity> downloadBook({
    required String bookId,
  }) async {
    var timeStamp = AppUtils.getTime();
    var nonce = AppUtils.getNonce();
    Map<String, String> formData = {};

    // formData['deviceModel'] = '2107119DC';
    // formData['deviceFactory'] = 'Xiaomi';
    // formData['osType'] = '1';
    // formData['deviceId'] = '2e33f78a-e0fb-4cd2-8193-f2efb7e8b3b0';
    formData['bookId'] = bookId.toString();
    // formData["scope"] = "app";
    formData["nonce"] = nonce;
    formData["timestamp"] = timeStamp.toString();

    var signStr = "";
    for (var key in formData.keys) {
      var value = formData[key];
      signStr = "${"$signStr$key=${value!}"}&";
    }
    signStr = "${signStr}secret_key=$SecretKey";
    formData["sign"] = EncryptUtils.encryptMd5(signStr).toUpperCase();
    var response = await HttpUtil().post(
      csgDownloadBook,
      data: formData,
      baseUrl: csgHost,
    );

    return DownloadBookResponseEntity.fromJson(
        response as Map<String, dynamic>);
  }
}
