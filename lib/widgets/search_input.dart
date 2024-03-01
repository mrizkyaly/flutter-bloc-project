import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/bloc/homes_bloc.dart';
import 'package:flutter_bloc_project/theme/theme.dart';

class SearchInput extends StatelessWidget {
  final HomesBloc homesBloc;
  final Duration debounceDuration;

  const SearchInput({
    super.key,
    required this.homesBloc,
    this.debounceDuration = const Duration(milliseconds: 1000),
  });

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return Container(
      height: 50,
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: borderColor, // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: iconColor,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextFormField(
                style: inputTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: 'Your Email Address',
                  hintStyle: inputTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onChanged: (query) {
                  // Cancel the previous timer
                  if (debounce != null) {
                    debounce!.cancel();
                  }

                  // Setup a new timer
                  debounce = Timer(debounceDuration, () {
                    // Dispatch the search event after the debounce duration
                    homesBloc.add(HomeSearchProductEvent(query: query));
                  });
                },
                // onChanged: (query) {
                //   homesBloc.add(HomeSearchProductEvent(query: query));
                // },
              ),
            )
          ],
        ),
      ),
    );
  }
}
