extension DynamicXt on dynamic{

  static bool isList(dynamic obj)=> obj.contains('List');
  static bool isPrimitive(dynamic obj){
    return obj == 1.runtimeType.toString() || obj == 0.0.runtimeType.toString() ||
        obj == "".runtimeType.toString() || obj == true.runtimeType.toString();
  }

  static bool isObject(dynamic obj)=> !isPrimitive(obj);
}