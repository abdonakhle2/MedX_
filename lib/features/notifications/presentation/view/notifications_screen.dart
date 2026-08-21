import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/notifications/presentation/manager/cubit/notifications_cubit.dart';
import 'package:project_1/features/notifications/presentation/manager/cubit/notifications_state.dart';
import '../../data/repos/notifications_repo_impl.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) =>
          NotificationsCubit(NotificationsRepoImpl(Dio()))
            ..fetchNotifications(), // جلب البيانات تلقائياً عند فتح الشاشة
      child: Scaffold(
        appBar: AppBar(title: Text(localeText.notifications)),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationsLoaded) {
              // استخدام RefreshIndicator للسحب والتحديث
              return RefreshIndicator(
                onRefresh: () async {
                  // استدعاء دالة الجلب مجدداً عند السحب لأسفل
                  context.read<NotificationsCubit>().fetchNotifications();
                },
                child: state.notifications.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 250),
                          Center(child: Text('There are no notifications')),
                        ],
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.notifications.length,
                        itemBuilder: (context, index) {
                          final notification = state.notifications[index];
                          return ListTile(
                            leading: Icon(
                              Icons.notifications,
                              color: notification.readAt == null
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            title: Text(notification.title ?? 'No Title'),
                            subtitle: Text(notification.body ?? ''),
                          );
                        },
                      ),
              );
            } else if (state is NotificationsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
