import 'dart:ffi';

final class GSListNative extends Struct {
  external final Pointer<Void> data;
  external final Pointer<GSListNative> next;
}

class GSList<T> extends Iterable<T> {
  final Pointer<GSListNative> base;
  final T Function(Pointer<Void> data) converter;

  const GSList.fromPointer(this.base, this.converter);

  @override
  Iterator<T> get iterator => _GSListIterator<T>(base.ref, converter);
}

class _GSListIterator<T> implements Iterator<T> {
  GSListNative native;
  final T Function(Pointer<Void> data) converter;

  _GSListIterator(this.native, this.converter);

  @override
  T get current => converter(native.data);

  @override
  bool moveNext() {
    if (native.next == nullptr) return false;
    native = native.next.ref;

    return true;
  }
}
