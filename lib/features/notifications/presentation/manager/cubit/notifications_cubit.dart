import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/notifications/data/repos/notifications_repo.dart';
import 'package:project_1/features/notifications/presentation/manager/cubit/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo repo; // أو NotificationsRepoImpl حسب الواجهة عندك

  NotificationsCubit(this.repo) : super(NotificationsInitial());

  void fetchNotifications() async {
    emit(NotificationsLoading());

    final result = await repo.getNotifications();

    result.fold(
      (failure) => emit(NotificationsError(failure.errorMessage)),
      (notifications) => emit(NotificationsLoaded(notifications)),
    );
  }
}
