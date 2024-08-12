import 'package:mocktail/mocktail.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/authentication/domain/app_user.dart';

const testEmail = 'test@test.ru';
const testPassword = 'test1234';
final testUser = AppUser(
  uid: testEmail.split('').reversed.join(),
  email: testEmail,
);

class MockAuthRepository extends Mock implements FakeAuthRepository {}
