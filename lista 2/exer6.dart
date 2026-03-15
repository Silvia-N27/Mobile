void main(List<String> arguments) {
  List<String> frutas = ['Manga', 'Laranja', 'Melancia', 'Banana', 'Maçã'];

  var frutasComA = frutas.where((fruta) => fruta.toLowerCase().startsWith('a')).toList();

  print(frutasComA);
}