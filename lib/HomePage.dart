// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_it/LoadingScreen.dart';
import 'package:note_it/about.dart';
import 'AddNote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'EditNote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseFirestore.instance.collection('Notes');

  bool loading = false;

  // @override
  // void initState() {

  //   if (ref == null) {
  //     setState(() => loading = true);
  //   } else {
  //     loading = false;
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: Center(
                child: Text(
                  'note it.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text(
                'About App',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutApp()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff202124),
        focusColor: Colors.blue,
        foregroundColor: Colors.amber,
        hoverColor: Colors.green,
        splashColor: Colors.tealAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNote(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('note it.'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNote(
                        docToEdit: ds,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey[700],
                  ),
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text(
                        ds['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ds['note'],
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
