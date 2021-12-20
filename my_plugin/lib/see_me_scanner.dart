class SeeMeScanner {
  final List<String> generateForDir;
  final bool preferRelativeImports;
  final String initializerName;

  const SeeMeScanner({
    this.generateForDir = const ['lib'],
    this.preferRelativeImports = true,
    this.initializerName = r'$initSeeMeScanner',
  });
}

const seeMeScannerInit = SeeMeScanner();
