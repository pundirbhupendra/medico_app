import 'package:equatable/equatable.dart';

abstract class OTpState extends Equatable {
  const OTpState();

  @override
  List<Object> get props => [];
}

class OTpStateInitial extends OTpState {}

class OtpStateInProgress extends OTpState {}

class OtpStateFailure extends OTpState {
  OtpStateFailure({this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class OTpStateSuccess<T> extends OTpState {
  OTpStateSuccess(this.data) : assert(data != null);

  final T data;

  @override
  List<Object> get props => [data];
}
class OtpSuccess extends  OTpState {
  final success; 
  OtpSuccess(this.success);
  @override
  List<Object> get props => [success];
}