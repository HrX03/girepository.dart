// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/base.dart';
import 'package:girepository/src/libraries.dart';
import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';

final class GIRegisteredTypeInfoNative extends Opaque {}

extension GIRegisteredTypeInfoPointerExt on GIRegisteredTypeInfo {
  Pointer<GIRegisteredTypeInfoNative> get pointer => voidPointer.cast();
}

class GIRegisteredTypeInfo extends GIBaseInfo {
  @protected
  GIRegisteredTypeInfo.raw(super.voidPointer) : super.raw();

  GIRegisteredTypeInfo.fromPointer(Pointer<GIRegisteredTypeInfoNative> pointer)
      : super.raw(pointer.cast());

  String getTypeName() {
    return _g_registered_type_info_get_type_name(pointer)
        .cast<Utf8>()
        .toDartString();
  }

  String getTypeInit() {
    return _g_registered_type_info_get_type_init(pointer)
        .cast<Utf8>()
        .toDartString();
  }

  int getGType() {
    return _g_registered_type_info_get_g_type(pointer);
  }
}

final _g_registered_type_info_get_type_name = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIRegisteredTypeInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIRegisteredTypeInfoNative>,
    )>('g_registered_type_info_get_type_name');

final _g_registered_type_info_get_type_init = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIRegisteredTypeInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIRegisteredTypeInfoNative>,
    )>('g_registered_type_info_get_type_init');

final _g_registered_type_info_get_g_type = libgirepository.lookupFunction<
    Size Function(
      Pointer<GIRegisteredTypeInfoNative>,
    ),
    int Function(
      Pointer<GIRegisteredTypeInfoNative>,
    )>('g_registered_type_info_get_g_type');
