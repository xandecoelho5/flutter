import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

const GOOGLE_API_KEY = 'AIzaSyDzaLip5wzdPdKytNa2JqjKYNn1IgbdsoU';

class LocationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    //&signature=YOUR_SIGNATURE
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300'
        '&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY';
    final response = await get(Uri.parse(url));
    final results = jsonDecode(response.body);

    return results.isEmpty
        ? 'Address not found'
        : jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
