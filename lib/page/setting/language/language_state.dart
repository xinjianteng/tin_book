import 'package:get/get.dart';

import '../../../common/helpers/prefs_helper.dart';


class LanguageState {

  RxString language = ''.obs;

  LanguageState() {
    ///Initialize variables
   language= Prefs().language.obs;
  }
}
