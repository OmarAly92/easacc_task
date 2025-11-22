import 'package:equatable/equatable.dart';

class InAppWebScreenArguments extends Equatable {
  final void Function() navigateAfterSuccess;
  final String? paymentUrl;

  const InAppWebScreenArguments({
    required this.navigateAfterSuccess,
    required this.paymentUrl,
  });

  @override
  List<Object?> get props => [navigateAfterSuccess, paymentUrl];
}
