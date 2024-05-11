// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:math';
// import 'package:pointycastle/pointycastle.dart';
// import 'dart:convert';
// Uint8List generateKeyFromPassword(String password) {
//   final keyBytes = Uint8List.fromList(password.codeUnits);
//   return keyBytes;
// }

// // void encryptFile(Uint8List key, File inputFile, File outputFile) {
// //   final cipher = BlockCipher('AES')..init(true, KeyParameter(key));
// //   final inputBytes = inputFile.readAsBytesSync();
// //   final encryptedBytes = cipher.process(Uint8List.fromList(inputBytes));
// //   outputFile.writeAsBytesSync(encryptedBytes);
// // }
// void encryptFile(Uint8List key, File inputFile, File outputFile) {
//   final cipher = BlockCipher('AES')..init(true, KeyParameter(key));

//   final inputLines = inputFile.readAsLinesSync();
//   final outputLines = <String>[];

//   for (var line in inputLines) {
//     final encryptedLine = cipher.process(Uint8List.fromList(line.codeUnits));
//     outputLines.add(base64.encode(encryptedLine));
//   }

//   outputFile.writeAsStringSync(outputLines.join('\n'));
// }

// void decryptFile(Uint8List key, File encryptedFile, File decryptedFile) {
//   final cipher = BlockCipher('AES')..init(false, KeyParameter(key));
//   final encryptedBytes = encryptedFile.readAsBytesSync();
//   final decryptedBytes = cipher.process(Uint8List.fromList(encryptedBytes));
//   decryptedFile.writeAsBytesSync(decryptedBytes);
// }

// void main() {
//   // Utilisation du mot de passe pour générer la clé
//   final key = generateKeyFromPassword('MDSLEMOTSDEPASSE');

//   // Chemins des fichiers
//   final inputFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt'); // Utilisation de 'r' pour raw string
//   final encryptedFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt');
//   final decryptedFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt');

//   // Crypter le fichier
//   encryptFile(key, inputFile, encryptedFile);
//   print('Fichier crypté avec succès.');

//   // Décrypter le fichier
//   decryptFile(key, encryptedFile, decryptedFile);
//   print('Fichier décrypté avec succès.');
// }



// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:io';
// import 'package:pointycastle/block/aes.dart';
// import 'package:pointycastle/block/modes/ecb.dart';
// import 'package:pointycastle/paddings/pkcs7.dart';
// import 'package:pointycastle/api.dart';
// import 'package:pointycastle/pointycastle.dart';
// import 'package:pointycastle/block/aes_fast.dart';

// Uint8List generateKeyFromPassword(String password) {
//   final utf8 = Utf8Encoder();
//   return Uint8List.fromList(utf8.convert(password));
// }

// void encryptFile(Uint8List key, File inputFile, File outputFile) {
//   final cipher = ECBBlockCipher(AESFastEngine())
//     ..init(
//       true,
//       KeyParameter(key),
//     );

//   final inputBytes = inputFile.readAsBytesSync();
//   final encryptedBytes = cipher.process(inputBytes); // Encrypt the input data

//   final encodedResult = base64.encode(encryptedBytes); // Encode the encrypted data as base64
//   outputFile.writeAsStringSync(encodedResult); // Write the encrypted data to the output file
// }

// void decryptFile(Uint8List key, File inputFile, File outputFile) {
//   final cipher = ECBBlockCipher(AESFastEngine())
//     ..init(
//       false, // Use decryption mode
//       KeyParameter(key),
//     );

//   final inputBytes = base64.decode(inputFile.readAsStringSync()); // Read Base64 encoded data
//   final decryptedBytes = cipher.process(inputBytes); // Decrypt the data

//   outputFile.writeAsBytesSync(decryptedBytes); // Write decrypted data to the output file
// }

// void main() {
//   // Utilisation du mot de passe pour générer la clé
//   final key = generateKeyFromPassword('MDSLEMOTSDEPASSE');

//   // Chemins des fichiers
//   final inputFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt');
//   final encryptedFile = File('C:\\Users\\Matthieu\\myapp\\encrypted_BDDMDP.txt');
//   final decryptedFile = File('C:\\Users\\Matthieu\\myapp\\decrypted_BDDMDP.txt');

//   // Crypter le fichier
//   encryptFile(key, inputFile, encryptedFile);
//   print('Fichier crypté avec succès.');

//   // Décrypter le fichier
//   decryptFile(key, encryptedFile, decryptedFile);
//   print('Fichier décrypté avec succès.');
// }

import 'dart:convert';
import 'dart:io';

// Fonction pour encoder un fichier en Base64 et écrire le contenu encodé dans un fichier
void encodeFileToBase64(String filePath, String outputFilePath) {
  final file = File(filePath);
  if (!file.existsSync()) {
    throw Exception('Le fichier $filePath n\'existe pas.');
  }

  final bytes = file.readAsBytesSync();
  final encoded = base64.encode(bytes);

  final outputFile = File(outputFilePath);
  outputFile.writeAsStringSync(encoded); // Écrire la chaîne encodée dans le fichier de sortie
}

// Fonction pour décoder une chaîne Base64 et écrire le contenu dans un fichier
void decodeBase64ToFile(String base64String, String outputPath) {
  final bytes = base64.decode(base64String);
  final outputFile = File(outputPath);
  outputFile.writeAsBytesSync(bytes);
}

void main() {
  final filePath = 'BDDMDP.txt';

  try {
    // Encoder le fichier en Base64 et enregistrer dans un fichier encodé
    encodeFileToBase64(filePath, filePath);
    print('Fichier encodé en Base64 et enregistré dans $filePath');

    // Lire le contenu du fichier encodé et décoder en écriture dans un fichier de sortie
    final encodedString = File(filePath).readAsStringSync();
    decodeBase64ToFile(encodedString, filePath);
    print('Fichier Base64 décodé avec succès et écrit dans $filePath');
  } catch (e) {
    print('Erreur : $e');
  }
}
