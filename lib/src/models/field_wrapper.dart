import 'package:analyzer/dart/element/type.dart';

class FieldWrapper {
  final String name;
  final DartType type;
  final String? equalsEvaluator;
  final bool isNamed;

  FieldWrapper({
    required this.name,
    required this.type,
    required this.equalsEvaluator,
    required this.isNamed,
  });

  String? genericType(){
    final typeStr = type.toString();
    final start = typeStr.indexOf('<');
    final end = typeStr.indexOf('>');

    if(start == -1 || end == -1){
      return null;
    }

    return typeStr.substring(start + 1, end);
  }

}
