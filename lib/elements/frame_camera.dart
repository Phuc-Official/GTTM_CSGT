import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FrameCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80, top: 180),
              child: SvgPicture.asset("assets/logo/expand.svg"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 160, top: 180),
              child: SvgPicture.asset("assets/logo/expand-1.svg"),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80, top: 180),
              child: SvgPicture.asset("assets/logo/expand-2.svg"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 160, top: 180),
              child: SvgPicture.asset("assets/logo/expand-3.svg"),
            ),
          ],
        ),
      ],
    );
  }
}