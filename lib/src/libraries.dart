import 'dart:ffi';
import 'dart:io';

DynamicLibrary? _libgirepository;
DynamicLibrary get libgirepository => _libgirepository ??=
    DynamicLibrary.open(_girepositoryEnv ?? _girepositoryPlatform);

String? get _girepositoryEnv => Platform.environment['LIBGIREPOSITORY_PATH'];
String get _girepositoryPlatform {
  if (Platform.isMacOS) return 'libgirepository-1.0.0.dylib';
  if (Platform.isWindows) return 'libgirepository-1.0-0.dll';
  return 'libgirepository-1.0.so';
}

DynamicLibrary? _libgio;
DynamicLibrary get libgio =>
    _libgio ??= DynamicLibrary.open(_gioEnv ?? _gioPlatform);

String? get _gioEnv => Platform.environment['LIBGIO_PATH'];
String get _gioPlatform {
  if (Platform.isMacOS) return 'libgio-2.0.0.dylib';
  if (Platform.isWindows) return 'gio-2.0-0.dll';
  return 'libgio-2.0.so.0';
}

DynamicLibrary? _libglib;
DynamicLibrary get libglib =>
    _libglib ??= DynamicLibrary.open(_glibEnv ?? _glibPlatform);

String? get _glibEnv => Platform.environment['LIBGLIB_PATH'];
String get _glibPlatform {
  if (Platform.isMacOS) return 'libglib-2.0.0.dylib';
  if (Platform.isWindows) return 'glib-2.0-0.dll';
  return 'libglib-2.0.so.0';
}

DynamicLibrary? _libgobject;
DynamicLibrary get libgobject =>
    _libgobject ??= DynamicLibrary.open(_gobjectEnv ?? _gobjectPlatform);

String? get _gobjectEnv => Platform.environment['LIBGOBJECT_PATH'];
String get _gobjectPlatform {
  if (Platform.isMacOS) return 'libgobject-2.0.0.dylib';
  if (Platform.isWindows) return 'gobject-2.0-0.dll';
  return 'libgobject-2.0.so.0';
}
