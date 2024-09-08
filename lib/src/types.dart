import 'dart:ffi';

@AbiSpecificIntegerMapping({
  Abi.androidArm: Int32(),
  Abi.androidArm64: Int64(),
  Abi.androidIA32: Int32(),
  Abi.androidX64: Int64(),
  Abi.androidRiscv64: Int64(),
  Abi.fuchsiaArm64: Int64(),
  Abi.fuchsiaX64: Int64(),
  Abi.fuchsiaRiscv64: Int64(),
  Abi.iosArm: Int32(),
  Abi.iosArm64: Int64(),
  Abi.iosX64: Int64(),
  Abi.linuxArm: Int32(),
  Abi.linuxArm64: Int64(),
  Abi.linuxIA32: Int32(),
  Abi.linuxX64: Int64(),
  Abi.linuxRiscv32: Int32(),
  Abi.linuxRiscv64: Int64(),
  Abi.macosArm64: Int64(),
  Abi.macosX64: Int64(),
  Abi.windowsArm64: Int64(),
  Abi.windowsIA32: Int32(),
  Abi.windowsX64: Int64(),
})
final class SignedSize extends AbiSpecificInteger {
  const SignedSize();
}

abstract class GFlag {
  final int value;

  const GFlag(int value) : value = 1 << value;

  static int merge(Set<GFlag> flags) {
    int result = 0;
    for (final flag in flags) {
      result |= flag.value;
    }
    return result;
  }

  static Set<T> split<T extends GFlag>(int value, List<T> enumValues) {
    final result = <T>{};
    for (final enumValue in enumValues) {
      if (value & enumValue.value == enumValue.value) {
        result.add(enumValue);
      }
    }

    return result;
  }
}

abstract class GEnum {
  final int value;

  const GEnum(this.value);

  static T fromValue<T extends GEnum>(int value, List<T> enumValues) {
    return enumValues.firstWhere(
      (e) => e.value == value,
      orElse: () => enumValues[0],
    );
  }
}
