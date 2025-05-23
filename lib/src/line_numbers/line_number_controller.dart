import 'package:flutter/widgets.dart';

class LineNumberController extends TextEditingController {
  final TextSpan Function(int, TextStyle?, bool)? lineNumberBuilder;

  int? activeLine;

  LineNumberController(
    this.lineNumberBuilder,
  );

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    bool? withComposing,
  }) {
    final children = <InlineSpan>[];
    final list = text.split('\n');

    for (int k = 0; k < list.length; k++) {
      final el = list[k];
      final number = int.parse(el);
      final isLineActive = activeLine == number;
      var textSpan = TextSpan(text: el, style: style);

      if (lineNumberBuilder != null) {
        textSpan = lineNumberBuilder!(number, style, isLineActive);
      }

      children.add(textSpan);
      if (k < list.length - 1) {
        children.add(const TextSpan(text: '\n'));
      }
    }

    return TextSpan(children: children, style: style);
  }
}
