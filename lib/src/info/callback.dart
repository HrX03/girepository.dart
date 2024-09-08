import 'dart:ffi';

import 'package:girepository/src/info/callable.dart';

final class GICallbackInfoNative extends Opaque {}

extension GICallbackInfoPointerExt on GICallbackInfo {
  Pointer<GICallbackInfoNative> get pointer => voidPointer.cast();
}

class GICallbackInfo extends GICallableInfo {
  GICallbackInfo.fromPointer(Pointer<GICallbackInfoNative> pointer)
      : super.raw(pointer.cast());
}
