import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BackGlyph extends StatelessWidget {
  const BackGlyph({super.key, this.color = AppColors.gold, this.size = 28});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _BackPainter(color),
    );
  }
}

class _BackPainter extends CustomPainter {
  const _BackPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(size.width * .72, size.height * .2)
      ..lineTo(size.width * .28, size.height * .5)
      ..lineTo(size.width * .72, size.height * .8);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BackPainter oldDelegate) => oldDelegate.color != color;
}

class PlayPauseGlyph extends StatelessWidget {
  const PlayPauseGlyph({
    super.key,
    required this.playing,
    this.color = AppColors.ink,
    this.size = 34,
  });

  final bool playing;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PlayPausePainter(playing: playing, color: color),
    );
  }
}

class _PlayPausePainter extends CustomPainter {
  const _PlayPausePainter({required this.playing, required this.color});
  final bool playing;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    if (playing) {
      final w = size.width * .22;
      final gap = size.width * .12;
      final top = size.height * .16;
      final h = size.height * .68;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width / 2 - gap / 2 - w, top, w, h),
          Radius.circular(w * .25),
        ),
        paint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width / 2 + gap / 2, top, w, h),
          Radius.circular(w * .25),
        ),
        paint,
      );
    } else {
      final path = Path()
        ..moveTo(size.width * .22, size.height * .12)
        ..lineTo(size.width * .82, size.height * .5)
        ..lineTo(size.width * .22, size.height * .88)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PlayPausePainter oldDelegate) =>
      oldDelegate.playing != playing || oldDelegate.color != color;
}

class SpeakerGlyph extends StatelessWidget {
  const SpeakerGlyph({
    super.key,
    required this.muted,
    this.color = AppColors.ink,
    this.size = 29,
  });

  final bool muted;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SpeakerPainter(muted: muted, color: color),
    );
  }
}

class _SpeakerPainter extends CustomPainter {
  const _SpeakerPainter({required this.muted, required this.color});
  final bool muted;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()..color = color;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final speaker = Path()
      ..moveTo(size.width * .12, size.height * .40)
      ..lineTo(size.width * .35, size.height * .40)
      ..lineTo(size.width * .58, size.height * .21)
      ..lineTo(size.width * .58, size.height * .79)
      ..lineTo(size.width * .35, size.height * .60)
      ..lineTo(size.width * .12, size.height * .60)
      ..close();
    canvas.drawPath(speaker, fill);

    if (muted) {
      canvas.drawLine(
        Offset(size.width * .70, size.height * .40),
        Offset(size.width * .88, size.height * .60),
        stroke,
      );
      canvas.drawLine(
        Offset(size.width * .88, size.height * .40),
        Offset(size.width * .70, size.height * .60),
        stroke,
      );
    } else {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width * .56, size.height * .5),
          width: size.width * .46,
          height: size.height * .60,
        ),
        -math.pi / 3,
        2 * math.pi / 3,
        false,
        stroke,
      );
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width * .56, size.height * .5),
          width: size.width * .68,
          height: size.height * .86,
        ),
        -math.pi / 3,
        2 * math.pi / 3,
        false,
        stroke,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SpeakerPainter oldDelegate) =>
      oldDelegate.muted != muted || oldDelegate.color != color;
}

class SebhaRing extends StatelessWidget {
  const SebhaRing({super.key, this.size = 360, this.beadCount = 30});
  final double size;
  final int beadCount;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _SebhaRingPainter(beadCount),
    );
  }
}

class _SebhaRingPainter extends CustomPainter {
  const _SebhaRingPainter(this.beadCount);
  final int beadCount;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * .40;
    final beadRadius = size.width * .047;
    for (var i = 0; i < beadCount; i++) {
      final angle = -math.pi / 2 + (math.pi * 2 * i / beadCount);
      final beadCenter = Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      );
      final shader = const RadialGradient(
        center: Alignment(-.35, -.38),
        radius: .85,
        colors: <Color>[
          Color(0xFFFFDC78),
          Color(0xFFE1AD43),
          Color(0xFF9D6820),
        ],
      ).createShader(Rect.fromCircle(center: beadCenter, radius: beadRadius));
      canvas.drawCircle(beadCenter, beadRadius, Paint()..shader = shader);
    }
  }

  @override
  bool shouldRepaint(covariant _SebhaRingPainter oldDelegate) =>
      oldDelegate.beadCount != beadCount;
}
