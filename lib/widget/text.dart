import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class GlobalText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

  const GlobalText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          textDirection ?? TextDirection.ltr, // Default to LTR if not provided
      child: Html(
        data: text, // Directly render HTML
        style: {
          "body": Style(
            fontSize: style?.fontSize != null
                ? FontSize(style!.fontSize!)
                : FontSize.medium,
            fontWeight: style?.fontWeight,
            color: style?.color,
            textAlign: textAlign ?? TextAlign.start,
          ),
        },
      ),
    );
  }
}
