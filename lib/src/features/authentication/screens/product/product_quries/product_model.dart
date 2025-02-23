class ProductModel {
  final String id;
  final String sellerId; // Matches 'seller_id' in Supabase
  final String title;
  final double price;
  final double? discount;
  final String description;
  final List<String> imageUrl;
  final String status; // Matches 'status' in Supabase
  final List<String> tags;
  final DateTime createdAt;
  final String condition;

  ProductModel({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.price,
    this.discount,
    required this.description,
    required this.imageUrl,
    this.status = 'available',
    required this.tags,
    required this.createdAt,
    required this.condition,
  });

  // Convert JSON data from Supabase to ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'] ?? '',
        sellerId: json['seller_id'] ?? '',
        title: json['title'] ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        discount: (json['discount'] as num?)?.toDouble(),
        description: json['description'] ?? '',
        imageUrl: List<String>.from(
            json['image_url'] ?? []), // Convert comma-separated string to List
        status: json['status'] ?? 'available',
        tags: List<String>.from(
            json['tags'] ?? []), // Convert comma-separated string to List
        createdAt: DateTime.parse(json['created_at']),
        condition: json['condition'] ?? '');
  }

  // Convert ProductModel to JSON format for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seller_id': sellerId, // Map to 'seller_id' column
      'title': title,
      'price': price,
      'discount': discount,
      'description': description,
      'image_url': imageUrl.join(','), // Convert List to comma-separated string
      'status': status, // Map condition to 'status'
      'tags': tags.join(','), // Convert List to comma-separated string
      'created_at': createdAt.toIso8601String(),
      'condition': condition
    };
  }
}
