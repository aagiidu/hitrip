import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Config {
  final String appName = 'Hi Trip';
  final String slogan = 'Монгол орноороо аялцгаая';
  final String mapAPIKey = 'AIzaSyBgJaEbK0r4EuQoPIKStAPfmbm3xTqZ7-E';
  final String countryName = 'Mongolia';
  final String splashIcon = 'assets/images/splash.png';
  final String supportEmail = 'info@ahatour.mn';
  final String privacyPolicyUrl =
      'https://firebasestorage.googleapis.com/v0/b/hitrip-admin.appspot.com/o/pages%2Fprivacy_policy.html?alt=media&token=258c2cd0-6d4c-4aa0-a37e-32ec251c6a75';
  final String iOSAppId = '000000';

  final String apiUrl = 'https://api.hitrip.mn';
  final String yourWebsiteUrl = 'http://www.ahatour.mn';
  final String facebookPageUrl = 'https://www.facebook.com/AHAtourTravelAgency';
  final String youtubeChannelUrl = 'https://www.youtube.com';

  // app theme color - primary color
  static const Color appThemeColor = Colors.blueAccent;
  static final Color? txtColor = Colors.blueGrey[600];

  //replace by your country lattitude & longitude
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(47.857222, 105.185278), //here
    zoom: 10,
  );

  //google maps marker icons
  final String hotelIcon = 'assets/images/hotel.png';
  final String restaurantIcon = 'assets/images/restaurant.png';
  final String hotelPinIcon = 'assets/images/hotel_pin.png';
  final String restaurantPinIcon = 'assets/images/restaurant_pin.png';
  final String drivingMarkerIcon = 'assets/images/driving_pin.png';
  final String uzmerPinIcon = 'assets/images/uzmer_pin_green.png';
  final String placePinIcon = 'assets/images/marker_80.png';
  final String destinationMarkerIcon =
      'assets/images/destination_map_marker.png';

  //Intro images
  final String introImage1 = 'assets/images/travel6.png';
  final String introImage2 = 'assets/images/travel1.png';
  final String introImage3 = 'assets/images/travel5.png';
}
