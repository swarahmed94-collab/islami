import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_glyphs.dart';
import '../widgets/islami_header.dart';
import 'azkar_details_screen.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  void _openAzkar(BuildContext context, String category) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => AzkarDetailsScreen(category: category),
        transitionDuration: const Duration(milliseconds: 260),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const ColoredBox(color: AppColors.background),
        const Positioned(top: 0, left: 0, right: 0, child: IslamiHeader(height: 200)),
        const Positioned(
          left: 20,
          right: 20,
          top: 201,
          child: _PrayerPanel(),
        ),
        const Positioned(
          left: 20,
          top: 532,
          child: Text(
            'Azkar',
            style: TextStyle(
              color: AppColors.white,
              fontFamily: 'JannaLT',
              fontSize: 17,
              height: 1,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 575,
          child: _AzkarCard(
            title: 'Evening Azkar',
            onTap: () => _openAzkar(context, 'أذكار المساء'),
          ),
        ),
        Positioned(
          right: 20,
          top: 575,
          child: _AzkarCard(
            title: 'Morning Azkar',
            onTap: () => _openAzkar(context, 'أذكار الصباح'),
          ),
        ),
      ],
    );
  }
}

class _PrayerPanel extends StatelessWidget {
  const _PrayerPanel();

  static const _prayers = <(String, String, String)>[
    ('Sunrise', '05:04', 'AM'),
    ('Dhuhr', '01:01', 'PM'),
    ('ASR', '04:38', 'PM'),
    ('Maghrib', '07:57', 'PM'),
    ('Isha', '09:27', 'PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(38),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 110,
              height: 82,
              padding: const EdgeInsets.fromLTRB(25, 18, 8, 8),
              decoration: const BoxDecoration(
                color: Color(0xFF8A7043),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(62),
                ),
              ),
              child: const Text(
                '16 Jul,\n2024',
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'JannaLT',
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 110,
              height: 82,
              padding: const EdgeInsets.fromLTRB(8, 18, 25, 8),
              decoration: const BoxDecoration(
                color: Color(0xFF8A7043),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(62),
                ),
              ),
              child: const Text(
                '09 Muh,\n1446',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'JannaLT',
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 13,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                Text(
                  'Pray Time',
                  style: TextStyle(
                    color: AppColors.navSelected,
                    fontFamily: 'JannaLT',
                    fontSize: 22,
                    height: 1,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Tuesday',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontFamily: 'JannaLT',
                    fontSize: 22,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 114,
            left: -45,
            right: -45,
            child: SizedBox(
              height: 114,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _prayers
                    .map((value) => _PrayerTile(
                          name: value.$1,
                          time: value.$2,
                          period: value.$3,
                          active: value.$1 == 'ASR',
                        ))
                    .toList(growable: false),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 22,
            child: Text(
              'Next Pray - 02:32',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.navSelected,
                fontFamily: 'JannaLT',
                fontSize: 16,
                height: 1,
              ),
            ),
          ),
          const Positioned(
            right: 28,
            bottom: 17,
            child: SpeakerGlyph(muted: true, size: 25),
          ),
        ],
      ),
    );
  }
}

class _PrayerTile extends StatelessWidget {
  const _PrayerTile({
    required this.name,
    required this.time,
    required this.period,
    required this.active,
  });

  final String name;
  final String time;
  final String period;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: active ? 105 : 86,
      height: active ? 126 : 106,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            const Color(0xFF26211D),
            active ? const Color(0xFFB09565) : const Color(0xFF9A8055),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: 'JannaLT',
              fontSize: 15,
              height: 1,
            ),
          ),
          const SizedBox(height: 11),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: 'JannaLT',
              fontSize: 25,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            period,
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: 'JannaLT',
              fontSize: 14,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _AzkarCard extends StatelessWidget {
  const _AzkarCard({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185,
        height: 245,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.gold, width: 1.5),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 22,
              left: 8,
              right: 8,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: 'JannaLT',
                  fontSize: 19,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
