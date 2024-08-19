import 'package:get/get.dart';

import 'values/values.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          // 语言设置
          AStrings.languageSettings: '语言设置',
          AStrings.systemLanguage: '系统语言',
          AStrings.setting: '设置',

          // 主题设置
          AStrings.appearanceSettings: '外观设置',
          AStrings.themeMode: '主题模式',
          AStrings.systemMode: '跟随系统',
          AStrings.lightMode: '浅色模式',
          AStrings.darkMode: '深色模式',
          AStrings.useDynamicColor: '使用动态颜色',
          AStrings.dynamicColorInfo: '需要 Android 版本不小于 12',
          AStrings.textScale: '字体缩放',
          AStrings.globalFont: '全局字体',
          AStrings.defaultFont: '默认字体',
          AStrings.importFont: '导入字体',

          // 检查更新
          AStrings.checkUpdate: '检查更新',
          AStrings.checkingForUpdates: '正在检查更新',
          AStrings.alreadyLatestVersion: '已是最新版本',
          AStrings.newVersionAvailable: '发现新版本',
          AStrings.downloadInfo: '是否立即下载新版本？',
          AStrings.downloadNow: '立即下载',
          AStrings.temporarilyCancel: '暂时取消',
          AStrings.checkUpdateError: '检查更新失败',

          // 关于应用
          AStrings.aboutApp: '关于应用',
          AStrings.sourceAddress: '开源地址',
          AStrings.contactAuthor: '联系作者',

          // 登录注册
          AStrings.logout: '退出',

          //阅读器
          AStrings.reading_page_copy: "复制",
          AStrings.reading_page_excerpt: "划线",
          AStrings.reading_page_theme: "主题",
          AStrings.reading_page_style: "样式",
          AStrings.reading_page_full_screen: "全屏",
          AStrings.reading_page_screen_timeout: "屏幕超时",
          AStrings.reading_page_page_turning_method: "翻页方式",
          AStrings.readingImportSuccess: "导入成功",
          AStrings.notes_page_copied: "已复制",
          AStrings.notes_page_exported_to: "导出至",


          /// 通用
          AStrings.home: '首页',
          AStrings.empty: '暂无数据',
          'ok': '确定',
          'cancel': '取消',
          'info': '提示',
          'error': '错误',

          /// 主页
          'markAllAsRead': '全标已读',
          'fullTextSearch': '全文搜索',
          'addFeed': '添加订阅',
          'moreSettings': '更多设置',
          'allFeeds': '全部订阅',
          'refreshSuccess': '刷新成功',
          'refreshSuccessInfo': '共刷新 @count 个订阅源',
          'refreshError': '刷新失败',
          'refreshErrorInfo': '@count 个订阅源刷新失败',
          'noFeeds': '暂无订阅源',
          'noFeedsInfo': '添加订阅源后再刷新',

          /// 阅读
          'markAsUnread': '标记未读',
          'markAsFavorite': '标记收藏',
          'cancelFavorite': '取消收藏',
          'copyLink': '复制链接',
          'sharePost': '分享文章',
          'loading': '加载中',
          'fullTextLoading': '正在获取全文',
          'imageLoading': '图片加载中',
          'imageLoadError': '图片加载失败',

          /// 添加订阅源
          'feedAddress': '订阅源地址',
          'pasteAddress': '粘贴',
          'resloveAddress': '解析',
          'resolveError': '订阅源地址解析错误',
          'feedExist': '该订阅源已存在',

          /// 编辑订阅
          'editFeed': '编辑订阅',
          'feedTitle': '订阅源标题',
          'feedCategory': '订阅源分类',
          'defaultCategory': '默认分类',
          'fullText': '获取全文',
          'openType': '打开方式',
          'openInApp': '应用内打开',
          'openInAppBrowser': '应用内便签页打开',
          'openInSystemBrowser': '系统浏览器打开',
          'saveFeed': '保存订阅',
          'deleteFeed': '取消订阅',

          /// 设置页面

          // 屏幕刷新率
          'screenRefreshRate': '屏幕帧率',
          'autoRate': '自动',
          // 阅读设置
          'readSettings': '阅读设置',
          'fontSize': '字体大小',
          'lineHeight': '行高',
          'pagePadding': '页面边距',
          'textAlign': '文字对齐',
          'leftAlign': '左对齐',
          'rightAlign': '右对齐',
          'centerAlign': '居中对齐',
          'justifyAlign': '两端对齐',
          // 刷新设置
          'refreshSettings': '刷新设置',
          'refreshOnStartup': '启动时刷新',
          'refreshOnStartupInfo': '启动应用时刷新订阅源',
          // 屏蔽设置
          'blockSettings': '屏蔽设置',
          'addBlockWord': '添加屏蔽词',
          'blockWord': '屏蔽词',
          // 代理设置
          'proxySettings': '代理设置',
          'useProxy': '使用代理',
          'useProxyInfo': '重启应用后生效',
          'proxyAddress': '代理地址',
          'proxyPort': '代理端口',
          'addressAndPortCannotBeEmpty': '代理地址和端口不能为空',
          // 导入导出
          'importOPML': '导入 OPML',
          'importError': '导入错误',
          'importErrorInfo': '仅支持 OPML 或 XML 文件。',
          'startImport': '开始导入',
          'importResult': '导入结果',
          'importResultInfo': '共发现 @allCount 个订阅源，导入成功 @successCount 个。',
          'importSuccess': '导入成功',
          'exportOPML': '导出 OPML',
          'exportSuccess': '导出成功',
        },
        'en_US': {}
      };
}
