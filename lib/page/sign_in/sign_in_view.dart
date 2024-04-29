import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/routers/routes.dart';
import '../../common/style/style.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'sign_in_logic.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SignInLogic());
    final state = Get.find<SignInLogic>().state;
    return Scaffold(
      backgroundColor: AppColors.appBg,
      appBar: commonAppBar(
        titleWidget: const Text(AStrings.login),
      ),
      body: buildBody(logic),
    );
  }

  Widget buildBody(SignInLogic logic) {
    return Container(
      margin: EdgeInsets.all(Dimens.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPhone(logic),
          SizedBox(height: Dimens.margin),
          _buildPassword(logic),
          SizedBox(height: Dimens.margin * 2),
          _buildLoginBtn(logic),
          SizedBox(height: Dimens.margin),
          _buildRegisterBtn(logic),
        ],
      ),
    );
  }

  ///输入框——手机号
  Widget _buildPhone(SignInLogic logic) {
    return CupertinoTextField(
      keyboardType: TextInputType.phone,
      style: TextStyleUnit.input,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      showCursor: true,
      onChanged: (String value) {
        logic.state.mobileStr.value = value;
      },
      placeholder: "请输入手机号",
    );
  }

  ///输入框——密码
  Widget _buildPassword(SignInLogic logic) {
    return CupertinoTextField(
      keyboardType: TextInputType.visiblePassword,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      style: TextStyleUnit.input,
      onChanged: (String value) {
        logic.state.mobileStr.value = value;
      },
      placeholder: "请输入密码，默认密码123456",
    );
  }

  ///登录按钮
  Widget _buildLoginBtn(SignInLogic logic) {
    return TextButton(
      style: TextStyleUnit.btnStyle(),
      onPressed: logic.login,
      child: Text(
        '登录',
        style: TextStyleUnit.btnTextStyle(),
      ),
    );
  }

  ///注册按钮
  Widget _buildRegisterBtn(SignInLogic logic) {
    return TextButton(
      style: TextStyleUnit.btnStyle(),
      onPressed: () {
        Get.toNamed(AppRoutes.REGISTER);
      },
      child: Text(
        '注册',
        style: TextStyleUnit.btnTextStyle(),
      ),
    );
  }
}
