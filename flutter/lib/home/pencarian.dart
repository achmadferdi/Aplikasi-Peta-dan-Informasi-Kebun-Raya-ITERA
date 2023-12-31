import 'package:flutter/material.dart';
import 'package:ridikc_crud/data_katalog/data_katalog_screen.dart';

class Pencarian extends StatefulWidget {
  const Pencarian({super.key});

  @override
  State<Pencarian> createState() => _PencarianState();
}

class _PencarianState extends State<Pencarian> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        onTap: () {
          Navigator.of(context).pushNamed(DataKatalogScreen.routeName);
        },
        readOnly: true,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search_rounded),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90)),
              borderSide: BorderSide(color: Colors.white)),
          hintText: 'Pencarian',
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
