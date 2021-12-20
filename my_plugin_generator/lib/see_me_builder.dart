import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:my_plugin/my_plugin.dart';
import 'package:source_gen/source_gen.dart';

const _seeMeTypeChecker = TypeChecker.fromRuntime(SeeMe);

class SeeMeBuilder extends Generator {
  @override
  FutureOr<String?> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    var output = <Map>[];
    for (var klass in library.classes) {
      if (!_seeMeTypeChecker.hasAnnotationOfExact(klass)) {
        continue;
      }

      // uncomment and change the following if you want to read some attributes of your SeeMe annotation
      // and send them to my_plugin_generator_builder

      // final seeMe = _seeMeTypeChecker.firstAnnotationOfExact(klass);
      // final reader = ConstantReader(seeMe);
      // final order = reader.peek('order')?.intValue;

      output.add({
        'name': klass.name,
        'uri': klass.source.uri.path,
        // 'order': order,
      });
    }

    return output.isEmpty ? null : jsonEncode(output);
  }
}

Builder seeMeBuilder(BuilderOptions options) {
  return LibraryBuilder(
    SeeMeBuilder(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.my_plugin.json',
  );
}
