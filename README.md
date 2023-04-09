A data class generator package used to generate all methods for your data class,
and save your time from writing boilerplate code for every class - although still you need to write a few code :)-.

## Methods
- equals.
- toString.
- hashCode.
- copyWith.
- fromJson.
- toJson.

## Usage
First, we need to do add datac_generator to the dependencies of the pubspec.yaml
```yaml
dev_dependencies:
  datac_generator: ^1.0.0

```
Next, we need to install it:
```properties
# Dart
pub get

# Flutter
flutter packages get
```

Import annotations package.
```dart
import 'package:datac_annotations/datac_annotations.dart';
```

Lastly, we need to mark class with *@DataClass()* annotation.

```dart
part 'person.g.dart';

@DataClass()
class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

}  
```

then run build runner command

```
 flutter pub run build_runner build --delete-conflicting-outputs
```

after that you can access method

```dart
@DataClass()
class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  @override
  int get hashCode => PersonExtension.hashcode(this);
  
  @override
  bool operator ==(Object other) => PersonExtension.eq(this, other);
  
  Map<String, dynamic> toJson() => PersonExtension.toJson(this);
  
  factory Person.fromJson(Map<String, dynamic> json) => PersonExtension.fromJson(json);
  
  @override
  String toString() => PersonExtension.toStringValue(this);

}

/// test
void main(){

  Person p1 = Person('name', 20);

  print(p1);
  print(p1.hashCode);
  print(p1.copyWith(age: 30));
  print(p1.toJson());

  Person p2 = Person('name', 20);
  print(p1 == p2);

}

/// output
///--------------
/// Person(name: name, age: 20)
/// 652408128
/// Person(name: name, age: 30)
/// {name: name, age: 20}
/// true
```

in case you don't need some of method to be generated you can use exclude params 
in DataClass witch accept list of DataClassMethods enum.

for example
```dart
@DataClass(exclude: [DataClassMethods.tostring])
class Person {}
```

if class has more than one constructor you have to unique name using *@Qualifier('constructorName')* in order to use for copy with method
```dart
@DataClass()
class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  @Qualifier('name')
  factory Person.name(String name) => Person(name, 0);
}

void main(){
  Person p = Person('Name', 20);
  p.copyWithName('another name');
}
```

if you don't need to create copy with method for specific constructor you
can use *@Ignore()* annotation.

```dart
@DataClass()
class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  @Ignore()
  factory Person.name(String name) => Person(name, 0);
}
```

if you need to add custom equals operator to some fields you can use *@Equals*
annotation with accept type of EqualsEvaluator.

example

```dart
/// first implement EqualsEvaluator class
class DateTimeEvaluator extends EqualsEvaluator<DateTime>{
  @override
  bool evaluate(DateTime obj, Object other) {
    if(other is! DateTime){
      return false;
    }

    return obj.isAtSameMomentAs(other);
  }

}

/// then add custom equals evaluator to field
@DataClass()
class Post{

  final String body;
  @Equals(evaluator: DateTimeEvaluator)
  final DateTime timstamp;

  Post(this.body, this.timstamp);

}

/// There is build in equals evaluator annotations:
/// 1- ListEquals.
/// 2- MapEquals.
/// 3- DateTimeEquals.
@DataClass()
class Post{

  final String body;
  @DateTimeEquals()
  final DateTime timstamp;

  Post(this.body, this.timstamp);

}

@DataClass()
class Country{

  final String name;
  @ListEquals()
  final List<Location> cityLocations;

  Country(this.name, this.cityLocations);

}

```