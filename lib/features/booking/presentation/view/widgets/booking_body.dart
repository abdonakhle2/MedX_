import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appoinment_cubit.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appointment_state.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_booking_app_bar.dart';
import 'package:project_1/features/booking/presentation/view/widgets/booking_status_toggle.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_booking_card.dart';

class BookingBody extends StatefulWidget {
  const BookingBody({super.key});

  @override
  State<BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<BookingBody> {
  bool isPending = true;

  @override
  void initState() {
    super.initState();
    context.read<UserAppointmentsCubit>().fetchUserAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        const CustomBookingAppBar(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 24),
              BookingStatusToggle(
                isPending: isPending,
                onChanged: (value) {
                  setState(() {
                    isPending = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<UserAppointmentsCubit, UserAppointmentsState>(
                builder: (context, state) {
                  if (state is UserAppointmentsLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 80),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is UserAppointmentsSuccess) {
                    final filteredAppointments = state.appointments.where((
                      appointment,
                    ) {
                      final status = appointment.status.toLowerCase();

                      if (isPending) {
                        return status == 'booked' ||
                            status == 'pending' ||
                            status == 'rescheduled';
                      } else {
                        return status == 'completed' || status == 'finished';
                      }
                    }).toList();

                    if (filteredAppointments.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80),
                        child: Center(
                          child: Text(
                            isPending
                                ? AppLocalizations.of(context)!.bookingsPending
                                : AppLocalizations.of(
                                    context,
                                  )!.bookingsCompleted,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredAppointments.length,
                      itemBuilder: (context, index) {
                        final appointment = filteredAppointments[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: CustomBookingCard(
                            isPending: isPending,
                            appointment: appointment,
                          ),
                        );
                      },
                    );
                  } else if (state is UserAppointmentsFailure) {
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
