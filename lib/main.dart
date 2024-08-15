import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/helpers/prefs_helper.dart';
import 'common/routers/pages.dart';
import 'common/theme.dart';
import 'common/translations.dart';
import 'common/utils/utils.dart';
import 'common/values/values.dart';
import 'init_app.dart';

Future<void>  main() async{
  await initApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ScreenUtilInit(
      designSize: Dimens.deviceSize,
      // 是否根据宽度/高度中的最小值适配文字
      minTextAdapt: true,
      // 支持分屏尺寸
      splitScreenMode: true,
      builder: (context, child) => RefreshConfiguration(
        // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
        // headerBuilder: () => const ClassicHeader(),
        // // 配置默认底部指示器
        // footerBuilder: () => const ClassicFooter(),

        headerBuilder: ()=> const ClassicHeader(
          //无特殊要求就可以用这个换下文案就行了
          height: 45.0,
          releaseText: '松开刷新',
          refreshingText: '刷新中',
          completeText: '刷新完成',
          idleText: '下拉刷新',
        ),
        footerBuilder: ()=> const ClassicFooter(
          //无特殊要求就可以用这个换下文案就行了
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(microseconds: 50),
          canLoadingText: '松开刷新',
          noDataText: '没有更多数据啦',
          loadingText: '刷新中',
          idleText: '上拉加载',
        ),
        // Viewport不满一屏时,禁用上拉加载更多功能
        hideFooterWhenNotFull: true,
        // 头部触发刷新的越界距离
        headerTriggerDistance: 80.h,
        //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
        maxOverScrollExtent: 100.h,
        // 尾部触发刷新的越界距离
        footerTriggerDistance: 150.h,
        // 底部最大可以拖动的范围
        maxUnderScrollExtent: 0,
        //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
        enableScrollWhenRefreshCompleted: true,
        //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
        enableLoadingWhenFailed: true,
        // 可以通过惯性滑动触发加载更多
        enableBallisticLoad: true,
        child: DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AStrings.appName,
            locale: const Locale('zh', 'CN'),
            fallbackLocale: const Locale('en', 'US'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('zh', 'CN'),
            ],
            translations: AppTranslations(),
            theme: buildLightTheme(lightDynamic),
            darkTheme: buildDarkTheme(darkDynamic),
            themeMode: [
              ThemeMode.system,
              ThemeMode.light,
              ThemeMode.dark,
            ][PrefsHelper.themeMode],
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            builder: EasyLoading.init(),

            navigatorObservers: [AppPages.observer],

            enableLog: true,
            logWriterCallback: LoggerUtil.write,
          );
        },),

      ),
    );
  }




}
