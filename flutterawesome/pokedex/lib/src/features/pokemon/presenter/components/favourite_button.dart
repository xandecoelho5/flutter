import 'package:flutter/material.dart';
import 'package:pokedex/src/core/utils/colors.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    Key? key,
    required this.isFavourite,
  }) : super(key: key);

  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 54),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFavourite ? kSecondaryColor : kPrimaryColor,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          elevation: 10,
        ),
        onPressed: () {},
        child: Text(
          isFavourite ? 'Remove from favourites' : 'Mark as favourite',
          style: TextStyle(
            fontSize: 14,
            color: isFavourite ? kPrimaryColor : Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
