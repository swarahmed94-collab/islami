import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/azkar_item.dart';
import '../repositories/azkar_repository.dart';
import '../widgets/custom_glyphs.dart';
import '../widgets/design_canvas.dart';
import '../widgets/mosque_footer.dart';

class AzkarDetailsScreen extends StatefulWidget {
  const AzkarDetailsScreen({super.key, required this.category});
  final String category;

  @override
  State<AzkarDetailsScreen> createState() => _AzkarDetailsScreenState();
}

class _AzkarDetailsScreenState extends State<AzkarDetailsScreen> {
  late final Future<List<AzkarItem>> _future =
      AzkarRepository.loadCategory(widget.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesignCanvas(
        child: ColoredBox(
          color: AppColors.background,
          child: Stack(
            children: <Widget>[
              FutureBuilder<List<AzkarItem>>(
                future: _future,
                builder: (context, snapshot) {
                  final items = snapshot.data;
                  if (items == null) return const SizedBox.shrink();
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 155,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 27,
                                top: 28,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: BackGlyph(size: 29),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 35,
                                left: 70,
                                right: 70,
                                child: Text(
                                  widget.category,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    color: AppColors.gold,
                                    fontFamily: 'JannaLT',
                                    fontSize: 21,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 130),
                        sliver: SliverList.builder(
                          itemCount: items.length,
                          itemBuilder: (_, index) => _AzkarItemCard(
                            item: items[index],
                            index: index + 1,
                          ),
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

class _AzkarItemCard extends StatelessWidget {
  const _AzkarItemCard({required this.item, required this.index});
  final AzkarItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gold, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          Text(
            item.content,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: AppColors.gold,
              fontFamily: 'JannaLT',
              fontSize: 18,
              height: 1.75,
            ),
          ),
          if (item.description.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            Text(
              item.description,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: AppColors.white,
                fontFamily: 'JannaLT',
                fontSize: 13,
                height: 1.55,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            '× ${item.count.isEmpty ? '1' : item.count}',
            style: const TextStyle(
              color: AppColors.gold,
              fontFamily: 'JannaLT',
              fontSize: 15,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
