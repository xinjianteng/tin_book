import 'dart:convert';

import 'package:get/get.dart';

import '../entity/entities.dart';
import '../utils/utils.dart';
import '../values/values.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 用户 profile
   Rx<UserCsgLoginResponseEntity> _profile = UserCsgLoginResponseEntity().obs;

  UserCsgLoginResponseEntity get profile => _profile.value;


  // 是否登录
  final _isLogin = false.obs;

  bool get isLogin => _isLogin.value;

  // 令牌 token
  String token = '';

  @override
  void onInit() {
    super.onInit();
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _profile(UserCsgLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
      _isLogin.value=true;
      token=profile.access_token!;
    }
  }

  /// 保存 profile
  Future<void> saveProfile(UserCsgLoginResponseEntity profile) async {
    _isLogin.value = true;
    token=profile.access_token!;
    _profile.value=profile;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
  }



  /// 保存 profile
  Future<void> cleanProfile() async {
    _isLogin.value = false;
    token="";
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, "");
  }


  /// 保存 图书信息
  Future<void> saveBook(UploadBook book) async {
    StorageService.to.setString(book.bookId!, jsonEncode(book));
  }

  /// 获取 图书信息
  Future<UploadBook> getBook(String bookId) async {
    var bookValue = StorageService.to.getString(bookId);
    return UploadBook.fromJson(jsonDecode(bookValue));
  }



}
