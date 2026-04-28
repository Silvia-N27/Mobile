import 'package:flutter/material.dart';
import 'package:pokemon/service/pokemon_service.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  String? campo;
  final apiService = PokemonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar Pokémon"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 143, 203, 221),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/fundo_pokemon.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 124, 171, 209).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: "Digite o nome do pokémon",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      campo = value.trim();
                    });
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: campo == null
                      ? null
                      : apiService.buscarPokemon(campo),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());

                      default:
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Erro ao buscar o pokémon"),
                          );
                        }
                        return exibeResultado(snapshot.data);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget exibeResultado(data) {
    final imagem = data["sprites"]["front_default"];
    final id = data["id"];
    final nome = data["name"];
    final tipo = data["types"].map((item) => item["type"]["name"]).join(", ");
    final altura = data["height"] / 10;
    final peso = data["weight"] / 10;
    final habilidades = data["abilities"]
        .map((item) => item["ability"]["name"])
        .join(", ");
    final experiencia = data["base_experience"];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Image.network(imagem, height: 120),

        Text("ID: $id"),
        Text("Nome: $nome"),
        Text("Tipo: $tipo"),
        Text("Altura: ${altura} m"),
        Text("Peso: ${peso} kg"),
        Text("Habilidades: $habilidades"),
        Text("Experiência base: $experiencia"),
      ],
    );
  }
}
