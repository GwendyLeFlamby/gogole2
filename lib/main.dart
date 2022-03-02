import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogole/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GogolePage(),
    );
  }
}

class GogolePage extends StatelessWidget {
  const GogolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF9F9F9),
        margin: const EdgeInsets.all(20),
        child: Column(
          children: const [
            Flexible(
                flex: 1,
                child: Image(image: AssetImage("assets/images/logo.png"))),
            Flexible(flex: 4, child: GogoleInputField())
          ],
        ),
      ),
    );
  }
}

class GogoleInputField extends StatefulWidget {
  const GogoleInputField({Key? key}) : super(key: key);

  @override
  _GogoleInputFieldState createState() => _GogoleInputFieldState();
}

class _GogoleInputFieldState extends State<GogoleInputField> {
  String gogolizedText = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isScreenWide =
        MediaQuery.of(context).orientation == Orientation.landscape;

    controller.text = gogolizedText;
    return Container(
      padding: const EdgeInsets.all(30),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: isScreenWide ? Axis.horizontal : Axis.vertical,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  right: (isScreenWide ? 20 : 0),
                  bottom: (isScreenWide ? 0 : 20)),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: 6,
                decoration: const InputDecoration.collapsed(
                    hintText: "Etnrez nu etxte à gogolzier..."),
                onChanged: (value) {
                  setState(() {
                    gogolizedText = gogolize(value);
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  left: (isScreenWide ? 20 : 0), top: (isScreenWide ? 0 : 20)),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Stack(children: [
                TextField(
                  enabled: false,
                  keyboardType: TextInputType.multiline,
                  minLines: 6,
                  maxLines: 6,
                  controller: controller,
                  decoration: const InputDecoration.collapsed(hintText: ""),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: IconButton(
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: gogolizedText))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Text copied to clipboard")));
                      });
                    },
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
