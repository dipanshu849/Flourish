import 'package:flourish/src/features/authentication/screens/review/review_model.dart';
import 'package:flourish/src/features/authentication/screens/review/review_repository.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewController extends GetxController {
  final ReviewRepository _reviewRepo = ReviewRepository();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> submitReview({
    required String sellerId,
    required String buyerId,
    required String productId,
    required int rating,
    String? comment,
  }) async {
    ReviewModel review = ReviewModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
      sellerId: sellerId,
      buyerId: buyerId,
      productId: productId,
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
    );

    bool success = await _reviewRepo.addReview(review);
    if (success) {
      Get.snackbar("Success", "Review submitted successfully!");
    } else {
      Get.snackbar("Error", "Failed to submit review.");
    }
  }

  // Fetch seller's average rating & total ratings count
  Future<Map<String, dynamic>> getSellerReviewStats(String sellerId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('rating')
          .eq('seller_id', sellerId);

      if (response.isEmpty) {
        return {'average_rating': 0.0, 'total_ratings': 0};
      }

      double avgRating = response
              .map((review) => review['rating'] as int)
              .reduce((a, b) => a + b) /
          response.length;

      return {
        'average_rating': avgRating,
        'total_ratings': response.length,
      };
    } catch (e) {
      print("Error fetching seller review stats: $e");
      return {'average_rating': 0.0, 'total_ratings': 0};
    }
  }

  Future<Map<String, dynamic>> getSellerReviews(String sellerId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('buyer_name, rating, review_text, created_at')
          .eq('seller_id', sellerId)
          .order('created_at', ascending: false);

      if (response.isEmpty) {
        return {
          'reviews': [],
          'average_rating': 0.0,
          'total_ratings': 0,
          'rating_distribution': {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
        };
      }

      double totalRating = 0.0;
      int totalRatings = response.length;
      Map<int, int> ratingDistribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

      for (var review in response) {
        int rating = review['rating'];
        totalRating += rating;
        ratingDistribution[rating] = (ratingDistribution[rating] ?? 0) + 1;
      }

      double avgRating = totalRating / totalRatings;

      return {
        'reviews': response,
        'average_rating': avgRating,
        'total_ratings': totalRatings,
        'rating_distribution': ratingDistribution,
      };
    } catch (e) {
      print("Error fetching reviews: $e");
      return {
        'reviews': [],
        'average_rating': 0.0,
        'total_ratings': 0,
        'rating_distribution': {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
      };
    }
  }
}
