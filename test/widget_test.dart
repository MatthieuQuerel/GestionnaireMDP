// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:myapp/ProcedureCrypteDecrypte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:io'; 
import 'package:myapp/main.dart'; 
import 'package:myapp/pages/AjouterModifier.dart';


void encodeFileToBase64(String filePath, String outputFilePath) {
  final file = File(filePath);
  if (!file.existsSync()) {
    throw Exception('Le fichier $filePath n\'existe pas.');
  }

  final bytes = file.readAsBytesSync();
  final encoded = base64.encode(bytes);

  final outputFile = File(outputFilePath);
  outputFile.writeAsStringSync(encoded); 
}

void decodeBase64ToFile(String base64String, String outputPath) {
  final bytes = base64.decode(base64String);
  final outputFile = File(outputPath);
  outputFile.writeAsBytesSync(bytes);
}

void main() {
//metre   
//1;test;cool;
//2;matt;15minimum;
//3;okey;15minimum;
// dans BDDMDP.txt
  test('Test de cryptage et décryptage', () {
    final filePath = 'BDDMDP.txt';
    final encodedFilePath = 'BDDMDP_encoded.txt';
    final decodedFilePath = 'BDDMDP_decoded.txt';

    // Encodez le fichier en Base64
    encodeFileToBase64(filePath, encodedFilePath);

    // Vérifiez si le fichier encodé a été créé
    final encodedFile = File(encodedFilePath);
    expect(encodedFile.existsSync(), true);

    // Décodage du fichier encodé
    final encodedContent = encodedFile.readAsStringSync();
    decodeBase64ToFile(encodedContent, decodedFilePath);

    // Vérifiez si le fichier décodé a été créé
    final decodedFile = File(decodedFilePath);
    expect(decodedFile.existsSync(), true);

    final originalContent = File(filePath).readAsStringSync();
    final decodedContent = decodedFile.readAsStringSync();
    expect(decodedContent, originalContent);
  });


  // Ajouter des tests pour le widget AjouterModifier
  group('Tests pour AjouterModifier Widget', () {
    setUp(() async {
      final file = File('BDDMDP.txt');
      await file.writeAsString('1;test;cool;\n2;matt;15minimum;\n');
    });

    tearDown(() async {
      // Nettoyage après les tests
      final file = File('BDDMDP.txt');
      if (await file.exists()) {
        await file.delete();
      }
    });

    testWidgets('Test ajout de nouvelles données', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AjouterModifier(title: 'Ajouter', id: 0)));

      // Simuler la saisie de données dans les champs
      await tester.enterText(find.byType(TextField).at(0), 'nouveau');
      await tester.enterText(find.byType(TextField).at(1), 'mdp123');

      // Simuler le clic sur le bouton de validation
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Vérifier que les données sont ajoutées
      final file = File('BDDMDP.txt');
      final lines = await file.readAsLines();
      expect(lines.contains('3;nouveau;mdp123'), isTrue);
    });

    testWidgets('Test modification de données existantes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AjouterModifier(title: 'Modifier', id: 2)));

      // Modifier les informations
      await tester.enterText(find.byType(TextField).at(0), 'mattUpdated');
      await tester.enterText(find.byType(TextField).at(1), 'newPass');

      // Simuler le clic sur le bouton de validation
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Vérifier les modifications
      final file = File('BDDMDP.txt');
      final lines = await file.readAsLines();
      expect(lines.contains('2;mattUpdated;newPass'), isTrue);
    });
  });
}


