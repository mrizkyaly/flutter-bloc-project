import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/bloc/homes_bloc.dart';
import 'package:flutter_bloc_project/theme/theme.dart';

class ButtonFilter extends StatefulWidget {
  final String name;
  final String type;
  final HomesBloc homesBloc;
  final int index; // Menambahkan indeks sebagai parameter

  const ButtonFilter({
    super.key,
    required this.name,
    required this.type,
    required this.homesBloc,
    required this.index, // Menerima indeks sebagai parameter
  });

  @override
  // ignore: library_private_types_in_public_api
  _ButtonFilterState createState() => _ButtonFilterState();
}

class _ButtonFilterState extends State<ButtonFilter> {
  int _activeIndex =
      -1; // Indeks tombol yang aktif, default -1 (tidak ada yang aktif)

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _activeIndex = widget.index;
          });

          widget.homesBloc
              .add(HomeFilteredProductEvent(filterType: widget.type));
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          // backgroundColor:
          //     _activeIndex == widget.index ? primaryColor : Colors.white,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(width: 1, color: borderColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Text(
            widget.name,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                //color: _activeIndex == widget.index ? Colors.white : titleColor,
                color: titleColor),
          ),
        ),
      ),
    );
  }
}
