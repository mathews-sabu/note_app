import 'package:flutter/material.dart';
import 'package:note_app/core/constants/color_constants.dart';

class NotesScreenController {
  static List notesList = [];
  static List<Color> colorList = [
    ColorConstants.clr1,
    ColorConstants.clr2,
    ColorConstants.clr3,
    ColorConstants.clr4,
  ];

  // add note
  static void addNote({
    required String title,
    required String description,
    required String date,
    int colorIndex = 0,
  }) {
    notesList.add({
      "title": title,
      "description": description,
      "date": date,
      "colorIndex": colorIndex
    });
  }

  static void deleteNote(int index) {
    notesList.removeAt(index);
  }

  static void editNote({
    required int index,
    required String title,
    required String description,
    required String date,
    int colorIndex = 0,
  }) {
    notesList[index] = {
      "title": title,
      "description": description,
      "date": date,
      "colorIndex": colorIndex
    };
  }
}
