import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightControler = TextEditingController();
  TextEditingController heightControler = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightControler.text = "";
    heightControler.text = "";
    setState(
      () {
        _formKey.currentState.reset();
        _infoText = "Informe seus dados!";
      },
    );
  }

  void _calculate() {
    setState(
      () {
        double weight = double.parse(weightControler.text);
        double height = double.parse(heightControler.text) / 100;
        double imc = weight / (height * height);

        if (imc < 18.0) {
          _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 18.6 && imc < 24.9) {
          _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 24.9 && imc < 29.9) {
          _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 29.9 && imc < 34.9) {
          _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 34.9 && imc < 39.9) {
          _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 40) {
          _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
        }

        // weightControler.text = "";
        // heightControler.text = "";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _resetFields(),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person_outline,
              size: 135,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                      controller: weightControler,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                      controller: heightControler,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 40.0,
                      margin: EdgeInsets.symmetric(vertical: 25),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }

                          return null;
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      _infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
