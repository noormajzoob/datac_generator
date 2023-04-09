import 'package:datac_generator/src/models/field_wrapper.dart';


String generateEqualMethod(String className, List<FieldWrapper> fields){
  StringBuffer buffer = StringBuffer();
  buffer.writeln('static bool eq($className obj, Object other){');
  buffer.writeln('if(identical(obj, other)) return true;');

  buffer.writeln('\nreturn other is $className && other.runtimeType == obj.runtimeType');

  for (var field in fields) {
    if(field.equalsEvaluator != null){
      buffer.write(' && ${field.equalsEvaluator}<${field.genericType()}>().evaluate(obj.${field.name}, other.${field.name})');
    }else{
      buffer.write(' && other.${field.name} == obj.${field.name}');
    }
  }
  buffer.writeln(';');
  buffer.writeln('}');
  return buffer.toString();
}