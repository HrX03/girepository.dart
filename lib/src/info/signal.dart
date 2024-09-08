// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/callable.dart';
import 'package:girepository/src/info/vfunc.dart';
import 'package:girepository/src/libraries.dart';
import 'package:girepository/src/types.dart';

enum GSignalFlag implements GFlag {
  runFirst(0),
  runLast(1),
  runCleanup(2),
  noRecurse(3),
  detailed(4),
  action(5),
  noHooks(6),
  mustCollect(7),
  deprecated(8),
  accumulatorFirstRun(17);

  @override
  final int value;

  const GSignalFlag(this.value);
}

final class GISignalInfoNative extends Opaque {}

extension GISignalInfoPointerExt on GISignalInfo {
  Pointer<GISignalInfoNative> get pointer => voidPointer.cast();
}

class GISignalInfo extends GICallableInfo {
  GISignalInfo.fromPointer(Pointer<GISignalInfoNative> pointer)
      : super.raw(pointer.cast());

  Set<GSignalFlag> getFlags() {
    return GFlag.split(_g_signal_info_get_flags(pointer), GSignalFlag.values);
  }

  GIVFuncInfo? getClassClosure() {
    final result = _g_signal_info_get_class_closure(pointer);
    if (result == nullptr) return null;
    return GIVFuncInfo.fromPointer(result);
  }

  bool trueStopsEmit() {
    return _g_signal_info_true_stops_emit(pointer);
  }
}

final _g_signal_info_get_flags = libgirepository.lookupFunction<
    UnsignedInt Function(Pointer<GISignalInfoNative>),
    int Function(Pointer<GISignalInfoNative>)>('g_signal_info_get_flags');

final _g_signal_info_get_class_closure = libgirepository.lookupFunction<
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GISignalInfoNative>,
    ),
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GISignalInfoNative>,
    )>('g_signal_info_get_class_closure');

final _g_signal_info_true_stops_emit = libgirepository.lookupFunction<
    Bool Function(Pointer<GISignalInfoNative>),
    bool Function(
        Pointer<GISignalInfoNative>)>('g_signal_info_true_stops_emit');
