// import 'package:epub_view/epub_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../common/utils/utils.dart';
// import '../../common/widgets/app.dart';
// import 'reader_logic.dart';
//
// class ReaderPage extends StatefulWidget {
//   const ReaderPage({super.key});
//
//   @override
//   State<ReaderPage> createState() => _ReaderPageState();
//
//
// }
//
// class _ReaderPageState extends State<ReaderPage> {
//   final logic = Get.put(ReaderLogic());
//   final state = Get.find<ReaderLogic>().state;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ReaderLogic>(
//       assignId: true,
//       builder: (logic) {
//         return Scaffold(
//           appBar: commonAppBar(
//               titleWidget: EpubViewActualChapter(
//                   controller: logic.epubController,
//                   builder: (chapterValue) => Text(
//                         chapterValue?.chapter?.Title
//                                 ?.replaceAll('\n', '')
//                                 .trim() ??
//                             '',
//                         textAlign: TextAlign.start,
//                       )),
//               leading:  BackButton(
//                 onPressed: (){
//                   logic.updateReadProgress();
//                 },
//               ),),
//           endDrawer: Drawer(
//             child: EpubViewTableOfContents(
//               controller: logic.epubController,
//             ),
//           ),
//           // Show epub document
//           body: EpubView(
//             controller: logic.epubController,
//           ),
//         );
//       },
//     );
//   }
//
//
//   @override
//   void dispose() {
//
//     super.dispose();
//   }
// }
