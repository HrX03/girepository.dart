// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/argument.dart';
import 'package:girepository/src/error.dart';
import 'package:girepository/src/errors.dart';
import 'package:girepository/src/info/callable.dart';
import 'package:girepository/src/libraries.dart';
import 'package:girepository/src/quark.dart';
import 'package:girepository/src/types.dart';
import 'package:ffi/ffi.dart';

final G_INVOKE_ERROR = GQuark.fromString("g-invoke-error-quark");

enum GInvokeError implements GErrorEnum {
  failed(0),
  symbolNotFound(1),
  argumentMismatch(2);

  @override
  final int code;

  const GInvokeError(this.code);
}

enum GIFunctionInfoFlag implements GFlag {
  isMethod(0),
  isConstructor(1),
  isGetter(2),
  isSetter(3),
  wrapsVfunc(4),
  throws(5);

  @override
  final int value;

  const GIFunctionInfoFlag(this.value);
}

final class GIFunctionInfoNative extends Opaque {}

extension GIFunctionInfoPointerExt on GIFunctionInfo {
  Pointer<GIFunctionInfoNative> get pointer => voidPointer.cast();
}

class GIFunctionInfo extends GICallableInfo {
  GIFunctionInfo.fromPointer(Pointer<GIFunctionInfoNative> pointer)
      : super.raw(pointer.cast());

  String getSymbol() {
    return _g_function_info_get_symbol(pointer).cast<Utf8>().toDartString();
  }

  Set<GIFunctionInfoFlag> getFlags() {
    final value = _g_function_info_get_flags(pointer);
    return GFlag.split(value, GIFunctionInfoFlag.values);
  }

  (bool, GIArgumentNative?) invoke({
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
      final result = _g_function_info_invoke(
        pointer,
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

final _g_function_info_get_flags = libgirepository.lookupFunction<
    UnsignedInt Function(
      Pointer<GIFunctionInfoNative>,
    ),
    int Function(
      Pointer<GIFunctionInfoNative>,
    )>('g_function_info_get_flags');

final _g_function_info_get_symbol = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIFunctionInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIFunctionInfoNative>,
    )>('g_function_info_get_symbol');

final _g_function_info_invoke = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIFunctionInfoNative>,
      Pointer<GIArgumentNative>,
      Int,
      Pointer<GIArgumentNative>,
      Int,
      Pointer<GIArgumentNative>,
      Pointer<Pointer<GErrorNative>>,
    ),
    bool Function(
      Pointer<GIFunctionInfoNative>,
      Pointer<GIArgumentNative>,
      int,
      Pointer<GIArgumentNative>,
      int,
      Pointer<GIArgumentNative>,
      Pointer<Pointer<GErrorNative>>,
    )>('g_function_info_invoke');
