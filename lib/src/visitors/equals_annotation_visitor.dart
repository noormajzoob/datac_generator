import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class EqualsAnnotationVisitor extends SimpleElementVisitor<void>{

  String? equalsType;

  @override
  void visitFieldElement(FieldElement element) {
    print('elem: ${element.displayName}');
    if(element.displayName == 'evaluator'){
      equalsType ??= element.type.toString();
    }
  }

  @override
  void visitSuperFormalParameterElement(SuperFormalParameterElement element) {
    print('elem: ${element.displayName}');
    if(element.displayName == 'evaluator') {
      equalsType ??= element.parameters.first.type.toString();
    }
  }

}