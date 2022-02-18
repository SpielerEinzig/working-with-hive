import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:using_hive/bank_account.dart';

late Box box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  box = await Hive.openBox("box");

  Hive.registerAdapter(BankAccountAdapter());

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String label = "";
  String address = "";
  String qrCode = "";

  late BankAccount bankAccount;

  String finalLabel = "";
  String finalAddress = "";
  String finalQrCode = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    if (finalLabel.isNotEmpty) {
      return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Label: $label",
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "QR code: $qrCode",
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Address: $address",
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Storage persistence",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                onChanged: (value) {
                  setState(() {
                    label = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your label",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your address",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  setState(() {
                    qrCode = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your qr code link",
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  //putting data in boxes
                  box.put(
                      "bankAccount",
                      BankAccount(
                          label: label, address: address, qrCode: qrCode));
                  //accessing stored data
                  bankAccount = box.get("bankAccount");
                  setState(() {
                    finalLabel = bankAccount.label;
                    finalAddress = bankAccount.address;
                    finalQrCode = bankAccount.qrCode;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
