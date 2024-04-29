import 'dart:convert';

import 'package:get/get.dart';
import 'package:tin_book/common/helpers/helpers.dart';

import '../entity/entities.dart';
import '../utils/utils.dart';
import '../values/values.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 用户 profile
  final Rx<UserCsgLoginResponseEntity> _profile = UserCsgLoginResponseEntity().obs;

  UserCsgLoginResponseEntity get profile => _profile.value;


  // 是否登录
  final _isLogin = false.obs;

  bool get isLogin => _isLogin.value;

  // 令牌 token
  String token = '';

  @override
  void onInit() {
    super.onInit();
    if (PrefsHelper.userProfile.isNotEmpty) {
      _profile(UserCsgLoginResponseEntity.fromJson(jsonDecode(PrefsHelper.userProfile)));
      _isLogin.value=true;
      token=profile.access_token!;
    }
  }

  /// 保存 profile
  Future<void> saveProfile(UserCsgLoginResponseEntity profile) async {
    _isLogin.value = true;
    token=profile.access_token!;
    _profile.value=profile;
    PrefsHelper.updateUserProfile(jsonEncode(profile));
  }



  /// 保存 profile
  Future<void> cleanProfile() async {
    _isLogin.value = false;
    token="";
    PrefsHelper.updateUserProfile('');
  }




}
