import 'package:datac_annotations/datac_annotations.dart';
import 'package:datac_generator/src/factories/hash_code_factory.dart';
import 'package:datac_generator/src/models/field_wrapper.dart';

String hashcodeMethodController(
    List<DataClassMethods?>? excludeList,
    String className,
    List<FieldWrapper> fields,
    ) {
  StringBuffer buffer = StringBuffer();

  if(excludeList?.contains(DataClassMethods.hashcode) == false){
    buffer.writeln(generateHashCodeMethod(className, fields));
  }

  return buffer.toString();
}