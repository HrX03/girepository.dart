// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/constant.dart';
import 'package:girepository/src/info/field.dart';
import 'package:girepository/src/info/function.dart';
import 'package:girepository/src/info/interface.dart';
import 'package:girepository/src/info/property.dart';
import 'package:girepository/src/info/registered_type.dart';
import 'package:girepository/src/info/signal.dart';
import 'package:girepository/src/info/struct.dart';
import 'package:girepository/src/info/vfunc.dart';
import 'package:girepository/src/libraries.dart';
import 'package:ffi/ffi.dart';

final class GIObjectInfoNative extends Opaque {}

extension GIObjectInfoPointerExt on GIObjectInfo {
  Pointer<GIObjectInfoNative> get pointer => voidPointer.cast();
}

class GIObjectInfo extends GIRegisteredTypeInfo {
  GIObjectInfo.fromPointer(Pointer<GIObjectInfoNative> pointer)
      : super.raw(pointer.cast());

  bool getAbstract() {
    return _g_object_info_get_abstract(pointer);
  }

  bool getFundamental() {
    return _g_object_info_get_fundamental(pointer);
  }

  bool getFinal() {
    return _g_object_info_get_final(pointer);
  }

  GIObjectInfo? getParent() {
    final result = _g_object_info_get_parent(pointer);
    if (result == nullptr) return null;
    return GIObjectInfo.fromPointer(result);
  }

  @override
  String getTypeName() {
    return _g_object_info_get_type_name(pointer).cast<Utf8>().toDartString();
  }

  @override
  String getTypeInit() {
    return _g_object_info_get_type_init(pointer).cast<Utf8>().toDartString();
  }

  int getNConstants() {
    return _g_object_info_get_n_constants(pointer);
  }

  GIConstantInfo getConstant(int index) {
    return GIConstantInfo.fromPointer(
      _g_object_info_get_constant(pointer, index),
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

  int getNFields() {
    return _g_object_info_get_n_fields(pointer);
  }

  GIFieldInfo getField(int index) {
    return GIFieldInfo.fromPointer(
      _g_object_info_get_field(pointer, index),
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

  int getNInterfaces() {
    return _g_object_info_get_n_interfaces(pointer);
  }

  GIInterfaceInfo getInterface(int index) {
    return GIInterfaceInfo.fromPointer(
      _g_object_info_get_interface(pointer, index),
    );
  }

  List<GIInterfaceInfo> getInterfaces() {
    final List<GIInterfaceInfo> result = [];
    final nFields = getNInterfaces();

    for (int i = 0; i < nFields; i++) {
      result.add(getInterface(i));
    }

    return result;
  }

  int getNMethods() {
    return _g_object_info_get_n_methods(pointer);
  }

  GIFunctionInfo getMethod(int index) {
    return GIFunctionInfo.fromPointer(
      _g_object_info_get_method(pointer, index),
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
      final result = _g_object_info_find_method(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GIFunctionInfo.fromPointer(result);
    });
  }

  (GIFunctionInfo, GIObjectInfo)? findMethodUsingInterfaces(String name) {
    return using((arena) {
      final interfacePointer = calloc<Pointer<GIObjectInfoNative>>();
      final result = _g_object_info_find_method_using_interfaces(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
        interfacePointer,
      );
      if (result == nullptr) return null;

      return (
        GIFunctionInfo.fromPointer(result),
        GIObjectInfo.fromPointer(interfacePointer.value),
      );
    });
  }

  int getNProperties() {
    return _g_object_info_get_n_properties(pointer);
  }

  GIPropertyInfo getProperty(int index) {
    return GIPropertyInfo.fromPointer(
      _g_object_info_get_property(pointer, index),
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

  int getNSignals() {
    return _g_object_info_get_n_signals(pointer);
  }

  GISignalInfo getSignal(int index) {
    return GISignalInfo.fromPointer(
      _g_object_info_get_signal(pointer, index),
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
      final result = _g_object_info_find_signal(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GISignalInfo.fromPointer(result);
    });
  }

  int getNVFuncs() {
    return _g_object_info_get_n_vfuncs(pointer);
  }

  GIVFuncInfo getVFunc(int index) {
    return GIVFuncInfo.fromPointer(
      _g_object_info_get_vfunc(pointer, index),
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
      final result = _g_object_info_find_vfunc(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;

      return GIVFuncInfo.fromPointer(result);
    });
  }

  (GIVFuncInfo, GIObjectInfo)? findVFuncUsingInterfaces(String name) {
    return using((arena) {
      final interfacePointer = calloc<Pointer<GIObjectInfoNative>>();
      final result = _g_object_info_find_vfunc_using_interfaces(
        pointer,
        name.toNativeUtf8(allocator: arena).cast(),
        interfacePointer,
      );
      if (result == nullptr) return null;

      return (
        GIVFuncInfo.fromPointer(result),
        GIObjectInfo.fromPointer(interfacePointer.value),
      );
    });
  }

  GIStructInfo? getClassStruct() {
    final result = _g_object_info_get_class_struct(pointer);
    if (result == nullptr) return null;
    return GIStructInfo.fromPointer(result);
  }

  String? getRefFunction() {
    final result = _g_object_info_get_ref_function(pointer);
    if (result == nullptr) return null;
    return result.cast<Utf8>().toDartString();
  }

  String? getUnrefFunction() {
    final result = _g_object_info_get_unref_function(pointer);
    if (result == nullptr) return null;
    return result.cast<Utf8>().toDartString();
  }

  String? getSetValueFunction() {
    final result = _g_object_info_get_set_value_function(pointer);
    if (result == nullptr) return null;
    return result.cast<Utf8>().toDartString();
  }

  String? getGetValueFunction() {
    final result = _g_object_info_get_get_value_function(pointer);
    if (result == nullptr) return null;
    return result.cast<Utf8>().toDartString();
  }
}

final _g_object_info_get_abstract = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIObjectInfoNative>,
    ),
    bool Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_abstract');

final _g_object_info_get_fundamental = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIObjectInfoNative>,
    ),
    bool Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_fundamental');

final _g_object_info_get_final = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIObjectInfoNative>,
    ),
    bool Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_final');

final _g_object_info_get_parent = libgirepository.lookupFunction<
    Pointer<GIObjectInfoNative> Function(
      Pointer<GIObjectInfoNative>,
    ),
    Pointer<GIObjectInfoNative> Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_parent');

final _g_object_info_get_type_name = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_type_name');

final _g_object_info_get_type_init = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_type_init');

final _g_object_info_get_n_constants = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIObjectInfoNative>,
    ),
    int Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_n_constants');

final _g_object_info_get_constant = libgirepository.lookupFunction<
    Pointer<GIConstantInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Int,
    ),
    Pointer<GIConstantInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      int,
    )>('g_object_info_get_constant');

