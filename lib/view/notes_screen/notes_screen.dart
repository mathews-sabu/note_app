// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/controller/notes_screen_controller.dart';
import 'package:note_app/view/notes_screen/widget/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int selectedColorIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            titleController.clear();
            descriptionController.clear();
            dateController.clear();
            selectedColorIndex = 0;
            customBottomSheet(context: context);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => NoteCard(
                  title: NotesScreenController.notesList[index]["title"],
                  description: NotesScreenController.notesList[index]
                      ["description"],
                  date: NotesScreenController.notesList[index]["date"],
                  colorIndex: NotesScreenController.notesList[index]
                      ["colorIndex"],
                  onDeletePressed: () {
                    NotesScreenController.deleteNote(index);
                    setState(() {});
                  },
                  onEditPressed: () {
                    titleController.text =
                        NotesScreenController.notesList[index]["title"];
                    descriptionController.text =
                        NotesScreenController.notesList[index]["description"];
                    dateController.text =
                        NotesScreenController.notesList[index]["date"];
                    selectedColorIndex =
                        NotesScreenController.notesList[index]["colorIndex"];

                    customBottomSheet(
                        context: context, isEdit: true, index: index);
                  },
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: NotesScreenController.notesList.length));
  }

  Future<dynamic> customBottomSheet(
      {required BuildContext context, bool isEdit = false, int? index}) {
    return showModalBottomSheet(
        backgroundColor: Colors.grey.shade800,
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, bottomSetState) {
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        isEdit ? "Update Note" : "Add Note",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: "Title",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: "Description",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: dateController,
                        decoration: InputDecoration(
                            hintText: "Date",
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: InkWell(
                              onTap: () async {
                                final selectedDateTime = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030));
                                if (selectedDateTime != null) {
                                  String formatedDate =
                                      DateFormat("dd MMM yyyy")
                                          .format(selectedDateTime);
                                  dateController.text = formatedDate.toString();
                                }

                                bottomSetState(() {});
                              },
                              child: Icon(
                                Icons.date_range_rounded,
                                size: 25,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            4,
                            (index) => InkWell(
                                  onTap: () {
                                    selectedColorIndex = index;

                                    bottomSetState(() {});
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: selectedColorIndex == index
                                                ? 5
                                                : 0),
                                        color: NotesScreenController
                                            .colorList[index],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              if (isEdit == true) {
                                NotesScreenController.editNote(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    date: dateController.text,
                                    colorIndex: selectedColorIndex,
                                    index: index!);
                              } else {
                                NotesScreenController.addNote(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    date: dateController.text,
                                    colorIndex: selectedColorIndex);
                              }
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: Container(
                              width: 100,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  isEdit == true ? "Edit" : "Add",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ));
            }));
  }
}
