import 'package:datac_generator/src/models/constructor_wrapper.dart';
import 'package:datac_generator/src/models/field_wrapper.dart';
import 'package:datac_generator/utils/string_extensions.dart';

String generateCopyWithMethods(
    String className, Map<ConstructorWrapper, List<FieldWrapper>> fields) {
  fields.forEach((key, value) {
    print('${key.name}, ${value.join()}');
  });

  final buffer = StringBuffer();

  fields.forEach((constructor, fields) {
    if (!constructor.isIgnore) {
      buffer.writeln(
        copWith(
          className: className,
          constructor: constructor,
          constructorFields: fields,
        ),
      );
    }
  });

  return buffer.toString();
}

String insertConstructorField(FieldWrapper field) {
  StringBuffer buffer = StringBuffer();

  if (field.isNamed) {
    buffer.writeln('${field.name}: ${field.name}?? this.${field.name},');
  } else {
    buffer.writeln('${field.name}?? this.${field.name},');
  }

  return buffer.toString();
}

String copWith({
  required String className,
  required ConstructorWrapper constructor,
  required List<FieldWrapper> constructorFields,
}) {
  StringBuffer buffer = StringBuffer();

  buffer.writeln(
      '$className copyWith${constructor.qualifier.capitalize()}({');
  for (var field in constructorFields) {
    final typeStr = field.type.toString();
    buffer.writeln('${typeStr.addNullableMark()} ${field.name},');
  }

  buffer.writeln('}){');
  buffer.writeln('return ${constructor.name}(');

  for (var field in constructorFields) {
    buffer.writeln(insertConstructorField(field));
  }
  buffer.writeln(');}');

  return buffer.toString();
}
