import 'dart:io';
import 'package:flutter/material.dart';

class AjouterModifier extends StatefulWidget {
  final String title;
  final int id;

  const AjouterModifier({Key? key, required this.title, required this.id}) : super(key: key);

  @override
  _AjouterModifierState createState() => _AjouterModifierState();
}

class _AjouterModifierState extends State<AjouterModifier> {
  final TextEditingController identifiantController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id > 0) {
      _loadData();
    }
  }

  void _loadData() async {
    final inputFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt');
    List<String> lines = await inputFile.readAsLines();
    String line = lines.firstWhere((line) => line.startsWith('${widget.id};'), orElse: () => '');
    if (line.isNotEmpty) {
      List<String> parts = line.split(';');
      identifiantController.text = parts[1];
      motDePasseController.text = parts[2];
    }
  }

  void _saveData() async {
    // Vérifie que les champs ne sont pas vides
    if (identifiantController.text.isEmpty || motDePasseController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tous les champs doivent être complétés.'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Arrête l'exécution si les champs sont vides
    }

    final outputFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt');
    List<String> lines = await outputFile.readAsLines();
    int newId = widget.id;

    if (widget.id == 0) {
      newId = (lines.map((line) => int.parse(line.split(';')[0])).fold(0, (prev, curr) => curr > prev ? curr : prev)) + 1;
    }

    String newData = '$newId;${identifiantController.text};${motDePasseController.text}';

    if (widget.id > 0) {
      lines = lines.map((line) => line.startsWith('${widget.id};') ? newData : line).toList();
    } else {
      lines.add(newData);
    }
    await outputFile.writeAsString(lines.join('\n'));
    Navigator.pushReplacementNamed(context, '/gestionaire');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/gestionaire'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: identifiantController,
              decoration: InputDecoration(labelText: 'Identifiant'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: motDePasseController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
