import 'package:flutter/material.dart';

enum FunctionalID {
    templates,
    modules,
    elements,
    shapes,
    upload,
    text,
    frames,
    backgrounds,
  }
class Functional {
  FunctionalID id;
  String name;
  IconData icon;
  Functional({ required this.id, required this.name, required this.icon });
}

List<Functional> getFunctions() {
  return [
    Functional(id: FunctionalID.templates, name: "Templates", icon: Icons.ac_unit),
    Functional(id: FunctionalID.modules, name: "Modules", icon: Icons.ac_unit),
    Functional(id: FunctionalID.elements, name: "Elements", icon: Icons.ac_unit),
    Functional(id: FunctionalID.shapes, name: "Shapes", icon: Icons.ac_unit),
    Functional(id: FunctionalID.upload, name: "Upload", icon: Icons.ac_unit),
    Functional(id: FunctionalID.text, name: "Text", icon: Icons.ac_unit),
    Functional(id: FunctionalID.frames, name: "Frames", icon: Icons.ac_unit),
    Functional(id: FunctionalID.backgrounds, name: "Backgrounds", icon: Icons.ac_unit),
  ];
}