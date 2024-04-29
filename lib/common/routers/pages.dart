import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../page/pages.dart';
import '../middlewares/middlewares.dart';
import 'routes.dart';


class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  ///别名映射页面
  static final routes = [

    GetPage(
      name: AppRoutes.INITIAL,
      page: () =>  WelcomePage(),
      transition: Transition.zoom,
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),


    GetPage(
      name: AppRoutes.SING_IN,
      page: () => SignInPage(),
    ),

    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
    ),

    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    GetPage(
      name: AppRoutes.bookDetail,
      page: () => BookDetailPage(),
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
      name: AppRoutes.bookReader,
      page: () => BookReaderPage(),
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

  ];



}
