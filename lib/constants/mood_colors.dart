import 'package:flutter/material.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

extension MoodExtension on Mood {
  String get name => toString().split('.').last;
}

class MoodColors {
  static const Map<Mood, Color> primaryColors = {
    Mood.anger: Color(0xFFD03232),
    Mood.sadness: Color(0xFF4A90E2),
    Mood.fear: Color(0xFFA669E6),
    Mood.disgust: Color(0xFF7ED321),
    Mood.joy: Color(0xFFF8E71C),
    Mood.shame: Color(0xFFE57399),
    Mood.ennui: Color(0xFF4B6A9B),
    Mood.anxiety: Color(0xFFE58742),
    Mood.envy: Color(0xFF6ECDAA),
  };

  static const Map<Mood, Color> darkPrimaryColors = {
    Mood.anger: Color(0xFF831F1F),
    Mood.sadness: Color(0xFF3B74B5),
    Mood.fear: Color(0xFF6E3BA3),
    Mood.disgust: Color(0xFF5A9316),
    Mood.joy: Color(0xFFC8B71A),
    Mood.shame: Color(0xFFB3576F),
    Mood.ennui: Color(0xFF374C70),
    Mood.anxiety: Color(0xFFC0652A),
    Mood.envy: Color(0xFF4F9C7E),
  };

  static const Map<Mood, Color> lightPrimaryColors = {
    Mood.anger: Color(0xFFE65757),
    Mood.sadness: Color(0xFFA3C9F8),
    Mood.fear: Color(0xFFB893E7),
    Mood.disgust: Color(0xFFB1E466),
    Mood.joy: Color(0xFFFBF1A0),
    Mood.shame: Color(0xFFF4A9B8),
    Mood.ennui: Color(0xFF8A9EC3),
    Mood.anxiety: Color(0xFFF2B072),
    Mood.envy: Color(0xFFA5E3C5),
  };

  static final Map<Mood, Color> opacityPrimaryColors = {
    Mood.anger: const Color(0xFFD03232).withOpacity(0.2),
    Mood.sadness: const Color(0xFF4A90E2).withOpacity(0.2),
    Mood.fear: const Color(0xFFA669E6).withOpacity(0.2),
    Mood.disgust: const Color.fromARGB(255, 143, 204, 77).withOpacity(0.2),
    Mood.joy: const Color.fromARGB(255, 255, 221, 0).withOpacity(0.2),
    Mood.shame: const Color(0xFFE57399).withOpacity(0.2),
    Mood.ennui: const Color(0xFF4B6A9B).withOpacity(0.2),
    Mood.anxiety: const Color(0xFFE58742).withOpacity(0.2),
    Mood.envy: const Color(0xFF6ECDAA).withOpacity(0.2),
  };

  static const Map<Mood, Color> secondaryColors = {
    Mood.anger: Color(0xFF5A2E2E),
    Mood.sadness: Color(0xFFA0A0A0),
    Mood.fear: Color(0xFF000000),
    Mood.disgust: Color.fromARGB(255, 136, 186, 21),
    Mood.joy: Color(0xFF4A90E2),
    Mood.shame: Color.fromARGB(255, 151, 151, 151),
    Mood.ennui: Color(0xFF969696),
    Mood.anxiety: Color(0xFF8B5730),
    Mood.envy: Color(0xFF4B9CC3),
  };

  static const Map<Mood, Color> darkSecondaryColors = {
    Mood.anger: Color(0xFF3D1C1C),
    Mood.sadness: Color(0xFF6D6D6D),
    Mood.fear: Color.fromARGB(255, 78, 78, 78),
    Mood.disgust: Color.fromARGB(255, 129, 209, 25),
    Mood.joy: Color(0xFF3B74B5),
    Mood.shame: Color.fromARGB(255, 75, 75, 75),
    Mood.ennui: Color(0xFF676767),
    Mood.anxiety: Color(0xFF5A371D),
    Mood.envy: Color(0xFF356E8A),
  };
}
