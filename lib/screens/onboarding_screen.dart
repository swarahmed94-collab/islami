import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../widgets/design_canvas.dart';
import '../widgets/islami_header.dart';
import 'main_shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  static const _slides = <_OnboardingSlide>[
    _OnboardingSlide(
      asset: null,
      imageWidth: 385,
      imageHeight: 385,
      imageTop: 272,
      title: 'Welcome To Islmi App',
      titleTop: 731,
    ),
    _OnboardingSlide(
      asset: AppAssets.kabba,
      imageWidth: 390,
      imageHeight: 400,
      imageTop: 235,
      title: 'Welcome To Islami',
      titleTop: 684,
      subtitle: 'We Are Very Excited To Have You In Our\nCommunity',
    ),
    _OnboardingSlide(
      asset: AppAssets.welcome,
      imageWidth: 370,
      imageHeight: 420,
      imageTop: 231,
      title: 'Reading the Quran',
      titleTop: 682,
      subtitle: 'Read, and your Lord is the Most Generous',
    ),
    _OnboardingSlide(
      asset: AppAssets.bearish,
      imageWidth: 340,
      imageHeight: 415,
      imageTop: 240,
      title: 'Bearish',
      titleTop: 685,
      subtitle: 'Praise the name of your Lord, the Most\nHigh',
    ),
    _OnboardingSlide(
      asset: AppAssets.radioIllustration,
      imageWidth: 330,
      imageHeight: 435,
      imageTop: 205,
      title: 'Holy Quran Radio',
      titleTop: 684,
      subtitle: 'You can listen to the Holy Quran Radio\nthrough the application for free and easily',
    ),
  ];

  void _goNext() {
    if (_page == _slides.length - 1) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const MainShell(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      );
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _goBack() {
    if (_page == 0) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesignCanvas(
        child: ColoredBox(
          color: AppColors.background,
          child: Stack(
            children: <Widget>[
              PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (value) => setState(() => _page = value),
                itemBuilder: (_, index) => _SlideBody(slide: _slides[index]),
              ),
              Positioned(
                left: 15,
                right: 15,
                bottom: 18,
                child: SizedBox(
                  height: 36,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      if (_page > 0)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: _goBack,
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 17,
                                  height: 1,
                                  fontFamily: 'JannaLT',
                                ),
                              ),
                            ),
                          ),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List<Widget>.generate(
                          _slides.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: index == _page ? 18 : 7,
                            height: 7,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: index == _page
                                  ? AppColors.gold
                                  : AppColors.gray,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _goNext,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              _page == _slides.length - 1 ? 'Finish' : 'Next',
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontSize: 17,
                                height: 1,
                                fontFamily: 'JannaLT',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlideBody extends StatelessWidget {
  const _SlideBody({required this.slide});
  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: IslamiHeader(height: 185, logoTop: 54, logoFontSize: 76),
        ),
        if (slide.asset != null)
          Positioned(
            top: slide.imageTop,
            left: (430 - slide.imageWidth) / 2,
            child: Image.asset(
              slide.asset!,
              width: slide.imageWidth,
              height: slide.imageHeight,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        Positioned(
          top: slide.titleTop,
          left: 20,
          right: 20,
          child: Text(
            slide.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.gold,
              fontFamily: 'JannaLT',
              fontSize: 24,
              height: 1.15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (slide.subtitle != null)
          Positioned(
            top: slide.titleTop + 88,
            left: 18,
            right: 18,
            child: Text(
              slide.subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.gold,
                fontFamily: 'JannaLT',
                fontSize: 17,
                height: 1.55,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.asset,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageTop,
    required this.title,
    required this.titleTop,
    this.subtitle,
  });

  final String? asset;
  final double imageWidth;
  final double imageHeight;
  final double imageTop;
  final String title;
  final double titleTop;
  final String? subtitle;
}
