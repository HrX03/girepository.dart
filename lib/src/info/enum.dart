// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/function.dart';
import 'package:girepository/src/info/registered_type.dart';
import 'package:girepository/src/info/type.dart';
import 'package:girepository/src/info/value.dart';
import 'package:girepository/src/libraries.dart';
import 'package:girepository/src/quark.dart';
import 'package:girepository/src/types.dart';
import 'package:ffi/ffi.dart';

final class GIEnumInfoNative extends Opaque {}

extension GIEnumInfoPointerExt on GIEnumInfo {
  Pointer<GIEnumInfoNative> get pointer => voidPointer.cast();
}

class GIEnumInfo extends GIRegisteredTypeInfo {
  GIEnumInfo.fromPointer(Pointer<GIEnumInfoNative> pointer)
      : super.raw(pointer.cast());

  int getNValues() {
    return _g_enum_info_get_n_values(pointer);
  }

  GIValueInfo getValue(int index) {
    return GIValueInfo.fromPointer(
      _g_enum_info_get_value(pointer, index),
    );
  }

  List<GIValueInfo> getValues() {
    final List<GIValueInfo> result = [];
    final nValues = getNValues();

    for (int i = 0; i < nValues; i++) {
      result.add(getValue(i));
    }

    return result;
  }

  int getNMethods() {
    return _g_enum_info_get_n_methods(pointer);
  }

  GIFunctionInfo getMethod(int index) {
    return GIFunctionInfo.fromPointer(
      _g_enum_info_get_method(pointer, index),
    );
  }

  List<GIFunctionInfo> getMethods() {
    final List<GIFunctionInfo> result = [];
    final nMethods = getNMethods();

    for (int i = 0; i < nMethods; i++) {
      result.add(getMethod(i));
    }

    return result;
  }

  GITypeTag getStorageType() {
    return GEnum.fromValue(
      _g_enum_info_get_storage_type(pointer),
      GITypeTag.values,
    );
  }

  GQuark? getErrorDomain() {
    final result = _g_enum_info_get_error_domain(pointer);
    if (result == nullptr) return null;
    return GQuark.fromString(result.cast<Utf8>().toDartString());
  }
}

final _g_enum_info_get_n_values = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIEnumInfoNative>,
    ),
    int Function(
      Pointer<GIEnumInfoNative>,
    )>('g_enum_info_get_n_values');

final _g_enum_info_get_value = libgirepository.lookupFunction<
    Pointer<GIValueInfoNative> Function(
      Pointer<GIEnumInfoNative>,
      Int,
    ),
    Pointer<GIValueInfoNative> Function(
      Pointer<GIEnumInfoNative>,
      int,
    )>('g_enum_info_get_value');

final _g_enum_info_get_n_methods = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIEnumInfoNative>,
    ),
    int Function(
      Pointer<GIEnumInfoNative>,
    )>('g_enum_info_get_n_methods');

final _g_enum_info_get_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIEnumInfoNative>,
      Int,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIEnumInfoNative>,
      int,
    )>('g_enum_info_get_method');

final _g_enum_info_get_storage_type = libgirepository.lookupFunction<
    Int Function(Pointer<GIEnumInfoNative>),
    int Function(Pointer<GIEnumInfoNative>)>('g_enum_info_get_storage_type');

final _g_enum_info_get_error_domain = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIEnumInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIEnumInfoNative>,
    )>('g_enum_info_get_error_domain');
