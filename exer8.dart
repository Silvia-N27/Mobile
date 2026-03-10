void main(List<String> arguments){
  int A = 5;
  int res = 1;
  String seq = '';

  for(int i = A; i >= 1; i--){
    res *= i;

    seq += i > 1 ? '$i X ' : '$i';
  }
  print('$A! = $seq = $res');
}
