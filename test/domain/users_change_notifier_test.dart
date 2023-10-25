import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit_test_tutorial/domain/users_change_notifier.dart';
import 'package:flutter_unit_test_tutorial/models/user.dart';
import 'package:flutter_unit_test_tutorial/services/users_service.dart';
import 'package:mocktail/mocktail.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  late MockUserService mockUserService;
  late UserChangeNotifier sut;

  setUp(() {
    mockUserService = MockUserService();
    sut = UserChangeNotifier(mockUserService);
  });

  group("all methods called from the service", () {
    final usersFromService = [
      User(name: "name1", password: "password1", email: "email1"),
      User(name: "name2", password: "password2", email: "email2"),
      User(name: "name3", password: "password3", email: "email3"),
    ];

    //is a function
    void mockCalledGetUsers() {
      when(() => mockUserService.getUsers())
          .thenAnswer((_) async => usersFromService);
    }

    void mockCalledGetUser(String name, String password) {
      when(() => mockUserService.getUser(name, password))
          .thenAnswer((_) async => usersFromService.firstWhere((element) {
                return element.name == name && element.password == password;
              }));
    }

    test("get users", () async {
      mockCalledGetUsers();
      await sut.getUsers();
      verify(() => mockUserService.getUsers()).called(1);
      verifyNoMoreInteractions(mockUserService);
    });

    test("get user by name and password", () async {
      mockCalledGetUser("name2", "password2");
      final res = await sut.getUser("name2", "password2");
      expect(res, User(name: "name2", password: "password2", email: "email2"));
      verify(() => mockUserService.getUser("name2", "password2")).called(1);
      verifyNoMoreInteractions(mockUserService);
    });
  });
}
