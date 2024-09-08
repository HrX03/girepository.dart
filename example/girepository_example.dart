import 'dart:ffi';
import 'dart:io';

import 'package:girepository/girepository.dart';

void main() {
  final repository = GIRepository.getDefault();
  GIRepository.prependSearchPath("/usr/lib/x86_64-linux-gnu/girepository-1.0/");

  repository.require("GLib");

  for (final namespace in repository.getLoadedNamespaces()) {
    final infos = repository.getInfos(namespace);

    final buffer = StringBuffer();
    for (final info in infos) {
      if (!info.isRegisteredTypeInfo) continue;

      if (info.isRegisteredTypeInfo) {
        writeRegisteredTypeInfo(buffer, info.cast<GIRegisteredTypeInfo>());
        buffer.writeln();
      }
    }

    File("$namespace.txt").writeAsString(buffer.toString());
  }
}

extension on GIRegisteredTypeInfo {
  T? caseValue<T>({
    T Function(GIStructInfo struct)? onStruct,
    T Function(GIEnumInfo enum_)? onEnum,
    T Function(GIInterfaceInfo interface)? onInterface,
    T Function(GIObjectInfo object)? onObject,
    T Function(GIUnionInfo union)? onUnion,
  }) {
    return switch (getType()) {
      GIInfoType.boxed ||
      GIInfoType.struct =>
        onStruct?.call(cast<GIStructInfo>()),
      GIInfoType.enum_ || GIInfoType.flags => onEnum?.call(cast<GIEnumInfo>()),
      GIInfoType.interface => onInterface?.call(cast<GIInterfaceInfo>()),
      GIInfoType.object => onObject?.call(cast<GIObjectInfo>()),
      GIInfoType.union => onUnion?.call(cast<GIUnionInfo>()),
      _ => throw ArgumentError(),
    };
  }
}

void writeRegisteredTypeInfo(StringBuffer buffer, GIRegisteredTypeInfo boxed) {
  final name = switch (boxed.getType()) {
    GIInfoType.boxed => "Boxed struct",
    GIInfoType.enum_ => "Enum",
    GIInfoType.flags => "Flags enum",
    GIInfoType.interface => "Interface",
    GIInfoType.object => "Object",
    GIInfoType.struct => "Struct",
    GIInfoType.union => "Union",
    _ => throw ArgumentError(),
  };
  buffer.writeln("G${boxed.getName()}: $name");

  final enumValues = boxed.caseValue(
    onStruct: (value) => <GIValueInfo>[],
    onEnum: (value) => value.getValues(),
    onInterface: (value) => <GIValueInfo>[],
    onObject: (value) => <GIValueInfo>[],
    onUnion: (value) => <GIValueInfo>[],
  )!;

  final methods = boxed.caseValue(
    onStruct: (value) => value.getMethods(),
    onEnum: (value) => value.getMethods(),
    onInterface: (value) => value.getMethods(),
    onObject: (value) => value.getMethods(),
    onUnion: (value) => value.getMethods(),
  )!;

  final constants = boxed.caseValue(
    onStruct: (value) => <GIConstantInfo>[],
    onEnum: (value) => <GIConstantInfo>[],
    onInterface: (value) => value.getConstants(),
    onObject: (value) => value.getConstants(),
    onUnion: (value) => <GIConstantInfo>[],
  )!;

  final fields = boxed.caseValue(
    onStruct: (value) => value.getFields(),
    onEnum: (value) => <GIFieldInfo>[],
    onInterface: (value) => <GIFieldInfo>[],
    onObject: (value) => value.getFields(),
    onUnion: (value) => value.getFields(),
  )!;

  final results = [
    if (enumValues.isNotEmpty) writeEnumValues(enumValues),
    if (constants.isNotEmpty) writeConstants(constants),
    if (fields.isNotEmpty) writeFields(fields),
    if (methods.isNotEmpty) writeMethods(methods),
  ];

  buffer.writeAll(results, "\n");
}

String writeEnumValues(List<GIValueInfo> values) {
  final buffer = StringBuffer();

  buffer.writeln("  ${values.length} Values:");

  for (final value in values) {
    buffer.writeln(
      "    ${value.getName()} = ${value.getValue()}",
    );
  }

  return buffer.toString();
}

String writeConstants(List<GIConstantInfo> constants) {
  final buffer = StringBuffer();

  buffer.writeln("  ${constants.length} Constants:");

  for (final constant in constants) {
    final value = constant.getValue();
    final argValue = value.toArgumentValue(constant.getTypeInfo().getTag());
    constant.freeValue(value);

    buffer.writeln(
      "    ${formatTypeInfo(constant.getTypeInfo())} ${constant.getName()} = ${argValue.value}",
    );
  }

  return buffer.toString();
}

String writeMethods(List<GIFunctionInfo> methods) {
  final buffer = StringBuffer();

  buffer.writeln("  ${methods.length} Methods:");

  for (final method in methods) {
    if (method.skipReturn()) continue;

    final formattedArgs = [];
    for (final argument in method.getArgs()) {
      final direction = switch (argument.getDirection()) {
        GIDirection.in_ => "in",
        final v => v.name,
      };

      final type = argument.getTypeInfo();
      formattedArgs.add(
        "$direction ${formatTypeInfo(type)} ${argument.getName()!}",
      );
    }
    buffer.writeln(
      "    ${formatTypeInfo(method.getReturnType())} ${method.getName()!}(${formattedArgs.join(", ")})",
    );
  }

  return buffer.toString();
}

String writeFields(List<GIFieldInfo> fields) {
  final buffer = StringBuffer();

  buffer.writeln("  ${fields.length} Fields:");

  for (final field in fields) {
    final String flagModifier;
    final flags = field.getFlags();
    if (flags.contains(GIFieldInfoFlag.isReadable) &&
        flags.contains(GIFieldInfoFlag.isWritable)) {
      flagModifier = "";
    } else if (flags.contains(GIFieldInfoFlag.isReadable)) {
      flagModifier = "final";
    } else if (flags.contains(GIFieldInfoFlag.isWritable)) {
      flagModifier = "set";
    } else {
      flagModifier = "";
    }

    buffer.writeln(
      "    ${flagModifier.isNotEmpty ? "$flagModifier " : ""}${formatTypeInfo(field.getTypeInfo())} ${field.getName()!}",
    );
  }

  return buffer.toString();
}

String formatTypeInfo(GITypeInfo type) {
  final paramAmount = switch (type.getTag()) {
    GITypeTag.array || GITypeTag.glist || GITypeTag.gslist => 1,
    GITypeTag.ghash => 2,
    _ => 0,
  };

  final params = [];
  for (int i = 0; i < paramAmount; i++) {
    final param = type.getParamType(i);
    if (param.voidPointer == nullptr) break;
    params.add(formatTypeInfo(param));
  }

  final typeName = switch (type.getTag()) {
    final v when v.isNumeric =>
      (v == GITypeTag.double_ || v == GITypeTag.float) ? "double" : "int",
    GITypeTag.utf8 || GITypeTag.filename || GITypeTag.unichar => "Char",
    GITypeTag.void_ => "void",
    GITypeTag.boolean => "bool",
    GITypeTag.array ||
    GITypeTag.glist ||
    GITypeTag.gslist =>
      "List<${params.join(", ")}>",
    GITypeTag.ghash => "Map<${params.join(", ")}>",
    GITypeTag.error => "GError",
    GITypeTag.interface => "G${type.getInterface()!.getName()}",
    final v => v.name,
  };
  if (type.isPointer()) {
    return "Pointer<$typeName>";
  }

  return typeName;
}
