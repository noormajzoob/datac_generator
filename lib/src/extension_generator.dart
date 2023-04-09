import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:datac_annotations/datac_annotations.dart';
import 'package:datac_generator/src/generation_controller/copy_with_method_controller.dart';
import 'package:datac_generator/src/generation_controller/equal_method_controller.dart';
import 'package:datac_generator/src/generation_controller/hash_code_method_controller.dart';
import 'package:datac_generator/src/generation_controller/json_method_controller.dart';
import 'package:datac_generator/src/generation_controller/to_string_method_controller.dart';
import 'package:datac_generator/src/visitors/model_visitor.dart';
import 'package:source_gen/source_gen.dart';


class ExtensionGenerator extends GeneratorForAnnotation<DataClass> {
  @override
  String generateForAnnotatedElement(
      Element element,
      ConstantReader annotation,
      BuildStep buildStep,
      ) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final  excludeList = this.excludeList(element);

    final buffer = StringBuffer();

    buffer.writeln(generateExtensionHeader(visitor.className));
    buffer.writeln(copyWithMethodsController(excludeList, visitor.className, visitor.constructorFields));
    buffer.writeln(toStringMethodController(excludeList, visitor.className, visitor.fields));
    buffer.writeln(equalsMethodController(excludeList, visitor.className, visitor.fields));
    buffer.writeln(jsonMethodController(excludeList, visitor.className, visitor.fields, visitor.constructorFields));
    buffer.writeln(hashcodeMethodController(excludeList, visitor.className, visitor.fields));
    buffer.writeln(generateExtensionFooter());

    return buffer.toString();
  }

  String generateExtensionHeader(String className) {
    return 'extension ${className}Extension on $className{';
  }

  String generateExtensionFooter() {
    return '}';
  }

  List<DataClassMethods?>? excludeList(Element element) {
    const typeChecker = TypeChecker.fromRuntime(DataClass);

    return typeChecker
        .firstAnnotationOfExact(element)
        ?.getField('exclude')
        ?.toListValue()
        ?.map((e) {
          int? index = e.getField('index')?.toIntValue();
          if (index != null) {
            return DataClassMethods.values[index];
          } else {
            null;
          }
      },
    ).toList();
  }

}
