import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' as cb;
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';
import 'package:my_plugin/my_plugin.dart';
import 'package:my_plugin_generator/my_library_builder.dart';
import 'package:source_gen/source_gen.dart';

class SeeMeScannerBuilder extends GeneratorForAnnotation<SeeMeScanner> {
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final initializerName = annotation.read('initializerName').stringValue;

    final generateForDir = annotation
        .read('generateForDir')
        .listValue
        .map((e) => e.toStringValue());

    final dirPattern = generateForDir.length > 1
        ? '{${generateForDir.join(',')}}'
        : '${generateForDir.first}';

    final seeMeConfigFiles = Glob("$dirPattern/**.my_plugin.json");
    final jsonData = <Map>[];

    await for (final id in buildStep.findAssets(seeMeConfigFiles)) {
      // here you receive all the data from my_plugin_builder
      jsonData.addAll([...json.decode(await buildStep.readAsString(id))]);
    }

    final library =
        MyLibraryBuilder(initializerName: initializerName).build(jsonData);

    final emitter = cb.DartEmitter(
      allocator: cb.Allocator.simplePrefixing(),
      orderDirectives: true,
      useNullSafetySyntax: true,
    );

    return DartFormatter().format(library.accept(emitter).toString());
  }
}

Builder seeMeScannerBuilder(BuilderOptions options) {
  return LibraryBuilder(
    SeeMeScannerBuilder(),
    generatedExtension: '.my_plugin.g.dart',
  );
}
