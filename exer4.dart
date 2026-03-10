void main(List<String> arguments){
  int a = 1;
  int b = 2;
  int c = 3;
  List<int> numeros = [a, b, c];

  numeros.sort((b, a) => a.compareTo(b));
  print(numeros);
}