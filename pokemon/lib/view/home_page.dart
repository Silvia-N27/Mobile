import 'package:flutter/material.dart';
import 'package:pokemon/view/pokemon_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 146, 168),
        title: const Text("PokeAPI", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/fundo_inicio.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GestureDetector(
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.catching_pokemon, color: Colors.white, size: 80),
                SizedBox(height: 20),
                Text(
                  "Buscar Pokémon",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PokemonPage()),
              );
            },
          ),
        ),
      ),
    );
  }
}
