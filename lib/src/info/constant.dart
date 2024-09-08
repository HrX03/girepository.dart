// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/argument.dart';
import 'package:girepository/src/info/base.dart';
import 'package:girepository/src/info/type.dart';
import 'package:girepository/src/libraries.dart';
import 'package:ffi/ffi.dart';

final class GIConstantInfoNative extends Opaque {}

extension GIConstantInfoPointerExt on GIConstantInfo {
  Pointer<GIConstantInfoNative> get pointer => voidPointer.cast();
}

class GIConstantInfo extends GIBaseInfo {
  GIConstantInfo.fromPointer(Pointer<GIConstantInfoNative> pointer)
      : super.raw(pointer.cast());

  void freeValue(GIArgument argument) {
    return _g_constant_info_free_value(pointer, argument.pointer);
  }

  GITypeInfo getTypeInfo() {
    return GITypeInfo.fromPointer(_g_constant_info_get_type(pointer));
  }

  GIArgument getValue() {
    final nativeArgument = calloc<GIArgumentNative>();
    _g_constant_info_get_value(pointer, nativeArgument);
    return GIArgument.fromPointer(nativeArgument);
  }
}

final _g_constant_info_free_value = libgirepository.lookupFunction<
    Void Function(
      Pointer<GIConstantInfoNative>,
      Pointer<GIArgumentNative>,
    ),
    void Function(
      Pointer<GIConstantInfoNative>,
      Pointer<GIArgumentNative>,
    )>('g_constant_info_free_value');

final _g_constant_info_get_type = libgirepository.lookupFunction<
    Pointer<GITypeInfoNative> Function(
      Pointer<GIConstantInfoNative>,
    ),
    Pointer<GITypeInfoNative> Function(
      Pointer<GIConstantInfoNative>,
    )>('g_constant_info_get_type');

final _g_constant_info_get_value = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIConstantInfoNative>,
      Pointer<GIArgumentNative>,
    ),
    int Function(
      Pointer<GIConstantInfoNative>,
      Pointer<GIArgumentNative>,
    )>('g_constant_info_get_value');
