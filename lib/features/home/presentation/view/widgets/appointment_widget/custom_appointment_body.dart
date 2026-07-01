import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_add_note.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_appointment_price.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_confirm_button.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_header_text.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_option_card.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_privcy_text.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_scheduling_card.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_upload_medical_file.dart';
import 'package:project_1/models/doctor.dart';

class CustomAppointmentBody extends StatefulWidget {
  final Doctor myDoctor;

  const CustomAppointmentBody({super.key, required this.myDoctor});

  @override
  State<CustomAppointmentBody> createState() => _CustomAppointmentBodyState();
}

class _CustomAppointmentBodyState extends State<CustomAppointmentBody> {
  String selectedMethod = "schedule";

  Key? get uploadFieldKey => null;
  @override
  Widget build(BuildContext context) {
    PlatformFile? uploadedPassportFile;
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            const CustomHeaderText(),
            const SizedBox(height: 20),
            CustomMethodSelection(),
            // const SizedBox(height: 25),

            // تظهر خيارات الجدولة فقط عند اختيار "Doctor's Schedule"
            if (selectedMethod == "schedule") const CustomSchedulingCard(),
            // const SizedBox(height: 10),
            const CustomAddNote(),
            const SizedBox(height: 2),
            FormField<PlatformFile?>(
              key: uploadFieldKey,
              initialValue: uploadedPassportFile,
              builder: (field) {
                return CustomUploadMedicalFile(
                  selectedFile: field.value,
                  errorText: field.errorText,
                  onFileSelected: (file) {
                    setState(() {
                      uploadedPassportFile = file;
                    });
                    field.didChange(file);
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            const CustomAppointmentPrice(),
            const SizedBox(height: 10),
            const CustomConfirmButton(),
            const SizedBox(height: 10),
            const CustomPrivcyText(),
            SizedBox(height: MediaQuery.of(context).size.height * .1),
          ],
        ),
      ),
    );
  }

  Widget CustomMethodSelection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => selectedMethod = "earliest"),
          child: CustomOptionCard(
            title: "Earliest Available",
            subtitle: "Today at 4:30 PM",
            icon: Icons.flash_on_rounded,
            isActive: selectedMethod == "earliest",
          ),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () => setState(() => selectedMethod = "schedule"),
          child: CustomOptionCard(
            title: "Doctor's Schedule",
            subtitle: "Pick a custom date/time",
            icon: Icons.calendar_today_rounded,
            isActive: selectedMethod == "schedule",
          ),
        ),
      ],
    );
  }
}
