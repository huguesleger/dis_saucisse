part of 'reception_cubit.dart';

enum ReceptionProblem { noNetwork, serverUnavailable }

@immutable
sealed class ReceptionState {
  const ReceptionState();
}

final class ReceptionStarting extends ReceptionState {
  const ReceptionStarting();
}

final class ReceptionFailed extends ReceptionState {
  const ReceptionFailed(this.problem);

  final ReceptionProblem problem;
}

final class ReceptionReady extends ReceptionState {
  const ReceptionReady({required this.invitation, required this.phones});

  final PairingPayload invitation;
  final List<PairedPhone> phones;

  ReceptionReady withPhone(PairedPhone phone) => ReceptionReady(
    invitation: invitation,
    phones: <PairedPhone>[...phones.where((PairedPhone known) => known.id != phone.id), phone],
  );
}
