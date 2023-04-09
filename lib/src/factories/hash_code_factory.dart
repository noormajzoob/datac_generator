import 'package:datac_generator/src/models/field_wrapper.dart';

String generateHashCodeMethod(String className, List<FieldWrapper> fields){
  StringBuffer buffer = StringBuffer();
  buffer.writeln('static int hashcode($className obj){');
  buffer.write('return ');

  int i = 0;
  for(var field in fields){
    if(i >= fields.length - 1){
      buffer.write('obj.${field.name}.hashCode;');
    }else{
      buffer.write('obj.${field.name}.hashCode ^ ');
    }
    ++i;
  }

  buffer.writeln('\n}');

  return buffer.toString();
}