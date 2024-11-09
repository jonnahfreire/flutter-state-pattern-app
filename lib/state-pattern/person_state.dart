import 'package:state_management_app/state-pattern/person_repository.dart';

sealed class PersonState {}

class LoadingPeopleState implements PersonState {}

class FetchedPeopleState implements PersonState {
  List<Person> people = [];
  FetchedPeopleState({required this.people});
}

class EmptyPeopleState implements PersonState {}

class ErrorPeopleState implements PersonState {
  final String error;
  ErrorPeopleState({required this.error});
}

class PeopleState {
  List<Person> people;
  bool isLoading;
  String error;

  PeopleState({
    required this.people,
    required this.isLoading,
    required this.error,
  });

  factory PeopleState.empty() {
    return PeopleState(isLoading: false, error: '', people: []);
  }

  PeopleState copyWith({
    List<Person>? people,
    bool? isLoading,
    String? error,
  }) {
    return PeopleState(
      people: people ?? this.people,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
