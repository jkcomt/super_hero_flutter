import 'package:flutter/material.dart';

class AttributeText extends StatelessWidget {
  final String tipo,text;

  AttributeText(this.tipo,this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(tipo,style: TextStyle(fontWeight: FontWeight.bold),),
        Text(text)
      ],
    );
  }
}