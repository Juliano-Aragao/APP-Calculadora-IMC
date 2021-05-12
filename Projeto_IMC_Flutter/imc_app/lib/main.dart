import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String  _infoText = " Informe seus dados! ";
  // criando funçõies para a acções dis botões

  void _resetFilds(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText =" Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });


  }

  void _calculate(){

    setState(() {
      double weight = double.parse(weightController.text) ;
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (  imc < 18.6 ) {
        _infoText = " Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal(${imc.toStringAsPrecision(4)} )";
      }else if (imc >= 24.9 && imc < 34.9) {
        _infoText = "Obsidade Grau I ( ${imc.toStringAsPrecision(4)}) ";
      } else if (imc >= 34.9 && imc < 39.9){
        _infoText = "Obseidade Grau II ( ${imc.toStringAsPrecision(4)}) ";
      }else if (imc >= 40){
        _infoText = "Obseidade Grau III ( ${imc.toStringAsPrecision(4)} )";
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora IMC'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFilds,
            )
          ],
        ),
        backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
          // é obrigado a colocar 0.0
          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.amber,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: " Peso em (KG)",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  controller: weightController,
                  validator: (value){
                    if (value.isEmpty){
                      return" Insira sua Peso";
                    }
                  },
                ),

                // novo campo de texto
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: " Altura (cm)",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 35.0),
                  controller: heightController,

                  validator: (value){
                    if (value.isEmpty){
                      return"Insira sua altura";
                    }
                  },


                ),

                // adicionando o botao
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 80.0,
                    child: RaisedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                  ),
                ),

                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
