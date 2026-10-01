import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_glyphs.dart';
import '../widgets/islami_header.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  static const _phrases = <String>[
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
    'لا إله إلا الله',
  ];

  int _count = 30;
  int _phrase = 0;

  void _increment() {
    setState(() {
      _count++;
      if (_count >= 33) {
        _count = 0;
        _phrase = (_phrase + 1) % _phrases.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          AppAssets.sebhaBackground,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          filterQuality: FilterQuality.high,
        ),
        Container(color: Colors.black.withValues(alpha: .55)),
        const Positioned(top: 0, left: 0, right: 0, child: IslamiHeader(height: 195)),
        const Positioned(
          top: 221,
          left: 20,
          right: 20,
          child: Text(
            'سَبِّحِ اسْمَ رَبِّكَ الأَعْلَى',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: AppColors.white,
              fontFamily: 'JannaLT',
              fontSize: 34,
              height: 1.15,
            ),
          ),
        ),
        Positioned(
          top: 354,
          left: 35,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _increment,
            child: SizedBox(
              width: 360,
              height: 360,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const SebhaRing(size: 360),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        _phrases[_phrase],
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontFamily: 'JannaLT',
                          fontSize: 35,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        '$_count',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontFamily: 'JannaLT',
                          fontSize: 37,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
