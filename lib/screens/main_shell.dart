import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/design_canvas.dart';
import 'hadith_screen.dart';
import 'quran_screen.dart';
import 'radio_screen.dart';
import 'sebha_screen.dart';
import 'time_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, 4).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesignCanvas(
        child: ColoredBox(
          color: AppColors.background,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                width: 430,
                height: 850,
                child: IndexedStack(
                  index: _index,
                  children: const <Widget>[
                    QuranScreen(),
                    HadithScreen(),
                    SebhaScreen(),
                    RadioScreen(),
                    TimeScreen(),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: AppBottomNav(
                  selectedIndex: _index,
                  onChanged: (value) => setState(() => _index = value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
