import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/bloc/homes_bloc.dart';
import 'package:flutter_bloc_project/theme/theme.dart';

class ButtonFilter extends StatelessWidget {
  final String name;
  final String type;
  final bool isActive;
  final HomesBloc homesBloc;

  const ButtonFilter({
    super.key,
    required this.name,
    required this.type,
    required this.homesBloc,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {
          homesBloc.add(HomeFilteredProductEvent(
            filterType: type,
          ));
        },
        style: ElevatedButton.styleFrom(
          elevation: 0, // Set elevation to 0 to remove shadow
          backgroundColor: isActive
              ? primaryColor
              : Colors.white, // Set background color to pure white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
                width: 1, color: borderColor), // Border width and color
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Text(
            name, // Button text
            style: inputTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : titleColor,
            ),
          ),
        ),
      ),
    );
  }
}
