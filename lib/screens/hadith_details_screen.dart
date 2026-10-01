import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/hadith.dart';
import '../widgets/custom_glyphs.dart';
import '../widgets/design_canvas.dart';
import '../widgets/mosque_footer.dart';

class HadithDetailsScreen extends StatelessWidget {
  const HadithDetailsScreen({super.key, required this.hadith});
  final Hadith hadith;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesignCanvas(
        child: ColoredBox(
          color: AppColors.background,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(26, 30, 26, 130),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 54,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => Navigator.of(context).pop(),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: BackGlyph(size: 29),
                              ),
                            ),
                          ),
                          Text(
                            hadith.englishTitle,
                            style: const TextStyle(
                              color: AppColors.gold,
                              fontFamily: 'JannaLT',
                              fontSize: 21,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      hadith.title,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontFamily: 'JannaLT',
                        fontSize: 26,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      hadith.body,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontFamily: 'JannaLT',
                        fontSize: 20,
                        height: 1.9,
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(left: 0, right: 0, bottom: 0, child: MosqueFooter()),
            ],
          ),
        ),
      ),
    );
  }
}
