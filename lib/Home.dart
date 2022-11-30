import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget
{
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  TextEditingController cepText = new TextEditingController();
  String result = "";

  _consultaCep() async
  {
    String textCep = cepText.text;

    String url = "https://viacep.com.br/ws/${textCep}/json/";
    Response response = (await get(Uri.parse(url)));

    Map<String,dynamic> retorno = json.decode(response.body);

    String cep = retorno["cep"];
    String logradouro = retorno["logradouro"];
    String cidade = retorno["localidade"];
    String bairro = retorno["bairro"];

    setState(() {
      result = "${cep} \n\n ${logradouro} \n\n ${cidade} \n\n ${bairro}";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultar Cep"),
        backgroundColor: Colors.green,
      ),
      body: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child : TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Entre com o Cep :',
                ),
                style: TextStyle(fontSize: 16),
                controller: cepText,
              ),
          ),
              Text("${result}", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),

              ElevatedButton.icon(
                icon: const Icon(Icons.search_rounded),
                label: const Text('Pesquisar'),
                onPressed: _consultaCep,
              ),
            ],
          )),
    );
  }
}