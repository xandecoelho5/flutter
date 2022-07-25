import 'package:flutter/material.dart';

const kBackgroundColor = Colors.white;
const kBackgroundDefaultInput = Color(0xFFF2F2F2);
const kBackgroundPressedInput = Color(0xFFE2E2E2);
final kBackgroundModal = const Color(0xFF17171B).withOpacity(0.5);

const kTextWhite = Colors.white;
const kTextBlack = Color(0xFF17171B);
const kTextGrey = Color(0xFF747476);
final kTextNumber = const Color(0xFF17171B).withOpacity(0.5);
final kTextNumberDarker = const Color(0xFF17171B).withOpacity(0.6);

const kTypePsychic = Color(0xFFEA5D60);
const kTypeFairy = Color(0xFFED6EC7);
const kTypeFlying = Color(0xFF748FC9);

final kWhiteTenOpacity = Colors.white.withOpacity(0.1);
final kWhiteThirtyOpacity = Colors.white.withOpacity(0.3);
final kWhiteThirtyFiveOpacity = Colors.white.withOpacity(0.35);
final kWhiteNoOpacity = Colors.white.withOpacity(0);
const kLightGrey = Color(0xFFF5F5F5);

final kGradientVector = [kWhiteThirtyOpacity, kWhiteNoOpacity];
final kGradientVectorWhite = kGradientVector;
final kGradientPokemonName = kGradientVector;
final kGradientPokeball = [kLightGrey.withOpacity(0.5), Colors.white];
final kGradientPokeballGrey = [const Color(0xFFECECEC), kLightGrey];
final kGradientPokeballWhite = [kWhiteTenOpacity, kWhiteNoOpacity];
final kGradientPokemonCircle = [kWhiteNoOpacity, kWhiteThirtyFiveOpacity];
final kGradientVectorGrey = [
  const Color(0xFFE5E5E5),
  kLightGrey.withOpacity(0),
];

const kHeightShort = Color(0xFFFFC5E6);
const kHeightMedium = Color(0xFFAEBFD7);
const kHeightTall = Color(0xFFAAACB8);

const kWeightLight = Color(0xFF99CD7C);
const kWeightNormal = Color(0xFF57B2DC);
const kWeightHeavy = Color(0xFF5A92A5);

// Styles
const kContentStyle = TextStyle(color: kTextGrey, fontSize: 16);

// TODO remove spacer from files and use this instead
// Spacers
const kSpacerSmall = SizedBox(height: 12.0);
const kSpacerMedium = SizedBox(height: 20.0);
const kSpacerLarge = SizedBox(height: 36.0);

const kSmallPadding = 12.0;
const kMediumPadding = 20.0;
const kLargePadding = 36.0;
