// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/base.dart';
import 'package:girepository/src/libraries.dart';

final class GIValueInfoNative extends Opaque {}

extension GIValueInfoPointerExt on GIValueInfo {
  Pointer<GIValueInfoNative> get pointer => voidPointer.cast();
}

class GIValueInfo extends GIBaseInfo {
  GIValueInfo.fromPointer(Pointer<GIValueInfoNative> pointer)
      : super.raw(pointer.cast());

  int getValue() {
    return _g_value_info_get_value(pointer);
  }
}

final _g_value_info_get_value = libgirepository.lookupFunction<
    Int64 Function(Pointer<GIValueInfoNative>),
    int Function(Pointer<GIValueInfoNative>)>('g_value_info_get_value');
