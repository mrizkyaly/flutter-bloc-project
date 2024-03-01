part of 'scanners_bloc.dart';

@immutable
sealed class ScannersEvent {}

class ScannerInitialEvent extends ScannersEvent {}

class ScannerNavigatToCartEvent extends ScannersEvent {}
