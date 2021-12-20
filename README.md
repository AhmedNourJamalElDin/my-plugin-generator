# My Plugin - Generator

If you want to scan all your code-base, find all the classes annotated with your annotation, generate something for these classes.

Example:

You want to make IoC such as [injectable](https://pub.dev/packages/injectable) where you want to scan all classes annotated with @SingleTon and generate the corresponding singleton in your container.


How it works:

1. Scan your code
2. Find any class that has `SeeMe` annotation
3. Create a cache JSON for these class with attributes you want
4. Find any function annotated with `SeeMeScanner`
5. Create a `{FILE_NAME}.my_plugin.g.dart` file corresponding to file that has the `SeeMeScanner` function
5. Generate a function that prints the names of all the classes annotated with `SeeMe`
