class Person {
  int id;
  String name;

  Person({
    required this.id,
    required this.name,
  });
}

class PersonRepository {
  List<Person> people = [
    Person(id: 1, name: "João"),
    Person(id: 2, name: "Maria"),
    Person(id: 3, name: "Chiquinha"),
  ];

  Future<List<Person>> getAll() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    // throw Exception("Ops! deu ruim..");

    return people;
  }
}
