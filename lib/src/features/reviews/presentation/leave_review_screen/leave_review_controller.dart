import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';
import 'package:nice_and_healthy/src/features/reviews/application/reviews_service.dart';
import 'package:nice_and_healthy/src/features/reviews/domain/review.dart';
import 'package:nice_and_healthy/src/utils/current_date_provider.dart';

class LeaveReviewController extends StateNotifier<AsyncValue<void>> {
  LeaveReviewController({
    required this.reviewsService,
    required this.currentDateBuilder,
  }) : super(const AsyncData<void>(null));

  final ReviewsService reviewsService;
  // this is injected so we can easily mock it in tests
  final DateTime Function() currentDateBuilder;

  Future<void> submitReview({
    required ProductID productId,
    required String comment,
    required double rating,
  }) async {
    final review = Review(
      comment: comment,
      rating: rating,
      date: currentDateBuilder(),
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => reviewsService.submitReview(productId: productId, review: review),
    );
  }
}

final leaveReviewControllerProvider =
    StateNotifierProvider.autoDispose<LeaveReviewController, AsyncValue<void>>(
        (ref) {
  return LeaveReviewController(
    reviewsService: ref.watch(reviewsServiceProvider),
    currentDateBuilder: ref.watch(currentDateBuilderProvider),
  );
});
