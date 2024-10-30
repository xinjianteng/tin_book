import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class BookshelfTips extends StatelessWidget {
  const BookshelfTips({super.key});

  final TextStyle textStyleBig = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  final TextStyle textStyle = const TextStyle(
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('(´。＿。｀)',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          const SizedBox(height: 50),
          Text(
            S.of(context).bookshelf_tips_1,
            style: textStyleBig,
          ),
          const SizedBox(height: 10),
          Text(
            S.of(context).bookshelf_tips_2,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
