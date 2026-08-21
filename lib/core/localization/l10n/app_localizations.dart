import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitleSplash.
  ///
  /// In en, this message translates to:
  /// **'Your Complete Digital Health Partner'**
  String get appTitleSplash;

  /// No description provided for @appSubtitleSplash.
  ///
  /// In en, this message translates to:
  /// **'Professional healthcare services at your fingertips.'**
  String get appSubtitleSplash;

  /// No description provided for @englishSplash.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishSplash;

  /// No description provided for @arabicSplash.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicSplash;

  /// No description provided for @continueButtonSplash.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButtonSplash;

  /// No description provided for @selectLanguageLogin.
  ///
  /// In en, this message translates to:
  /// **'Select Language :'**
  String get selectLanguageLogin;

  /// No description provided for @humanCentricLogin.
  ///
  /// In en, this message translates to:
  /// **'Human-Centric Authority in Healthcare.'**
  String get humanCentricLogin;

  /// No description provided for @welcomeBackLogin.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBackLogin;

  /// No description provided for @emailLogin.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLogin;

  /// No description provided for @passwordLogin.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLogin;

  /// No description provided for @forgotPasswordLogin.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordLogin;

  /// No description provided for @dontHaveAccountLogin.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccountLogin;

  /// No description provided for @createAccountLogin.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountLogin;

  /// No description provided for @newToPlatformLogin.
  ///
  /// In en, this message translates to:
  /// **'NEW TO THE PLATFORM?'**
  String get newToPlatformLogin;

  /// No description provided for @buttonLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get buttonLogin;

  /// No description provided for @hipaaCompliantLogin.
  ///
  /// In en, this message translates to:
  /// **'HIPAA COMPLIANT'**
  String get hipaaCompliantLogin;

  /// No description provided for @aesEncryptionLogin.
  ///
  /// In en, this message translates to:
  /// **'256-BIT AES'**
  String get aesEncryptionLogin;

  /// No description provided for @passwordRequiredLogin.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequiredLogin;

  /// No description provided for @passwordLengthLogin.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordLengthLogin;

  /// No description provided for @emailRequiredLogin.
  ///
  /// In en, this message translates to:
  /// **'email is required'**
  String get emailRequiredLogin;

  /// No description provided for @emailInvalidLogin.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailInvalidLogin;

  /// No description provided for @emailExampleLogin.
  ///
  /// In en, this message translates to:
  /// **'ahmad@example.com'**
  String get emailExampleLogin;

  /// No description provided for @registerFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get registerFirstName;

  /// No description provided for @registerLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get registerLastName;

  /// No description provided for @registerPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get registerPhoneNumber;

  /// No description provided for @registerGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get registerGender;

  /// No description provided for @registerSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select your gender'**
  String get registerSelectGender;

  /// No description provided for @registerMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get registerMale;

  /// No description provided for @registerFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get registerFemale;

  /// No description provided for @registerBirthdate.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get registerBirthdate;

  /// No description provided for @registerAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get registerAddress;

  /// No description provided for @registerUploadID.
  ///
  /// In en, this message translates to:
  /// **'Please upload your ID/passport image'**
  String get registerUploadID;

  /// No description provided for @registerConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registerConfirmPassword;

  /// No description provided for @registerSelectBirthdate.
  ///
  /// In en, this message translates to:
  /// **'Select birthdate'**
  String get registerSelectBirthdate;

  /// No description provided for @registerDateFormat.
  ///
  /// In en, this message translates to:
  /// **'DD-MM-YYYY'**
  String get registerDateFormat;

  /// No description provided for @registerBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get registerBack;

  /// No description provided for @registerNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get registerNext;

  /// No description provided for @registerVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get registerVerify;

  /// No description provided for @registerConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get registerConfirmPasswordRequired;

  /// No description provided for @registerPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get registerPasswordsDoNotMatch;

  /// No description provided for @registerRetypePassword.
  ///
  /// In en, this message translates to:
  /// **'Retype your password'**
  String get registerRetypePassword;

  /// No description provided for @registerEnterAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your address'**
  String get registerEnterAddress;

  /// No description provided for @registerAddressExample.
  ///
  /// In en, this message translates to:
  /// **'Damascus, Syria'**
  String get registerAddressExample;

  /// No description provided for @registerSelectBirthdateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select your birthdate'**
  String get registerSelectBirthdateRequired;

  /// No description provided for @registerPhoneCountryCode.
  ///
  /// In en, this message translates to:
  /// **'+963'**
  String get registerPhoneCountryCode;

  /// No description provided for @registerEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get registerEnterPhone;

  /// No description provided for @registerInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get registerInvalidPhone;

  /// No description provided for @phoneStartWith9.
  ///
  /// In en, this message translates to:
  /// **'Phone number must start with 9'**
  String get phoneStartWith9;

  /// No description provided for @registerInvalidFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid first name'**
  String get registerInvalidFirstName;

  /// No description provided for @registerFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get registerFirstNameRequired;

  /// No description provided for @registerInvalidLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid last name'**
  String get registerInvalidLastName;

  /// No description provided for @registerLastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get registerLastNameRequired;

  /// No description provided for @registerTabBasicInfo.
  ///
  /// In en, this message translates to:
  /// **'BASIC INFO'**
  String get registerTabBasicInfo;

  /// No description provided for @registerTabCredentials.
  ///
  /// In en, this message translates to:
  /// **'CREDENTIALS'**
  String get registerTabCredentials;

  /// No description provided for @registerTabVerification.
  ///
  /// In en, this message translates to:
  /// **'VERIFICATION'**
  String get registerTabVerification;

  /// No description provided for @registerUploadIDPassport.
  ///
  /// In en, this message translates to:
  /// **'Upload ID or Passport'**
  String get registerUploadIDPassport;

  /// No description provided for @registerSupportedFormats.
  ///
  /// In en, this message translates to:
  /// **'Supported formats: JPG, PNG, PDF'**
  String get registerSupportedFormats;

  /// No description provided for @registerEmailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get registerEmailAddressLabel;

  /// No description provided for @registerMinimumCharacters.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get registerMinimumCharacters;

  /// No description provided for @registerEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get registerEnterPassword;

  /// No description provided for @registerBirthdateExample.
  ///
  /// In en, this message translates to:
  /// **'10-07-1990'**
  String get registerBirthdateExample;

  /// No description provided for @registerFirstNameExample.
  ///
  /// In en, this message translates to:
  /// **'Ahmad'**
  String get registerFirstNameExample;

  /// No description provided for @registerLastNameExample.
  ///
  /// In en, this message translates to:
  /// **'Al-Faraj'**
  String get registerLastNameExample;

  /// No description provided for @bookingsMedXCenter.
  ///
  /// In en, this message translates to:
  /// **'MedX Center'**
  String get bookingsMedXCenter;

  /// No description provided for @bookingsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get bookingsCompleted;

  /// No description provided for @bookingsPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bookingsPending;

  /// No description provided for @bookingsDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get bookingsDate;

  /// No description provided for @bookingsTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get bookingsTime;

  /// No description provided for @updateNote.
  ///
  /// In en, this message translates to:
  /// **'Update Note'**
  String get updateNote;

  /// No description provided for @bookingsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get bookingsCancel;

  /// No description provided for @bookingsRateVisit.
  ///
  /// In en, this message translates to:
  /// **'Rate Visit'**
  String get bookingsRateVisit;

  /// No description provided for @bookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookingsTitle;

  /// No description provided for @ratingCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your appointment, the care quality, and staff professionalism...'**
  String get ratingCommentHint;

  /// No description provided for @ratingTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Visit'**
  String get ratingTitle;

  /// No description provided for @ratingQuestion.
  ///
  /// In en, this message translates to:
  /// **'How was your clinical experience with'**
  String get ratingQuestion;

  /// No description provided for @ratingShareThoughts.
  ///
  /// In en, this message translates to:
  /// **'SHARE YOUR THOUGHTS'**
  String get ratingShareThoughts;

  /// No description provided for @ratingMaybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get ratingMaybeLater;

  /// No description provided for @ratingSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Rating'**
  String get ratingSubmit;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'My Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No favorites added yet'**
  String get favoritesEmpty;

  /// No description provided for @failedToLoadFavorites.
  ///
  /// In en, this message translates to:
  /// **'Failed to load favorites'**
  String get failedToLoadFavorites;

  /// No description provided for @favoritesAdded.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get favoritesAdded;

  /// No description provided for @favoritesRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get favoritesRemoved;

  /// No description provided for @searchCenter.
  ///
  /// In en, this message translates to:
  /// **'Center'**
  String get searchCenter;

  /// No description provided for @searchDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get searchDoctor;

  /// No description provided for @searchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchLabel;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for centers'**
  String get searchHint;

  /// No description provided for @noResultSearch.
  ///
  /// In en, this message translates to:
  /// **'there are no result'**
  String get noResultSearch;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @appointmentPrimaryFacility.
  ///
  /// In en, this message translates to:
  /// **'PRIMARY FACILITY'**
  String get appointmentPrimaryFacility;

  /// No description provided for @doctorHourlySuffix.
  ///
  /// In en, this message translates to:
  /// **'/hr'**
  String get doctorHourlySuffix;

  /// No description provided for @doctorBookButton.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get doctorBookButton;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditTitle;

  /// No description provided for @profileContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get profileContactInfo;

  /// No description provided for @profilePersonalIdentity.
  ///
  /// In en, this message translates to:
  /// **'Personal Identity'**
  String get profilePersonalIdentity;

  /// No description provided for @profileAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get profileAge;

  /// No description provided for @profileBirthdate.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get profileBirthdate;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profileLogout;

  /// No description provided for @profileMember.
  ///
  /// In en, this message translates to:
  /// **'MEMBER'**
  String get profileMember;

  /// No description provided for @profileIdLabel.
  ///
  /// In en, this message translates to:
  /// **'ID:'**
  String get profileIdLabel;

  /// No description provided for @profileResidential.
  ///
  /// In en, this message translates to:
  /// **'RESIDENTIAL'**
  String get profileResidential;

  /// No description provided for @profileVerificationDocuments.
  ///
  /// In en, this message translates to:
  /// **'Verification Documents'**
  String get profileVerificationDocuments;

  /// No description provided for @profilePassportFile.
  ///
  /// In en, this message translates to:
  /// **'PASSPORT FILE'**
  String get profilePassportFile;

  /// No description provided for @profileNoPassportImage.
  ///
  /// In en, this message translates to:
  /// **'No image'**
  String get profileNoPassportImage;

  /// No description provided for @profileStartDate.
  ///
  /// In en, this message translates to:
  /// **'START DATE'**
  String get profileStartDate;

  /// No description provided for @profileChangeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get profileChangeLanguage;

  /// No description provided for @profileSelectLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your favorite language'**
  String get profileSelectLanguageSubtitle;

  /// No description provided for @editProfileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get editProfileSaveChanges;

  /// No description provided for @profileLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguageTitle;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @editProfileUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get editProfileUpdateSuccess;

  /// No description provided for @homeMedicalCenters.
  ///
  /// In en, this message translates to:
  /// **'Medical Centers : '**
  String get homeMedicalCenters;

  /// No description provided for @homeHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Prioritize Your\nHealth Today'**
  String get homeHeaderTitle;

  /// No description provided for @homeHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You have no upcoming appointments. Schedule a visit to stay on top of your health.'**
  String get homeHeaderSubtitle;

  /// No description provided for @homeBookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get homeBookAppointment;

  /// No description provided for @homeUpcomingAppointment.
  ///
  /// In en, this message translates to:
  /// **'Your Upcoming Appointment'**
  String get homeUpcomingAppointment;

  /// No description provided for @homeOurNetwork.
  ///
  /// In en, this message translates to:
  /// **'OUR NETWORK'**
  String get homeOurNetwork;

  /// No description provided for @homeSpecialists.
  ///
  /// In en, this message translates to:
  /// **'SPECIALISTS'**
  String get homeSpecialists;

  /// No description provided for @homeDistricts.
  ///
  /// In en, this message translates to:
  /// **'DISTRICTS'**
  String get homeDistricts;

  /// No description provided for @homeCentersCount.
  ///
  /// In en, this message translates to:
  /// **'CENTERS'**
  String get homeCentersCount;

  /// No description provided for @homeAvgRating.
  ///
  /// In en, this message translates to:
  /// **'AVG RATING'**
  String get homeAvgRating;

  /// No description provided for @homeSupport.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get homeSupport;

  /// No description provided for @homeDoctorsCount.
  ///
  /// In en, this message translates to:
  /// **'DOCTORS'**
  String get homeDoctorsCount;

  /// No description provided for @homeGetDoctorsByDepartment.
  ///
  /// In en, this message translates to:
  /// **'Get Doctors By Department'**
  String get homeGetDoctorsByDepartment;

  /// No description provided for @centerAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About the Institute'**
  String get centerAboutTitle;

  /// No description provided for @centerDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Center Details'**
  String get centerDetailsTitle;

  /// No description provided for @centerDoctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get centerDoctors;

  /// No description provided for @noDoctorsFound.
  ///
  /// In en, this message translates to:
  /// **'No doctors found in this department.'**
  String get noDoctorsFound;

  /// No description provided for @centerExperience.
  ///
  /// In en, this message translates to:
  /// **'EXPERIENCE'**
  String get centerExperience;

  /// No description provided for @centerOperatingHours.
  ///
  /// In en, this message translates to:
  /// **'OPERATING HOURS'**
  String get centerOperatingHours;

  /// No description provided for @centerLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get centerLocation;

  /// No description provided for @centerGetDirections.
  ///
  /// In en, this message translates to:
  /// **'GET DIRECTIONS'**
  String get centerGetDirections;

  /// No description provided for @centerRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get centerRating;

  /// No description provided for @bookingNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Type your notes here...'**
  String get bookingNotesHint;

  /// No description provided for @bookingAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get bookingAppointmentTitle;

  /// No description provided for @bookingEarliestAvailable.
  ///
  /// In en, this message translates to:
  /// **'Earliest Available'**
  String get bookingEarliestAvailable;

  /// No description provided for @bookingDoctorSchedule.
  ///
  /// In en, this message translates to:
  /// **'Doctor\'s Schedule'**
  String get bookingDoctorSchedule;

  /// No description provided for @bookingPaymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get bookingPaymentDetails;

  /// No description provided for @bookingConsultationFee.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fee'**
  String get bookingConsultationFee;

  /// No description provided for @bookingPlatformFee.
  ///
  /// In en, this message translates to:
  /// **'Digital Platform Fee'**
  String get bookingPlatformFee;

  /// No description provided for @bookingTotalCash.
  ///
  /// In en, this message translates to:
  /// **'Total cash'**
  String get bookingTotalCash;

  /// No description provided for @bookingConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get bookingConfirmButton;

  /// No description provided for @bookingWithDoctorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Book with'**
  String get bookingWithDoctorPrefix;

  /// No description provided for @bookingTermsAgreementPrefix.
  ///
  /// In en, this message translates to:
  /// **'By confirming, you agree to our'**
  String get bookingTermsAgreementPrefix;

  /// No description provided for @bookingTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get bookingTermsOfService;

  /// No description provided for @bookingPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get bookingPrivacyPolicy;

  /// No description provided for @bookingAndConjunction.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get bookingAndConjunction;

  /// No description provided for @termsRule1.
  ///
  /// In en, this message translates to:
  /// **'1. User must be 18+ years old.'**
  String get termsRule1;

  /// No description provided for @termsRule2.
  ///
  /// In en, this message translates to:
  /// **'2. Accurate information is required.'**
  String get termsRule2;

  /// No description provided for @termsRule3.
  ///
  /// In en, this message translates to:
  /// **'3. cash payment'**
  String get termsRule3;

  /// No description provided for @privacyRule1.
  ///
  /// In en, this message translates to:
  /// **'1. We value your health data privacy.'**
  String get privacyRule1;

  /// No description provided for @privacyRule2.
  ///
  /// In en, this message translates to:
  /// **'2. Data is encrypted and secured.'**
  String get privacyRule2;

  /// No description provided for @privacyRule3.
  ///
  /// In en, this message translates to:
  /// **'3. We do not share data with third parties.'**
  String get privacyRule3;

  /// No description provided for @bookingAppointmentTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Appointment time'**
  String get bookingAppointmentTimeLabel;

  /// No description provided for @bookingNoDateSelected.
  ///
  /// In en, this message translates to:
  /// **'No date selected'**
  String get bookingNoDateSelected;

  /// No description provided for @bookingNoTimeSelected.
  ///
  /// In en, this message translates to:
  /// **'No time selected'**
  String get bookingNoTimeSelected;

  /// No description provided for @bookingTapToChangeDateTime.
  ///
  /// In en, this message translates to:
  /// **'Tap to change date and time'**
  String get bookingTapToChangeDateTime;

  /// No description provided for @bookingChooseDateTime.
  ///
  /// In en, this message translates to:
  /// **'Choose date & time'**
  String get bookingChooseDateTime;

  /// No description provided for @bookingSelectAppointmentDate.
  ///
  /// In en, this message translates to:
  /// **'Select appointment date'**
  String get bookingSelectAppointmentDate;

  /// No description provided for @bookingConfirmDateTime.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get bookingConfirmDateTime;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get termsTitle;

  /// No description provided for @termsUnderstandButton.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get termsUnderstandButton;

  /// No description provided for @bookingSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get bookingSuccessTitle;

  /// No description provided for @bookingSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been booked successfully.'**
  String get bookingSuccessMessage;

  /// No description provided for @bookingSuccessButton.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get bookingSuccessButton;

  /// No description provided for @medicalUploadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to pick image:'**
  String get medicalUploadError;

  /// No description provided for @medicalUploadTapToUpload.
  ///
  /// In en, this message translates to:
  /// **'Tap to Upload a photo/file medical'**
  String get medicalUploadTapToUpload;

  /// No description provided for @medicalUploadFileSelected.
  ///
  /// In en, this message translates to:
  /// **'The file selected. Tap to change.'**
  String get medicalUploadFileSelected;

  /// No description provided for @medicalUploadChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get medicalUploadChange;

  /// No description provided for @bookingPickCustomDateTime.
  ///
  /// In en, this message translates to:
  /// **'Pick a custom date/time'**
  String get bookingPickCustomDateTime;

  /// No description provided for @bookingDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetailsTitle;

  /// No description provided for @bookingCaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Case Description'**
  String get bookingCaseDescription;

  /// No description provided for @bookingCaseDescriptionDummy.
  ///
  /// In en, this message translates to:
  /// **'Regular checkup for blood pressure and heart monitoring. An ECG was performed and new medications were prescribed to control blood pressure.'**
  String get bookingCaseDescriptionDummy;

  /// No description provided for @bookingClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get bookingClose;

  /// No description provided for @errorSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorSomethingWentWrong;

  /// No description provided for @errorFailedToLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Profile'**
  String get errorFailedToLoadProfile;

  /// No description provided for @errorRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get errorRetry;

  /// No description provided for @homeEmptyCentersTitle.
  ///
  /// In en, this message translates to:
  /// **'No Centers Available'**
  String get homeEmptyCentersTitle;

  /// No description provided for @homeEmptyCentersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any medical centers at the moment.'**
  String get homeEmptyCentersSubtitle;

  /// No description provided for @profileHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get profileHelpCenter;

  /// No description provided for @profileHelpCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get help and learn more about the app'**
  String get profileHelpCenterSubtitle;

  /// No description provided for @helpScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpScreenTitle;

  /// No description provided for @helpHowToBookTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Book'**
  String get helpHowToBookTitle;

  /// No description provided for @helpHowToBookDesc.
  ///
  /// In en, this message translates to:
  /// **'You can search for a doctor or center, choose an available time slot, and confirm your booking easily.'**
  String get helpHowToBookDesc;

  /// No description provided for @helpReviewBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviewing Bookings'**
  String get helpReviewBookingTitle;

  /// No description provided for @helpReviewBookingDesc.
  ///
  /// In en, this message translates to:
  /// **'You can check all your pending and completed bookings in the Bookings tab. You can also reschedule or cancel them.'**
  String get helpReviewBookingDesc;

  /// No description provided for @helpAppInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get helpAppInfoTitle;

  /// No description provided for @helpAppInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'MedX provides a seamless healthcare experience, connecting you with top professionals to prioritize your health.'**
  String get helpAppInfoDesc;

  /// No description provided for @helpRescheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Rescheduling Bookings'**
  String get helpRescheduleTitle;

  /// No description provided for @helpRescheduleDesc.
  ///
  /// In en, this message translates to:
  /// **'If your plans change, you can easily reschedule your booking from the Bookings tab by selecting a new available date and time.'**
  String get helpRescheduleDesc;

  /// No description provided for @helpBookingDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviewing Booking Details'**
  String get helpBookingDetailsTitle;

  /// No description provided for @helpBookingDetailsDesc.
  ///
  /// In en, this message translates to:
  /// **'You can view the full details of any upcoming or past appointment, including doctor notes, clinic location, and payment status, directly from your Bookings list.'**
  String get helpBookingDetailsDesc;

  /// No description provided for @helpContactSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get helpContactSupportTitle;

  /// No description provided for @helpContactSupportDesc.
  ///
  /// In en, this message translates to:
  /// **'If you face any issues, our support team is available 24/7 to assist you with your bookings and inquiries.'**
  String get helpContactSupportDesc;

  /// No description provided for @helpManageFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Managing Favorites'**
  String get helpManageFavoritesTitle;

  /// No description provided for @helpManageFavoritesDesc.
  ///
  /// In en, this message translates to:
  /// **'You can save your preferred doctors and medical centers to your favorites for quick and easy access later.'**
  String get helpManageFavoritesDesc;

  /// No description provided for @sessionExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Session expired, please login again.'**
  String get sessionExpiredMessage;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to MedX'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Book your medical appointments easily and track your health with a click.'**
  String get onboardingWelcomeDesc;

  /// No description provided for @onboardingBestDoctorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Best Doctors'**
  String get onboardingBestDoctorsTitle;

  /// No description provided for @onboardingBestDoctorsDesc.
  ///
  /// In en, this message translates to:
  /// **'Connect with the best doctors in various specialties.'**
  String get onboardingBestDoctorsDesc;

  /// No description provided for @onboardingSafeRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Records are Safe'**
  String get onboardingSafeRecordsTitle;

  /// No description provided for @onboardingSafeRecordsDesc.
  ///
  /// In en, this message translates to:
  /// **'We care about your privacy and keep your medical records securely.'**
  String get onboardingSafeRecordsDesc;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboardingStart;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @searchDoctorByDepartmentHint.
  ///
  /// In en, this message translates to:
  /// **'Search by department...'**
  String get searchDoctorByDepartmentHint;

  /// No description provided for @centerNoDepartments.
  ///
  /// In en, this message translates to:
  /// **'No departments available for this clinic.'**
  String get centerNoDepartments;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @logoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get logoutSuccess;

  /// No description provided for @errorNoAuthToken.
  ///
  /// In en, this message translates to:
  /// **'No auth token found. Please login again.'**
  String get errorNoAuthToken;

  /// No description provided for @errorConnectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout with ApiServer'**
  String get errorConnectionTimeout;

  /// No description provided for @errorSendTimeout.
  ///
  /// In en, this message translates to:
  /// **'Send timeout with ApiServer'**
  String get errorSendTimeout;

  /// No description provided for @errorReceiveTimeout.
  ///
  /// In en, this message translates to:
  /// **'Receive timeout with ApiServer'**
  String get errorReceiveTimeout;

  /// No description provided for @errorBadCertificate.
  ///
  /// In en, this message translates to:
  /// **'Bad certificate with ApiServer'**
  String get errorBadCertificate;

  /// No description provided for @errorRequestCanceled.
  ///
  /// In en, this message translates to:
  /// **'Request to ApiServer was canceled'**
  String get errorRequestCanceled;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get errorNoInternet;

  /// No description provided for @errorUnexpected.
  ///
  /// In en, this message translates to:
  /// **'Unexpected Error, Please try again!'**
  String get errorUnexpected;

  /// No description provided for @errorOops.
  ///
  /// In en, this message translates to:
  /// **'Opps, There was an Error, Please try again'**
  String get errorOops;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized / Forbidden access'**
  String get errorUnauthorized;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Request not found, Please try later!'**
  String get errorNotFound;

  /// No description provided for @errorInternalServer.
  ///
  /// In en, this message translates to:
  /// **'Internal server error, Please try later!'**
  String get errorInternalServer;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Validation Error, Please check your inputs.'**
  String get errorValidation;

  /// No description provided for @errorStatusCode.
  ///
  /// In en, this message translates to:
  /// **'Opps, There was an Error, Status Code:'**
  String get errorStatusCode;

  /// No description provided for @bookingEarliestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Today at 4:30 PM'**
  String get bookingEarliestSubtitle;

  /// No description provided for @noAvailableTimes.
  ///
  /// In en, this message translates to:
  /// **'No available times after the current time'**
  String get noAvailableTimes;

  /// No description provided for @bookingErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please make sure to select the correct date and time for the appointment'**
  String get bookingErrorMessage;

  /// No description provided for @earliestAvailable.
  ///
  /// In en, this message translates to:
  /// **'Earliest Available'**
  String get earliestAvailable;

  /// No description provided for @todayAt.
  ///
  /// In en, this message translates to:
  /// **'Today At '**
  String get todayAt;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @doctorsSchedule.
  ///
  /// In en, this message translates to:
  /// **'Doctor\'s Schedule'**
  String get doctorsSchedule;

  /// No description provided for @pickACustomDate.
  ///
  /// In en, this message translates to:
  /// **'pick a custom date'**
  String get pickACustomDate;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'My Notifications'**
  String get notifications;

  /// No description provided for @doctorNote.
  ///
  /// In en, this message translates to:
  /// **'Doctor\'s Notes'**
  String get doctorNote;

  /// No description provided for @userNote.
  ///
  /// In en, this message translates to:
  /// **'My Notes'**
  String get userNote;

  /// No description provided for @noNotes.
  ///
  /// In en, this message translates to:
  /// **'There are no notes'**
  String get noNotes;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
