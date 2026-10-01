import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class IslamiHeader extends StatelessWidget {
  const IslamiHeader({
    super.key,
    this.height = 188,
    this.logoTop = 53,
    this.logoFontSize = 75,
    this.mosqueWidth = 330,
  });

  final double height;
  final double logoTop;
  final double logoFontSize;
  final double mosqueWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 430,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: 17,
            child: Image.asset(
              AppAssets.mosqueOutline,
              width: mosqueWidth,
              height: 148,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned(
            top: logoTop,
            child: Text(
              'Islami',
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: TextStyle(
                color: AppColors.gold,
                fontFamily: 'Kamali',
                fontSize: logoFontSize,
                height: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
