import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../database_helper/database_helper.dart';
import '../model/note_model.dart';

class NoteController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  var notes = <Note>[].obs;

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  bool isEmpty() {
    return notes.isEmpty;
  }

  void addNoteToDatabase() async {
    String title = titleController.text;
    String content = contentController.text;
    Note note = Note(
      title: title,
      content: content,
      dateTimeEdited: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now()),
      dateTimeCreated: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now()),
      isFavorite: false,
    );
    await DatabaseHelper.instance.addNote(note);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void updateNote(int id, String dTCreated) async {
    final title = titleController.text;
    final content = contentController.text;
    Note note = Note(
      id: id,
      title: title,
      content: content,
      dateTimeEdited: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now()),
      dateTimeCreated: dTCreated,
    );
    await DatabaseHelper.instance.updateNote(note);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.offAllNamed('/home'); // Corrected route name
  }

  void deleteNote(int id) async {
    await DatabaseHelper.instance.deleteNote(id); // Corrected deletion
    getAllNotes();
  }

  void favoriteNote(int id) async {
    Note note = notes.firstWhere((note) => note.id == id);
    note.isFavorite = !note.isFavorite;
    await DatabaseHelper.instance.updateNote(note);
    getAllNotes();
  }


  void deleteAllNotes() async {
    await DatabaseHelper.instance.deleteAllNotes();
    getAllNotes();
  }

  void getAllNotes() async {
    notes.value = await DatabaseHelper.instance.getNoteList();
    update();
  }

  void shareNote(String title, String content) {
    Share.share("$title \n$content");
  }
}
