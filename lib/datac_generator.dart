library datac_generator;

import 'package:build/build.dart';
import 'package:datac_generator/src/extension_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder dataClassGenerator(BuilderOptions options) =>
    SharedPartBuilder([ExtensionGenerator()], 'data_class');