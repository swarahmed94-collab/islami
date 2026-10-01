import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../models/hadith.dart';
import '../repositories/hadith_repository.dart';
import '../widgets/islami_header.dart';
import '../widgets/mosque_footer.dart';
import 'hadith_details_screen.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  late final Future<List<Hadith>> _future = HadithRepository.loadAll();
  final PageController _controller = PageController(viewportFraction: .77);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _open(Hadith hadith) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => HadithDetailsScreen(hadith: hadith),
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
          AppAssets.hadithPhotoBackground,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
        Container(color: Colors.black.withValues(alpha: .57)),
        const Positioned(top: 0, left: 0, right: 0, child: IslamiHeader(height: 203)),
        Positioned(
          top: 212,
          left: 0,
          right: 0,
          height: 618,
          child: FutureBuilder<List<Hadith>>(
            future: _future,
            builder: (context, snapshot) {
              final hadiths = snapshot.data;
              if (hadiths == null) return const SizedBox.shrink();
              return PageView.builder(
                controller: _controller,
                padEnds: true,
                physics: const BouncingScrollPhysics(),
                itemCount: hadiths.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: _HadithCard(
                      hadith: hadiths[index],
                      onTap: () => _open(hadiths[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HadithCard extends StatelessWidget {
  const _HadithCard({required this.hadith, required this.onTap});
  final Hadith hadith;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Opacity(
                opacity: .20,
                child: Image.asset(
                  AppAssets.hadithCardBackground,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Positioned(
              left: 14,
              right: 14,
              top: 55,
              bottom: 55,
              child: Column(
                children: <Widget>[
                  Text(
                    hadith.title,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontFamily: 'JannaLT',
                      fontSize: 24,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: ClipRect(
                      child: Text(
                        hadith.body,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontFamily: 'JannaLT',
                          fontSize: 15.2,
                          height: 1.72,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: MosqueFooter(opacity: .38, height: 78),
            ),
          ],
        ),
      ),
    );
  }
}
