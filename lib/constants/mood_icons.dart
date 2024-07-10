import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

class MoodIcons {
  static const Map<Mood, IconData> emotionIcons = {
    Mood.anger: FontAwesomeIcons.faceAngry,
    Mood.sadness: FontAwesomeIcons.faceSadTear,
    Mood.fear: FontAwesomeIcons.faceFlushed,
    Mood.disgust: FontAwesomeIcons.faceDizzy,
    Mood.joy: FontAwesomeIcons.faceLaugh,
    Mood.shame: FontAwesomeIcons.faceMehBlank,
    Mood.ennui: FontAwesomeIcons.faceFrownOpen,
    Mood.anxiety: FontAwesomeIcons.faceGrimace,
    Mood.envy: FontAwesomeIcons.faceRollingEyes,
  };
}
