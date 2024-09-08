// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/arg.dart';
import 'package:girepository/src/info/callable.dart';
import 'package:girepository/src/info/callback.dart';
import 'package:girepository/src/info/constant.dart';
import 'package:girepository/src/info/enum.dart';
import 'package:girepository/src/info/field.dart';
import 'package:girepository/src/info/function.dart';
import 'package:girepository/src/info/interface.dart';
import 'package:girepository/src/info/object.dart';
import 'package:girepository/src/info/property.dart';
import 'package:girepository/src/info/registered_type.dart';
import 'package:girepository/src/info/signal.dart';
import 'package:girepository/src/info/struct.dart';
import 'package:girepository/src/info/type.dart';
import 'package:girepository/src/info/union.dart';
import 'package:girepository/src/info/value.dart';
import 'package:girepository/src/info/vfunc.dart';
import 'package:girepository/src/libraries.dart';
import 'package:girepository/src/typelib.dart';
import 'package:girepository/src/types.dart';
import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';

enum GIInfoType implements GEnum {
  invalid(0),
  function(1),
  callback(2),
  struct(3),
  boxed(4),
  enum_(5),
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

base class GIBaseInfoNative extends Opaque {}

extension GIBaseInfoPointerExt on GIBaseInfo {
  Pointer<GIBaseInfoNative> get pointer => voidPointer.cast();
}

class GIBaseInfo {
  /// Avoid using this where possible, this is exposed only to allow
  /// pointer casting on subclasses, prefer using the pointer
  /// member exposed by extensions on the type.
  final Pointer<Void> voidPointer;

  @protected
  GIBaseInfo.raw(this.voidPointer);

  GIBaseInfo.fromPointer(Pointer<GIBaseInfoNative> pointer)
      : voidPointer = pointer.cast();

  bool equal(GIBaseInfo other) {
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
}

extension GIBaseInfoTypeExtension on GIBaseInfo {
  bool _typeMatch(Set<GIInfoType> types) {
    return types.contains(getType());
  }

  bool get isArgInfo {
    return _typeMatch({GIInfoType.arg});
  }

  bool get isCallableInfo {
    return _typeMatch({
      GIInfoType.function,
      GIInfoType.callback,
      GIInfoType.signal,
      GIInfoType.vfunc,
    });
  }

  bool get isConstantInfo {
    return _typeMatch({GIInfoType.constant});
  }

  bool get isEnumInfo {
    return _typeMatch({GIInfoType.enum_, GIInfoType.flags});
  }

  bool get isFieldInfo {
    return _typeMatch({GIInfoType.field});
  }

  bool get isFunctionInfo {
    return _typeMatch({GIInfoType.function});
  }

  bool get isInterfaceInfo {
    return _typeMatch({GIInfoType.interface});
  }

  bool get isObjectInfo {
    return _typeMatch({GIInfoType.object});
  }

  bool get isPropertyInfo {
    return _typeMatch({GIInfoType.property});
  }

  bool get isRegisteredTypeInfo {
    return _typeMatch({
      GIInfoType.boxed,
      GIInfoType.enum_,
      GIInfoType.flags,
      GIInfoType.interface,
      GIInfoType.object,
      GIInfoType.struct,
      GIInfoType.union,
    });
  }

  bool get isSignalInfo {
    return _typeMatch({GIInfoType.signal});
  }

  bool get isStructInfo {
    return _typeMatch({GIInfoType.struct});
  }

  bool get isTypeInfo {
    return _typeMatch({GIInfoType.type});
  }

  bool get isUnionInfo {
    return _typeMatch({GIInfoType.union});
  }

  bool get isValueInfo {
    return _typeMatch({GIInfoType.enumValue});
  }

  bool get isVFuncInfo {
    return _typeMatch({GIInfoType.vfunc});
  }

  G cast<G extends GIBaseInfo>() {
    return switch (G) {
      const (GIArgInfo) => GIArgInfo.fromPointer(pointer.cast()),
      const (GIBaseInfo) => GIBaseInfo.fromPointer(pointer.cast()),
      const (GICallableInfo) => GICallableInfo.fromPointer(pointer.cast()),
      const (GICallbackInfo) => GICallbackInfo.fromPointer(pointer.cast()),
      const (GIConstantInfo) => GIConstantInfo.fromPointer(pointer.cast()),
      const (GIEnumInfo) => GIEnumInfo.fromPointer(pointer.cast()),
      const (GIFieldInfo) => GIFieldInfo.fromPointer(pointer.cast()),
      const (GIFunctionInfo) => GIFunctionInfo.fromPointer(pointer.cast()),
      const (GIInterfaceInfo) => GIInterfaceInfo.fromPointer(pointer.cast()),
      const (GIObjectInfo) => GIObjectInfo.fromPointer(pointer.cast()),
      const (GIPropertyInfo) => GIPropertyInfo.fromPointer(pointer.cast()),
      const (GIRegisteredTypeInfo) =>
        GIRegisteredTypeInfo.fromPointer(pointer.cast()),
      const (GISignalInfo) => GISignalInfo.fromPointer(pointer.cast()),
      const (GIStructInfo) => GIStructInfo.fromPointer(pointer.cast()),
      const (GITypeInfo) => GITypeInfo.fromPointer(pointer.cast()),
      const (GIUnionInfo) => GIUnionInfo.fromPointer(pointer.cast()),
      const (GIValueInfo) => GIValueInfo.fromPointer(pointer.cast()),
      const (GIVFuncInfo) => GIVFuncInfo.fromPointer(pointer.cast()),
      _ => throw UnsupportedError("Can't cast to unsupported type $G"),
    } as G;
  }
}

final class GIAttributeIterNative extends Struct {
  // ignore: unused_field
  external Pointer<Void> _data;
}

extension type GIAttributeIter._(Pointer<GIAttributeIterNative> _this) {
  Pointer<GIAttributeIterNative> get pointer => _this;

  static GIAttributeIter init() {
    return GIAttributeIter._(
      calloc<GIAttributeIterNative>()..ref._data = nullptr,
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
