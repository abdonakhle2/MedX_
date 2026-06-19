import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/models/user.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _birthdateController;
  late TextEditingController _addressController;
  late TextEditingController _idPassportController;
  
  DateTime? _selectedBirthdate;

  @override
  void initState() {
    super.initState();
    final user = User.currentUser;
    _nameController = TextEditingController(text: user.name);
    _phoneController = TextEditingController(text: user.phone_number?.toString());
    _emailController = TextEditingController(text: user.email);
    _addressController = TextEditingController(text: user.address);
    _idPassportController = TextEditingController(text: user.id_passport?.toString());
    
    _selectedBirthdate = user.birthdate;
    if (_selectedBirthdate != null) {
      _birthdateController = TextEditingController(
        text: '${_selectedBirthdate!.year}-${_selectedBirthdate!.month.toString().padLeft(2, '0')}-${_selectedBirthdate!.day.toString().padLeft(2, '0')}',
      );
    } else {
      _birthdateController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthdateController.dispose();
    _addressController.dispose();
    _idPassportController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthdate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthdate ?? DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select Birthdate',
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
        _birthdateController.text =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileCubit>().updateProfile(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: int.tryParse(_phoneController.text.trim()),
            birthdate: _selectedBirthdate,
            address: _addressController.text.trim(),
            idPassport: int.tryParse(_idPassportController.text.trim()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: AppFonts.headlineMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Profile updated successfully!',
                  style: AppFonts.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
              ),
            );
            Navigator.pop(context);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: AppFonts.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        builder: (context, state) {
          final isUpdating = state is ProfileUpdating;
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppGradients.primaryGradient,
                              boxShadow: AppShadows.softShadow,
                            ),
                            child: const Center(
                              child: Icon(
                                Symbols.person_rounded,
                                color: Colors.white,
                                size: 50,
                                fill: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Full Name
                    _buildFieldLabel('Full Name'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      style: AppFonts.bodyMedium.copyWith(color: AppColors.black),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: 'John Doe',
                        icon: Symbols.person,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Address
                    _buildFieldLabel('Email Address'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: AppFonts.bodyMedium.copyWith(color: AppColors.black),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: 'JohnDoe@gmail.com',
                        icon: Symbols.mail,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Phone Number
                    _buildFieldLabel('Phone Number'),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.greyLight,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.grey.shade200, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              "+963",
                              style: AppFonts.labelLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            style: AppFonts.bodyMedium.copyWith(color: AppColors.black),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (value.trim().length < 7) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                            decoration: _buildInputDecoration(
                              hintText: '999999999',
                              icon: Symbols.call,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Birthdate
                    _buildFieldLabel('Birthdate'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _birthdateController,
                      readOnly: true,
                      onTap: () => _pickBirthdate(context),
                      style: AppFonts.bodyMedium.copyWith(color: AppColors.black),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please select your birthdate';
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: 'Oct 24, 1992',
                        icon: Symbols.calendar_month,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ID / Passport Number
                    _buildFieldLabel('ID / Passport Number'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _idPassportController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: AppFonts.bodyMedium.copyWith(color: AppColors.black),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your ID/Passport number';
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: '123456789',
                        icon: Symbols.badge,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Address
                    _buildFieldLabel('Address'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _addressController,
                      style: AppFonts.bodyMedium.copyWith(color: AppColors.black),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your residential address';
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: '722 Marble Arch, West District, London, UK',
                        icon: Symbols.location_on,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isUpdating ? null : _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: isUpdating
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Save Changes",
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
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: AppFonts.bodyLarge.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    );
  }

  InputDecoration _buildInputDecoration({required String hintText, required IconData icon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppFonts.bodyMedium.copyWith(
        color: AppColors.secondary.withOpacity(0.4),
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.secondary.withOpacity(0.6),
        size: 22,
      ),
      filled: true,
      fillColor: AppColors.greyLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
    );
  }
}
