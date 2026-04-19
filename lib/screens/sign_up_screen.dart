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
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.greyLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
      backgroundColor: AppColors.neutral.withOpacity(.9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Text(
                'MedX',
                style: AppFonts.headlineExtraLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
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
                          color: const Color.fromARGB(177, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Join the network of premier healthcare specialists.',
                        style: AppFonts.bodySmall.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          buildStepIndicator('BASIC INFO', currentStep >= 0),
                          buildStepIndicator('CREDENTIALS ', currentStep >= 1),
                          buildStepIndicator('VERIFICATION', currentStep >= 2),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (currentStep == 0) ...[
                                const SizedBox(height: 20),
                                Text(
                                  'Full Name',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  key: const ValueKey('signup_full_name'),
                                  hintText: 'user name',
                                  inputType: TextInputType.name,
                                  textStyle: AppFonts.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (data) {
                                    user.name = data;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Email Address',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  key: const ValueKey('signup_email'),
                                  hintText: 'emailName@gmail.com',
                                  inputType: TextInputType.emailAddress,
                                  textStyle: AppFonts.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (data) {
                                    user.email = data;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Phone Number',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.greyLight,
                                        borderRadius: BorderRadius.circular(10),
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
                                          color: Colors.grey,
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.phone,
                                          color: Colors.grey,
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
                                const SizedBox(height: 20),
                                Text(
                                  'Gender',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    _buildGenderOption('Male', Icons.male),
                                    const SizedBox(width: 15),
                                    _buildGenderOption('Female', Icons.female),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Birthdate',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  key: const ValueKey('signup_birthdate'),
                                  controller: birthdateController,
                                  hintText: 'Select birthdate',
                                  textStyle: AppFonts.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                  readOnly: true,
                                  inputType: TextInputType.datetime,
                                  suffixIcon: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                  ),
                                  onTap: () => _pickBirthdate(context),
                                  onChanged: null,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Address',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  key: const ValueKey('signup_address'),
                                  textStyle: AppFonts.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                  hintText: 'City, Country',
                                  suffixIcon: const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (data) {
                                    user.address = data;
                                  },
                                ),
                              ] else if (currentStep == 2) ...[
                                const SizedBox(height: 20),
                                Text(
                                  'ID / Passport Number',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  key: const ValueKey('signup_id_passport'),
                                  textStyle: AppFonts.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Document Number',
                                  suffixIcon: const Icon(
                                    Icons.badge,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (data) {
                                    user.id_passport = int.tryParse(data) ?? 0;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Password',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  key: const ValueKey('signup_password'),
                                  textStyle: AppFonts.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                  hintText: '********',
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
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onChanged: (data) {
                                    user.password = data;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Confirm Password',
                                  style: AppFonts.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  key: const ValueKey(
                                    'signup_confirm_password',
                                  ),
                                  textStyle: AppFonts.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                  hintText: '********',
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
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onChanged: (data) {
                                    user.confirm_password = data;
                                  },
                                ),
                              ],
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 55,
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
                                      print(
                                        "Phone Number: ${user.phone_number}",
                                      );
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentStep == 2 ? "Verify" : "Next",
                                        style: AppFonts.headlineSmall.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        currentStep == 2
                                            ? Icons.check_circle
                                            : Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (currentStep > 0) ...[
                                const SizedBox(height: 10),
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        currentStep--;
                                      });
                                    },
                                    child: Text(
                                      "Back",
                                      style: AppFonts.headlineSmall.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              if (currentStep == 0) ...[
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: AppFonts.bodySmall.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LogInScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "  Log In",
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
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.shield,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "Your data is encrypted and secure. We comply with global healthcare privacy standards.",
                                style: AppFonts.bodySmall.copyWith(
                                  color: AppColors.secondary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildFooterItem(
                              Icons.verified_user,
                              'HIPAA COMPLIANT',
                            ),
                            _buildFooterItem(Icons.lock, '256_BIT AES'),
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
}

Widget buildStepIndicator(String title, bool isActive) {
  return Expanded(
    child: Column(
      children: [
        Container(
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppFonts.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: isActive ? AppColors.primary : Colors.grey,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooterItem(IconData icon, String label) {
  return Row(
    children: [
      Icon(icon, size: 14, color: Colors.grey),
      const SizedBox(width: 5),
      Text(
        label,
        style: AppFonts.labelSmall.copyWith(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
