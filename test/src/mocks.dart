import 'package:mocktail/mocktail.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/authentication/domain/app_user.dart';
import 'package:nice_and_healthy/src/features/cart/data/local/local_cart_repository.dart';
import 'package:nice_and_healthy/src/features/cart/data/remote/remote_cart_repository.dart';

const testEmail = 'test@test.ru';
const testPassword = 'test1234';
final testUser = AppUser(
  uid: testEmail.split('').reversed.join(),
  email: testEmail,
);

class MockAuthRepository extends Mock implements FakeAuthRepository {}

class MockRemoteCartRepository extends Mock implements RemoteCartRepository {}

class MockLocalCartRepository extends Mock implements LocalCartRepository {}
