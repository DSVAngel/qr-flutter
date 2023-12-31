part of 'generate_qr_bloc.dart';

abstract class GenerateQRState extends Equatable {
  const GenerateQRState();

  @override
  List<Object> get props => [];
}

class GenerateQRInitialState extends GenerateQRState {}

class GenerateQRLoadingState extends GenerateQRState {}

class GenerateQRSuccessState extends GenerateQRState {
  final QRData qrData;

  const GenerateQRSuccessState({required this.qrData});

  @override
  List<Object> get props => [qrData];
}

class GenerateQRErrorState extends GenerateQRState {
  final String error;

  const GenerateQRErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
