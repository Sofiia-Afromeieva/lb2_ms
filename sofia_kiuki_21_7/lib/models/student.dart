import 'package:flutter/material.dart';

const departmentIcons = {
  Department.finance: Icons.account_balance,
  Department.law: Icons.gavel,
  Department.it: Icons.router,
  Department.medical: Icons.healing,
};

enum Department {
  finance,
  law,
  it,
  medical
}


enum Gender {
  male,
  female
}


class Student {
  String firstName;
  String lastName;
  Department department;
  int grade;
  Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}
