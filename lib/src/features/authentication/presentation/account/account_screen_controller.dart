import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_screen_controller.g.dart';

@riverpod
class AccountScreenController extends _$AccountScreenController {
  @override
  FutureOr<void> build() {
    // * some async work
    // await someFuture();
    // * return comeOtherFuture()
    // return ref.read(someProvider).someFuture();

    // in our case we leave the body empty
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signOut);
  }
}

// * AsyncNotifier without Riverpod generator
// class AccountScreenController extends AutoDisposeAsyncNotifier<void> {
//   @override
//   FutureOr<void> build() async {}

//   Future<void> signOut() async {
//     final authRepository = ref.read(authRepositoryProvider);
//     state = const AsyncLoading<void>();
//     state = await AsyncValue.guard<void>(authRepository.signOut);
//   }
// }

// * Provider without Riverpod generator
// final accountScreenControllerProvider =
//     AutoDisposeAsyncNotifierProvider<AccountScreenController, void>(
//         AccountScreenController.new);

// * StateNotifier version
// class AccountScreenController extends StateNotifier<AsyncValue<void>> {
//   AccountScreenController({required this.authRepository})
//       : super(const AsyncData<void>(null));

//   final FakeAuthRepository authRepository;

//   Future<void> signOut() async {
//     // set state to loading
//     // sign out (using auth repo)
//     // if success, set state to data(null) and return true
//     // if error, set state to error and return false
//     // try {
//     //   state = const AsyncValue<void>.loading();
//     //   await authRepository.signOut();
//     //   state = const AsyncValue<void>.data(null);
//     //   return true;
//     // } catch (e, st) {
//     //   state = AsyncValue.error(e, st);
//     //   return false;
//     // }
//     state = const AsyncLoading<void>();
//     state = await AsyncValue.guard<void>(() => authRepository.signOut());
//   }
// }

// final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
//     AccountScreenController, AsyncValue<void>>((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AccountScreenController(authRepository: authRepository);
// });
