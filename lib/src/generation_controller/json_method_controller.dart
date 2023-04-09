import 'package:datac_annotations/datac_annotations.dart';
import 'package:datac_generator/src/factories/from_json_factory.dart';
import 'package:datac_generator/src/factories/to_json_factory.dart';
import 'package:datac_generator/src/models/constructor_wrapper.dart';
import 'package:datac_generator/src/models/field_wrapper.dart';

String jsonMethodController(
    List<DataClassMethods?>? excludeList,
    String className,
    List<FieldWrapper> fields,
    Map<ConstructorWrapper, List<FieldWrapper>> constructorFields
    ){
  StringBuffer buffer = StringBuffer();
  if(excludeList?.contains(DataClassMethods.json) == false){
    if(excludeList?.contains(DataClassMethods.toJson) == false){
      buffer.writeln(generateToJsonMethod(className, fields));
    }

    if(excludeList?.contains(DataClassMethods.fromJson) == false){
      buffer.writeln(generateFromJsonMethods(className, constructorFields));
    }
  }
  return buffer.toString();
}