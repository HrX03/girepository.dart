import 'dart:ffi';

final class GITypelibNative extends Opaque {}

extension type GITypelib._(Pointer<GITypelibNative> _this) {
  const GITypelib.fromPointer(this._this);

  Pointer<GITypelibNative> get pointer => _this;
}
