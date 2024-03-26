// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:note_app/controller/notes_screen_controller.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.colorIndex,
    this.onDeletePressed,
    this.onEditPressed,
  });
  final String title;
  final String description;
  final String date;
  final int colorIndex;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: NotesScreenController.colorList[colorIndex],
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: onEditPressed, child: Icon(Icons.edit)),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                              onTap: onDeletePressed, child: Icon(Icons.delete))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(description),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(date),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.share)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
