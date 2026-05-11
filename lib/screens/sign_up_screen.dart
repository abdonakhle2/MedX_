import 'package:flutter/material.dart';
import 'package:project_1/models/user.dart';
import 'package:project_1/screens/home_screen.dart';
import 'package:project_1/screens/log_in_screen.dart';
import 'package:project_1/widgets/custom_button.dart';
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
            color: isSelected ? AppColors.primary : AppColors.greyLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade300,
              width: 1,
            ),
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
      backgroundColor: AppColors.neutral,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.health_and_safety,
                      size: 44,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'MedX',
                  style: AppFonts.headlineExtraLarge.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your account',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.secondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 40),

                // Form Section
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step indicators
                          Row(
                            children: [
                              buildStepIndicator(
                                'BASIC INFO',
                                currentStep >= 0,
                                0,
                              ),
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
                          const SizedBox(height: 32),
                          if (currentStep == 0) ...[
                            _buildFieldLabel('Full Name'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              key: const ValueKey('signup_full_name'),
                              hintText: 'John Doe',
                              inputType: TextInputType.name,
                              suffixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                              onChanged: (data) {
                                user.name = data;
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildFieldLabel('Email Address'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              key: const ValueKey('signup_email'),
                              hintText: 'johndoe@example.com',
                              inputType: TextInputType.emailAddress,
                              suffixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              onChanged: (data) {
                                user.email = data;
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildFieldLabel('Phone Number'),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const SizedBox(height: 6),
                                Expanded(
                                  child: CustomTextField(
                                    key: const ValueKey('signup_phone'),
                                    hintText: '+963 911 111 111',
                                    onlyNumbers: true,
                                    inputType: TextInputType.phone,
                                    suffixIcon: const Icon(
                                      Icons.phone_outlined,
                                      color: Colors.grey,
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
                            _buildFieldLabel('Gender'),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildGenderOption('Male', Icons.male_outlined),
                                const SizedBox(width: 12),
                                _buildGenderOption(
                                  'Female',
                                  Icons.female_outlined,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            _buildFieldLabel('Birthdate'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              key: const ValueKey('signup_birthdate'),
                              controller: birthdateController,
                              hintText: 'DD-MM-YYYY',
                              readOnly: true,
                              inputType: TextInputType.datetime,
                              suffixIcon: const Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.grey,
                              ),
                              onTap: () => _pickBirthdate(context),
                              onChanged: null,
                            ),
                            const SizedBox(height: 24),
                            _buildFieldLabel('Address'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              key: const ValueKey('signup_address'),
                              hintText: 'City, Country',
                              suffixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                              ),
                              onChanged: (data) {
                                user.address = data;
                              },
                            ),
                          ] else if (currentStep == 2) ...[
                            _buildFieldLabel('ID / Passport Number'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              key: const ValueKey('signup_id_passport'),
                              hintText: 'Document Number',
                              suffixIcon: const Icon(
                                Icons.badge_outlined,
                                color: Colors.grey,
                              ),
                              onChanged: (data) {
                                user.id_passport = int.tryParse(data) ?? 0;
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildFieldLabel('Password'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              key: const ValueKey('signup_password'),
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
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (data) {
                                user.password = data;
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildFieldLabel('Confirm Password'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              key: const ValueKey('signup_confirm_password'),
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
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (data) {
                                user.confirm_password = data;
                              },
                            ),
                          ],
                          const SizedBox(height: 32),
                          // Action button
                          CustomButton(
                            text: currentStep == 2 ? "Verify" : "Next",
                            onTap: () {
                              if (currentStep < 2) {
                                setState(() {
                                  currentStep++;
                                });
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(userName: user.name),
                                  ),
                                );
                              }
                            },
                          ),
                          if (currentStep > 0) ...[
                            const SizedBox(height: 16),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentStep--;
                                  });
                                },
                                child: Text(
                                  "Back",
                                  style: AppFonts.labelLarge.copyWith(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          if (currentStep == 0) ...[
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade200,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    "ALREADY HAVE AN ACCOUNT?",
                                    style: AppFonts.labelSmall.copyWith(
                                      color: AppColors.secondary,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade200,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: AppFonts.bodyMedium.copyWith(
                                    color: AppColors.secondary,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
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
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTrustBadge(
                      Icons.verified_user_outlined,
                      'HIPAA COMPLIANT',
                    ),
                    const SizedBox(width: 32),
                    _buildTrustBadge(Icons.lock_outline, '256-BIT AES'),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: AppFonts.labelLarge.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildStepIndicator(String title, bool isActive, int step) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppFonts.labelSmall.copyWith(
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              color: isActive ? AppColors.primary : AppColors.secondary,
              letterSpacing: 0.5,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBadge(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.secondary),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppFonts.labelSmall.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
