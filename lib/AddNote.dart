import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('Notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        actions: [
          TextButton(
              onPressed: () {
                ref.add({
                  'title': title.text,
                  'note': note.text,
                }).whenComplete(() => Navigator.pop(context));
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ))
        ],
      )),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                    hintText: "Title", hintStyle: TextStyle(fontSize: 25)),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: TextField(
                  controller: note,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                      hintText: "Note", hintStyle: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
