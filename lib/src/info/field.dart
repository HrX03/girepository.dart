// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:dlib_gen/src/info/base.dart';
import 'package:dlib_gen/src/info/type.dart';
import 'package:dlib_gen/src/libraries.dart';
import 'package:dlib_gen/src/types.dart';

enum GIFieldInfoFlag implements GFlag {
  isReadable(0),
  isWritable(1);

  @override
  final int value;

  const GIFieldInfoFlag(this.value);
}

final class GIFieldInfoNative extends Opaque {}

class GIFieldInfo extends GIInfo<GIFieldInfoNative> {
  const GIFieldInfo.fromPointer(super.pointer);

  Set<GIFieldInfoFlag> getFlags() {
    return GFlag.split(
      _g_field_info_get_flags(pointer),
      GIFieldInfoFlag.values,
    );
  }

  int getOffset() {
    return _g_field_info_get_offset(pointer);
  }

  int getSize() {
    return _g_field_info_get_size(pointer);
  }

  GITypeInfo getTypeInfo() {
    return GITypeInfo.fromPointer(_g_field_info_get_type(pointer));
  }
}

final _g_field_info_get_flags = libgirepository.lookupFunction<
    UnsignedInt Function(Pointer<GIFieldInfoNative>),
    int Function(Pointer<GIFieldInfoNative>)>('g_field_info_get_flags');

final _g_field_info_get_offset = libgirepository.lookupFunction<
    Int Function(Pointer<GIFieldInfoNative>),
    int Function(Pointer<GIFieldInfoNative>)>('g_field_info_get_offset');

final _g_field_info_get_size = libgirepository.lookupFunction<
    Int Function(Pointer<GIFieldInfoNative>),
    int Function(Pointer<GIFieldInfoNative>)>('g_field_info_get_size');

final _g_field_info_get_type = libgirepository.lookupFunction<
    Pointer<GITypeInfoNative> Function(
      Pointer<GIFieldInfoNative>,
    ),
    Pointer<GITypeInfoNative> Function(
      Pointer<GIFieldInfoNative>,
    )>('g_field_info_get_size');
