import 'package:datac_generator/src/models/field_wrapper.dart';
import 'package:datac_generator/utils/dynamic_extensions.dart';

String generateToJsonMethod(String className, List<FieldWrapper> fields){
  StringBuffer buffer = StringBuffer();
  buffer.writeln('static Map<String, dynamic> toJson($className obj){');
  buffer.writeln('return {');

  for (var field in fields) {
    final typeStr = field.type.toString();

    if(DynamicXt.isList(typeStr)){
      buffer.writeln("'${field.name}': obj.${field.name}.map((e) => e.toJson()).toList(), ");
    }else if(DynamicXt.isObject(typeStr)){
      buffer.writeln("'${field.name}': obj.${field.name}.toJson(), ");
    }else {
      buffer.writeln("'${field.name}': obj.${field.name}, ");
    }
  }

  buffer.writeln('};\n}');
  return buffer.toString();
}
