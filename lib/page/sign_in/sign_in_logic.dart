import 'package:get/get.dart';

import '../../common/api/apis.dart';
import '../../common/entity/entities.dart';
import '../../common/routers/routes.dart';
import '../../common/store/user_store.dart';
import '../../common/utils/utils.dart';
import 'sign_in_state.dart';

/// 登录逻辑控制类，负责处理登录相关的业务逻辑
class SignInLogic extends GetxController {
  final SignInState state = SignInState();

  /// 使用CSG登录接口进行登录
  login() async {
    // loginByBmob();

    loginByCsg();
  }

  /// 使用CSG登录接口进行登录的实现
  /// 步骤包括：清除旧用户信息、创建登录请求参数、发送登录请求、保存登录用户信息、跳转到应用页面
  loginByCsg() async {
    // 清除之前的用户信息
    UserStore.user.cleanProfile();
    // 创建登录请求参数，包含用户名和经过AES加密的密码
    UserCsgLoginRequestEntity csgParams = UserCsgLoginRequestEntity(
        username: "APP@+86 19959271454",
        password: EncryptAesUtils.encryptAES(
            "a123456", "gbcloudgbcloudgb", "gbcloudgbcloudgb"));
    // 向CSG API发送登录请求，并获取登录响应
    UserCsgLoginResponseEntity csgUser = await CsgAPI.login(params: csgParams);


    // 保存登录用户的信息
    UserStore.user.saveProfile(csgUser).then((value) => {
          // 登录成功后，跳转到应用页面
          Get.offAndToNamed(AppRoutes.Application)
        });
  }

  /// 使用Bmob登录接口进行登录
  /// 步骤包括：创建登录请求参数、发送登录请求、（待实现）保存用户信息、跳转到初始化页面
  loginByBmob() async {
    // 创建登录请求参数，使用手机号作为用户名和密码
    UserLoginRequestEntity params = UserLoginRequestEntity(
        username: state.mobileStr.value, password: state.mobileStr.value);
    // 向Bmob API发送登录请求，并获取登录响应
    UserLoginResponseEntity user = await BmobAPI.login(params: params);
    //  TODO: 注释掉的代码，应该是登录成功后保存用户信息的逻辑
    // UserStore.to.saveProfile(user.);
    // 登录成功后，跳转到初始化页面
    Get.offAndToNamed(AppRoutes.INITIAL);
  }

  /// 输入变化时的回调处理，当前为空实现，可根据需要进行扩展
  onChanged(String value) {}
}
