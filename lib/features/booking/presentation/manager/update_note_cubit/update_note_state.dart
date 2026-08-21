abstract class UpdateNoteState {}

class UpdateNoteInitial extends UpdateNoteState {}

class UpdateNoteLoading extends UpdateNoteState {}

class UpdateNoteSuccess extends UpdateNoteState {}

class UpdateNoteFailure extends UpdateNoteState {
  final String errorMessage;
  UpdateNoteFailure(this.errorMessage);
}
