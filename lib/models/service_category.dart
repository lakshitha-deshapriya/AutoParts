class ServiceCategory {
  int id;
  String category;
  String coverUrl;

  ServiceCategory({
    this.id,
    this.category,
    this.coverUrl,
  });

  static final idKey = 'id';
  static final categoryKey = 'category';
  static final coverUrlKey = 'cover';

  factory ServiceCategory.fromJson(dynamic json) {
    int id = json[idKey];
    String category = json[categoryKey];
    String coverUrl = json[coverUrlKey]?.toString() ?? '';

    return ServiceCategory(
      id: id,
      category: category,
      coverUrl: coverUrl,
    );
  }
}
