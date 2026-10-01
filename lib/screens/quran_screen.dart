import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../models/surah.dart';
import '../repositories/quran_repository.dart';
import '../widgets/islami_header.dart';
import 'surah_details_screen.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final TextEditingController _search = TextEditingController();
  late final Future<List<Surah>> _future = QuranRepository.loadCatalog();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _openSurah(Surah surah) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => SurahDetailsScreen(surah: surah),
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
        Image.asset(
          AppAssets.homeBackground,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          filterQuality: FilterQuality.high,
        ),
        Container(color: Colors.black.withValues(alpha: .58)),
        FutureBuilder<List<Surah>>(
          future: _future,
          builder: (context, snapshot) {
            final surahs = snapshot.data;
            if (surahs == null) return const SizedBox.shrink();
            final query = _query.trim().toLowerCase();
            final filtered = query.isEmpty
                ? surahs
                : surahs.where((s) {
                    return s.englishName.toLowerCase().contains(query) ||
                        s.arabicName.contains(_query.trim()) ||
                        s.number.toString() == query;
                  }).toList(growable: false);

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: _QuranHeader(
                    controller: _search,
                    query: _query,
                    onChanged: (value) => setState(() => _query = value),
                    onRecentTap: _openSurah,
                    surahs: surahs,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20, _query.isEmpty ? 0 : 18, 20, 28),
                  sliver: SliverList.builder(
                    itemCount: filtered.length,
                    itemBuilder: (_, index) {
                      final surah = filtered[index];
                      return _SurahRow(
                        surah: surah,
                        onTap: () => _openSurah(surah),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _QuranHeader extends StatelessWidget {
  const _QuranHeader({
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onRecentTap,
    required this.surahs,
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final ValueChanged<Surah> onRecentTap;
  final List<Surah> surahs;

  @override
  Widget build(BuildContext context) {
    final filteredMode = query.trim().isNotEmpty;
    return SizedBox(
      height: filteredMode ? 270 : 484,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const IslamiHeader(height: 184),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.background.withValues(alpha: .48),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: AppColors.gold, width: 1),
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 14),
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: SvgPicture.asset(
                      AppAssets.quranIcon,
                      colorFilter: const ColorFilter.mode(
                        AppColors.gold,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      cursorColor: AppColors.gold,
                      textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch(query)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontFamily: 'JannaLT',
                        fontSize: 17,
                        height: 1,
                      ),
                      decoration: const InputDecoration(
                        isCollapsed: true,
                        hintText: 'Sura Name',
                        hintStyle: TextStyle(
                          color: AppColors.white,
                          fontFamily: 'JannaLT',
                          fontSize: 17,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          if (!filteredMode) ...<Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 10),
              child: Text(
                'Most Recently',
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'JannaLT',
                  fontSize: 17,
                  height: 1,
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: <Widget>[
                  _RecentCard(
                    surah: surahs.length > 20 ? surahs[20] : surahs.first,
                    onTap: onRecentTap,
                    showArt: true,
                  ),
                  const SizedBox(width: 10),
                  _RecentCard(
                    surah: surahs.first,
                    onTap: onRecentTap,
                    showArt: false,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Text(
                'Suras List',
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'JannaLT',
                  fontSize: 17,
                  height: 1,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  const _RecentCard({
    required this.surah,
    required this.onTap,
    required this.showArt,
  });

  final Surah surah;
  final ValueChanged<Surah> onTap;
  final bool showArt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(surah),
      child: Container(
        width: 285,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: <Widget>[
            if (showArt)
              Positioned(
                right: 8,
                bottom: 4,
                child: Image.asset(
                  AppAssets.quranSura,
                  width: 150,
                  height: 130,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            Positioned(
              left: 16,
              top: 20,
              right: showArt ? 135 : 16,
              child: Text(
                surah.englishName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontFamily: 'JannaLT',
                  fontSize: 25,
                  height: 1,
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 63,
              right: showArt ? 135 : 16,
              child: Text(
                surah.arabicName,
                textDirection: TextDirection.rtl,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontFamily: 'JannaLT',
                  fontSize: 23,
                  height: 1,
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Text(
                '${surah.verseCount} Verses',
                style: const TextStyle(
                  color: AppColors.ink,
                  fontFamily: 'JannaLT',
                  fontSize: 16,
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

class _SurahRow extends StatelessWidget {
  const _SurahRow({required this.surah, required this.onTap});
  final Surah surah;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 82,
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
            SizedBox(
              width: 62,
              height: 62,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    AppAssets.surahBadge,
                    width: 51,
                    height: 51,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    '${surah.number}',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontFamily: 'JannaLT',
                      fontSize: 15,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    surah.englishName,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontFamily: 'JannaLT',
                      fontSize: 21,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${surah.verseCount} Verses',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontFamily: 'JannaLT',
                      fontSize: 14,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 105,
              child: Text(
                surah.arabicName,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: 'JannaLT',
                  fontSize: 20,
                  height: 1,
                ),
              ),
            ),
              ],
            ),
            const Positioned(
              left: 43,
              right: 45,
              bottom: 0,
              child: SizedBox(
                height: 1,
                child: ColoredBox(color: Color(0xFFD6D6D6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
