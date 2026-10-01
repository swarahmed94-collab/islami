import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../widgets/design_canvas.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _phaseTimer;
  Timer? _navigationTimer;
  bool _showDecoratedSplash = false;

  @override
  void initState() {
    super.initState();
    _phaseTimer = Timer(const Duration(milliseconds: 650), () {
      if (mounted) setState(() => _showDecoratedSplash = true);
    });
    _navigationTimer = Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
          transitionDuration: const Duration(milliseconds: 320),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _phaseTimer?.cancel();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesignCanvas(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: _showDecoratedSplash
              ? const _DecoratedSplash(key: ValueKey<String>('decorated'))
              : const _MinimalSplash(key: ValueKey<String>('minimal')),
        ),
      ),
    );
  }
}

class _MinimalSplash extends StatelessWidget {
  const _MinimalSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 120,
            top: 381,
            child: SvgPicture.asset(
              AppAssets.appMark,
              width: 190,
              height: 186,
              colorFilter: const ColorFilter.mode(
                AppColors.gold,
                BlendMode.srcIn,
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 72,
            child: _RouteCredit(),
          ),
        ],
      ),
    );
  }
}

class _DecoratedSplash extends StatelessWidget {
  const _DecoratedSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(AppAssets.splashBackground, fit: BoxFit.cover),
        Positioned(
          left: 52,
          right: 52,
          top: 52,
          child: Opacity(
            opacity: .72,
            child: Image.asset(AppAssets.mosqueOutline, height: 170),
          ),
        ),
        Positioned(
          right: 24,
          top: 0,
          child: Image.asset(AppAssets.lantern, height: 310),
        ),
        Positioned(
          left: -40,
          top: 198,
          child: Image.asset(AppAssets.cornerLeft, width: 155),
        ),
        Positioned(
          right: -28,
          bottom: 135,
          child: Image.asset(AppAssets.cornerRight, width: 150),
        ),
        Positioned(
          left: 116,
          top: 344,
          child: SvgPicture.asset(
            AppAssets.appMark,
            width: 198,
            height: 194,
            colorFilter: const ColorFilter.mode(
              AppColors.gold,
              BlendMode.srcIn,
            ),
          ),
        ),
        const Positioned(
          top: 502,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Islami',
              style: TextStyle(
                color: AppColors.gold,
                fontFamily: 'Kamali',
                fontSize: 62,
                height: 1,
              ),
            ),
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 76,
          child: _RouteCredit(),
        ),
      ],
    );
  }
}

class _RouteCredit extends StatelessWidget {
  const _RouteCredit();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Route',
          style: TextStyle(
            color: AppColors.goldMuted,
            fontFamily: 'Kamali',
            fontSize: 48,
            height: .9,
          ),
        ),
        Text(
          'Training center & innovation space',
          style: TextStyle(
            color: AppColors.goldMuted,
            fontFamily: 'JannaLT',
            fontSize: 7,
            height: 1,
          ),
        ),
        SizedBox(height: 18),
        Text(
          'Supervised by Mohamed Nabil',
          style: TextStyle(
            color: AppColors.gold,
            fontFamily: 'JannaLT',
            fontSize: 17,
            height: 1,
          ),
        ),
      ],
    );
  }
}
