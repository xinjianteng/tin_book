import 'package:get/get.dart';


class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  bool get isRelease => bool.fromEnvironment("dart.vm.product");


  @override
  void onInit() {
    super.onInit();
  }








}
