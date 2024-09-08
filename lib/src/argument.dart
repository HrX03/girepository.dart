import 'dart:ffi';

import 'package:girepository/src/info/type.dart';
import 'package:girepository/src/types.dart';
import 'package:ffi/ffi.dart';

final class GIArgumentNative extends Union {
  @Bool()
  external bool vBoolean;

  @Int8()
  external int vInt8;

  @Uint8()
  external int vUint8;

  @Int16()
  external int vInt16;

  @Uint16()
  external int vUint16;

  @Int32()
  external int vInt32;

  @Uint32()
  external int vUint32;

  @Int64()
  external int vInt64;

  @Uint64()
  external int vUint64;

  @Float()
  external double vFloat;

  @Double()
  external double vDouble;

  @Short()
  external int vShort;

  @UnsignedShort()
  external int vUshort;

  @Int()
  external int vInt;

  @UnsignedInt()
  external int vUint;

  @Long()
  external int vLong;

  @UnsignedLong()
  external int vUlong;

  @SignedSize()
  external int vSsize;

  @Size()
  external int vSize;

  external Pointer<Char> vString;
  external Pointer<Void> vPointer;
}

extension type GIArgument._(Pointer<GIArgumentNative> _this) {
  const GIArgument.fromPointer(this._this);

  Pointer<GIArgumentNative> get pointer => _this;

  GIArgumentValue toArgumentValue(GITypeTag tag) {
    return switch (tag) {
      GITypeTag.void_ => GIArgumentValue.pointer(nullptr),
      GITypeTag.boolean => GIArgumentValue.boolean(_this.ref.vBoolean),
      GITypeTag.int8 => GIArgumentValue.int8(_this.ref.vInt8),
      GITypeTag.uint8 => GIArgumentValue.uint8(_this.ref.vUint8),
      GITypeTag.int16 => GIArgumentValue.int16(_this.ref.vInt16),
      GITypeTag.uint16 => GIArgumentValue.uint16(_this.ref.vUint16),
      GITypeTag.int32 => GIArgumentValue.int32(_this.ref.vInt32),
      GITypeTag.uint32 => GIArgumentValue.uint32(_this.ref.vUint32),
      GITypeTag.int64 => GIArgumentValue.int64(_this.ref.vInt64),
      GITypeTag.uint64 => GIArgumentValue.uint64(_this.ref.vUint64),
      GITypeTag.float => GIArgumentValue.float(_this.ref.vFloat),
      GITypeTag.double_ => GIArgumentValue.double_(_this.ref.vDouble),
      GITypeTag.gtype => GIArgumentValue.size(_this.ref.vSize),
      GITypeTag.utf8 ||
      GITypeTag.filename =>
        GIArgumentValue.string(_this.ref.vString.cast<Utf8>().toDartString()),
      GITypeTag.array ||
      GITypeTag.interface ||
      GITypeTag.glist ||
      GITypeTag.gslist ||
      GITypeTag.ghash ||
      GITypeTag.error ||
      GITypeTag.unichar =>
        GIArgumentValue.pointer(_this.cast()),
    };
  }
}

sealed class GIArgumentValue<T> {
  final T value;

  const GIArgumentValue(this.value);

