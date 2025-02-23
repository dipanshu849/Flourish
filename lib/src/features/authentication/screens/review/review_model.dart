class ReviewModel {
  final String id;
  final String sellerId;
  final String buyerId;
  final String productId;
  final int rating;
  final String? comment;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.sellerId,
    required this.buyerId,
    required this.productId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  // Convert Supabase JSON to ReviewModel
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      sellerId: json['seller_id'] ?? '',
      buyerId: json['buyer_id'] ?? '',
      productId: json['product_id'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Convert ReviewModel to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seller_id': sellerId,
      'buyer_id': buyerId,
      'product_id': productId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
