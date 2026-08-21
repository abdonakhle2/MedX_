part of 'update_cubit.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

final class UpdateLoading extends UpdateState {}

final class UpdateSuccess extends UpdateState {
  final User user;
  UpdateSuccess(this.user);
}

final class UpdateError extends UpdateState {
  final String errorMessage;
  UpdateError({required this.errorMessage});
}
