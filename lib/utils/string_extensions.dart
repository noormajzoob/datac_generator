extension StringTx on String{

  String addNullableMark(){
    return '${replaceFirst('?', '')}?';
  }

  String removeNullableMark(){
    return replaceFirst('?', '');
  }

  String capitalize(){
    if(this == '') return '';

    String firstChar = this[0].toUpperCase();
    return firstChar + substring(1);
  }

}