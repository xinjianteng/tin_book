import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'register_logic.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(RegisterLogic());
    final state = Get.find<RegisterLogic>().state;

    return Scaffold(
      appBar: commonAppBar(
        titleWidget: const Text(AStrings.register),
        leading: const BackButton(
          color: AppColors.btn,
        ),
      ),
      body: buildBody(logic),
    );
  }

  Widget buildBody(RegisterLogic logic) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildPhone(logic),
              const SizedBox(height: 10),
              buildPassword(logic),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primary,
                ),
                height: 40,
                child: TextButton(
                  onPressed: logic.register,
                  child: const Text(
                    '注册',
                    style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildPhone(RegisterLogic logic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: logic.phoneEditer,
        keyboardType: TextInputType.phone,
        style: const TextStyle(fontSize: 14, color: AppColors.primaryText),
        decoration: const InputDecoration(
          hintText: '请输入手机号',
          hintStyle: TextStyle(color: AppColors.secondaryText),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildPassword(RegisterLogic logic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: logic.passwordEditer,
        keyboardType: TextInputType.visiblePassword,
        style: const TextStyle(fontSize: 14, color: AppColors.primaryText),
        decoration: const InputDecoration(
          hintText: '请输入密码，默认密码123456',
          hintStyle: TextStyle(color: AppColors.secondaryText),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
