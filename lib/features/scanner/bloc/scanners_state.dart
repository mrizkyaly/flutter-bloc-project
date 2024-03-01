part of 'scanners_bloc.dart';

@immutable
sealed class ScannersState {}

abstract class ScannerActionState extends ScannersState {}

// Scanner State
final class ScannersInitial extends ScannersState {}

class ScannerLoadingState extends ScannersState {}

class ScannerLoadedSuccessState extends ScannersState {}

class ScannerErrorState extends ScannersState {}

// NAVIGATE STATE

class ScannerNavigateToCartPageActionState extends ScannerActionState {}
