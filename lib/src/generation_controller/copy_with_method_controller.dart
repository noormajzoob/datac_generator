import 'package:datac_annotations/datac_annotations.dart';
import 'package:datac_generator/src/factories/copy_with_factory.dart';
import 'package:datac_generator/src/models/constructor_wrapper.dart';
import 'package:datac_generator/src/models/field_wrapper.dart';

String copyWithMethodsController(
    List<DataClassMethods?>? excludeList,
    String className,
    Map<ConstructorWrapper, List<FieldWrapper>> fields,
    ) {
  StringBuffer buffer = StringBuffer();

  if(excludeList?.contains(DataClassMethods.copyWith) == false){
    buffer.writeln(generateCopyWithMethods(className, fields));
  }

  return buffer.toString();
}