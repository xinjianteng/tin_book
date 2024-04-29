import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/routers/routes.dart';
import '../../common/style/style.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'mine_logic.dart';

class MinePage extends StatelessWidget {

  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: commonAppBar(
        titleWidget: const Text(AStrings.mine),
      ),
      body: buildBody(),
    );
  }


  Widget buildBody() {
    return Container(
      margin: EdgeInsets.all(Dimens.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: Dimens.margin * 2),
          _buildLogoutBtn("退出",logic.logout),
          _buildLogoutBtn("所有图书",(){
            Get.toNamed(AppRoutes.bookMain);
          }),

        ],
      ),
    );
  }



  Widget _buildLogoutBtn(String title, Function() function,) {
    return TextButton(
      style: TextStyleUnit.btnStyle(),
      onPressed: function,
      child: Text(
        title,
        style: TextStyleUnit.btnTextStyle(),
      ),
    );
  }

}
