// ignore_for_file: constant_identifier_names

enum Scope {
  PHOTOFRAME(1, "PHOTOFRAME"),
  ;

  const Scope(this.id, this.name);
  final int id;
  final String name;
}
