import 'package:flutter/material.dart';
import 'package:state_management_app/state-pattern/person_repository.dart';
import 'package:state_management_app/state-pattern/person_state.dart';

// class PersonStore extends ChangeNotifier {
//   PeopleState state = PeopleState.empty();
//   final PersonRepository repository = PersonRepository();

//   Future<void> getAll() async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final people = await repository.getAll();
//       state = state.copyWith(people: people, isLoading: false);
//       notifyListeners();
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//       notifyListeners();
//     }
//   }
// }

class PersonStore extends ChangeNotifier {
  PersonState state = EmptyPeopleState();
  final PersonRepository repository = PersonRepository();

  PersonStore._();

  static PersonStore? _instance;
  static get instance {
    _instance ??= PersonStore._();
    return _instance;
  }

  Future<void> getAll() async {
    state = LoadingPeopleState();
    notifyListeners();

    try {
      final people = await repository.getAll();
      state = FetchedPeopleState(people: people);
      notifyListeners();
    } catch (e) {
      state = ErrorPeopleState(error: e.toString());
      notifyListeners();
    }
  }
}
