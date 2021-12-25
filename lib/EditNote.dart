import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditNote({required this.docToEdit});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit['title']);
    note = TextEditingController(text: widget.docToEdit['note']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        actions: [
          TextButton(
              onPressed: () {
                widget.docToEdit.reference.update({
                  'title': title.text,
                  'note': note.text,
                }).whenComplete(() => Navigator.pop(context));
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18),
              )),
          TextButton(
              onPressed: () {
                widget.docToEdit.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              child: const Text(
                "Delete",
                style: TextStyle(fontSize: 18),
              ))
        ],
      )),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: TextField(
                  controller: note,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(hintText: "Note"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
