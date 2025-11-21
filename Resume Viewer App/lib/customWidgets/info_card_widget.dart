import 'package:flutter/material.dart';

class ResumeInfoCard extends StatelessWidget {
  final double width;
  final EdgeInsetsGeometry? margin;
  final Widget headerIcon;
  final Widget? trailing;
  final Widget title;
  final List<Widget> children;
  final Color? backColor;

  const ResumeInfoCard({
    super.key,
    required this.width,
    this.margin,
    required this.headerIcon,
    this.trailing,
    required this.title,
    this.children = const [],
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backColor?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerIcon,
                const SizedBox(width: 10),
                trailing ?? const SizedBox(width: 40),
              ],
            ),
            title,
            ...children,
          ],
        ),
      ),
    );
  }
}