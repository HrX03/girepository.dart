// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:dlib_gen/src/info/base.dart';
import 'package:dlib_gen/src/info/constant.dart';
import 'package:dlib_gen/src/info/function.dart';
import 'package:dlib_gen/src/info/property.dart';
import 'package:dlib_gen/src/info/signal.dart';
import 'package:dlib_gen/src/info/struct.dart';
import 'package:dlib_gen/src/info/vfunc.dart';
import 'package:dlib_gen/src/libraries.dart';
import 'package:ffi/ffi.dart';

final class GIInterfaceInfoNative extends Opaque {}

class GIInterfaceInfo extends GIInfo<GIInterfaceInfoNative> {
  const GIInterfaceInfo.fromPointer(super.pointer);

  int getNPrerequisites() {
    return _g_interface_info_get_n_prerequisites(pointer);
  }

  GIBaseInfo getPrerequisite(int index) {
    return GIBaseInfo.fromPointer(
      _g_interface_info_get_prerequisite(pointer, index),
    );
  }

  List<GIBaseInfo> getPrerequisites() {
    final List<GIBaseInfo> result = [];
    final nProperties = getNPrerequisites();

    for (int i = 0; i < nProperties; i++) {
      result.add(getPrerequisite(i));
    }

    return result;
  }

  int getNProperties() {
    return _g_interface_info_get_n_properties(pointer);
  }

  GIPropertyInfo getProperty(int index) {
    return GIPropertyInfo.fromPointer(
      _g_interface_info_get_property(pointer, index),
    );
  }

  List<GIPropertyInfo> getProperties() {
    final List<GIPropertyInfo> result = [];
    final nProperties = getNProperties();

    for (int i = 0; i < nProperties; i++) {
      result.add(getProperty(i));
    }

    return result;
  }

  int getNMethods() {
    return _g_interface_info_get_n_methods(pointer);
  }

  GIFunctionInfo getMethod(int index) {
    return GIFunctionInfo.fromPointer(
      _g_interface_info_get_method(pointer, index),
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
      final result = _g_interface_info_find_method(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GIFunctionInfo.fromPointer(result);
    });
  }

  int getNSignals() {
    return _g_interface_info_get_n_signals(pointer);
  }

  GISignalInfo getSignal(int index) {
    return GISignalInfo.fromPointer(
      _g_interface_info_get_signal(pointer, index),
    );
  }

  List<GISignalInfo> getSignals() {
    final List<GISignalInfo> result = [];
    final nSignals = getNSignals();

    for (int i = 0; i < nSignals; i++) {
      result.add(getSignal(i));
    }

    return result;
  }

  GISignalInfo? findSignal(String name) {
    return using((arena) {
      final result = _g_interface_info_find_signal(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GISignalInfo.fromPointer(result);
    });
  }

  int getNVFuncs() {
    return _g_interface_info_get_n_vfuncs(pointer);
  }

  GIVFuncInfo getVFunc(int index) {
    return GIVFuncInfo.fromPointer(
      _g_interface_info_get_vfunc(pointer, index),
    );
  }

  List<GIVFuncInfo> getVFuncs() {
    final List<GIVFuncInfo> result = [];
    final nVFuncs = getNVFuncs();

    for (int i = 0; i < nVFuncs; i++) {
      result.add(getVFunc(i));
    }

    return result;
  }

  GIVFuncInfo? findVFunc(String name) {
    return using((arena) {
      final result = _g_interface_info_find_vfunc(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GIVFuncInfo.fromPointer(result);
    });
  }

  int getNConstants() {
    return _g_interface_info_get_n_constants(pointer);
  }

  GIConstantInfo getConstant(int index) {
    return GIConstantInfo.fromPointer(
      _g_interface_info_get_constant(pointer, index),
    );
  }

  List<GIConstantInfo> getConstants() {
    final List<GIConstantInfo> result = [];
    final nConstants = getNConstants();

    for (int i = 0; i < nConstants; i++) {
      result.add(getConstant(i));
    }

    return result;
  }

  GIStructInfo? getInterfaceStruct() {
    final result = _g_interface_info_get_iface_struct(pointer);
    if (result == nullptr) return null;
    return GIStructInfo.fromPointer(result);
  }
}

final _g_interface_info_get_n_prerequisites = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIInterfaceInfoNative>,
    ),
    int Function(
      Pointer<GIInterfaceInfoNative>,
    )>('g_interface_info_get_n_prerequisites');

final _g_interface_info_get_prerequisite = libgirepository.lookupFunction<
    Pointer<GIBaseInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Int,
    ),
    Pointer<GIBaseInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      int,
    )>('g_interface_info_get_prerequisite');

final _g_interface_info_get_n_properties = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIInterfaceInfoNative>,
    ),
    int Function(
      Pointer<GIInterfaceInfoNative>,
    )>('g_interface_info_get_n_properties');

final _g_interface_info_get_property = libgirepository.lookupFunction<
    Pointer<GIPropertyInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Int,
    ),
    Pointer<GIPropertyInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      int,
    )>('g_interface_info_get_property');

final _g_interface_info_get_n_methods = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIInterfaceInfoNative>,
    ),
    int Function(
      Pointer<GIInterfaceInfoNative>,
    )>('g_interface_info_get_n_methods');

final _g_interface_info_get_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Int,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      int,
    )>('g_interface_info_get_method');

final _g_interface_info_find_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Pointer<Char>,
    )>('g_interface_info_find_method');

final _g_interface_info_get_n_signals = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIInterfaceInfoNative>,
    ),
    int Function(
      Pointer<GIInterfaceInfoNative>,
    )>('g_interface_info_get_n_signals');

final _g_interface_info_get_signal = libgirepository.lookupFunction<
    Pointer<GISignalInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Int,
    ),
    Pointer<GISignalInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      int,
    )>('g_interface_info_get_signal');

final _g_interface_info_find_signal = libgirepository.lookupFunction<
    Pointer<GISignalInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GISignalInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Pointer<Char>,
    )>('g_interface_info_find_signal');

final _g_interface_info_get_n_vfuncs = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIInterfaceInfoNative>,
    ),
    int Function(
      Pointer<GIInterfaceInfoNative>,
    )>('g_interface_info_get_n_vfuncs');

final _g_interface_info_get_vfunc = libgirepository.lookupFunction<
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Int,
    ),
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      int,
    )>('g_interface_info_get_vfunc');

final _g_interface_info_find_vfunc = libgirepository.lookupFunction<
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Pointer<Char>,
    )>('g_interface_info_find_vfunc');

final _g_interface_info_get_n_constants = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIInterfaceInfoNative>,
    ),
    int Function(
      Pointer<GIInterfaceInfoNative>,
    )>('g_interface_info_get_n_constants');

final _g_interface_info_get_constant = libgirepository.lookupFunction<
    Pointer<GIConstantInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      Int,
    ),
    Pointer<GIConstantInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
      int,
    )>('g_interface_info_get_constant');

final _g_interface_info_get_iface_struct = libgirepository.lookupFunction<
    Pointer<GIStructInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
    ),
    Pointer<GIStructInfoNative> Function(
      Pointer<GIInterfaceInfoNative>,
    )>('g_interface_info_get_iface_struct');
