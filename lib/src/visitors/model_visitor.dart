import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:datac_annotations/datac_annotations.dart';
import 'package:datac_generator/src/models/constructor_wrapper.dart';
import 'package:datac_generator/src/models/field_wrapper.dart';
import 'package:source_gen/source_gen.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  List<FieldWrapper> fields = [];
  Map<ConstructorWrapper, List<FieldWrapper>> constructorFields = {};

  @override
  void visitConstructorElement(ConstructorElement element) {

    if(element.name == 'fromJson'){
      return;
    }
    final params = element.parameters
        .map((e) => FieldWrapper(
              name: e.name,
              type: e.type,
              equalsEvaluator: null,
              isNamed: e.isNamed,
            ))
        .toList();

    constructorFields[
      ConstructorWrapper(
      name: element.displayName,
      qualifier: getQualifier(element),
      isIgnore: isIgnored(element),
    )] = params;

    if (className == '') {
      final returnType = element.returnType.toString();
      className = returnType.replaceFirst('*', '');
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    // exclude hashCode field
    if (element.name != 'hashCode') {
      print('find annotation: ${getEqualsEvaluator(element)}');
      fields.add(
        FieldWrapper(
          name: element.name,
          type: element.type,
          equalsEvaluator: getEqualsEvaluator(element),
          isNamed: false,
        ),
      );
    }
  }

  bool isIgnored(ConstructorElement element) {
    const typeCheck = TypeChecker.fromRuntime(Ignore);

    return typeCheck.hasAnnotationOfExact(element);
  }

  String getQualifier(ConstructorElement element) {
    const typeCheck = TypeChecker.fromRuntime(Qualifier);
    String qualifier = '';

    if (typeCheck.hasAnnotationOfExact(element)) {
      qualifier = typeCheck
              .firstAnnotationOfExact(element)
              ?.getField('name')
              ?.toStringValue() ??
          '';
    }

    return qualifier;
  }

  String? getEqualsEvaluator(FieldElement element) {

    final equals = TypeChecker.fromRuntime(Equals);
    final listEqual = TypeChecker.fromRuntime(ListEquals);
    final mapEqual = TypeChecker.fromRuntime(MapEquals);
    final dateEquals = TypeChecker.fromRuntime(DataTimeEquals);

    if(listEqual.hasAnnotationOfExact(element)){
      return 'ListEqualsEvaluator';
    }

    if(mapEqual.hasAnnotationOfExact(element)){
      return 'MapEqualsEvaluator';
    }

    if(dateEquals.hasAnnotationOfExact(element)){
      return 'DateTimeEqualsEvaluator';
    }

    final fullDeclarationName = equals.firstAnnotationOfExact(element)
        ?.getField('evaluator')?.toTypeValue()?.getDisplayString(withNullability: false);

    int? endIndex = fullDeclarationName?.indexOf('<');

    if(endIndex == null || endIndex == -1){
      return null;
    }

    return fullDeclarationName?.substring(0, endIndex);
  }

}
