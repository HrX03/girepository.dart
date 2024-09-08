// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/constant.dart';
import 'package:girepository/src/info/field.dart';
import 'package:girepository/src/info/function.dart';
import 'package:girepository/src/info/registered_type.dart';
import 'package:girepository/src/info/type.dart';
import 'package:girepository/src/libraries.dart';
import 'package:ffi/ffi.dart';

final class GIUnionInfoNative extends Opaque {}

extension GIUnionInfoPointerExt on GIUnionInfo {
  Pointer<GIUnionInfoNative> get pointer => voidPointer.cast();
}

class GIUnionInfo extends GIRegisteredTypeInfo {
  GIUnionInfo.fromPointer(Pointer<GIUnionInfoNative> pointer)
      : super.raw(pointer.cast());

  int getNFields() {
    return _g_union_info_get_n_fields(pointer);
  }

  GIFieldInfo getField(int index) {
    return GIFieldInfo.fromPointer(
      _g_union_info_get_field(pointer, index),
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

  int getNMethods() {
    return _g_union_info_get_n_methods(pointer);
  }

  GIFunctionInfo getMethod(int index) {
    return GIFunctionInfo.fromPointer(
      _g_union_info_get_method(pointer, index),
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

  GIFunctionInfo? findMethod(String name) {
    return using((arena) {
      final result = _g_union_info_find_method(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GIFunctionInfo.fromPointer(result);
    });
  }

  bool isDiscriminated() {
    return _g_union_info_is_discriminated(pointer);
  }

  int getDiscriminatorOffset() {
    return _g_union_info_get_discriminator_offset(pointer);
  }

  GITypeInfo? getDiscriminatorType() {
    final result = _g_union_info_get_discriminator_type(pointer);
    if (result == nullptr) return null;
    return GITypeInfo.fromPointer(result);
  }

  GIConstantInfo getDiscriminator(int index) {
    return GIConstantInfo.fromPointer(
      _g_union_info_get_discriminator(pointer, index),
    );
  }

  int getSize() {
    return _g_union_info_get_size(pointer);
  }

  int getAlignment() {
    return _g_union_info_get_alignment(pointer);
  }
}

final _g_union_info_get_n_fields = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIUnionInfoNative>,
    ),
    int Function(
      Pointer<GIUnionInfoNative>,
    )>('g_union_info_get_n_fields');

final _g_union_info_get_field = libgirepository.lookupFunction<
    Pointer<GIFieldInfoNative> Function(
      Pointer<GIUnionInfoNative>,
      Int,
    ),
    Pointer<GIFieldInfoNative> Function(
      Pointer<GIUnionInfoNative>,
      int,
    )>('g_union_info_get_field');

final _g_union_info_get_n_methods = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIUnionInfoNative>,
    ),
    int Function(
      Pointer<GIUnionInfoNative>,
    )>('g_union_info_get_n_methods');

final _g_union_info_get_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIUnionInfoNative>,
      Int,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIUnionInfoNative>,
      int,
    )>('g_union_info_get_method');

final _g_union_info_is_discriminated = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIUnionInfoNative>,
    ),
    bool Function(
      Pointer<GIUnionInfoNative>,
    )>('g_union_info_is_discriminated');

final _g_union_info_get_discriminator_offset = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIUnionInfoNative>,
    ),
    int Function(
      Pointer<GIUnionInfoNative>,
    )>('g_union_info_get_discriminator_offset');

final _g_union_info_get_discriminator_type = libgirepository.lookupFunction<
    Pointer<GITypeInfoNative> Function(
      Pointer<GIUnionInfoNative>,
    ),
    Pointer<GITypeInfoNative> Function(
      Pointer<GIUnionInfoNative>,
    )>('g_union_info_get_discriminator_type');

final _g_union_info_get_discriminator = libgirepository.lookupFunction<
    Pointer<GIConstantInfoNative> Function(
      Pointer<GIUnionInfoNative>,
      Int,
    ),
    Pointer<GIConstantInfoNative> Function(
      Pointer<GIUnionInfoNative>,
      int,
    )>('g_union_info_get_discriminator');

final _g_union_info_find_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIUnionInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIUnionInfoNative>,
      Pointer<Char>,
    )>('g_union_info_find_method');

final _g_union_info_get_size = libgirepository.lookupFunction<
    Size Function(Pointer<GIUnionInfoNative>),
    int Function(Pointer<GIUnionInfoNative>)>('g_union_info_get_size');

final _g_union_info_get_alignment = libgirepository.lookupFunction<
    Size Function(Pointer<GIUnionInfoNative>),
    int Function(Pointer<GIUnionInfoNative>)>('g_union_info_get_alignment');
