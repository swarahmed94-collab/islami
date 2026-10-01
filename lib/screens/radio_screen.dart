import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_glyphs.dart';
import '../widgets/islami_header.dart';
import '../widgets/mosque_footer.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  bool _reciters = false;
  int? _playing = 1;
  final Set<int> _muted = <int>{1};

  static const _radioNames = <String>[
    'Radio Ibrahim Al-Akdar',
    'Radio Al-Qaria Yassen',
    'Radio Ahmed Al-trabulsi',
    'Radio Addokali Mohammad Alalim',
  ];

  static const _reciterNames = <String>[
    'Ibrahim Al-Akdar',
    'Akram Alalaqmi',
    'Majed Al-Enezi',
    'Malik shaibat Alhamed',
  ];

  @override
  Widget build(BuildContext context) {
    final names = _reciters ? _reciterNames : _radioNames;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          AppAssets.radioBackground,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          filterQuality: FilterQuality.high,
        ),
        Container(color: Colors.black.withValues(alpha: .60)),
        const Positioned(top: 0, left: 0, right: 0, child: IslamiHeader(height: 205)),
        Positioned(
          top: 206,
          left: 20,
          right: 20,
          child: _RadioTabs(
            reciters: _reciters,
            onChanged: (value) => setState(() => _reciters = value),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: 264,
          bottom: 7,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: names.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, index) {
              final playing = _playing == index;
              final muted = _muted.contains(index);
              return _RadioCard(
                name: names[index],
                playing: playing,
                muted: muted,
                onPlay: () => setState(() => _playing = playing ? null : index),
                onMute: () => setState(() {
                  if (muted) {
                    _muted.remove(index);
                  } else {
                    _muted.add(index);
                  }
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RadioTabs extends StatelessWidget {
  const _RadioTabs({required this.reciters, required this.onChanged});
  final bool reciters;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _TabButton(
              text: 'Radio',
              selected: !reciters,
              onTap: () => onChanged(false),
            ),
          ),
          Expanded(
            child: _TabButton(
              text: 'Reciters',
              selected: reciters,
              onTap: () => onChanged(true),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.text, required this.selected, required this.onTap});
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? AppColors.ink : AppColors.white,
            fontFamily: 'JannaLT',
            fontSize: 17,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _RadioCard extends StatelessWidget {
  const _RadioCard({
    required this.name,
    required this.playing,
    required this.muted,
    required this.onPlay,
    required this.onMute,
  });

  final String name;
  final bool playing;
  final bool muted;
  final VoidCallback onPlay;
  final VoidCallback onMute;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 133,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(19),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          if (playing)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: .58,
                child: SvgPicture.asset(
                  AppAssets.soundWave,
                  height: 60,
                  fit: BoxFit.fill,
                  colorFilter: const ColorFilter.mode(
                    AppColors.goldMuted,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
          else
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: MosqueFooter(opacity: .25, height: 66),
            ),
          Positioned(
            top: 20,
            left: 15,
            right: 15,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.ink,
                fontFamily: 'JannaLT',
                fontSize: 19,
                height: 1,
              ),
            ),
          ),
          Positioned(
            left: 176,
            bottom: 18,
            child: GestureDetector(
              onTap: onPlay,
              child: PlayPauseGlyph(playing: playing, size: 36),
            ),
          ),
          Positioned(
            left: 231,
            bottom: 20,
            child: GestureDetector(
              onTap: onMute,
              child: SpeakerGlyph(muted: muted, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
