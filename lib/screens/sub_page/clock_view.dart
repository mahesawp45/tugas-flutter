import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:bmi_app/constants/constants.dart';

class ClockView extends StatefulWidget {
  const ClockView({
    Key? key,
    required this.sizeClock,
  }) : super(key: key);

  final double sizeClock;

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    //buat update UI per 1 detik
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    }).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.sizeClock,
      height: widget.sizeClock,
      child: Transform.rotate(
        angle: -pi / 2, //Rotasi biar sesuai arah jarum jam
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Titik Tengah
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    //radius
    var radius = min(centerX, centerY);

    //Koordinat detik, menit, jam
    var sekarang = DateTime.now(); // 60 detik = 360 -> 1 detik = 6
    var secHanX = centerX + radius * 0.6 * cos(sekarang.second * 6 * pi / 180);
    var secHanY = centerX + radius * 0.6 * sin(sekarang.second * 6 * pi / 180);

    var minHanX = centerX + radius * 0.6 * cos(sekarang.minute * 6 * pi / 180);
    var minHanY = centerX + radius * 0.6 * sin(sekarang.minute * 6 * pi / 180);

    var hourHanX = centerX +
        radius *
            0.4 *
            cos((sekarang.hour * 30 + sekarang.minute * 0.5) * pi / 180);
    var hourHanY = centerX +
        radius *
            0.4 *
            sin((sekarang.hour * 30 + sekarang.minute * 0.5) * pi / 180);

    //ukuran katik detik, menit, jam
    var detikKatik = Offset(secHanX, secHanY);
    var menitKatik = Offset(minHanX, minHanY);
    var jamKatik = Offset(hourHanX, hourHanY);

    // .................................................................. BRUSH
    //ini yang dipake gambar jam dalem
    var fillBrush = Paint()..color = primaryColorLighter;

    //ini yang dipake gambar bingkai jam
    var outLineBrush = Paint()
      ..color = secondColor
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;

    //ini buat Titik di tengah
    var centerDotFillBrush = Paint()..color = secondColor;

    //ini buat katik detik
    var secHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..strokeWidth = size.width / 60
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    //ini buat katik menit
    var minHandBrush = Paint()
      // ..shader = const RadialGradient(colors: [Colors.indigo, Colors.lightBlue])
      //     .createShader(
      //   Rect.fromCircle(center: center, radius: radius),
      // )
      ..color = Colors.red.shade900
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30
      ..style = PaintingStyle.stroke;

    //ini buat katik menit
    var hourHandBrush = Paint()
      // ..shader = const RadialGradient(colors: [Colors.purple, Colors.pink])
      //     .createShader(
      //   Rect.fromCircle(center: center, radius: radius),
      // )
      ..color = const Color.fromARGB(255, 231, 231, 231)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24
      ..style = PaintingStyle.stroke;

    var dashBrush = Paint()
      ..color = secondColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //................................................................... PENGGAMBAR BRUSH
    // Bikin lingkaran Jam
    canvas.drawCircle(center, radius * 0.75, fillBrush);

    // Bikin bingkai Jam
    canvas.drawCircle(center, radius * 0.75, outLineBrush);

    //Bikin Katik detik, menit, jam
    canvas.drawLine(center, detikKatik, secHandBrush);
    canvas.drawLine(center, menitKatik, minHandBrush);
    canvas.drawLine(center, jamKatik, hourHandBrush);

    // Bikin titik tengah Jam -> Harus paling atas kan biar ketutupan
    canvas.drawCircle(center, radius * 0.12, centerDotFillBrush);

    // Bikin garis" luar
    // var outerCircleRadius = radius;
    // var innerCircleRadius = radius * 0.9;
    // for (double i = 0; i < 360; i += 12) {
    //   var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
    //   var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

    //   var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
    //   var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
    //   canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
