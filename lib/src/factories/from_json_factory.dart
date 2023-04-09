import 'package:datac_generator/src/models/constructor_wrapper.dart';
import 'package:datac_generator/src/models/field_wrapper.dart';
import 'package:datac_generator/utils/dynamic_extensions.dart';
import 'package:datac_generator/utils/string_extensions.dart';

String generateFromJsonMethods(String className, Map<ConstructorWrapper, List<FieldWrapper>> fields){
  StringBuffer buffer = StringBuffer();

  fields.forEach((constructor, fields) {
    if(!constructor.isIgnore){
      buffer.writeln(fromJson(className,  constructor, fields));
    }
  });

  return buffer.toString();
}

String fromJson(String className, ConstructorWrapper constructor, List<FieldWrapper> constructorFields){
  StringBuffer buffer = StringBuffer();
  buffer.writeln('static $className fromJson${constructor.qualifier.capitalize()}(Map<String, dynamic> json){');
  buffer.writeln('return ${constructor.name}(');

  for (var field in constructorFields) {
    buffer.writeln(insertConstructorField(field));
  }
  buffer.writeln(');}');

  return buffer.toString();
}

String insertConstructorField(FieldWrapper field){
  StringBuffer buffer = StringBuffer();
  final typeStr = field.type.toString();

  if (field.isNamed) {
    if(DynamicXt.isList(field.type.toString())){
      buffer.writeln(
          "${field.name}: json['${field.name}'].foreEach((e) => ${field.genericType()}.fromJson(e)), ");
    }else if(DynamicXt.isObject(typeStr)){
      buffer.writeln(
          "${field.name}: $typeStr.fromJson(json['${field.name}']), ");
    }else {
      buffer.writeln(
          "${field.name}: json['${field.name}'], ");
    }
  } else {
    if(DynamicXt.isList(typeStr)){
      buffer.writeln(
          "(json['${field.name}'] as List<dynamic>).map((e) => ${field.genericType()}.fromJson(e)).toList(), ");
    }else if(DynamicXt.isObject(typeStr)){
      buffer.writeln(
          "$typeStr.fromJson(json['${field.name}']), ");
    }else {
      buffer.writeln(
          "json['${field.name}'], ");
    }
  }

  return buffer.toString();
}