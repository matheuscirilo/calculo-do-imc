import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController massaController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFiled() {
    massaController.text = "";
    alturaController.text = "";
    setState(() {
      _infotext = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculaImc() {
    setState(() {
      double peso = double.parse(massaController.text);
      double tamanho = double.parse(alturaController.text) / 100;

      double imc = (peso / (tamanho * tamanho));

      if (imc < 18.6) {
        _infotext = "Abaixo do peso ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infotext = "Peso ideal ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infotext = "Levemente acima do peso ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infotext = "Obesidade grau 1 ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infotext = "Obesidade grau 2 ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40) {
        _infotext = "Obesidade grau 3 ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  String _infotext = "Informe seus dados";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFiled,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.person_outline,
                      size: 120,
                      color: Colors.green,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        controller: massaController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira seu peso";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Massa (KG)",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25)),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        controller: alturaController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira sua altura";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Altura (cm)",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25)),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                          height: 50,
                          child: RaisedButton(
                            onPressed: (){
                              if(_formKey.currentState.validate()){
                                _calculaImc();
                              }
                            },
                            child: Text(
                              "Calcular",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            color: Colors.green,
                          )),
                    ),
                    Text(
                      _infotext,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    )
                  ]),
            )));
  }
}
