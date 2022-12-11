import 'package:flutter/material.dart';

enum FunctionalID {
    template,
    module,
    element,
    shape,
    upload,
    text,
    frame,
    background,
  }
class Functional {
  FunctionalID id;
  String name;
  IconData icon;
  Functional({ required this.id, required this.name, required this.icon });
}

List<Functional> getFunctions() {
  return [
    Functional(id: FunctionalID.template, name: "Templates", icon: Icons.ac_unit),
    Functional(id: FunctionalID.module, name: "Modules", icon: Icons.ac_unit),
    Functional(id: FunctionalID.element, name: "Elements", icon: Icons.ac_unit),
    Functional(id: FunctionalID.shape, name: "Shapes", icon: Icons.ac_unit),
    Functional(id: FunctionalID.upload, name: "Upload", icon: Icons.ac_unit),
    Functional(id: FunctionalID.text, name: "Text", icon: Icons.ac_unit),
    Functional(id: FunctionalID.frame, name: "Frames", icon: Icons.ac_unit),
    Functional(id: FunctionalID.background, name: "Backgrounds", icon: Icons.ac_unit),
  ];
}