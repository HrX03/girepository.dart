// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:girepository/src/info/base.dart';
import 'package:girepository/src/error.dart';
import 'package:girepository/src/libraries.dart';
import 'package:girepository/src/list.dart';
import 'package:girepository/src/typelib.dart';
import 'package:girepository/src/types.dart';
import 'package:ffi/ffi.dart';

final class GIRepositoryNative extends Opaque {}

extension type GIRepository._(Pointer<GIRepositoryNative> _this) {
  static void prependSearchPath(String directory) {
    return using((arena) {
      return _g_irepository_prepend_search_path(
        directory.toNativeUtf8(allocator: arena).cast(),
      );
    });
  }

  static GIRepository getDefault() {
    return GIRepository._(_g_irepository_get_default());
  }

  GSList<String> getSearchPath() {
    return GSList.fromPointer(
      _g_irepository_get_search_path(),
      (data) {
        return data.cast<Utf8>().toDartString();
      },
    );
  }

  GIBaseInfo? findByName(String namespace, String name) {
    return using((arena) {
      final pointer = _g_irepository_find_by_name(
        _this,
        namespace.toNativeUtf8(allocator: arena).cast(),
        name.toNativeUtf8(allocator: arena).cast(),
      );

      if (pointer == nullptr) return null;
      return GIBaseInfo.fromPointer(pointer);
    });
  }

  List<String> getDependencies(String namespace) {
    return using((arena) {
      final pointer = _g_irepository_get_dependencies(
        _this,
        namespace.toNativeUtf8(allocator: arena).cast(),
      );

      try {
        return charPPToString(pointer);
      } finally {
        calloc.free(pointer);
      }
    });
  }

  List<String> getLoadedNamespaces() {
    final pointer = _g_irepository_get_loaded_namespaces(_this);

    try {
      return charPPToString(pointer);
    } finally {
      calloc.free(pointer);
    }
  }

  int getNInfos(String namespace) {
    return using((arena) {
      return _g_irepository_get_n_infos(
        _this,
        namespace.toNativeUtf8(allocator: arena).cast(),
      );
    });
  }

  GIBaseInfo getInfo(String namespace, int index) {
    return using((arena) {
      return GIBaseInfo.fromPointer(
        _g_irepository_get_info(
          _this,
          namespace.toNativeUtf8(allocator: arena).cast(),
          index,
        ),
      );
    });
  }

  List<GIBaseInfo> getInfos(String namespace) {
    final List<GIBaseInfo> result = [];
    final nInfos = getNInfos(namespace);

    for (int i = 0; i < nInfos; i++) {
      result.add(getInfo(namespace, i));
    }

    return result;
  }

  String? getCPrefix(String namespace) {
    return using((arena) {
      final result = _g_irepository_get_c_prefix(
        _this,
        namespace.toNativeUtf8(allocator: arena).cast(),
      );
      if (result == nullptr) return null;
      return result.cast<Utf8>().toDartString();
    });
  }

  bool isRegistered(String namespace, [String? version]) {
    return using((arena) {
      return _g_irepository_is_registered(
        _this,
        namespace.toNativeUtf8(allocator: arena).cast(),
        version?.toNativeUtf8(allocator: arena).cast() ?? nullptr,
      );
    });
  }

  String loadTypelib(GITypelib typelib) {
    return handleGError((nativeErr) {
      final result =
          _g_irepository_load_typelib(_this, typelib.pointer, 0, nativeErr);
      return result.cast<Utf8>().toDartString();
    });
  }

  GITypelib? require(String namespace, [String? version]) {
    return using((arena) {
      return handleGError((nativeErr) {
        final pointer = _g_irepository_require(
          _this,
          namespace.toNativeUtf8(allocator: arena).cast(),
          version?.toNativeUtf8(allocator: arena).cast() ?? nullptr,
          0,
          nativeErr,
        );

        if (pointer == nullptr) return null;
        return GITypelib.fromPointer(pointer);
      });
    });
  }
}

final _g_irepository_find_by_name = libgirepository.lookupFunction<
    Pointer<GIBaseInfoNative> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
      Pointer<Char>,
    ),
    Pointer<GIBaseInfoNative> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
      Pointer<Char>,
    )>('g_irepository_find_by_name');

final _g_irepository_get_default = libgirepository.lookupFunction<
    Pointer<GIRepositoryNative> Function(),
    Pointer<GIRepositoryNative> Function()>('g_irepository_get_default');

final _g_irepository_get_dependencies = libgirepository.lookupFunction<
    Pointer<Pointer<Char>> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
    ),
    Pointer<Pointer<Char>> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
    )>('g_irepository_get_dependencies');

final _g_irepository_get_search_path = libgirepository.lookupFunction<
    Pointer<GSListNative> Function(),
    Pointer<GSListNative> Function()>('g_irepository_get_search_path');

final _g_irepository_get_n_infos = libgirepository.lookupFunction<
    Int Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
    ),
    int Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
    )>('g_irepository_get_n_infos');

final _g_irepository_get_loaded_namespaces = libgirepository.lookupFunction<
    Pointer<Pointer<Char>> Function(
      Pointer<GIRepositoryNative>,
    ),
    Pointer<Pointer<Char>> Function(
      Pointer<GIRepositoryNative>,
    )>('g_irepository_get_loaded_namespaces');

final _g_irepository_get_info = libgirepository.lookupFunction<
    Pointer<GIBaseInfoNative> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
      Int,
    ),
    Pointer<GIBaseInfoNative> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
      int,
    )>('g_irepository_get_info');

final _g_irepository_get_c_prefix = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
    ),
    Pointer<Char> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
    )>('g_irepository_get_c_prefix');

final _g_irepository_is_registered = libgirepository.lookupFunction<
    Bool Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
      Pointer<Char>,
    ),
    bool Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
      Pointer<Char>,
    )>('g_irepository_is_registered');

final _g_irepository_load_typelib = libgirepository.lookupFunction<
    Pointer<Char> Function(
      Pointer<GIRepositoryNative>,
      Pointer<GITypelibNative>,
      UnsignedInt,
      Pointer<Pointer<GErrorNative>>,
    ),
    Pointer<Char> Function(
      Pointer<GIRepositoryNative>,
      Pointer<GITypelibNative>,
      int,
      Pointer<Pointer<GErrorNative>>,
    )>('g_irepository_load_typelib');

final _g_irepository_prepend_search_path = libgirepository.lookupFunction<
    Void Function(Pointer<Char>),
    void Function(Pointer<Char>)>('g_irepository_prepend_search_path');

final _g_irepository_require = libgirepository.lookupFunction<
    Pointer<GITypelibNative> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
      Pointer<Char>,
      UnsignedInt,
      Pointer<Pointer<GErrorNative>>,
    ),
    Pointer<GITypelibNative> Function(
      Pointer<GIRepositoryNative>,
      Pointer<Char>,
      Pointer<Char>,
      int,
      Pointer<Pointer<GErrorNative>>,
    )>('g_irepository_require');
