import 'package:flutter/material.dart';
import 'package:using_hive/constants.dart';
import 'package:using_hive/storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final StorageService _storageService = StorageService();
  String? persistedText;

  getData() {
    setState(() {
      persistedText = _storageService.readData();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Storage persistence with hive"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              persistedText != null ? persistedText! : "No data",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.07),
            TextField(
              controller: _textEditingController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter text to persist",
                labelText: "Text",
                labelStyle: const TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: textFieldBorder,
                enabledBorder: textFieldBorder,
                focusedErrorBorder: textFieldBorder,
                focusedBorder: textFieldBorder,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            CustomButton(
              text: "Submit",
              onPressed: () {
                setState(() {
                  _storageService.writeData(
                    value: _textEditingController.text.trim(),
                  );

                  persistedText = _storageService.readData();
                });
              },
            ),
            SizedBox(height: size.height * 0.02),
            CustomButton(
              text: "Delete",
              onPressed: () async {
                await _storageService.deleteData();

                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
