import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/cart/ui/cart.dart';
import 'package:flutter_bloc_project/features/scanner/bloc/scanners_bloc.dart';
import 'package:flutter_bloc_project/theme/theme.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  MobileScannerController cameraController = MobileScannerController(
    returnImage: true,
  );
  bool isRoute = false;
  Timer? debounce;

  final ScannersBloc scannersBloc = ScannersBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Scanner Product',
          style: titleTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(
                      Icons.flash_off,
                      color: Colors.grey,
                    );
                  case TorchState.on:
                    return const Icon(
                      Icons.flash_on,
                      color: Colors.yellow,
                    );
                }
              },
            ),
            iconSize: 32,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.front:
                      return const Icon(
                        Icons.camera_front,
                        color: Colors.grey,
                      );
                    case CameraFacing.back:
                      return const Icon(
                        Icons.camera_rear,
                        color: Colors.grey,
                      );
                  }
                },
              ),
              iconSize: 32,
              onPressed: () => cameraController.switchCamera()),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(
              10.0), // Set the preferred size for the bottom border
          child: Container(
            color: borderColor,
            height: 1.0, // Height of the bottom border
          ),
        ),
      ),
      body: BlocConsumer<ScannersBloc, ScannersState>(
        bloc: scannersBloc,
        listenWhen: (previous, current) => current is ScannerActionState,
        buildWhen: (previous, current) => current is! ScannerActionState,
        listener: (context, state) {
          if (state is ScannerNavigateToCartPageActionState) {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()))
                .then((value) => isRoute = false);
          }
        },
        builder: (context, state) {
          return MobileScanner(
            fit: BoxFit.fill,
            controller: cameraController,
            onDetect: (capture) {
              if (debounce != null) {
                debounce!.cancel();
              }

              debounce = Timer(const Duration(milliseconds: 500), () {
                scannersBloc.add(ScannerNavigatToCartEvent());
              });
            },
          );
        },
      ),
    );
  }
}
