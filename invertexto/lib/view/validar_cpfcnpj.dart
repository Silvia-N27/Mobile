import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class ValidarCpfcnpj extends StatefulWidget {
  const ValidarCpfcnpj({super.key});

  @override
  State<ValidarCpfcnpj> createState() => _ValidarCpfcnpjState();
}

class _ValidarCpfcnpjState extends State<ValidarCpfcnpj> {
  String? campo;
  String? tipo;
  final apiService = Invertextoservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Digite um número",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: ((value) {
                setState(() {
                  campo = value;
                });
              }),
            ),
            SizedBox(height: 10.0),

            DropdownButtonFormField<String>(
              value: tipo,
              decoration: InputDecoration(
                labelText: "Escolha um para validar",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white),
              items: const [
                DropdownMenuItem(value: "cpf", child: Text("CPF")),
                DropdownMenuItem(value: "cnpj", child: Text("CNPJ")),
              ],
              onChanged: (value) {
                setState(() {
                  tipo = value;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: apiService.validarCPFeCNPJ(campo, tipo),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            snapshot.error.toString().replaceFirst(
                              "Exception: ",
                              "",
                            ),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            softWrap: true,
                          ),
                        );
                      } else {
                        return exibeResultado(context, snapshot);
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget exibeResultado(BuildContext contexto, AsyncSnapshot snapshot) {
    String resultado = '';

    if (snapshot.data != null) {
    bool valido = snapshot.data["valid"] == true;


      if (valido) {
        resultado += "true\n";
        resultado += '"${snapshot.data["formatted"]}"';
      } else {
        resultado += "false";
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        resultado,
        style: TextStyle(color: Colors.white, fontSize: 18),
        softWrap: true,
      ),
    );
  }
}
