class SingleCategory {
  final String id, name, description, count;

  SingleCategory({
    this.id,
    this.name,
    this.description,
    this.count,
  });

  factory SingleCategory.fromJson(Map<String, dynamic> json) {
    return SingleCategory(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      count: json['count'].toString(),
    );
  }
}
