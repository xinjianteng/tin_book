import 'package:flutter/material.dart';

import '../../../models/book.dart';
import 'widget_title.dart';


class ReadingNotes extends StatelessWidget {
  const ReadingNotes({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetTitle(context.navBarNotes, null),
          Expanded(
            child: ListView(children: [bookNotesList(book.id)]),
          ),
        ],
      ),
    );
  }
}
