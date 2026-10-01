import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/surah.dart';
import '../repositories/quran_repository.dart';
import '../widgets/custom_glyphs.dart';
import '../widgets/design_canvas.dart';
import '../widgets/mosque_footer.dart';

class SurahDetailsScreen extends StatefulWidget {
  const SurahDetailsScreen({super.key, required this.surah});
  final Surah surah;

  @override
  State<SurahDetailsScreen> createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  late final Future<List<String>> _future =
      QuranRepository.loadVerses(widget.surah.number);
  int? _selectedVerse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesignCanvas(
        child: ColoredBox(
          color: AppColors.background,
          child: Stack(
            children: <Widget>[
              FutureBuilder<List<String>>(
                future: _future,
                builder: (context, snapshot) {
                  final verses = snapshot.data;
                  if (verses == null) return const SizedBox.shrink();
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 195,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 27,
                                top: 28,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: BackGlyph(size: 29),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 34,
                                left: 80,
                                right: 80,
                                child: Text(
                                  widget.surah.englishName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.gold,
                                    fontFamily: 'JannaLT',
                                    fontSize: 21,
                                    height: 1,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 111,
                                left: 60,
                                right: 60,
                                child: Text(
                                  widget.surah.arabicName,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    color: AppColors.gold,
                                    fontFamily: 'JannaLT',
                                    fontSize: 24,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(18, 4, 18, 126),
                        sliver: SliverList.builder(
                          itemCount: verses.length,
                          itemBuilder: (_, index) {
                            final selected = _selectedVerse == index;
                            return GestureDetector(
                              onTap: () => setState(() {
                                _selectedVerse = selected ? null : index;
                              }),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 394,
                                constraints: const BoxConstraints(minHeight: 71),
                                margin: const EdgeInsets.only(bottom: 9),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.gold
                                      : AppColors.background,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: AppColors.gold,
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '[${index + 1}] ${verses[index]}',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: selected
                                        ? AppColors.ink
                                        : AppColors.gold,
                                    fontFamily: 'JannaLT',
                                    fontSize: 20,
                                    height: 1.55,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Positioned(left: 0, right: 0, bottom: 0, child: MosqueFooter()),
            ],
          ),
        ),
      ),
    );
  }
}
