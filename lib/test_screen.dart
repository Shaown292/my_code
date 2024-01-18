import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Copy Text Example'),
        ),
        body: CopyTextRow(),
      ),
    );
  }
}

class CopyTextRow extends StatelessWidget {
  final String textToCopy = 'Hello, world!';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(textToCopy),
        ),
        IconButton(
          icon: Icon(Icons.copy),
          onPressed: () {
            _copyToClipboard(textToCopy);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Text copied to clipboard')),
            );
          },
        ),
      ],
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