final _g_object_info_get_n_fields = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIObjectInfoNative>,
    ),
    int Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_n_fields');

final _g_object_info_get_field = libgirepository.lookupFunction<
    Pointer<GIFieldInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Int,
    ),
    Pointer<GIFieldInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      int,
    )>('g_object_info_get_field');

final _g_object_info_get_n_interfaces = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIObjectInfoNative>,
    ),
    int Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_n_interfaces');

final _g_object_info_get_interface = libgirepository.lookupFunction<
    Pointer<GIInterfaceInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Int,
    ),
    Pointer<GIInterfaceInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      int,
    )>('g_object_info_get_interface');

final _g_object_info_get_n_methods = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIObjectInfoNative>,
    ),
    int Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_n_methods');

final _g_object_info_get_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Int,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      int,
    )>('g_object_info_get_method');

final _g_object_info_find_method = libgirepository.lookupFunction<
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GIFunctionInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Pointer<Char>,
    )>('g_object_info_find_method');

final _g_object_info_find_method_using_interfaces =
    libgirepository.lookupFunction<
        Pointer<GIFunctionInfoNative> Function(
          Pointer<GIObjectInfoNative>,
          Pointer<Char>,
          Pointer<Pointer<GIObjectInfoNative>>,
        ),
        Pointer<GIFunctionInfoNative> Function(
          Pointer<GIObjectInfoNative>,
          Pointer<Char>,
          Pointer<Pointer<GIObjectInfoNative>>,
        )>('g_object_info_find_method_using_interfaces');

final _g_object_info_get_n_properties = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIObjectInfoNative>,
    ),
    int Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_n_properties');

final _g_object_info_get_property = libgirepository.lookupFunction<
    Pointer<GIPropertyInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Int,
    ),
    Pointer<GIPropertyInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      int,
    )>('g_object_info_get_property');

final _g_object_info_get_n_signals = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIObjectInfoNative>,
    ),
    int Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_n_signals');

final _g_object_info_get_signal = libgirepository.lookupFunction<
    Pointer<GISignalInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Int,
    ),
    Pointer<GISignalInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      int,
    )>('g_object_info_get_signal');

final _g_object_info_find_signal = libgirepository.lookupFunction<
    Pointer<GISignalInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GISignalInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Pointer<Char>,
    )>('g_object_info_find_signal');

final _g_object_info_get_n_vfuncs = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIObjectInfoNative>,
    ),
    int Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_n_vfuncs');

final _g_object_info_get_vfunc = libgirepository.lookupFunction<
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Int,
    ),
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      int,
    )>('g_object_info_get_vfunc');

final _g_object_info_find_vfunc = libgirepository.lookupFunction<
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Pointer<Char>,
    ),
    Pointer<GIVFuncInfoNative> Function(
      Pointer<GIObjectInfoNative>,
      Pointer<Char>,
    )>('g_object_info_find_vfunc');

final _g_object_info_find_vfunc_using_interfaces =
    libgirepository.lookupFunction<
        Pointer<GIVFuncInfoNative> Function(
          Pointer<GIObjectInfoNative>,
          Pointer<Char>,
          Pointer<Pointer<GIObjectInfoNative>>,
        ),
        Pointer<GIVFuncInfoNative> Function(
          Pointer<GIObjectInfoNative>,
          Pointer<Char>,
          Pointer<Pointer<GIObjectInfoNative>>,
        )>('g_object_info_find_vfunc_using_interfaces');

final _g_object_info_get_class_struct = libgirepository.lookupFunction<
    Pointer<GIStructInfoNative> Function(
      Pointer<GIObjectInfoNative>,
    ),
    Pointer<GIStructInfoNative> Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_class_struct');

final _g_object_info_get_ref_function = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_ref_function');

final _g_object_info_get_unref_function = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_unref_function');

final _g_object_info_get_set_value_function = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_set_value_function');

final _g_object_info_get_get_value_function = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    ),
    Pointer<Char> Function(
      Pointer<GIObjectInfoNative>,
    )>('g_object_info_get_get_value_function');
