import 'package:flutter/material.dart';
import 'package:project_1/models/user.dart';
import 'package:project_1/screens/home_screen.dart';
import 'package:project_1/screens/log_in_screen.dart';
import 'package:project_1/widgets/custom_text_field.dart';
import 'package:project_1/constants/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int currentStep = 0;
  String? selectedGender;
  late User user;
  final TextEditingController birthdateController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  DateTime? selectedBirthdate;

  @override
  void initState() {
    super.initState();
    user = User();
  }

  @override
  void dispose() {
    birthdateController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthdate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:
          selectedBirthdate ??
          DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: 'DD-MM-YYYY',
      helpText: 'Select birthdate',
    );

    if (pickedDate != null) {
      setState(() {
        selectedBirthdate = pickedDate;
        birthdateController.text =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
        user.birthdate = pickedDate;
      });
    }
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    bool isSelected = selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = gender;
            user.gender = selectedGender!;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isSelected ? AppGradients.primaryGradient : null,
            color: isSelected ? null : AppColors.greyLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: isSelected ? AppShadows.elevatedShadow : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : AppColors.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                gender,
                style: AppFonts.labelLarge.copyWith(
                  color: isSelected ? Colors.white : AppColors.black,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.local_hospital_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'MedX',
                    style: AppFonts.headlineMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Create your professional profile',
                        style: AppFonts.headlineLarge.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Join the network of premier healthcare specialists.',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Step indicators
                      Row(
                        children: [
                          buildStepIndicator('BASIC INFO', currentStep >= 0, 0),
                          const SizedBox(width: 8),
                          buildStepIndicator(
                            'CREDENTIALS',
                            currentStep >= 1,
                            1,
                          ),
                          const SizedBox(width: 8),
                          buildStepIndicator(
                            'VERIFICATION',
                            currentStep >= 2,
                            2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Form container
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: AppShadows.cardShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (currentStep == 0) ...[
                              const SizedBox(height: 10),
                              _buildFieldLabel('Full Name'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                key: const ValueKey('signup_full_name'),
                                hintText: 'user name',
                                inputType: TextInputType.name,
                                textStyle: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.black,
                                ),
                                suffixIcon: Icon(
                                  Icons.person_rounded,
                                  color: AppColors.secondary.withOpacity(0.4),
                                ),
                                onChanged: (data) {
                                  user.name = data;
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildFieldLabel('Email Address'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                key: const ValueKey('signup_email'),
                                hintText: 'emailName@gmail.com',
                                inputType: TextInputType.emailAddress,
                                textStyle: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.black,
                                ),
                                suffixIcon: Icon(
                                  Icons.email_rounded,
                                  color: AppColors.secondary.withOpacity(0.4),
                                ),
                                onChanged: (data) {
                                  user.email = data;
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildFieldLabel('Phone Number'),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    width: 64,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+963",
                                        style: AppFonts.labelLarge.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      key: const ValueKey('signup_phone'),
                                      hintText: "91 111 111",

                                      onlyNumbers: true,
                                      inputType: TextInputType.phone,
                                      textStyle: AppFonts.bodyMedium.copyWith(
                                        color: AppColors.black,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.phone_rounded,
                                        color: AppColors.secondary.withOpacity(
                                          0.4,
                                        ),
                                        size: 20,
                                      ),
                                      onChanged: (data) {
                                        user.phone_number =
                                            int.tryParse(data) ?? 0;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ] else if (currentStep == 1) ...[
                              const SizedBox(height: 10),
                              _buildFieldLabel('Gender'),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  _buildGenderOption(
                                    'Male',
                                    Icons.male_rounded,
                                  ),
                                  const SizedBox(width: 14),
                                  _buildGenderOption(
                                    'Female',
                                    Icons.female_rounded,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _buildFieldLabel('Birthdate'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                key: const ValueKey('signup_birthdate'),
                                controller: birthdateController,
                                hintText: 'Select birthdate',
                                textStyle: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.black,
                                ),
                                readOnly: true,
                                inputType: TextInputType.datetime,
                                suffixIcon: Icon(
                                  Icons.calendar_today_rounded,
                                  color: AppColors.secondary.withOpacity(0.4),
                                ),
                                onTap: () => _pickBirthdate(context),
                                onChanged: null,
                              ),
                              const SizedBox(height: 20),
                              _buildFieldLabel('Address'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                key: const ValueKey('signup_address'),
                                textStyle: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.black,
                                ),
                                hintText: 'City, Country',
                                suffixIcon: Icon(
                                  Icons.location_on_rounded,
                                  color: AppColors.secondary.withOpacity(0.4),
                                ),
                                onChanged: (data) {
                                  user.address = data;
                                },
                              ),
                            ] else if (currentStep == 2) ...[
                              const SizedBox(height: 10),
                              _buildFieldLabel('ID / Passport Number'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                key: const ValueKey('signup_id_passport'),
                                textStyle: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.black,
                                ),
                                hintText: 'Document Number',
                                suffixIcon: Icon(
                                  Icons.badge_rounded,
                                  color: AppColors.secondary.withOpacity(0.4),
                                ),
                                onChanged: (data) {
                                  user.id_passport = int.tryParse(data) ?? 0;
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildFieldLabel('Password'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                key: const ValueKey('signup_password'),
                                textStyle: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.black,
                                ),
                                hintText: '••••••••',
                                obscureText: obscurePassword,
                                inputType: TextInputType.visiblePassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    obscurePassword
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: AppColors.secondary.withOpacity(0.4),
                                  ),
                                ),
                                onChanged: (data) {
                                  user.password = data;
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildFieldLabel('Confirm Password'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                key: const ValueKey('signup_confirm_password'),
                                textStyle: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.black,
                                ),
                                hintText: '••••••••',
                                obscureText: obscureConfirmPassword,
                                inputType: TextInputType.visiblePassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureConfirmPassword =
                                          !obscureConfirmPassword;
                                    });
                                  },
                                  icon: Icon(
                                    obscureConfirmPassword
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: AppColors.secondary.withOpacity(0.4),
                                  ),
                                ),
                                onChanged: (data) {
                                  user.confirm_password = data;
                                },
                              ),
                            ],
                            const SizedBox(height: 28),
                            // Action button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (currentStep < 2) {
                                    setState(() {
                                      currentStep++;
                                    });
                                  } else {
                                    // Final Submit - Print user data
                                    print("=== User Information ===");
                                    print("Name: ${user.name}");
                                    print("Email: ${user.email}");
                                    print("Phone Number: ${user.phone_number}");
                                    print("Gender: ${user.gender}");
                                    print("Birthdate: ${user.birthdate}");
                                    print("Address: ${user.address}");
                                    print("ID/Passport: ${user.id_passport}");
                                    print("Password: ${user.password}");
                                    print(
                                      "Confirm Password: ${user.confirm_password}",
                                    );
                                    print("Is Verified: ${user.Is_verified}");
                                    print("========================");

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(userName: user.name),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currentStep == 2 ? "Verify" : "Next",
                                      style: AppFonts.labelLarge.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        currentStep == 2
                                            ? Icons.check_rounded
                                            : Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (currentStep > 0) ...[
                              const SizedBox(height: 12),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      currentStep--;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_rounded,
                                        color: AppColors.secondary,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Back",
                                        style: AppFonts.labelLarge.copyWith(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            if (currentStep == 0) ...[
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: AppFonts.bodySmall.copyWith(
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LogInScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Log In",
                                      style: AppFonts.labelLarge.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Security note
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary.withOpacity(0.08),
                              AppColors.primary.withOpacity(0.03),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: AppShadows.softShadow,
                              ),
                              child: Icon(
                                Icons.shield_rounded,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                "Your data is encrypted and secure. We comply with global healthcare privacy standards.",
                                style: AppFonts.bodySmall.copyWith(
                                  color: AppColors.secondary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Footer
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildFooterItem(
                              Icons.verified_user_rounded,
                              'HIPAA COMPLIANT',
                            ),
                            Container(
                              width: 1,
                              height: 16,
                              color: Colors.grey.shade300,
                            ),
                            _buildFooterItem(Icons.lock_rounded, '256-BIT AES'),
                          ],
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
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: AppFonts.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    );
  }

  Widget buildStepIndicator(String title, bool isActive, int step) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              gradient: isActive ? AppGradients.primaryGradient : null,
              color: isActive ? null : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(3),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppFonts.labelSmall.copyWith(
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? AppColors.primary : AppColors.secondary,
              letterSpacing: 0.5,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFooterItem(IconData icon, String label) {
  return Row(
    children: [
      Icon(icon, size: 14, color: AppColors.secondary.withOpacity(0.5)),
      const SizedBox(width: 6),
      Text(
        label,
        style: AppFonts.labelSmall.copyWith(
          color: AppColors.secondary.withOpacity(0.5),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ],
  );
}
