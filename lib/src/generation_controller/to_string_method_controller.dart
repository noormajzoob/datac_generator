import 'package:datac_annotations/datac_annotations.dart';
import 'package:datac_generator/src/factories/to_string_factory.dart';
import 'package:datac_generator/src/models/field_wrapper.dart';

String toStringMethodController(
    List<DataClassMethods?>? excludeList,
    String className,
    List<FieldWrapper> fields,
    ) {
  StringBuffer buffer = StringBuffer();

  if(excludeList?.contains(DataClassMethods.tostring) == false){
    buffer.writeln(generateToStringMethod(className, fields));
  }

  return buffer.toString();
}