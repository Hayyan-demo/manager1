import 'package:flutter/material.dart';
import 'package:order_delivery_manager/dashboard/models/user_model.dart';

class UsersTable extends StatelessWidget {
  final List<UserModel> users;

  const UsersTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Table(
          border: TableBorder.all(
              color: Colors.black.withAlpha(100),
              width: 1,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            const TableRow(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 71, 252, 0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                children: [
                  _HeaderCell('ID'),
                  _HeaderCell('First Name'),
                  _HeaderCell('Last Name'),
                  _HeaderCell('Phone'),
                  _HeaderCell('Location'),
                  _HeaderCell('Locale'),
                  _HeaderCell('Role'),
                  _HeaderCell('Created At'),
                  _HeaderCell('Updated At'),
                ]),
            for (UserModel user in users)
              TableRow(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 165, 241),
                  ),
                  children: [
                    _DataCell(
                      text: user.id,
                    ),
                    _DataCell(
                      text: user.firstName ?? '-',
                    ),
                    _DataCell(
                      text: user.lastName ?? '-',
                    ),
                    _DataCell(
                      text: user.phoneNumber,
                    ),
                    _DataCell(text: user.location ?? ''),
                    _DataCell(text: user.locale ?? ''),
                    _DataCell(text: user.role),
                    _DataCell(text: user.createDate),
                    _DataCell(text: user.updateDate),
                  ])
          ],
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;

  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class _DataCell extends StatelessWidget {
  final String text;

  const _DataCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
                color: text == 'admin'
                    ? const Color.fromARGB(255, 255, 220, 116)
                    : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
