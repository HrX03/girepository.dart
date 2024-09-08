// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:dlib_gen/src/errors.dart';
import 'package:dlib_gen/src/quark.dart';
import 'package:dlib_gen/src/libraries.dart';

T handleGError<T>(
  T Function(Pointer<Pointer<GErrorNative>> nativeErr) callback,
) {
  final nativeErr = calloc<Pointer<GErrorNative>>();
  final result = callback(nativeErr);

  if (nativeErr.value != nullptr) {
    throw GLibException(nativeErr.value);
  }

  return result;
}

final class GErrorNative extends Struct {
  @Uint32()
  external final int quark;

  @Int()
  external final int code;

  external final Pointer<Char> message;
}

extension type GError._(Pointer<GErrorNative> _this) {
  const GError.fromPointer(this._this);

  GQuark get quark => GQuark.fromValue(_this.ref.quark);
  int get code => _this.ref.code;
  String get message {
    return _this.ref.message.cast<Utf8>().toDartString();
  }

  GError copy() {
    return GError.fromPointer(_g_error_copy(_this));
  }

  bool matches(GQuark quark, GErrorEnum errorEnum) {
    return _g_error_matches(_this, quark.value, errorEnum.code);
  }

  bool matchesRaw(GQuark quark, int code) {
    return _g_error_matches(_this, quark.value, code);
  }

  void free() {
    return _g_error_free(_this);
  }
}

final _g_error_copy = libglib.lookupFunction<
    Pointer<GErrorNative> Function(Pointer<GErrorNative>),
    Pointer<GErrorNative> Function(Pointer<GErrorNative>)>(
  'g_error_copy',
);

final _g_error_free = libglib.lookupFunction<
    Void Function(Pointer<GErrorNative>),
    void Function(Pointer<GErrorNative>)>('g_error_free');

final _g_error_matches = libglib.lookupFunction<
    Bool Function(Pointer<GErrorNative>, Uint32, Int),
    bool Function(Pointer<GErrorNative>, int, int)>('g_error_matches');

class GLibException implements Exception {
  final GError error;

  GLibException(Pointer<GErrorNative> nativeErr)
      : error = GError.fromPointer(nativeErr);

  bool matches(GQuark quark, GErrorEnum errorEnum) {
    return error.matches(quark, errorEnum);
  }

  bool matchesRaw(GQuark quark, int code) {
    return error.matchesRaw(quark, code);
  }

  @override
  String toString() {
    return "GError(code ${error.code}, quark ${error.quark.string}): ${error.message}";
  }
}
