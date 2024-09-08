// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:dlib_gen/src/info/base.dart';
import 'package:dlib_gen/src/info/field.dart';
import 'package:dlib_gen/src/info/function.dart';
import 'package:dlib_gen/src/libraries.dart';
import 'package:ffi/ffi.dart';

final class GIStructInfoNative extends Opaque {}

class GIStructInfo extends GIInfo<GIStructInfoNative> {
  const GIStructInfo.fromPointer(super.pointer);

  int getAlignment() {
    return _g_struct_info_get_alignment(pointer);
  }

  int getSize() {
    return _g_struct_info_get_size(pointer);
  }

  bool isGTypeStruct() {
    return _g_struct_info_is_gtype_struct(pointer);
  }

  bool isForeign() {
    return _g_struct_info_is_foreign(pointer);
  }

  int getNFields() {
    return _g_struct_info_get_n_fields(pointer);
  }

  GIFieldInfo getField(int index) {
    return GIFieldInfo.fromPointer(
      _g_struct_info_get_field(pointer, index),
    );
  }

  List<GIFieldInfo> getFields() {
    final List<GIFieldInfo> result = [];
    final nFields = getNFields();

    for (int i = 0; i < nFields; i++) {
      result.add(getField(i));
    }

    return result;
  }

  GIFieldInfo? findField(String name) {
    return using((arena) {
      final result = _g_struct_info_find_field(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GIFieldInfo.fromPointer(result);
    });
  }

  int getNMethods() {
    return _g_struct_info_get_n_methods(pointer);
  }

  GIFunctionInfo getMethod(int index) {
    return GIFunctionInfo.fromPointer(
      _g_struct_info_get_method(pointer, index),
    );
  }

  List<GIFunctionInfo> getConstants() {
    final List<GIFunctionInfo> result = [];
    final nMethods = getNMethods();

    for (int i = 0; i < nMethods; i++) {
      result.add(getMethod(i));
    }

    return result;
  }

  GIFunctionInfo? findMethod(String name) {
    return using((arena) {
      final result = _g_struct_info_find_method(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GIFunctionInfo.fromPointer(result);
    });
  }
}

final _g_struct_info_get_alignment = libgirepository.lookupFunction<
    Size Function(Pointer<GIStructInfoNative>),
    int Function(Pointer<GIStructInfoNative>)>('g_struct_info_get_alignment');

final _g_struct_info_get_size = libgirepository.lookupFunction<
    Size Function(Pointer<GIStructInfoNative>),
    int Function(Pointer<GIStructInfoNative>)>('g_struct_info_get_size');

final _g_struct_info_is_gtype_struct = libgirepository.lookupFunction<
    Bool Function(Pointer<GIStructInfoNative>),
    bool Function(
        Pointer<GIStructInfoNative>)>('g_struct_info_is_gtype_struct');

final _g_struct_info_is_foreign = libgirepository.lookupFunction<
    Bool Function(Pointer<GIStructInfoNative>),
    bool Function(Pointer<GIStructInfoNative>)>('g_struct_info_is_foreign');

final _g_struct_info_get_n_fields = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIStructInfoNative>,
    ),
    int Function(
      Pointer<GIStructInfoNative>,
    )>('g_struct_info_get_n_fields');

final _g_struct_info_get_field = libgirepository.lookupFunction<
    Pointer<GIFieldInfoNative> Function(
      Pointer<GIStructInfoNative>,
      Int,
    ),
    Pointer<GIFieldInfoNative> Function(
      Pointer<GIStructInfoNative>,
      int,
    )>('g_struct_info_get_field');

final _g_struct_info_find_field = libgirepository.lookupFunction<
    Pointer<GIFieldInfoNative> Function(
      Pointer<GIStructInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GIFieldInfoNative> Function(
      Pointer<GIStructInfoNative>,
      Pointer<Char>,
    )>('g_struct_info_find_field');

final _g_struct_info_get_n_methods = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIStructInfoNative>,
    ),
    int Function(
      Pointer<GIStructInfoNative>,
    )>('g_struct_info_get_n_methods');

final _g_struct_info_get_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIStructInfoNative>,
      Int,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIStructInfoNative>,
      int,
    )>('g_struct_info_get_method');

final _g_struct_info_find_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIStructInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIStructInfoNative>,
      Pointer<Char>,
    )>('g_struct_info_find_method');
