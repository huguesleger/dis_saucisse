import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/bloc/pair_computer_cubit.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/widgets/pair_help_sheet.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/widgets/pair_top_bar.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/widgets/pair_viewfinder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PairScannerView extends StatefulWidget {
  const PairScannerView({super.key});

  @override
  State<PairScannerView> createState() => _PairScannerViewState();
}

class _PairScannerViewState extends State<PairScannerView> {
  final MobileScannerController _controller = MobileScannerController(formats: <BarcodeFormat>[BarcodeFormat.qrCode]);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final String? code = capture.barcodes.map((Barcode barcode) => barcode.rawValue).nonNulls.firstOrNull;
    if (code != null) context.read<PairComputerCubit>().codeScanned(code);
  }

  Future<void> _importImage() async {
    final PairComputerCubit cubit = context.read<PairComputerCubit>();
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 2000);
    if (image != null) await cubit.qrImagePicked(image.path);
  }

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      Expanded(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
              errorBuilder: (BuildContext context, MobileScannerException error) =>
                  const ColoredBox(color: DsColors.text),
            ),
            const PairViewfinder(),
            const Align(alignment: Alignment.topCenter, child: PairTopBar()),
          ],
        ),
      ),
      PairHelpSheet(onImportImage: _importImage),
    ],
  );
}
