import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {//STL stateless e STF statefull, se coloca crtl shift R ele converte de um para o outro
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cont = 0;
  //controla pra nao fica negativo ou ficar maior que 11
  bool get isEmpty => cont == 0 ;
  bool get isFull => cont == 11;

  void decrement() {
    setState(() {
       cont --;
    });
  }

  void incriment() {
    setState(() {
      cont ++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 199, 193),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/campo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pontuação',
              style: TextStyle(
                fontSize: 30,
                color: Colors.purple,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 25),
            Text(cont.toString(), style: TextStyle(fontSize: 50, color: Colors.white)),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: isEmpty ? null : decrement, //nao deixa ficar negativo
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: Size(80, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Saiu',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(width: 25),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: Size(80, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: isFull ? null : incriment, //nao deixa passar de 11
                  child: Text(
                    'Entrou',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
