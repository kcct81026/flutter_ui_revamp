import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';

class ShimmerBox extends StatefulWidget {
  const ShimmerBox({super.key});

  @override
  State<ShimmerBox> createState() => ShimmerBoxState();
}

class ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _anim = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return CustomPaint(
          painter: _ShimmerPainter(_anim.value),
          child: Container(color: AppColors.grey20),
        );
      },
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  final double slide;
  _ShimmerPainter(this.slide);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.shader = LinearGradient(
      colors: [
        AppColors.grey20,
        AppColors.grey20.withValues(alpha: 0.6),
        AppColors.grey20,
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment(-1 - slide, -0.3),
      end: Alignment(1 - slide, 0.3),
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _ShimmerPainter oldDelegate) {
    return oldDelegate.slide != slide;
  }
}
