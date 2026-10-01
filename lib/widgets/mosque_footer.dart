import 'package:flutter/material.dart';
import '../constants/app_assets.dart';

class MosqueFooter extends StatelessWidget {
  const MosqueFooter({
    super.key,
    this.opacity = 0.78,
    this.height = 118,
  });

  final double opacity;
  final double height;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: Image.asset(
          AppAssets.mosqueFooter,
          width: 430,
          height: height,
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
