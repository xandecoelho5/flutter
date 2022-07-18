import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            width: 212,
            height: 700,
            color: Colors.yellow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPaint(painter: FaceOutlinePainter()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    double xoff = 0.0, yoff = 0.0;
    path.moveTo(20 + xoff, 344 + yoff);
    path.cubicTo(
        28 + xoff, 351 + yoff, 104 + xoff, 302 + yoff, 95 + xoff, 313 + yoff);
    path.cubicTo(
        87 + xoff, 323 + yoff, 106 + xoff, 290 + yoff, 95 + xoff, 345 + yoff);
    path.cubicTo(
        85 + xoff, 356 + yoff, 156 + xoff, 306 + yoff, 164 + xoff, 318 + yoff);
    path.cubicTo(
        168 + xoff, 324 + yoff, 150 + xoff, 354 + yoff, 180 + xoff, 342 + yoff);
    path.cubicTo(
        195 + xoff, 342 + yoff, 251 + xoff, 316 + yoff, 254 + xoff, 322 + yoff);
    path.cubicTo(
        261 + xoff, 335 + yoff, 254 + xoff, 337 + yoff, 262 + xoff, 344 + yoff);
    path.cubicTo(
        273 + xoff, 354 + yoff, 320 + xoff, 328 + yoff, 335 + xoff, 330 + yoff);
    path.cubicTo(
        352 + xoff, 332 + yoff, 332 + xoff, 362 + yoff, 400 + xoff, 352 + yoff);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}
