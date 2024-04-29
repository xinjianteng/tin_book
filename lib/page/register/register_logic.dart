import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/api/apis.dart';
import '../../common/entity/entities.dart';
import 'register_state.dart';

class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();

  TextEditingController phoneEditer = TextEditingController();
  TextEditingController passwordEditer = TextEditingController();


  register() async{
    var phone = phoneEditer.text;
    var password = passwordEditer.text;
    phone = "15805930941";
    password = "123456";

    UserRegisterRequestEntity registerParams =
    UserRegisterRequestEntity(username: phone,email: "xxx", password: password);

    UserRegisterRequestEntity registerUser = await BmobAPI.register(params: registerParams);

  }

}
