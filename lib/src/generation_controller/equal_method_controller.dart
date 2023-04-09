import 'package:datac_annotations/datac_annotations.dart';
import 'package:datac_generator/src/factories/equals_factory.dart';
import 'package:datac_generator/src/models/field_wrapper.dart';

String equalsMethodController(
    List<DataClassMethods?>? excludeList,
    String className,
    List<FieldWrapper> fields,
    ) {
  StringBuffer buffer = StringBuffer();

  if(excludeList?.contains(DataClassMethods.equals) == false){
    buffer.writeln(generateEqualMethod(className, fields));
  }

  return buffer.toString();
}