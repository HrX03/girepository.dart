// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:dlib_gen/src/info/base.dart';
import 'package:dlib_gen/src/libraries.dart';
import 'package:dlib_gen/src/types.dart';

enum GITypeTag implements GEnum {
  void_(0),
  boolean(1),
  int8(2),
  uint8(3),
  int16(4),
  uint16(5),
  int32(6),
  uint32(7),
  int64(8),
  uint64(9),
  float(10),
  double_(11),
  gtype(12),
  utf8(13),
  filename(14),
  array(15),
  interface(16),
  glist(17),
  gslist(18),
  ghash(19),
  error(20),
  unichar(21);

  @override
  final int value;

  const GITypeTag(this.value);
}

enum GIArrayType implements GEnum {
  c(0),
  array(1),
  ptrArray(2),
  byteArray(3);

  @override
  final int value;

  const GIArrayType(this.value);
}

final class GITypeInfoNative extends Opaque {}

class GITypeInfo extends GIInfo<GITypeInfoNative> {
  const GITypeInfo.fromPointer(super.pointer);

  bool isPointer() {
    return _g_type_info_is_pointer(pointer);
  }

  GITypeTag getTag() {
    return GEnum.fromValue(_g_type_info_get_tag(pointer), GITypeTag.values);
  }

  GITypeInfo getParamType(int index) {
    return GITypeInfo.fromPointer(_g_type_info_get_param_type(pointer, index));
  }

  GIBaseInfo? getInterface() {
    final result = _g_type_info_get_interface(pointer);
    if (result == nullptr) return null;
    return GIBaseInfo.fromPointer(result);
  }

  int getArrayLength() {
    return _g_type_info_get_array_length(pointer);
  }

  int getArrayFixedSize() {
    return _g_type_info_get_array_fixed_size(pointer);
  }

  bool isZeroTerminated() {
    return _g_type_info_is_null_terminated(pointer);
  }

  GIArrayType? getArrayType() {
    final result = _g_type_info_get_array_type(pointer);
    if (result < 0) return null;
    return GEnum.fromValue(result, GIArrayType.values);
  }
}

final _g_type_info_is_pointer = libgirepository.lookupFunction<
    Bool Function(Pointer<GITypeInfoNative>),
    bool Function(Pointer<GITypeInfoNative>)>('g_type_info_is_pointer');

final _g_type_info_get_tag = libgirepository.lookupFunction<
    UnsignedInt Function(Pointer<GITypeInfoNative>),
    int Function(Pointer<GITypeInfoNative>)>('g_type_info_get_tag');

final _g_type_info_get_param_type = libgirepository.lookupFunction<
    Pointer<GITypeInfoNative> Function(
      Pointer<GITypeInfoNative>,
      Int,
    ),
    Pointer<GITypeInfoNative> Function(
      Pointer<GITypeInfoNative>,
      int,
    )>('g_type_info_get_param_type');

final _g_type_info_get_interface = libgirepository.lookupFunction<
    Pointer<GIBaseInfoNative> Function(
      Pointer<GITypeInfoNative>,
    ),
    Pointer<GIBaseInfoNative> Function(
      Pointer<GITypeInfoNative>,
    )>('g_type_info_get_interface');

final _g_type_info_get_array_length = libgirepository.lookupFunction<
    Int Function(Pointer<GITypeInfoNative>),
    int Function(Pointer<GITypeInfoNative>)>('g_type_info_get_array_length');

final _g_type_info_get_array_fixed_size = libgirepository.lookupFunction<
    Int Function(Pointer<GITypeInfoNative>),
    int Function(
        Pointer<GITypeInfoNative>)>('g_type_info_get_array_fixed_size');

final _g_type_info_is_null_terminated = libgirepository.lookupFunction<
    Bool Function(Pointer<GITypeInfoNative>),
    bool Function(Pointer<GITypeInfoNative>)>('g_type_info_is_null_terminated');

final _g_type_info_get_array_type = libgirepository.lookupFunction<
    Int Function(Pointer<GITypeInfoNative>),
    int Function(Pointer<GITypeInfoNative>)>('g_type_info_get_array_type');
