import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Base64App());
}

class Base64App extends StatelessWidget {
  const Base64App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Base64ConverterScreen(),
    );
  }
}

class Base64ConverterScreen extends StatefulWidget {
  const Base64ConverterScreen({super.key});

  @override
  _Base64ConverterScreenState createState() => _Base64ConverterScreenState();
}

class _Base64ConverterScreenState extends State<Base64ConverterScreen> {
  TextEditingController inputController = TextEditingController();
  String outputText = "";

  void encodeToBase64() {
    setState(() {
      outputText = base64Encode(utf8.encode(inputController.text));
    });
  }

  void decodeFromBase64() {
    try {
      setState(() {
        outputText = utf8.decode(base64Decode(inputController.text));
      });
    } catch (e) {
      setState(() {
        outputText = "Invalid Base64 string";
      });
    }
  }

  void openAboutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("About"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Developed by SystemDown"),
                SizedBox(height: 10),
                InkWell(
                  onTap:
                      () => launchUrl(
                        Uri.parse("https://github.com/systemdownTM"),
                      ),
                  child: Text(
                    "GitHub Repository",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Close"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FDECODE Base64"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: openAboutDialog,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                labelText: "Enter Text or Base64",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[900],
              ),
              maxLines: 3,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: encodeToBase64,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text("Encode"),
                ),
                ElevatedButton(
                  onPressed: decodeFromBase64,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text("Decode"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SelectableText(
                outputText,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
