import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/book.dart';
import '../book_notes/book_notes_list.dart';
import 'widget_title.dart';


class ReadingNotes extends StatelessWidget {
  const ReadingNotes({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetTitle(S.of(context).navBar_notes, null),
          Expanded(
            child:
                ListView(children: [BookNotesList(book: book, reading: true)]),
          ),
        ],
      ),
    );
  }
}
