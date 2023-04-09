import 'package:datac_generator/src/models/field_wrapper.dart';

String generateToStringMethod(String className, List<FieldWrapper> fields){
  StringBuffer buffer = StringBuffer();

  buffer.writeln('static String toStringValue($className obj){');
  buffer.writeln('return "${generateClassString(className, fields)}";');
  buffer.writeln('}');

  return buffer.toString();
}

String generateClassString(String className, List<FieldWrapper> fields){
  StringBuffer buffer = StringBuffer();

  buffer.write('$className(');
  int index = 0;
  for (var field in fields) {
    if(index >= fields.length - 1){
      buffer.write('${field.name}: \${obj.${field.name}}');
    }else{
      buffer.write('${field.name}: \${obj.${field.name}}, ');
    }
    ++index;
  }
  buffer.write(')');

  return buffer.toString();
}