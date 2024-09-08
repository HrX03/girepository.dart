// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:dlib_gen/src/info/arg.dart';
import 'package:dlib_gen/src/info/constant.dart';
import 'package:dlib_gen/src/info/field.dart';
import 'package:dlib_gen/src/info/function.dart';
import 'package:dlib_gen/src/info/interface.dart';
import 'package:dlib_gen/src/info/property.dart';
import 'package:dlib_gen/src/info/signal.dart';
import 'package:dlib_gen/src/info/struct.dart';
import 'package:dlib_gen/src/info/type.dart';
import 'package:dlib_gen/src/info/vfunc.dart';
import 'package:dlib_gen/src/libraries.dart';
import 'package:dlib_gen/src/typelib.dart';
import 'package:dlib_gen/src/types.dart';
import 'package:ffi/ffi.dart';

enum GIInfoType implements GEnum {
  invalid(0),
  function(1),
  callback(2),
  struct(3),
  boxed(4),
  enumerate(5),
  flags(6),
  object(7),
  interface(8),
  constant(9),
  union(11),
  enumValue(12),
  signal(13),
  vfunc(14),
  property(15),
  field(16),
  arg(17),
  type(18),
  unresolved(19);

  @override
  final int value;

  const GIInfoType(this.value);

  @override
  String toString() {
    return _g_info_type_to_string(value).cast<Utf8>().toDartString();
  }
}

abstract class GIInfo<T extends NativeType> {
  final Pointer<T> pointer;

  const GIInfo(this.pointer);

  bool equal(GIInfo other) {
    return _g_base_info_equal(pointer.cast(), other.pointer.cast());
  }

  GIInfoType getType() {
    return GEnum.fromValue(
      _g_base_info_get_type(pointer.cast()),
      GIInfoType.values,
    );
  }

  GITypelib getTypelib() {
    return GITypelib.fromPointer(_g_base_info_get_typelib(pointer.cast()));
  }

  String getNamespace() {
    return _g_base_info_get_namespace(pointer.cast())
        .cast<Utf8>()
        .toDartString();
  }

  String? getName() {
    final result = _g_base_info_get_name(pointer.cast());

    if (result == nullptr) return null;
    return result.cast<Utf8>().toDartString();
  }

  String? getAttribute(String attribute) {
    return using((arena) {
      final result = _g_base_info_get_attribute(
        pointer.cast(),
        attribute.toNativeUtf8(allocator: arena).cast(),
      );

      if (result == nullptr) return null;
      return result.cast<Utf8>().toDartString();
    });
  }

  void forEachAttribute(void Function(String name, String value) callback) {
    final iterator = GIAttributeIter.init();
    final name = calloc<Pointer<Char>>();
    final value = calloc<Pointer<Char>>();
    while (_g_base_info_iterate_attributes(
      pointer.cast(),
      iterator._this,
      name,
      value,
    )) {
      callback(
        name.cast<Utf8>().toDartString(),
        value.cast<Utf8>().toDartString(),
      );
    }
  }

  GIBaseInfo getContainer() {
    return GIBaseInfo.fromPointer(_g_base_info_get_container(pointer.cast()));
  }

  bool isDeprecated() {
    return _g_base_info_is_deprecated(pointer.cast());
  }

  G cast<G extends GIInfo>() {
    return switch (G) {
      const (GIArgInfo) => GIArgInfo.fromPointer(pointer.cast()),
      const (GIBaseInfo) => GIBaseInfo.fromPointer(pointer.cast()),
      const (GIConstantInfo) => GIConstantInfo.fromPointer(pointer.cast()),
      const (GIFieldInfo) => GIFieldInfo.fromPointer(pointer.cast()),
      const (GIFunctionInfo) => GIFunctionInfo.fromPointer(pointer.cast()),
      const (GIInterfaceInfo) => GIInterfaceInfo.fromPointer(pointer.cast()),
      const (GIPropertyInfo) => GIPropertyInfo.fromPointer(pointer.cast()),
      const (GISignalInfo) => GISignalInfo.fromPointer(pointer.cast()),
      const (GIStructInfo) => GIStructInfo.fromPointer(pointer.cast()),
      const (GITypeInfo) => GITypeInfo.fromPointer(pointer.cast()),
      const (GIVFuncInfo) => GIVFuncInfo.fromPointer(pointer.cast()),
      _ => throw UnsupportedError("Can't cast to unsupported type $G"),
    } as G;
  }
}

base class GIBaseInfoNative extends Opaque {}

class GIBaseInfo extends GIInfo<GIBaseInfoNative> {
  const GIBaseInfo.fromPointer(super.pointer);
}

final class GIAttributeIterNative extends Struct {
  // ignore: unused_field
  external Pointer<Void> _data;
}

extension type GIAttributeIter._(Pointer<GIAttributeIterNative> _this) {
  static GIAttributeIter init() {
    final empty = calloc<Int>()..value = 0;
    return GIAttributeIter._(
      calloc<GIAttributeIterNative>()..ref._data = empty.cast(),
    );
  }
}

final _g_base_info_equal = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIBaseInfoNative>,
      Pointer<GIBaseInfoNative>,
    ),
    bool Function(
      Pointer<GIBaseInfoNative>,
      Pointer<GIBaseInfoNative>,
    )>('g_base_info_equal');

final _g_base_info_get_type = libgirepository.lookupFunction<
    UnsignedInt Function(Pointer<GIBaseInfoNative>),
    int Function(Pointer<GIBaseInfoNative>)>('g_base_info_get_type');

final _g_base_info_get_typelib = libgirepository.lookupFunction<
    Pointer<GITypelibNative> Function(
      Pointer<GIBaseInfoNative>,
    ),
    Pointer<GITypelibNative> Function(
      Pointer<GIBaseInfoNative>,
    )>('g_base_info_get_typelib');

final _g_base_info_get_namespace = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIBaseInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIBaseInfoNative>,
    )>('g_base_info_get_namespace');

final _g_base_info_get_name = libgirepository.lookupFunction<
    Pointer<Char> Function(Pointer<GIBaseInfoNative>),
    Pointer<Char> Function(Pointer<GIBaseInfoNative>)>('g_base_info_get_name');

final _g_base_info_get_attribute = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIBaseInfoNative>,
      Pointer<Char>,
    ),
    Pointer<Char> Function(
      Pointer<GIBaseInfoNative>,
      Pointer<Char>,
    )>('g_base_info_get_attribute');

final _g_base_info_iterate_attributes = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIBaseInfoNative>,
      Pointer<GIAttributeIterNative>,
      Pointer<Pointer<Char>>,
      Pointer<Pointer<Char>>,
    ),
    bool Function(
      Pointer<GIBaseInfoNative>,
      Pointer<GIAttributeIterNative>,
      Pointer<Pointer<Char>>,
      Pointer<Pointer<Char>>,
    )>('g_base_info_iterate_attributes');

final _g_base_info_get_container = libgirepository.lookupFunction<
    Pointer<GIBaseInfoNative> Function(
      Pointer<GIBaseInfoNative>,
    ),
    Pointer<GIBaseInfoNative> Function(
      Pointer<GIBaseInfoNative>,
    )>('g_base_info_get_container');

final _g_base_info_is_deprecated = libgirepository.lookupFunction<
    Bool Function(Pointer<GIBaseInfoNative>),
    bool Function(Pointer<GIBaseInfoNative>)>('g_base_info_is_deprecated');

final _g_info_type_to_string = libgirepository.lookupFunction<
    Pointer<Char> Function(UnsignedInt),
    Pointer<Char> Function(int)>('g_info_type_to_string');
