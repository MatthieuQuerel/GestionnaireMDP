import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/pages/AjouterModifier.dart'; 
 import 'package:myapp/ProcedureCrypteDecrypte.dart';

class MyGestionaire extends StatefulWidget {
  const MyGestionaire({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyGestionaire> createState() => _MyGestionaireState();
}

class _MyGestionaireState extends State<MyGestionaire> {
  List<Map<String, String>> users = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String encryptedFile = 'C:\\Users\\Matthieu\\myapp\\BDDMDP.txt';

    try {
      List<String> lines = [];
      File file = File(encryptedFile);
      Stream<List<int>> inputStream = file.openRead();

      await inputStream.transform(utf8.decoder).transform(LineSplitter()).forEach((String line) {
        lines.add(line);
      });

      setState(() {
        users = lines.map((line) {
          var parts = line.split(';');
          return {
            "id": parts[0],
            "username": parts[1],
            "password": parts[2],
          };
        }).toList();
      });
    } catch (e) {
      print('Erreur lors de la lecture du fichier: $e');
    }
  }

  void _modifyUser(int index) {
    int id = int.parse(users[index]['id']!);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AjouterModifier(title: 'Ajouter Modifier', id: id)),
    );
  }

  void _addUser() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AjouterModifier(title: 'Ajouter Modifier', id: 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20), // Ajustez selon votre besoin
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: 'Déconnexion',
              onPressed: () {
                final filePath = 'C:\\Users\\Matthieu\\myapp\\BDDMDP.txt';
                encodeFileToBase64(filePath, filePath);
                print('Fichier encodé en Base64 et enregistré dans $filePath');

                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('User')),
                  DataColumn(label: Text('MDP')),
                  DataColumn(label: Text('Modifier')),
                ],
                rows: users.map(
                  (user) => DataRow(
                    cells: [
                      DataCell(Text(user['id'].toString())),
                      DataCell(Text(user['username'].toString())),
                      DataCell(Text(user['password'].toString())),
                      DataCell(
                        ElevatedButton(
                          onPressed: () => _modifyUser(users.indexOf(user)),
                          child: Text('Modifier'),
                        ),
                      ),
                    ],
                  ),
                ).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Ajouter un utilisateur'),
            ),
          ],
        ),
      ),
    );
  }
}