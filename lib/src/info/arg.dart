// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:dlib_gen/src/info/base.dart';
import 'package:dlib_gen/src/info/type.dart';
import 'package:dlib_gen/src/libraries.dart';
import 'package:dlib_gen/src/types.dart';

enum GITransfer implements GEnum {
  nothing(0),
  container(1),
  everything(2);

  @override
  final int value;

  const GITransfer(this.value);
}

enum GIDirection implements GEnum {
  in_(0),
  out(1),
  inout(2);

  @override
  final int value;

  const GIDirection(this.value);
}

enum GIScopeType implements GEnum {
  invalid(0),
  call(1),
  async(2),
  notified(3),
  forever(4);

  @override
  final int value;

  const GIScopeType(this.value);
}

final class GIArgInfoNative extends Opaque {}

class GIArgInfo extends GIInfo<GIArgInfoNative> {
  const GIArgInfo.fromPointer(super.pointer);

  int getClosure() {
    return _g_arg_info_get_closure(pointer);
  }

  int getDestroy() {
    return _g_arg_info_get_destroy(pointer);
  }

  GIDirection getDirection() {
    return GEnum.fromValue(
      _g_arg_info_get_direction(pointer),
      GIDirection.values,
    );
  }

  GITransfer getOwnershipTransfer() {
    return GEnum.fromValue(
      _g_arg_info_get_ownership_transfer(pointer),
      GITransfer.values,
    );
  }

  GIScopeType getScope() {
    return GEnum.fromValue(
      _g_arg_info_get_scope(pointer),
      GIScopeType.values,
    );
  }

  GITypeInfo getTypeInfo() {
    return GITypeInfo.fromPointer(_g_arg_info_get_type(pointer));
  }

  bool mayBeNull() {
    return _g_arg_info_may_be_null(pointer);
  }

  bool isCallerAllocates() {
    return _g_arg_info_is_caller_allocates(pointer);
  }

  bool isOptional() {
    return _g_arg_info_is_optional(pointer);
  }

  bool isReturnValue() {
    return _g_arg_info_is_return_value(pointer);
  }

  bool isSkip() {
    return _g_arg_info_is_skip(pointer);
  }
}

final _g_arg_info_get_closure = libgirepository.lookupFunction<
    Int Function(Pointer<GIArgInfoNative>),
    int Function(Pointer<GIArgInfoNative>)>('g_arg_info_get_closure');

final _g_arg_info_get_destroy = libgirepository.lookupFunction<
    Int Function(Pointer<GIArgInfoNative>),
    int Function(Pointer<GIArgInfoNative>)>('g_arg_info_get_destroy');

final _g_arg_info_get_direction = libgirepository.lookupFunction<
    UnsignedInt Function(Pointer<GIArgInfoNative>),
    int Function(Pointer<GIArgInfoNative>)>('g_arg_info_get_direction');

final _g_arg_info_get_ownership_transfer = libgirepository.lookupFunction<
    UnsignedInt Function(
      Pointer<GIArgInfoNative>,
    ),
    int Function(
      Pointer<GIArgInfoNative>,
    )>('g_arg_info_get_ownership_transfer');

final _g_arg_info_get_scope = libgirepository.lookupFunction<
    UnsignedInt Function(Pointer<GIArgInfoNative>),
    int Function(Pointer<GIArgInfoNative>)>('g_arg_info_get_scope');

final _g_arg_info_get_type = libgirepository.lookupFunction<
    Pointer<GITypeInfoNative> Function(
      Pointer<GIArgInfoNative>,
    ),
    Pointer<GITypeInfoNative> Function(
      Pointer<GIArgInfoNative>,
    )>('g_arg_info_get_type');

final _g_arg_info_may_be_null = libgirepository.lookupFunction<
    Bool Function(Pointer<GIArgInfoNative>),
    bool Function(Pointer<GIArgInfoNative>)>('g_arg_info_may_be_null');

final _g_arg_info_is_caller_allocates = libgirepository.lookupFunction<
    Bool Function(Pointer<GIArgInfoNative>),
    bool Function(Pointer<GIArgInfoNative>)>('g_arg_info_is_caller_allocates');

final _g_arg_info_is_optional = libgirepository.lookupFunction<
    Bool Function(Pointer<GIArgInfoNative>),
    bool Function(Pointer<GIArgInfoNative>)>('g_arg_info_is_optional');

final _g_arg_info_is_return_value = libgirepository.lookupFunction<
    Bool Function(Pointer<GIArgInfoNative>),
    bool Function(Pointer<GIArgInfoNative>)>('g_arg_info_is_return_value');

final _g_arg_info_is_skip = libgirepository.lookupFunction<
    Bool Function(Pointer<GIArgInfoNative>),
    bool Function(Pointer<GIArgInfoNative>)>('g_arg_info_is_skip');
