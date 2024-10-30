import 'dart:convert';

import 'package:get/get.dart';
import 'package:tin_book/common/helpers/prefs_helper.dart';

import '../entity/entities.dart';

class UserStore extends GetxController {
  static UserStore get user => Get.find();

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
    var profileOffline = Prefs().userinfo;
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
     Prefs().updateUserInfo(jsonEncode(profile));
  }



  /// 保存 profile
  Future<void> cleanProfile() async {
    _isLogin.value = false;
    token="";
    Prefs().updateUserInfo('');
  }






}
