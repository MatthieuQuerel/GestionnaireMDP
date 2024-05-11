import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/ProcedureCrypteDecrypte.dart';
import 'package:myapp/pages/Gestionaire.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 145, 2, 241),
        body: Stack(
          children: [
            Positioned(top: 80, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

 

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "KeyPass",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bienvenue",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Veuillez vous connecter avec vos informations"),
        const SizedBox(height: 60),
        _buildGreyText("Adresse mail"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Mot de passe"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("Se souvenir de moi"),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");

        if (emailController.text == "user@example.com" && passwordController.text == "MDSLEMOTSDEPASSE") {
  //          final key = generateKeyFromPassword('MDSLEMOTSDEPASSE');
  //         final inputFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt'); 
  //          final encryptedFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt'); 
  //          final decryptedFile = File('C:\\Users\\Matthieu\\myapp\\BDDMDP.txt');
          
  // //       encryptFile(key, inputFile, encryptedFile);
  // // print('Fichier crypté avec succès.');

  // decryptFile(key, encryptedFile, decryptedFile);

 final filePath = 'BDDMDP.txt';
 
  
  try {   
    final encodedString = File(filePath).readAsStringSync();
     decodeBase64ToFile(encodedString, filePath);
  } catch (e) {
    print('Erreur : $e');
  }
  
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const MyGestionaire(title: 'Gestionaire')),
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Identifiants incorrects'),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
    ),
  );
}

      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Se connecter"),
    );
  }
}

