import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../data/repository/qr_repository.dart';
import '../../domain/usecases/generate_qr_usecase.dart';
import '../blocs/generate_qr/generate_qr_bloc.dart';
import '../widgets/number_input.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _inputController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR App'),
      ),
      body: BlocProvider(
        create: (context) => GenerateQRBloc(
          generateQRUseCase: GenerateQRUseCase(qrRepository: QRRepository()),
        ),
        child: BlocConsumer<GenerateQRBloc, GenerateQRState>(
          listener: (context, state) {
            if (state is GenerateQRSuccessState) {
              _showQRDialog(context, state.qrData.data);
            } else if (state is GenerateQRErrorState) {
              _showErrorDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImage(
                    data: '1234567890',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 16),
                  NumberInput(controller: _inputController),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final inputData = _inputController.text;
                      context.read<GenerateQRBloc>().generateQR(inputData);
                    },
                    child: const Text('Generar QR'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showQRDialog(BuildContext context, String qrData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR Code generado'),
        content: Image.network(qrData),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
