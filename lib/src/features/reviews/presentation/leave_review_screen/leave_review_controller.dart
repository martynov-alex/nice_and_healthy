import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';
import 'package:nice_and_healthy/src/features/reviews/application/reviews_service.dart';
import 'package:nice_and_healthy/src/features/reviews/domain/review.dart';
import 'package:nice_and_healthy/src/utils/current_date_builder.dart';

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
    required Review? previousReview,
    VoidCallback? onSuccess,
  }) async {
    if (previousReview?.rating == rating &&
        previousReview?.comment == comment) {
      if (mounted) onSuccess?.call();
      return;
    }

    final review = Review(
      comment: comment,
      rating: rating,
      date: currentDateBuilder(),
    );

    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() =>
        reviewsService.submitReview(productId: productId, review: review));
    if (mounted) {
      // * only set the state if the controller hasn't been disposed
      state = newState;
      if (!state.hasError) onSuccess?.call();
    }
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
