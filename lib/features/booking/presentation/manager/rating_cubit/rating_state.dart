abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSuccess extends RatingState {
  final String message;
  RatingSuccess({required this.message});
}

class RatingFailure extends RatingState {
  final String errMessage;
  RatingFailure({required this.errMessage});
}
