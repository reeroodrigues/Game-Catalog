import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_catalog_app/features/reviews/models/game_review_model.dart';

class ReviewRepository {
  final FirebaseFirestore firestore;

  ReviewRepository(this.firestore);

  Future<void> saveReview(GameReviewModel review) async {
    await firestore
        .collection('reviews')
        .doc('${review.userId}_${review.gameId}')
        .set(review.toJson());
  }

  Future<GameReviewModel?> getReview(String userId, int gameId) async {
    final doc =
        await firestore.collection('reviews').doc('${userId}_$gameId').get();

    if (doc.exists) {
      return GameReviewModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<List<GameReviewModel>> getUserReviews(String userId) async {
    final query = await firestore
        .collection('reviews')
        .where('userId', isEqualTo: userId)
        .get();

    return query.docs
        .map((doc) => GameReviewModel.fromJson(doc.data()))
        .toList();
  }
}
