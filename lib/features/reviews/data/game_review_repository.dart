import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_review_model.dart';

final gameReviewRepositoryProvider = Provider<GameReviewRepository>((ref) {
  return GameReviewRepository(FirebaseFirestore.instance);
});

class GameReviewRepository {
  final FirebaseFirestore firestore;

  GameReviewRepository(this.firestore);

  Future<void> saveReview(GameReviewModel review) async {
    final docRef = firestore
        .collection('reviews')
        .doc('${review.userId}_${review.gameId}');

    await docRef.set(review.toJson());
  }

  Future<List<GameReviewModel>> getReviewsForGame(int gameId) async {
    final snapshot = await firestore
        .collection('reviews')
        .where('gameId', isEqualTo: gameId)
        .get();

    return snapshot.docs
        .map((doc) => GameReviewModel.fromJson(doc.data()))
        .toList();
  }
}
