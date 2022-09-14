import 'package:flutter/material.dart';

import 'constants.dart';

FadeInImage fetchImage(url) {
  return FadeInImage.assetNetwork(
    placeholder: kPlaceholderImage,
    image: url,
    imageErrorBuilder: (context, error, stackTrace) {
      return Image.asset(kPlaceholderImage);
    },
  );
}
