import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const _items = <_NavItem>[
    _NavItem('Quran', AppAssets.quranIcon),
    _NavItem('Hadith', AppAssets.hadithIcon),
    _NavItem('Hadith', AppAssets.sebhaIcon),
    _NavItem('Radio', AppAssets.radioIcon),
    _NavItem('Time', AppAssets.timeIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430,
      height: 82,
      color: AppColors.gold,
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(_items.length, (index) {
          final item = _items[index];
          final selected = selectedIndex == index;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(index),
            child: SizedBox(
              width: 78,
              height: 68,
              child: Column(
                children: <Widget>[
                  Container(
                    width: selected ? 60 : 42,
                    height: 37,
                    decoration: BoxDecoration(
                      color: selected ? AppColors.navSelected : Colors.transparent,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      item.asset,
                      width: selected ? 25 : 24,
                      height: selected ? 25 : 24,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        selected ? AppColors.white : AppColors.ink,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  if (selected)
                    SizedBox(
                      height: 25,
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontFamily: 'JannaLT',
                          fontSize: 13,
                          height: 1.35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.asset);
  final String label;
  final String asset;
}
