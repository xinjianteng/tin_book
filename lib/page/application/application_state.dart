import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ApplicationState {
  // 当前 tab 页码
  final _page = 1.obs;

  set page(value) => _page.value = value;

  get page => _page.value;

  // tab 页标题
  late final List<String> tabTitles;

  List<Widget> tabImages = [
    _buildFrame('assets/tab_home_nor.png'),
    _buildFrame('assets/tab_bookcase_nor.png'),
    _buildFrame('assets/tab_profile_nor.png'),
  ];
  List<Widget> tabSelectedImages = [
    _buildFrame('assets/tab_home_sel.png'),
    _buildFrame('assets/tab_bookcase_sel.png'),
    _buildFrame('assets/tab_profile_sel.png'),
  ];

  ApplicationState() {
    ///Initialize variables
    ///
    // 准备一些静态数据
    tabTitles = ['Welcome', 'Cagegory', 'Bookmarks', 'Account'];
  }


  static Widget _buildFrame(String  path) {
    return  Container(
      margin: const EdgeInsets.only(top: 5),
      child: Image.asset(path),
    );
  }
}
