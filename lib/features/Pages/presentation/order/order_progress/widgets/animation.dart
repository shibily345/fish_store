// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OrderTrackingAnimation extends StatefulWidget {
  double progress;
  OrderTrackingAnimation({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  _OrderTrackingAnimationState createState() => _OrderTrackingAnimationState();
}

class _OrderTrackingAnimationState extends State<OrderTrackingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation =
        Tween<double>(begin: 0.0, end: widget.progress).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _OrderTrackingPainter(_animation.value),
            size: const Size(300, 100),
          );
        },
      ),
    );
  }

  void startAnimation() {
    _controller.forward();
  }
}

class _OrderTrackingPainter extends CustomPainter {
  final double progress;

  _OrderTrackingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final completedLinePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final circlePaint = Paint()
      ..color = const Color.fromARGB(255, 174, 173, 173)
      ..style = PaintingStyle.fill;

    final completedCirclePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final textPaint = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Draw the lines
    canvas.drawLine(Offset(0.0, size.height / 2),
        Offset(size.width, size.height / 2), linePaint);

    // Draw the completed line
    canvas.drawLine(Offset(0.0, size.height / 2),
        Offset(size.width, size.height / 2), completedLinePaint);

    // Draw the circles
    for (int i = 0; i < 5; i++) {
      final cx = size.width / 5 * (i + 1);
      final isCompleted = i < progress;
      canvas.drawCircle(Offset(cx, size.height / 2), 12.0,
          isCompleted ? completedCirclePaint : circlePaint);
    }

    // Draw the text
    for (int i = 0; i < 5; i++) {
      final cx = size.width / 5 * (i + 1);
      final isCompleted = i < progress;
      textPaint.text = TextSpan(
        text: ['Booked', 'Accepted', 'Processed', 'Shipped', 'Delivered'][i],
        style: TextStyle(
          color: isCompleted
              ? Colors.green
              : const Color.fromARGB(136, 158, 158, 158),
          fontSize: 12.0,
        ),
      );
      textPaint.layout(minWidth: 0.0, maxWidth: size.width);
      textPaint.paint(
          canvas, Offset(cx - textPaint.width / 2, size.height / 2 - 50.0));
    }
  }

  @override
  bool shouldRepaint(_OrderTrackingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
