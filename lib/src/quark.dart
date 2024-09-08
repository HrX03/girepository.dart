// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:girepository/src/libraries.dart';

final G_FILE_ERROR = GQuark.fromString("g-file-error-quark");
final G_IO_ERROR = GQuark.fromString("g-io-error-quark");
final G_IREPOSITORY_ERROR = GQuark.fromString("g-irepository-error-quark");

extension type GQuark._(int value) {
  GQuark.fromValue(this.value) : assert(value > 0);

  factory GQuark.fromString(String str) {
    return using(
      (arena) => GQuark.fromValue(
        _g_quark_from_string(str.toNativeUtf8(allocator: arena).cast()),
      ),
    );
  }

  GQuark? tryString(String str) {
    return using((arena) {
      final int quarkValue = _g_quark_try_string(
        str.toNativeUtf8(allocator: arena).cast(),
      );
      if (quarkValue == 0) return null;
      return GQuark.fromValue(quarkValue);
    });
  }

  String get string {
    return _g_quark_to_string(value).cast<Utf8>().toDartString();
  }
}

final _g_quark_from_string = libglib.lookupFunction<
    Uint32 Function(Pointer<Char>),
    int Function(Pointer<Char>)>('g_quark_from_string');

final _g_quark_try_string = libglib.lookupFunction<
    Uint32 Function(Pointer<Char>),
    int Function(Pointer<Char>)>('g_quark_try_string');

final _g_quark_to_string = libglib.lookupFunction<
    Pointer<Char> Function(Uint32),
    Pointer<Char> Function(int)>('g_quark_to_string');
