import 'package:auto_parts/models/savable.dart';

class ServiceImage extends Savable {
  static final String tableName = 'SERVICE_IMAGES';
  static final String loadQuery = 'SELECT * FROM ' + tableName + ' WHERE ID=?';

  String id;
  String imageUrl;

  ServiceImage({
    this.id,
    this.imageUrl,
  });

  static final String idCol = 'ID';
  static final String imageUrlCol = 'IMAGE_URL';

  static final Map<String, String> serviceImagesColMap = {
    idCol: 'TEXT',
    imageUrlCol: 'TEXT',
  };

  static String getOnCreateSql() {
    String serviceImagesSql = 'CREATE TABLE ' + tableName + ' ( ';
    int imagesIndex = 1;
    serviceImagesColMap.forEach((key, value) {
      serviceImagesSql = serviceImagesSql + key + ' ' + value + ', ';
      if (imagesIndex == serviceImagesColMap.length) {
        serviceImagesSql = serviceImagesSql +
            'PRIMARY KEY ( ' +
            idCol +
            ', ' +
            imageUrlCol +
            ' ) )';
      }
      imagesIndex++;
    });
    return serviceImagesSql;
  }

  @override
  String getTableName() {
    return tableName;
  }

  @override
  String getArgs() {
    return 'ID = ?';
  }

  @override
  List<dynamic> getArgValues() {
    return [id];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[idCol] = id;
    map[imageUrlCol] = imageUrl;
    return map;
  }

  factory ServiceImage.fromMapObject(Map<String, dynamic> map) {
    return ServiceImage(
      id: map[idCol],
      imageUrl: map[imageUrlCol],
    );
  }
}
