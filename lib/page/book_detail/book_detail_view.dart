import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/style.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'book_detail_logic.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final logic = Get.put(BookDetailLogic());
  final state = Get.find<BookDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        titleWidget: const Text(AStrings.bookInfo),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      width: ScreenUtil().screenWidth,
      child: Stack(
        children: [
          Positioned(
            left: Dimens.margin,
            top: Dimens.margin,
            child: _buildBookCover(),
          ),
          Positioned(
            left: Dimens.margin * 2 + Dimens.bookWidthMAX,
            top: Dimens.margin,
            right: 0.h,
            child: _buildBookName(),
          ),
          Positioned(
            left: Dimens.margin * 2 + Dimens.bookWidthMAX,
            top: 86.h,
            right: 0.h,
            child: _buildBookAuthor(),
          ),
          Positioned(
            left: Dimens.margin,
            right: Dimens.margin,
            bottom: Dimens.margin,
            child: buildBtn(
              title: AStrings.addShelf,
              specs: Specs.max,
              onTap: () {
                logic.addShelf();
              },
            ),
          ),
          // Positioned(
          //   left: 16.w,
          //   right: Dimens.margin,
          //   top: Dimens.margin + Dimens.bookHeightMAX + 12.h,
          //   child: _buildNoteList(),
          // ),
        ],
      ),
    );
  }

  Widget _buildBookCover() {
    return DecoratedBox(
      decoration: DecorationStyle.bookDecoration(),
      child: netImageCached(
        state.book.bookCovers?[0] ?? "",
        radius: Dimens.bookCoverRadius,
        width: Dimens.bookWidthMAX,
        height: Dimens.bookHeightMAX,
      ),
    );
  }

  Widget _buildBookName() {
    return Text(
      logic.state.book.bookName ?? AStrings.unknownBookName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyleUnit.bookNameStyle2(),
    );
  }

  Widget _buildBookAuthor() {
    return Text(
      state.book.bookAuthor ?? AStrings.unknownAuthor,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyleUnit.bookAuthorStyle(),
    );
  }

  Widget _buildNoteList() {
    return Container(
      color: AppColors.pinkColor,
      child: ListView(
        children: [
          for (var item in state.notes!)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                '${item.noteContent}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyleUnit.bookNoteStyle(),
              ),
            ),
        ],
      ),
    );
  }


}
