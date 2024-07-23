import 'package:flutter/material.dart';
import 'package:same_city_playmate/pages/Discovering_screen.dart';
import 'package:same_city_playmate/pages/Playmate_screen.dart';
import 'package:same_city_playmate/pages/Nearby_screen.dart';
import 'package:same_city_playmate/pages/Welcome_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'Welcome':
      return MaterialPageRoute(builder: (_) => WelcomeScreen());
    case '/Discovering':
      return MaterialPageRoute(builder: (_) => DiscoveringScreen());
    case '/Playmate':
      return MaterialPageRoute(builder: (_) => PlaymateScreen());
    case '/Nearby':
      return MaterialPageRoute(builder: (_) => NearbyScreen());
    default:
      return MaterialPageRoute(builder: (_) => WelcomeScreen());
  }
}
