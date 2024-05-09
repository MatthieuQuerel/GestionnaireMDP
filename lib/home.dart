import 'dart:io';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _encryptFile() async {
    const String password = 'MySuperSecretPassword'; // Mot de passe constant
    final inputFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt');

    try {
      // Vérifier si le fichier d'entrée existe
      if (!await inputFile.exists()) {
        print('Le fichier d\'entrée n\'existe pas.');
        return;
      }

      // Lire le contenu du fichier
      final content = await inputFile.readAsString();
      print('Contenu du fichier : $content');

      // Convertir le mot de passe en clé
      final key = encrypt.Key.fromUtf8(password.padRight(32)); // Pour une clé de 256 bits

      // Initialiser le chiffreur avec la clé
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      // Crypter le contenu
      final encryptedContent = encrypter.encrypt(content, iv: encrypt.IV.fromLength(16));

      // Écrire le message crypté dans un nouveau fichier
      await inputFile.writeAsString(encryptedContent.base64);

      print('Le fichier a été crypté avec succès.');
    } catch (e) {
      print('Une erreur s\'est produite lors du cryptage du fichier : $e');
    }
  }

  Future<void> _decryptFile() async {
    const String password = 'MySuperSecretPassword'; // Mot de passe constant
    final inputFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt');

    try {
      // Vérifier si le fichier d'entrée existe
      if (!await inputFile.exists()) {
        print('Le fichier d\'entrée n\'existe pas.');
        return;
      }

      // Lire le contenu du fichier chiffré
      final encryptedContent = await inputFile.readAsString();

      // Convertir le mot de passe en clé
      final key = encrypt.Key.fromUtf8(password.padRight(32)); // Pour une clé de 256 bits

      // Initialiser le chiffreur avec la clé
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      // Déchiffrer le contenu
      final decryptedContent = encrypter.decrypt64(encryptedContent, iv: encrypt.IV.fromLength(16));

      print('Contenu du fichier déchiffré : $decryptedContent');
    } catch (e) {
      print('Une erreur s\'est produite lors du déchiffrement du fichier : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock),
            onPressed: _encryptFile,
            tooltip: 'Crypter le fichier',
          ),
          IconButton(
            icon: const Icon(Icons.lock_open),
            onPressed: _decryptFile,
            tooltip: 'Déchiffrer le fichier',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
