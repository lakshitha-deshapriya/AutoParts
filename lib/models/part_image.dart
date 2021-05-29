import 'package:auto_parts/models/savable.dart';

class PartImage extends Savable {
  static final String tableName = 'PART_IMAGES';
  static final String loadQuery = 'SELECT * FROM ' + tableName + ' WHERE ID=?';

  String id;
  String imageUrl;

  PartImage({
    this.id,
    this.imageUrl,
  });

  static final String idCol = 'ID';
  static final String imageUrlCol = 'IMAGE_URL';

  static final Map<String, String> partImagesColMap = {
    idCol: 'TEXT',
    imageUrlCol: 'TEXT',
  };

  static String getOnCreateSql() {
    String partImagesSql = 'CREATE TABLE ' + tableName + ' ( ';
    int imagesIndex = 1;
    partImagesColMap.forEach((key, value) {
      partImagesSql = partImagesSql + key + ' ' + value + ', ';
      if (imagesIndex == partImagesColMap.length) {
        partImagesSql = partImagesSql +
            'PRIMARY KEY ( ' +
            idCol +
            ', ' +
            imageUrlCol +
            ' ) )';
      }
      imagesIndex++;
    });
    return partImagesSql;
  }

  @override
  String getTableName() {
    return tableName;
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[idCol] = id;
    map[imageUrlCol] = imageUrl;
    return map;
  }

  factory PartImage.fromMapObject(Map<String, dynamic> map) {
    return PartImage(
      id: map[idCol],
      imageUrl: map[imageUrlCol],
    );
  }
}
