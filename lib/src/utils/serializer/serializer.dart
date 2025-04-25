import 'package:wolnelektury/src/application/app_logger.dart';

List<T> serializer<T, E>({
  required List<Map<String, dynamic>> data,
  required T Function(E data) serializer,
}) {
  final list = <T>[];
  for (final element in data) {
    try {
      final serializedData = serializer(element as E);
      list.add(serializedData);
    } catch (e, s) {
      AppLogger.instance.e(
        'serializer: error while serializing data of type ${T.toString()}',
        e,
        s,
      );
    }
  }
  return list;
}
