import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String categoria = '/categoria';
  static const String produto = '/produto';
  static const String sobre = '/sobre';

  Routes._();
}

const kPlaceholderImage = 'assets/images/placeholder.png';

// colors
const kWarmPurple = Color(0xFF5E2A84);
const kTomato = Color(0xFFF15025);
const kGreyish = Color(0xFFAAAAAA);
const kDark = Color(0xFF2D3142);
const kGreyishBrown = Color(0xFF4A4A4A);
const kWhite = Color(0xFFD5D5D5);
const kWhiteTwo = Color(0xFFFCFCFC);

const kDivider = Divider(height: 5, color: kGreyish);

// text styles
const kLogoMenu = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 24,
  letterSpacing: -0.6,
  color: Colors.white,
);

const kNomeCategoria = TextStyle(
  fontSize: 12,
  letterSpacing: -0.3,
);

const kDescricaoProduto = TextStyle(
  fontSize: 18,
  color: kGreyishBrown,
  fontWeight: FontWeight.w500,
);

const kDescricaoProduto2 = TextStyle(
  fontSize: 17,
  color: kGreyishBrown,
  fontWeight: FontWeight.bold,
);

const kPrecoPor = TextStyle(
  fontSize: 18,
  color: kTomato,
  fontWeight: FontWeight.bold,
);

const kPrecoDe = TextStyle(
  fontSize: 12,
  color: kGreyish,
  fontWeight: FontWeight.w500,
  decoration: TextDecoration.lineThrough,
);

const kMenuItem = TextStyle(
  fontSize: 14,
  color: kGreyishBrown,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.3,
);

const kLogoSobre = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 64,
  letterSpacing: -1.5,
  color: kGreyishBrown,
);

const kNomeDesenvolvedor = TextStyle(
  fontSize: 12,
  color: kGreyishBrown,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.3,
);

const kDataDesenvolvimento = TextStyle(
  fontSize: 12,
  color: kGreyishBrown,
  fontWeight: FontWeight.w300,
  letterSpacing: -0.3,
);

const kReservado = TextStyle(fontSize: 14, color: kGreyish);
