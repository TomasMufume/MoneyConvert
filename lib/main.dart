import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=60df7606";

void main() async{

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.red,
      primaryColor: Colors.green
    ),
    debugShowCheckedModeBanner: false,

  ));
}

Future <Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged (String text){
    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged (String text){
    double dolar = double.parse(text);
    dolarController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged (String text){
    double euro = double.parse(text);
    dolarController.text = (euro * this.euro).toStringAsFixed(2);
    euroController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("\$ Money Convert \$"),
        backgroundColor: Colors.red,
        centerTitle: true,
        ),
      body: FutureBuilder <Map> (
          future: getData(),
          // ignore: missing_return
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Carregando dados!", style: TextStyle(
                    color: Colors.red,
                    fontSize: 25),
                  textAlign: TextAlign.center),

                );
              default:
                if(snapshot.hasError){
                  return Center(
                    child: Text("Erro Carregando dados!", style: TextStyle(
                        color: Colors.red,
                        fontSize: 25),
                        textAlign: TextAlign.center),

                  );
                } else{
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.money_off, size: 150, color: Colors.redAccent),
                        Divider(),
                        buildTextField("Reais", "R\$ ", realController, _realChanged),
                        Divider(),
                        buildTextField("Dolares", "USD ", dolarController, _dolarChanged),
                        Divider(),
                        buildTextField("Euros", "€ ", euroController, _euroChanged)
                        ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
 Widget buildTextField(String label, prefix, TextEditingController c, Function f){
  return  TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.red),
        border: OutlineInputBorder(),
        prefixText: prefix
    ),
    style: TextStyle(
        color: Colors.red, fontSize: 25
    ),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
 }