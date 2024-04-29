import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import 'application_state.dart';

class ApplicationLogic extends GetxController {
  final ApplicationState state = ApplicationState();



  // 页控制器
  late final PageController pageController;

  // 底部导航项目
  // 自定义类 - 可以是任何类
  final bottomTabs = Rx<List<BottomNavigationBarItem>>([]);

  @override
  void onInit() {
    super.onInit();

    bottomTabs.value = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.home,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.home,
          color: AppColors.secondaryText,
        ),
        label: 'main',
        backgroundColor: AppColors.primaryBackground,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.grid,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.grid,
          color: AppColors.secondaryText,
        ),
        label: 'category',
        backgroundColor: AppColors.primaryBackground,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.tag,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.tag,
          color: AppColors.secondaryText,
        ),
        label: 'tag',
        backgroundColor: AppColors.primaryBackground,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.me,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.me,
          color: AppColors.secondaryText,
        ),
        label: 'my',
        backgroundColor: AppColors.primaryBackground,
      ),
    ];
    pageController = PageController(initialPage: state.page);
    update();
  }


  // tab栏动画
  void handleNavBarTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page = page;
  }


}
