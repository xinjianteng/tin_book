import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tin_book/page/setting/appearance_settings/appearance_settings_view.dart';
import 'package:tin_book/page/setting/setting_view.dart';

import '../../page/pages.dart';
import '../../page/setting/about_app/about_app_view.dart';
import '../../page/setting/language/language_view.dart';
import '../middlewares/middlewares.dart';
import 'routes.dart';


class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  ///别名映射页面
  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.INITIAL,
      page: () =>  const WelcomePage(),
      transition: Transition.zoom,
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),


    GetPage(
      name: AppRoutes.SING_IN,
      page: () => const SignInPage(),
    ),

    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterPage(),
    ),

    GetPage(
      name: AppRoutes.Application,
      page: () => const ApplicationPage(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    GetPage(
      name: AppRoutes.bookDetail,
      page: () => const BookDetailPage(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    // GetPage(
    //   name: AppRoutes.reader,
    //   page: () => ReaderPage(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),

    GetPage(
      name: AppRoutes.readering,
      page: () => const ReadingPage(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),



    GetPage(
      name: AppRoutes.bookMain,
      page: () => BookMainPage(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),




    GetPage(
      name: AppRoutes.setting,
      page: () => SettingPage(),
    ),

    GetPage(
      name: AppRoutes.languageSettings,
      page: () => LanguagePage(),
    ),

    GetPage(
      name: AppRoutes.aboutApp,
      page: () => AboutAppPage(),
    ),

    GetPage(
      name: AppRoutes.appearanceSettings,
      page: () => AppearanceSettingsPage(),
    ),

  ];



}
