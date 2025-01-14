import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class GlobalText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  final Locale? locale;
  const GlobalText({super.key, required this.text, this.style, this.textDirection, this.textAlign, this.overflow, this.maxLines, this.locale});

  @override
  Widget build(BuildContext context) {
     var document = parse(text);
    String cleanText = document.body?.text ?? ''; // Extracts only the text part
    return  Text(
      cleanText,
      style: style,
      textDirection: textDirection,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      locale: locale,);
  }
}