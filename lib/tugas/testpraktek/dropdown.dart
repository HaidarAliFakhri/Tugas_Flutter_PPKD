import 'package:flutter/material.dart';

class DropdownWidgetDay16 extends StatefulWidget {
  const DropdownWidgetDay16({super.key});

  @override
  State<DropdownWidgetDay16> createState() => _DropdownWidgetDay16State();
}

class _DropdownWidgetDay16State extends State<DropdownWidgetDay16> {
  String? dropDownValue;
  final List<String> listColor = ["Merah", "Hijau", "Biru"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton(
          value: dropDownValue,
          items: listColor.map((String val) {
            return DropdownMenuItem(
              value: val,
              child: Text(val, style: TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              dropDownValue = value;
            });
            print(dropDownValue);
          },
        ),
        Container(
          width: double.infinity,
          height: 100,
          color: dropDownValue == "Merah"
              ? Colors.red
              : dropDownValue == "Hijau"
              ? Colors.green
              : Colors.blue,
        ),
      ],
    );
  }
}
