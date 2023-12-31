import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/qr_data.dart';
import '../../../domain/usecases/generate_qr_usecase.dart';

part 'generate_qr_state.dart';

class GenerateQRBloc extends Cubit<GenerateQRState> {
  final GenerateQRUseCase generateQRUseCase;

  GenerateQRBloc({required this.generateQRUseCase}) : super(GenerateQRInitialState());

  Future<void> generateQR(String inputData) async {
    emit(GenerateQRLoadingState());
    final result = await generateQRUseCase.execute(inputData);
    result.fold(
          (error) => emit(GenerateQRErrorState(error: error.toString())),
          (qrData) => emit(GenerateQRSuccessState(qrData: qrData)),
    );
  }
}
