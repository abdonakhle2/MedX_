import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_upload_id_passport.dart';
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
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _birthdateController;
  late TextEditingController _addressController;
  late TextEditingController _idPassportController;
  late TextEditingController _passwordController;

  DateTime? _selectedBirthdate;
  bool _isPasswordHidden = false;

  @override
  void initState() {
    super.initState();
    final user = User.currentUser;
    _firstNameController = TextEditingController(text: user.firstName);
    _lastNameController = TextEditingController(text: user.lastName);
    _phoneController = TextEditingController(
      text: user.phone_number?.toString(),
    );
    _emailController = TextEditingController(text: user.email);
    _addressController = TextEditingController(text: user.address);
    _idPassportController = TextEditingController(
      text: user.id_passport?.toString(),
    );
    _passwordController = TextEditingController(text: user.password);

    _selectedBirthdate = user.birthdate;
    if (_selectedBirthdate != null) {
      _birthdateController = TextEditingController(
        text:
            '${_selectedBirthdate!.year}-${_selectedBirthdate!.month.toString().padLeft(2, '0')}-${_selectedBirthdate!.day.toString().padLeft(2, '0')}',
      );
    } else {
      _birthdateController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthdateController.dispose();
    _addressController.dispose();
    _idPassportController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthdate(BuildContext context) async {
    final localeText = AppLocalizations.of(context)!;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthdate ?? DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: localeText.registerSelectBirthdate,
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
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
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
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localeText.profileEditTitle,
          style: AppFonts.headlineMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: colorScheme.onSurface,
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
                  localeText.editProfileUpdateSuccess,
                  style: AppFonts.bodyMedium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: colorScheme
                    .primary, // الاعتماد على لون الثيم الأساسي للنجاح أو لون مخصص متوافق
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
            Navigator.pop(context);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: AppFonts.bodyMedium.copyWith(
                    color: colorScheme.onError,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: colorScheme.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        builder: (context, state) {
          final localeText = AppLocalizations.of(context)!;

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
                            child: Center(
                              child: Icon(
                                Symbols.person_rounded,
                                color: colorScheme.onPrimary,
                                size: 50,
                                fill: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // First Name
                    _buildFieldLabel(context, localeText.registerFirstName),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameController,
                      style: AppFonts.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localeText.registerFirstNameRequired;
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        context: context,
                        hintText: localeText.registerFirstNameExample,
                        icon: Symbols.person,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Last Name
                    _buildFieldLabel(context, localeText.registerLastName),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameController,
                      style: AppFonts.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localeText.registerLastNameRequired;
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        context: context,
                        hintText: localeText.registerLastNameExample,
                        icon: Symbols.person,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Address
                    _buildFieldLabel(
                      context,
                      localeText.registerEmailAddressLabel,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      style: AppFonts.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localeText.emailRequiredLogin;
                        }
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value.trim())) {
                          return localeText.emailInvalidLogin;
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        context: context,
                        hintText: 'JohnDoe@gmail.com',
                        icon: Symbols.mail,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Phone Number
                    _buildFieldLabel(context, localeText.registerPhoneNumber),
                    const SizedBox(height: 8),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: colorScheme.onSurface.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: colorScheme.onSurface.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "+963",
                                textDirection: TextDirection.ltr,
                                style: AppFonts.labelLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: AppFonts.bodyMedium.copyWith(
                                color: colorScheme.onSurface,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return localeText.registerInvalidPhone;
                                }
                                if (value.trim().length < 9) {
                                  return localeText.registerInvalidPhone;
                                }
                                return null;
                              },
                              decoration: _buildInputDecoration(
                                context: context,
                                hintText: '999999999',
                                icon: Symbols.call,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Birthdate
                    _buildFieldLabel(context, localeText.profileBirthdate),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _birthdateController,
                      readOnly: true,
                      onTap: () => _pickBirthdate(context),
                      style: AppFonts.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localeText.registerSelectBirthdate;
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        context: context,
                        hintText: 'Oct 24, 1992',
                        icon: Symbols.calendar_month,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ID / Passport Number
                    _buildFieldLabel(context, localeText.profilePassportNumber),
                    const SizedBox(height: 8),
                    // TextFormField(
                    //   controller: _idPassportController,
                    //   keyboardType: TextInputType.number,
                    //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    //   style: AppFonts.bodyMedium.copyWith(
                    //     color: colorScheme.onSurface,
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return localeText.registerUploadIDPassport;
                    //     }
                    //     return null;
                    //   },
                    //   decoration: _buildInputDecoration(
                    //     context: context,
                    //     hintText: '123456789',
                    //     icon: Symbols.badge,
                    //   ),
                    // ),
                    CustomUploadIdPassportFile(),
                    const SizedBox(height: 20),

                    // Address
                    _buildFieldLabel(context, localeText.registerAddress),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _addressController,
                      style: AppFonts.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localeText.registerAddress;
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        context: context,
                        hintText: '722 Marble Arch, West District, London, UK',
                        icon: Symbols.location_on,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password
                    _buildFieldLabel(context, localeText.passwordLogin),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style: AppFonts.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      obscureText: _isPasswordHidden,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localeText.passwordRequiredLogin;
                        }
                        if (value.length < 8) {
                          return localeText.registerMinimumCharacters;
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colorScheme.onSurface.withOpacity(0.05),
                        hintText: '**********',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
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
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: isUpdating
                            ? CircularProgressIndicator(
                                color: colorScheme.onPrimary,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    localeText.editProfileSaveChanges,
                                    style: AppFonts.labelLarge.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: colorScheme.onPrimary.withOpacity(
                                        0.2,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check_rounded,
                                      color: colorScheme.onPrimary,
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

  Widget _buildFieldLabel(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      text,
      style: AppFonts.bodyLarge.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required BuildContext context,
    required String hintText,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppFonts.bodyMedium.copyWith(
        color: colorScheme.onSurface.withOpacity(0.4),
      ),
      prefixIcon: Icon(
        icon,
        color: colorScheme.onSurface.withOpacity(0.4),
        size: 22,
      ),
      filled: true,
      fillColor: colorScheme.onSurface.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: colorScheme.onSurface.withOpacity(0.1),
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.error, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    );
  }
}
