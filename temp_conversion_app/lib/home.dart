import 'package:flutter/material.dart';

class tempConversion extends StatefulWidget {
  const tempConversion({super.key});

  @override
  State<tempConversion> createState() => _tempConversionState();
}

class _tempConversionState extends State<tempConversion> {
  final _tempController = TextEditingController();
  String _result = "";
  String _conversionType = 'To Celsius';
  List _history = [];

  void _calculate() {
    double inputTemp = double.tryParse(_tempController.text) ?? 0;
    double outputTemp;

    if (_conversionType == 'To Celsius') {
      outputTemp = (inputTemp - 32) * 5 / 9;
    } else {
      outputTemp = inputTemp * 9 / 5 + 32;
    }

    setState(() {
      _result = outputTemp.toStringAsFixed(1);
      _history.add('${_tempController.text} $_conversionType = $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Conversion',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tempController,
              decoration: const InputDecoration(
                labelText: 'Enter temperature',
              ),
            ),
            DropdownButton<String>(
              value: _conversionType,
              onChanged: (String? newValue) {
                setState(() {
                  _conversionType = newValue!;
                });
              },
              items: <String>['To Celsius', 'To Fahrenheit']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16.0),
            Text(
              _result,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'History',
              style:
                  TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
