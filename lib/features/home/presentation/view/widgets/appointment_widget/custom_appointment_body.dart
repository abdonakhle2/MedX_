import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/manager/book_appointment_cubit/booking_cubit.dart';
import 'package:project_1/features/home/presentation/manager/book_appointment_cubit/booking_state.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_add_note.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_appointment_price.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_confirm_button.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_header_text.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_option_card.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_privcy_text.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_scheduling_card.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_show_succes_dialog.dart';
import 'package:project_1/models/doctor.dart';

class CustomAppointmentBody extends StatefulWidget {
  final Doctor myDoctor;

  const CustomAppointmentBody({super.key, required this.myDoctor});

  @override
  State<CustomAppointmentBody> createState() => _CustomAppointmentBodyState();
}

class _CustomAppointmentBodyState extends State<CustomAppointmentBody> {
  String selectedMethod = "schedule";
  final TextEditingController _notesController = TextEditingController();

  // ربط المفتاح بالـ State العام الجديد
  final GlobalKey<CustomSchedulingCardState> schedulingKey = GlobalKey();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // PlatformFile? uploadedPassportFile;

    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          print("================================");
          print("✅ تم الحجز بنجاح وتم استقبال البيانات:");
          print(state.appointmentDetails);
          print("رقم الحجز: ${state.appointmentDetails['id']}");
          print("تاريخ الحجز: ${state.appointmentDetails['date']}");
          print("================================");
          CustomShowSuccessDialog(context);
        } else if (state is BookingFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: SliverToBoxAdapter(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 18),
              CustomHeaderText(doctor: widget.myDoctor),
              // const SizedBox(height: 20),
              // CustomMethodSelection(),
              if (selectedMethod == "schedule")
                CustomSchedulingCard(
                  key: schedulingKey,
                  doctor: widget.myDoctor,
                ),
              // const SizedBox(height: 10),
              CustomAddNote(controller: _notesController),
              // const SizedBox(height: 2),
              // FormField<PlatformFile?>(
              //   initialValue: uploadedPassportFile,
              //   builder: (field) {
              //     return CustomUploadMedicalFile(
              //       selectedFile: field.value,
              //       errorText: field.errorText,
              //       onFileSelected: (file) {
              //         setState(() {
              //           uploadedPassportFile = file;
              //         });
              //         field.didChange(file);
              //       },
              //     );
              //   },
              // ),
              // const SizedBox(height: 10),
              CustomAppointmentPrice(doctor: widget.myDoctor),
              // const SizedBox(height: 10),
              CustomConfirmButton(onPressed: _performBooking),
              // const SizedBox(height: 10),
              const CustomPrivcyText(),
              SizedBox(height: MediaQuery.of(context).size.height * .1),
            ],
          ),
        ),
      ),
    );
  }

  void _performBooking() {
    final schedState = schedulingKey.currentState;
    final payload = schedState?.getBookingPayload();

    if (payload == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.bookingErrorMessage),
        ),
      );
      return;
    }

    // إرسال البيانات المستخرجة مباشرة (والتي تحتوي على is_asap: 1 عند اختيار أقرب وقت)
    context.read<BookingCubit>().bookAppointment(
      doctorId: widget.myDoctor.doc_id,
      depId: widget.myDoctor.department_id,
      date: payload['date'],
      time: payload['time'],
      isAsap: payload['is_asap'], // سيتم تمرير 1 هنا بشكل صحيح
      userNotes: _notesController.text,
    );
  }

  Widget CustomMethodSelection() {
    final localeText = AppLocalizations.of(context)!;

    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => selectedMethod = "earliest"),
          child: CustomOptionCard(
            title: localeText.bookingEarliestAvailable,
            subtitle: localeText.bookingEarliestSubtitle,
            icon: Icons.flash_on_rounded,
            isActive: selectedMethod == "earliest",
          ),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () => setState(() => selectedMethod = "schedule"),
          child: CustomOptionCard(
            title: localeText.bookingDoctorSchedule,
            subtitle: localeText.bookingPickCustomDateTime,
            icon: Icons.calendar_today_rounded,
            isActive: selectedMethod == "schedule",
          ),
        ),
      ],
    );
  }
}
