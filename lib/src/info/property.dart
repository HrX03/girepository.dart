// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/arg.dart';
import 'package:girepository/src/info/base.dart';
import 'package:girepository/src/info/function.dart';
import 'package:girepository/src/info/type.dart';
import 'package:girepository/src/libraries.dart';
import 'package:girepository/src/types.dart';

enum GParamFlag implements GFlag {
  readable(0),
  writable(1),
  construct(2),
  constructOnly(3),
  laxValidation(4),
  staticName(5),
  staticNick(6),
  staticBlurb(7),
  explicitNotify(30),
  deprecated(31);

  @override
  final int value;

  const GParamFlag(this.value);
}

final class GIPropertyInfoNative extends Opaque {}

extension GIPropertyInfoPointerExt on GIPropertyInfo {
  Pointer<GIPropertyInfoNative> get pointer => voidPointer.cast();
}

class GIPropertyInfo extends GIBaseInfo {
  GIPropertyInfo.fromPointer(Pointer<GIPropertyInfoNative> pointer)
      : super.raw(pointer.cast());

  Set<GParamFlag> getFlags() {
    return GFlag.split(_g_property_info_get_flags(pointer), GParamFlag.values);
  }

  GITransfer getOwnershipTransfer() {
    return GEnum.fromValue(
      _g_property_info_get_ownership_transfer(pointer),
      GITransfer.values,
    );
  }

  GITypeInfo getTypeInfo() {
    return GITypeInfo.fromPointer(_g_property_info_get_type(pointer));
  }

  GIFunctionInfo? getGetter() {
    final result = _g_property_info_get_getter(pointer);
    if (result == nullptr) return null;
    return GIFunctionInfo.fromPointer(result);
  }

  GIFunctionInfo? getSetter() {
    final result = _g_property_info_get_setter(pointer);
    if (result == nullptr) return null;
    return GIFunctionInfo.fromPointer(result);
  }
}

final _g_property_info_get_flags = libgirepository.lookupFunction<
    UnsignedInt Function(Pointer<GIPropertyInfoNative>),
    int Function(Pointer<GIPropertyInfoNative>)>('g_property_info_get_flags');

final _g_property_info_get_ownership_transfer = libgirepository.lookupFunction<
    UnsignedInt Function(
      Pointer<GIPropertyInfoNative>,
    ),
    int Function(
      Pointer<GIPropertyInfoNative>,
    )>('g_property_info_get_ownership_transfer');

final _g_property_info_get_type = libgirepository.lookupFunction<
    Pointer<GITypeInfoNative> Function(
      Pointer<GIPropertyInfoNative>,
    ),
    Pointer<GITypeInfoNative> Function(
      Pointer<GIPropertyInfoNative>,
    )>('g_property_info_get_type');

final _g_property_info_get_getter = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIPropertyInfoNative>,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIPropertyInfoNative>,
    )>('g_property_info_get_getter');

final _g_property_info_get_setter = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIPropertyInfoNative>,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIPropertyInfoNative>,
    )>('g_property_info_get_setter');
