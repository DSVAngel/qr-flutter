import 'package:dartz/dartz.dart';
import '../../data/repository/qr_repository.dart';
import '../entities/qr_data.dart';

class GenerateQRUseCase {
  final QRRepository qrRepository;

  GenerateQRUseCase({required this.qrRepository});

  Future<Either<Exception, QRData>> execute(String inputData) async {
    try {
      final qrImage = await qrRepository.generateQRCode(inputData);
      return Right(QRData(data: inputData));
    } catch (e) {
      return Left(Exception('Error generating QR code'));
    }
  }
}