  static GIArgumentValue<bool> boolean(bool value) => _GIBoolArgument(value);
  static GIArgumentValue<int> int8(int value) => _GIInt8Argument(value);
  static GIArgumentValue<int> uint8(int value) => _GIUint8Argument(value);
  static GIArgumentValue<int> int16(int value) => _GIInt16Argument(value);
  static GIArgumentValue<int> uint16(int value) => _GIUint16Argument(value);
  static GIArgumentValue<int> int32(int value) => _GIInt32Argument(value);
  static GIArgumentValue<int> uint32(int value) => _GIUint32Argument(value);
  static GIArgumentValue<int> int64(int value) => _GIInt64Argument(value);
  static GIArgumentValue<int> uint64(int value) => _GIUint64Argument(value);
  static GIArgumentValue<double> float(double value) => _GIFloatArgument(value);
  static GIArgumentValue<double> double_(double value) =>
      _GIDoubleArgument(value);
  static GIArgumentValue<int> integer(int value) => _GIIntArgument(value);
  static GIArgumentValue<int> uint(int value) => _GIUintArgument(value);
  static GIArgumentValue<int> long(int value) => _GILongArgument(value);
  static GIArgumentValue<int> ulong(int value) => _GIUlongArgument(value);
  static GIArgumentValue<int> ssize(int value) => _GISSizeArgument(value);
  static GIArgumentValue<int> size(int value) => _GISizeArgument(value);
  static GIArgumentValue<String> string(String value) =>
      _GIStringArgument(value);
  static GIArgumentValue<Pointer<Void>> pointer(Pointer<Void> value) =>
      GIPointerArgument(value);

  Pointer<GIArgumentNative> _allocateNative(
    void Function(GIArgumentNative) callback,
  ) {
    final pointer = calloc<GIArgumentNative>();
    callback(pointer.ref);
    return pointer;
  }

  Pointer<GIArgumentNative> toNative();
}

class _GIBoolArgument extends GIArgumentValue<bool> {
  const _GIBoolArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vBoolean = value;
    });
  }
}

class _GIInt8Argument extends GIArgumentValue<int> {
  const _GIInt8Argument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vInt8 = value;
    });
  }
}

class _GIUint8Argument extends GIArgumentValue<int> {
  const _GIUint8Argument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vUint8 = value;
    });
  }
}

class _GIInt16Argument extends GIArgumentValue<int> {
  const _GIInt16Argument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vInt16 = value;
    });
  }
}

class _GIUint16Argument extends GIArgumentValue<int> {
  const _GIUint16Argument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vUint16 = value;
    });
  }
}

class _GIInt32Argument extends GIArgumentValue<int> {
  const _GIInt32Argument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vInt32 = value;
    });
  }
}

class _GIUint32Argument extends GIArgumentValue<int> {
  const _GIUint32Argument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vUint32 = value;
    });
  }
}

class _GIInt64Argument extends GIArgumentValue<int> {
  const _GIInt64Argument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vInt64 = value;
    });
  }
}

class _GIUint64Argument extends GIArgumentValue<int> {
  const _GIUint64Argument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vUint64 = value;
    });
  }
}

class _GIFloatArgument extends GIArgumentValue<double> {
  const _GIFloatArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vFloat = value;
    });
  }
}

class _GIDoubleArgument extends GIArgumentValue<double> {
  const _GIDoubleArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vDouble = value;
    });
  }
}

class _GIIntArgument extends GIArgumentValue<int> {
  const _GIIntArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vInt = value;
    });
  }
}

class _GIUintArgument extends GIArgumentValue<int> {
  const _GIUintArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vUint = value;
    });
  }
}

class _GILongArgument extends GIArgumentValue<int> {
  const _GILongArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vLong = value;
    });
  }
}

class _GIUlongArgument extends GIArgumentValue<int> {
  const _GIUlongArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vUlong = value;
    });
  }
}

class _GISizeArgument extends GIArgumentValue<int> {
  const _GISizeArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vSize = value;
    });
  }
}

class _GISSizeArgument extends GIArgumentValue<int> {
  const _GISSizeArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vSsize = value;
    });
  }
}

class _GIStringArgument extends GIArgumentValue<String> {
  const _GIStringArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vString = value.toNativeUtf8().cast();
    });
  }
}

class GIPointerArgument extends GIArgumentValue<Pointer<Void>> {
  const GIPointerArgument(super.value);

  @override
  Pointer<GIArgumentNative> toNative() {
    return _allocateNative((ref) {
      ref.vPointer = value;
    });
  }
}
