// ignore_for_file: constant_identifier_names

abstract class GErrorEnum {
  final int code;

  const GErrorEnum(this.code);
}

enum GFileError implements GErrorEnum {
  EXIST(0),
  ISDIR(1),
  ACCES(2),
  NAMETOOLONG(3),
  NOENT(4),
  NOTDIR(5),
  NXIO(6),
  NODEV(7),
  ROFS(8),
  TXTBSY(9),
  FAULT(10),
  LOOP(11),
  NOSPC(12),
  NOMEM(13),
  MFILE(14),
  NFILE(15),
  BADF(16),
  INVAL(17),
  PIPE(18),
  AGAIN(19),
  INTR(20),
  IO(21),
  PERM(22),
  NOSYS(23),
  FAILED(24);

  @override
  final int code;

  const GFileError(this.code);
}

enum GIOError implements GErrorEnum {
  FAILED(0),
  NOT_FOUND(1),
  EXISTS(2),
  IS_DIRECTORY(3),
  NOT_DIRECTORY(4),
  NOT_EMPTY(5),
  NOT_REGULAR_FILE(6),
  NOT_SYMBOLIC_LINK(7),
  NOT_MOUNTABLE_FILE(8),
  FILENAME_TOO_LONG(9),
  INVALID_FILENAME(10),
  TOO_MANY_LINKS(11),
  NO_SPACE(12),
  INVALID_ARGUMENT(13),
  PERMISSION_DENIED(14),
  NOT_SUPPORTED(15),
  NOT_MOUNTED(16),
  ALREADY_MOUNTED(17),
  CLOSED(18),
  CANCELLED(19),
  PENDING(20),
  READ_ONLY(21),
  CANT_CREATE_BACKUP(22),
  WRONG_ETAG(23),
  TIMED_OUT(24),
  WOULD_RECURSE(25),
  BUSY(26),
  WOULD_BLOCK(27),
  HOST_NOT_FOUND(28),
  WOULD_MERGE(29),
  FAILED_HANDLED(30),
  TOO_MANY_OPEN_FILES(31),
  NOT_INITIALIZED(32),
  ADDRESS_IN_USE(33),
  PARTIAL_INPUT(34),
  INVALID_DATA(35),
  DBUS_ERROR(36),
  HOST_UNREACHABLE(37),
  NETWORK_UNREACHABLE(38),
  CONNECTION_REFUSED(39),
  PROXY_FAILED(40),
  PROXY_AUTH_FAILED(41),
  PROXY_NEED_AUTH(42),
  PROXY_NOT_ALLOWED(43),
  BROKEN_PIPE(44),
  CONNECTION_CLOSED(44),
  NOT_CONNECTED(45),
  MESSAGE_TOO_LARGE(46),
  NO_SUCH_DEVICE(47),
  DESTINATION_UNSET(48);

  @override
  final int code;

  const GIOError(this.code);
}

enum GIRepositoryError implements GErrorEnum {
  typelibNotFound(0),
  namespaceMismatch(1),
  namespaceVersionConflict(2),
  libraryNotFound(3);

  @override
  final int code;

  const GIRepositoryError(this.code);
}
