
import '../entity/entities.dart';
import '../utils/utils.dart';
import '../values/values.dart';

/// 用户
class BmobAPI {

  /// 登录
  static Future<UserLoginResponseEntity> login({
    UserLoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().get(
      '/1/login',
      queryParameters: params?.toJson(),
      baseUrl: BMOB_API_HOST,
    );

    return UserLoginResponseEntity.fromJson(response as Map<String, dynamic>);
  }


  /// 注册
  static Future<UserRegisterRequestEntity> register({
    UserRegisterRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/1/users',
      queryParameters: params!.toJson(),
      baseUrl: BMOB_API_HOST,
    );

    // var response =DioUtil().request( '/1/users',method: DioMethod.post,params: params!.toJson());

    return UserRegisterRequestEntity.fromJson(response as Map<String, dynamic>);
  }



}
