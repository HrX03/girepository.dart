// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:dlib_gen/src/argument.dart';
import 'package:dlib_gen/src/info/base.dart';
import 'package:dlib_gen/src/info/type.dart';
import 'package:dlib_gen/src/libraries.dart';
import 'package:ffi/ffi.dart';

final class GIConstantInfoNative extends Opaque {}

class GIConstantInfo extends GIInfo<GIConstantInfoNative> {
  const GIConstantInfo.fromPointer(super.pointer);

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
