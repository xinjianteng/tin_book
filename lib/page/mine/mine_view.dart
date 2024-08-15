import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/routers/routes.dart';
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
        titleWidget:  Text(AStrings.mine),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.setting);
            },
            icon: Icon(Icons.settings),
          ),
        ]
      ),
      body: buildBody2(),
    );
  }


  Widget buildBody2(){
    return SafeArea(child: ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      children: [


        ListItemCard(
          trailing: const Icon(Icons.book),
          title: '所有图书',
          onTap: () {
            Get.toNamed(AppRoutes.bookMain);
          },
        ),
        SizedBox(height: Dimens.margin),
        ListItemCard(
          trailing: const Icon(Icons.logout),
          title: AStrings.logout.tr,
          onTap: () {
            logic.logout();
          },
        ),
      ],
    ));
  }






}
