import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/booking/data/booking_repo_imp.dart';
import 'package:project_1/models/appointments.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_show_dialog.dart';
import 'package:project_1/features/booking/presentation/view/widgets/booking_details_bottom_sheet.dart';
import 'package:project_1/features/booking/presentation/manager/update_note_cubit/update_note_cubit.dart';
import 'package:project_1/features/booking/presentation/manager/update_note_cubit/update_note_state.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appoinment_cubit.dart';
import 'package:project_1/features/booking/presentation/manager/cancel_appintment_cubit/cancel_appointment_cubit.dart';
import 'package:project_1/features/booking/presentation/manager/cancel_appintment_cubit/cancel_appointment_state.dart';

class CustomBookingCard extends StatelessWidget {
  final bool isPending;
  final Appointments appointment;

  const CustomBookingCard({
    super.key,
    required this.isPending,
    required this.appointment,
  });

  void _showEditNoteBottomSheet(
    BuildContext context,
    Appointments appointment,
  ) {
    final TextEditingController noteController = TextEditingController(
      text: appointment.userNotes ?? '',
    );
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final userAppointmentsCubit = context.read<UserAppointmentsCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) {
        return BlocProvider(
          create: (context) => UpdateNoteCubit(BookingRepoImpl(Dio())),
          child: BlocConsumer<UpdateNoteCubit, UpdateNoteState>(
            listener: (context, state) {
              if (state is UpdateNoteSuccess) {
                Navigator.pop(modalContext);
                userAppointmentsCubit.fetchUserAppointments();
                print('تم تحديث الملاحظة بنجاح للموعد رقم: ${appointment.id}');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('the note updated')),
                );
              } else if (state is UpdateNoteFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              bool isLoading = state is UpdateNoteLoading;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(modalContext).viewInsets.bottom + 20,
                  left: 20,
                  right: 20,
                  top: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تعديل الملاحظة',
                      style: AppFonts.headlineMedium.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: noteController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'اكتب ملاحظتك هنا...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                                context
                                    .read<UpdateNoteCubit>()
                                    .updateAppointmentNotes(
                                      appointmentId: int.parse(
                                        appointment.id.toString(),
                                      ),
                                      userNotes: noteController.text,
                                    );
                              },
                        child: isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: colorScheme.onPrimary,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'حفظ التعديل',
                                style: AppFonts.labelLarge.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // دالة عرض حوار تأكيد إلغاء وحذف الحجز
  void _showCancelConfirmationDialog(
    BuildContext context,
    Appointments appointment,
  ) {
    final userAppointmentsCubit = context.read<UserAppointmentsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider(
        create: (context) => CancelAppointmentCubit(BookingRepoImpl(Dio())),
        child: BlocConsumer<CancelAppointmentCubit, CancelAppointmentState>(
          listener: (context, state) {
            if (state is CancelAppointmentSuccess) {
              Navigator.pop(dialogContext);
              userAppointmentsCubit.fetchUserAppointments();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('canceled successfully')),
              );
            } else if (state is CancelAppointmentFailure) {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            bool isLoading = state is CancelAppointmentLoading;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('cancel the appointment'),
              content: const Text('are you sure to cancel the appointment'),
              actions: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.pop(dialogContext),
                  style: TextButton.styleFrom(
                    foregroundColor:
                        Colors.grey[750], // لون النص رمادي داكن وواضح
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Undo',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          context
                              .read<CancelAppointmentCubit>()
                              .cancelAppointment(
                                appointmentId: int.parse(
                                  appointment.id.toString(),
                                ),
                              );
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'I am sure',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    final String formattedDate = appointment.date.toIso8601String().substring(
      0,
      10,
    );
    final String formattedTime = appointment.time.toIso8601String().length >= 16
        ? appointment.time.toIso8601String().substring(11, 16)
        : appointment.time.toString();
    final String currentLang = Localizations.localeOf(context).languageCode;

    final String doctorName = currentLang == 'ar'
        ? (appointment.doctor?.nameAr ?? 'اسم الطبيب')
        : (appointment.doctor?.nameEn ?? 'Doctor Name');

    final String clinicName =
        (currentLang == 'ar'
            ? appointment.department?.clinic?.nameAr
            : appointment.department?.clinic?.nameEn) ??
        localeText.bookingsMedXCenter;

    final String rawDesc =
        (currentLang == 'ar'
            ? appointment.department?.descriptionAr
            : appointment.department?.descriptionEn) ??
        'Department';

    final String departmentName = currentLang == 'ar'
        ? (rawDesc.contains('قسم') ? rawDesc.split(' بيقدم')[0] : rawDesc)
        : (rawDesc.startsWith('The ')
              ? '${rawDesc.replaceFirst('The ', '').split(' Department')[0]} Department'
              : rawDesc);
    final String formattedFee =
        '${appointment.appointmentFee.toStringAsFixed(2)} \$';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(0.08),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary.withOpacity(0.08),
                        colorScheme.primary.withOpacity(0.03),
                      ],
                    ),
                  ),
                  child: Icon(
                    Symbols.person_filled_rounded,
                    size: 180,
                    color: colorScheme.primary.withOpacity(0.15),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'STATUS: ${appointment.status.toUpperCase()}',
                    style: AppFonts.labelSmall.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isPending
                        ? AppColors.amber.withOpacity(0.15)
                        : AppColors.success.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPending
                              ? AppColors.amber
                              : AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isPending
                            ? localeText.bookingsPending
                            : localeText.bookingsCompleted,
                        style: AppFonts.labelSmall.copyWith(
                          color: isPending
                              ? AppColors.amber
                              : AppColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        doctorName,
                        style: AppFonts.headlineMedium.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        formattedFee,
                        style: AppFonts.labelMedium.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  clinicName,
                  style: AppFonts.bodyMedium.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  departmentName,
                  style: AppFonts.bodySmall.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Symbols.calendar_today,
                                size: 20,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localeText.bookingsDate,
                                  style: AppFonts.labelSmall.copyWith(
                                    color: colorScheme.onSurface.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: AppFonts.bodyMedium.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 36,
                        color: colorScheme.onSurface.withOpacity(0.1),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Symbols.access_time,
                                size: 20,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localeText.bookingsTime,
                                  style: AppFonts.labelSmall.copyWith(
                                    color: colorScheme.onSurface.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                ),
                                Text(
                                  formattedTime,
                                  style: AppFonts.bodyMedium.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: isPending
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface.withOpacity(0.04),
                            border: Border.all(
                              color: colorScheme.onSurface.withOpacity(0.15),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                _showEditNoteBottomSheet(context, appointment);
                              },
                              child: Center(
                                child: Text(
                                  localeText.updateNote,
                                  style: AppFonts.labelLarge.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.error.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                // استدعاء دالة عرض حوار إلغاء وحذف الحجز
                                _showCancelConfirmationDialog(
                                  context,
                                  appointment,
                                );
                              },
                              child: Center(
                                child: Text(
                                  localeText.bookingsCancel,
                                  style: AppFonts.labelLarge.copyWith(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface.withOpacity(0.04),
                            border: Border.all(
                              color: colorScheme.onSurface.withOpacity(0.15),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                BookingDetailsBottomSheet.show(
                                  context,
                                  appointment,
                                );
                              },
                              child: Center(
                                child: Text(
                                  localeText.bookingDetailsTitle,
                                  style: AppFonts.labelLarge.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              ShowSuccessDialog(context, appointment);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star_rounded, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  localeText.bookingsRateVisit,
                                  style: AppFonts.labelLarge.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
