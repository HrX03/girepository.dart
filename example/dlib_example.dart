import 'package:dlib_gen/src/info/base.dart';
import 'package:dlib_gen/src/info/constant.dart';
import 'package:dlib_gen/src/repository.dart';

void main() {
  final repository = GIRepository.getDefault();

  repository.require("GLib", "2.0");
  repository.require("Gio", "2.0");

  final infos = repository.getInfos("Gio");
  for (final info in infos) {
    if (info.getType() == GIInfoType.constant) {
      final constant = info.cast<GIConstantInfo>();
      final constantArg = constant.getValue();
      final constantVal =
          constantArg.toArgumentValue(constant.getTypeInfo().getTag());
      print("${info.getName()}: ${constantVal.value}");
      constant.freeValue(constantArg);
    }
  }
}
