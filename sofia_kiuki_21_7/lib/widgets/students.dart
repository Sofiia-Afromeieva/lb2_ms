import 'package:flutter/material.dart'; 
import 'package:sofia_kiuki_21_7/widgets/student_item.dart';
import 'package:sofia_kiuki_21_7/widgets/new_student.dart';
import 'package:sofia_kiuki_21_7/models/student.dart';


class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final List<Student> _studentsList = [
    Student(
      firstName: 'Naruto',
      lastName: 'Uzumaki',
      department: Department.law,
      grade: 7,
      gender: Gender.male,
    ),
        Student(
      firstName: 'Shalltear',
      lastName: 'Bloodfallen',
      department: Department.finance,
      grade: 9,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Light',
      lastName: 'Yagami',
      department: Department.it,
      grade: 6,
      gender: Gender.male,
    ),
        Student(
      firstName: 'Nanami',
      lastName: 'Momozono',
      department: Department.medical,
      grade: 8,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Joseph',
      lastName: 'Joestar',
      department: Department.finance,
      grade: 9,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Ferid',
      lastName: 'Bathory',
      department: Department.medical,
      grade: 10,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Lucy',
      lastName: 'Heartfilia',
      department: Department.it,
      grade: 8,
      gender: Gender.female,
    ),
  ];

void _addNewStudent(Student student) {
    setState(() {
      _studentsList.add(student);
    });
  }

  void _deleteStudent(int index) {
    final deletedStudent = _studentsList[index];
    setState(() {
      _studentsList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Student removed!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _studentsList.insert(index, deletedStudent);
            });
          },
        ),
      ),
    );
  }

void _openNewStudentModal({Student? student, int? index}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    builder: (ctx) {
      return SafeArea(
        minimum: const EdgeInsets.only(top: 16), 
        child: FractionallySizedBox(
          heightFactor: 0.95, 
          child: NewStudent(
            initialStudent: student,
            onSave: (newStudent) {
              if (index != null) {
                setState(() {
                  _studentsList[index] = newStudent;
                });
              } else {
                _addNewStudent(newStudent);
              }
            },
          ),
        ),
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            onPressed: () => _openNewStudentModal(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _studentsList.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_studentsList[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => _deleteStudent(index),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: InkWell(
              onTap: () => _openNewStudentModal(
                student: _studentsList[index],
                index: index,
              ),
              child: StudentItem(student: _studentsList[index]),
            ),
          );
        },
      ),
    );
  }
}
