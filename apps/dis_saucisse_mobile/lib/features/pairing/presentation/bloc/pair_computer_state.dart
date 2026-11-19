part of 'pair_computer_cubit.dart';

enum PairingProblem { invalidCode, unreachable, refused }

@immutable
sealed class PairComputerState {
  const PairComputerState();
}

final class PairComputerScanning extends PairComputerState {
  const PairComputerScanning();
}

final class PairComputerPairing extends PairComputerState {
  const PairComputerPairing(this.computerName);

  final String computerName;
}

final class PairComputerPaired extends PairComputerState {
  const PairComputerPaired(this.computer);

  final PairedComputer computer;
}

final class PairComputerFailed extends PairComputerState {
  const PairComputerFailed(this.problem);

  final PairingProblem problem;
}
