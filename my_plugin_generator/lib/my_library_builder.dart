import 'package:code_builder/code_builder.dart';

class MyLibraryBuilder {
  final String initializerName;

  MyLibraryBuilder({
    required this.initializerName,
  });

  Library build(List<Map> jsonData) {
    final calls = <Code>[
      const Code('print("Hello World!");'),
      const Code('print("I can see the following classes:");'),
      for(var json in jsonData)
        Code('print("${json['name']}");'),
    ];

    final initMethod = Method(
      (b) => b
        ..name = initializerName
        ..modifier = MethodModifier.async
        ..body = Block(
          (b) => b..statements.addAll(calls),
        )
        ..returns = TypeReference(
          (b) => b
            ..symbol = 'Future'
            ..types.add(const Reference('void')),
        ),
    );

    return Library((b) => b
      ..body.addAll([
        initMethod,
      ]));
  }
}
