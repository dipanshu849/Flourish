import 'package:flourish/src/features/authentication/screens/review/review_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Add a review
  Future<bool> addReview(ReviewModel review) async {
    try {
      final response = await _supabase.from('reviews').insert(review.toJson());
      return response != null;
    } catch (e) {
      print("Error adding review: $e");
      return false;
    }
  }

  // Fetch all reviews for a seller
  Future<List<ReviewModel>> getSellerReviews(String sellerId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('*')
          .eq('seller_id', sellerId)
          .order('created_at', ascending: false);

      return response.map((review) => ReviewModel.fromJson(review)).toList();
    } catch (e) {
      print("Error fetching reviews: $e");
      return [];
    }
  }

  // Get average rating of a seller
  Future<double> getAverageRating(String sellerId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('rating')
          .eq('seller_id', sellerId);

      if (response.isEmpty) return 0.0;

      double avgRating = response
              .map((review) => review['rating'] as int)
              .reduce((a, b) => a + b) /
          response.length;

      return avgRating;
    } catch (e) {
      print("Error fetching average rating: $e");
      return 0.0;
    }
  }
}
