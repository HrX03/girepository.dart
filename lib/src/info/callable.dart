// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/arg.dart';
import 'package:girepository/src/info/base.dart';
import 'package:girepository/src/info/type.dart';
import 'package:girepository/src/libraries.dart';
import 'package:girepository/src/types.dart';
import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';

final class GICallableInfoNative extends Opaque {}

extension GICallableInfoPointerExt on GICallableInfo {
  Pointer<GICallableInfoNative> get pointer => voidPointer.cast();
}

class GICallableInfo extends GIBaseInfo {
  @protected
  GICallableInfo.raw(super.voidPointer) : super.raw();

  GICallableInfo.fromPointer(Pointer<GICallableInfoNative> pointer)
      : super.raw(pointer.cast());

  bool canThrowGError() {
    return _g_callable_info_can_throw_gerror(pointer);
  }

  int getNArgs() {
    return _g_callable_info_get_n_args(pointer);
  }

  GIArgInfo getArg(int index) {
    return GIArgInfo.fromPointer(
      _g_callable_info_get_arg(pointer, index),
    );
  }

  List<GIArgInfo> getArgs() {
    final List<GIArgInfo> result = [];
    final nArgs = getNArgs();

    for (int i = 0; i < nArgs; i++) {
      result.add(getArg(i));
    }

    return result;
  }

  GITransfer getCallerOwns() {
    return GEnum.fromValue(
      _g_callable_info_get_caller_owns(pointer),
      GITransfer.values,
    );
  }

  GITransfer getInstanceOwnershipTransfer() {
    return GEnum.fromValue(
      _g_callable_info_get_instance_ownership_transfer(pointer),
      GITransfer.values,
    );
  }

  String? getReturnAttribute(String attribute) {
    return using((arena) {
      final result = _g_callable_info_get_return_attribute(
          pointer, attribute.toNativeUtf8(allocator: arena).cast());
      if (result == nullptr) return null;
      return result.cast<Utf8>().toDartString();
    });
  }

  GITypeInfo getReturnType() {
    return GITypeInfo.fromPointer(_g_callable_info_get_return_type(pointer));
  }

  bool isMethod() {
    return _g_callable_info_is_method(pointer);
  }

  void forEachReturnAttribute(
    void Function(String name, String value) callback,
  ) {
    final iterator = GIAttributeIter.init();
    final name = calloc<Pointer<Char>>();
    final value = calloc<Pointer<Char>>();
    while (_g_callable_info_iterate_return_attributes(
      pointer.cast(),
      iterator.pointer,
      name,
      value,
    )) {
      callback(
        name.cast<Utf8>().toDartString(),
        value.cast<Utf8>().toDartString(),
      );
    }
  }

  bool mayReturnNull() {
    return _g_callable_info_may_return_null(pointer);
  }

  bool skipReturn() {
    return _g_callable_info_skip_return(pointer);
  }
}

final _g_callable_info_can_throw_gerror = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GICallableInfoNative>,
    ),
    bool Function(
      Pointer<GICallableInfoNative>,
    )>('g_callable_info_can_throw_gerror');

final _g_callable_info_get_n_args = libgirepository.lookupFunction<
    Int Function(
      Pointer<GICallableInfoNative>,
    ),
    int Function(
      Pointer<GICallableInfoNative>,
    )>('g_callable_info_get_n_args');

final _g_callable_info_get_arg = libgirepository.lookupFunction<
    Pointer<GIArgInfoNative> Function(
      Pointer<GICallableInfoNative>,
      Int,
    ),
    Pointer<GIArgInfoNative> Function(
      Pointer<GICallableInfoNative>,
      int,
    )>('g_callable_info_get_arg');

final _g_callable_info_get_caller_owns = libgirepository.lookupFunction<
    UnsignedInt Function(
      Pointer<GICallableInfoNative>,
    ),
    int Function(
      Pointer<GICallableInfoNative>,
    )>('g_callable_info_get_caller_owns');

final _g_callable_info_get_instance_ownership_transfer =
    libgirepository.lookupFunction<
        UnsignedInt Function(
          Pointer<GICallableInfoNative>,
        ),
        int Function(
          Pointer<GICallableInfoNative>,
        )>('g_callable_info_get_instance_ownership_transfer');

final _g_callable_info_get_return_attribute = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GICallableInfoNative>,
      Pointer<Char>,
    ),
    Pointer<Char> Function(
      Pointer<GICallableInfoNative>,
      Pointer<Char>,
    )>('g_callable_info_get_return_attribute');

final _g_callable_info_get_return_type = libgirepository.lookupFunction<
    Pointer<GITypeInfoNative> Function(
      Pointer<GICallableInfoNative>,
    ),
    Pointer<GITypeInfoNative> Function(
      Pointer<GICallableInfoNative>,
    )>('g_callable_info_get_return_type');

/* final _g_callable_info_invoke = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GICallableInfoNative>,
      Pointer<Void>,
      Pointer<GIArgumentNative>,
      Int,
      Pointer<GIArgumentNative>,
      Int,
      Pointer<GIArgumentNative>,
      Bool,
      Bool,
      Pointer<Pointer<GErrorNative>>,
    ),
    bool Function(
      Pointer<GICallableInfoNative>,
      Pointer<Void>,
      Pointer<GIArgumentNative>,
      int,
      Pointer<GIArgumentNative>,
      int,
      Pointer<GIArgumentNative>,
      bool,
      bool,
      Pointer<Pointer<GErrorNative>>,
    )>('g_callable_info_invoke'); */

final _g_callable_info_is_method = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GICallableInfoNative>,
    ),
    bool Function(
      Pointer<GICallableInfoNative>,
    )>('g_callable_info_is_method');

final _g_callable_info_iterate_return_attributes =
    libgirepository.lookupFunction<
        Bool Function(
          Pointer<GICallableInfoNative>,
          Pointer<GIAttributeIterNative>,
          Pointer<Pointer<Char>>,
          Pointer<Pointer<Char>>,
        ),
        bool Function(
          Pointer<GICallableInfoNative>,
          Pointer<GIAttributeIterNative>,
          Pointer<Pointer<Char>>,
          Pointer<Pointer<Char>>,
        )>('g_callable_info_iterate_return_attributes');

final _g_callable_info_may_return_null = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GICallableInfoNative>,
    ),
    bool Function(
      Pointer<GICallableInfoNative>,
    )>('g_callable_info_may_return_null');

final _g_callable_info_skip_return = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GICallableInfoNative>,
    ),
    bool Function(
      Pointer<GICallableInfoNative>,
    )>('g_callable_info_skip_return');
