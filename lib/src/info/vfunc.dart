// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:dlib_gen/src/argument.dart';
import 'package:dlib_gen/src/error.dart';
import 'package:dlib_gen/src/info/base.dart';
import 'package:dlib_gen/src/info/function.dart';
import 'package:dlib_gen/src/info/signal.dart';
import 'package:dlib_gen/src/libraries.dart';
import 'package:dlib_gen/src/types.dart';
import 'package:ffi/ffi.dart';

enum GIVFuncInfoFlag implements GFlag {
  mustChainUp(0),
  mustOverride(1),
  mustNotOverride(2),
  throws(3);

  @override
  final int value;

  const GIVFuncInfoFlag(this.value);
}

final class GIVFuncInfoNative extends Opaque {}

class GIVFuncInfo extends GIInfo<GIVFuncInfoNative> {
  const GIVFuncInfo.fromPointer(super.pointer);

  Set<GIVFuncInfoFlag> getFlags() {
    return GFlag.split(
      _g_vfunc_info_get_flags(pointer),
      GIVFuncInfoFlag.values,
    );
  }

  int getOffset() {
    return _g_vfunc_info_get_offset(pointer);
  }

  GISignalInfo? getSignal() {
    final result = _g_vfunc_info_get_signal(pointer);
    if (result == nullptr) return null;
    return GISignalInfo.fromPointer(result);
  }

  GIFunctionInfo? getInvoker() {
    final result = _g_vfunc_info_get_invoker(pointer);
    if (result == nullptr) return null;
    return GIFunctionInfo.fromPointer(result);
  }

  Pointer<Void> getAddress(int type) {
    return handleGError((nativeErr) {
      return _g_vfunc_info_get_address(pointer, type, nativeErr);
    });
  }

  (bool, GIArgumentNative?) invoke(
    int type, {
    List<GIArgumentValue> inArguments = const [],
    List<GIArgumentValue> outArguments = const [],
  }) {
    final Pointer<GIArgumentNative> inArgumentsNative;
    if (inArguments.isNotEmpty) {
      inArgumentsNative = calloc<GIArgumentNative>(inArguments.length);
      for (final (index, argument) in inArguments.indexed) {
        inArgumentsNative[index] = argument.toNative().ref;
      }
    } else {
      inArgumentsNative = nullptr;
    }

    final Pointer<GIArgumentNative> outArgumentsNative;
    if (inArguments.isNotEmpty) {
      outArgumentsNative = calloc<GIArgumentNative>(outArguments.length);
      for (final (index, argument) in outArguments.indexed) {
        outArgumentsNative[index] = argument.toNative().ref;
      }
    } else {
      outArgumentsNative = nullptr;
    }

    final Pointer<GIArgumentNative> returnArgumentNative =
        calloc<GIArgumentNative>();

    return handleGError((nativeErr) {
      final result = _g_vfunc_info_invoke(
        pointer,
        type,
        inArgumentsNative,
        inArguments.length,
        outArgumentsNative,
        outArguments.length,
        returnArgumentNative,
        nativeErr,
      );

      return (
        result,
        returnArgumentNative != nullptr ? returnArgumentNative.ref : null,
      );
    });
  }
}

final _g_vfunc_info_get_flags = libgirepository.lookupFunction<
    UnsignedInt Function(Pointer<GIVFuncInfoNative>),
    int Function(Pointer<GIVFuncInfoNative>)>('g_vfunc_info_get_flags');

final _g_vfunc_info_get_offset = libgirepository.lookupFunction<
    Int Function(Pointer<GIVFuncInfoNative>),
    int Function(Pointer<GIVFuncInfoNative>)>('g_vfunc_info_get_offset');

final _g_vfunc_info_get_signal = libgirepository.lookupFunction<
    Pointer<GISignalInfoNative> Function(
      Pointer<GIVFuncInfoNative>,
    ),
    Pointer<GISignalInfoNative> Function(
      Pointer<GIVFuncInfoNative>,
    )>('g_vfunc_info_get_signal');

final _g_vfunc_info_get_invoker = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIVFuncInfoNative>,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIVFuncInfoNative>,
    )>('g_vfunc_info_get_invoker');

final _g_vfunc_info_get_address = libgirepository.lookupFunction<
    Pointer<Void> Function(
      Pointer<GIVFuncInfoNative>,
      Size,
      Pointer<Pointer<GErrorNative>>,
    ),
    Pointer<Void> Function(
      Pointer<GIVFuncInfoNative>,
      int,
      Pointer<Pointer<GErrorNative>>,
    )>('g_vfunc_info_get_address');

final _g_vfunc_info_invoke = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIVFuncInfoNative>,
      Size,
      Pointer<GIArgumentNative>,
      Int,
      Pointer<GIArgumentNative>,
      Int,
      Pointer<GIArgumentNative>,
      Pointer<Pointer<GErrorNative>>,
    ),
    bool Function(
      Pointer<GIVFuncInfoNative>,
      int,
      Pointer<GIArgumentNative>,
      int,
      Pointer<GIArgumentNative>,
      int,
      Pointer<GIArgumentNative>,
      Pointer<Pointer<GErrorNative>>,
    )>('g_vfunc_info_invoke');
