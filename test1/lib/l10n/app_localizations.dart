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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Wejehni'**
  String get appTitle;

  /// No description provided for @mainHeader.
  ///
  /// In en, this message translates to:
  /// **'Wejehni'**
  String get mainHeader;

  /// No description provided for @mainSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your smart guide to choosing a university major'**
  String get mainSubtitle;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Wejehni helps you choose the right specialty based on your answers to a set of questions for each specialty. This is a trial version and may contain some errors. We welcome any feedback or suggestions to improve the experience.'**
  String get appDescription;

  /// No description provided for @selectSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Select Specialty'**
  String get selectSpecialty;

  /// No description provided for @startTest.
  ///
  /// In en, this message translates to:
  /// **'Start Test'**
  String get startTest;

  /// No description provided for @loadingQuestions.
  ///
  /// In en, this message translates to:
  /// **'Loading questions...'**
  String get loadingQuestions;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @startOver.
  ///
  /// In en, this message translates to:
  /// **'Start Over'**
  String get startOver;

  /// No description provided for @startOverConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Start Over'**
  String get startOverConfirmationTitle;

  /// No description provided for @startOverConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to start over? All current answers will be deleted.'**
  String get startOverConfirmationMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @appInfo.
  ///
  /// In en, this message translates to:
  /// **'App Info'**
  String get appInfo;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version: 1.0.0'**
  String get version;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'How to Use'**
  String get howToUse;

  /// No description provided for @step1.
  ///
  /// In en, this message translates to:
  /// **'1. Select your specialty'**
  String get step1;

  /// No description provided for @step2.
  ///
  /// In en, this message translates to:
  /// **'2. Answer the questions honestly and accurately'**
  String get step2;

  /// No description provided for @step3.
  ///
  /// In en, this message translates to:
  /// **'3. Get suitable recommendations'**
  String get step3;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @technicalSupport.
  ///
  /// In en, this message translates to:
  /// **'Technical Support'**
  String get technicalSupport;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'ONJPA57@gmail.com'**
  String get emailAddress;

  /// No description provided for @emailCopied.
  ///
  /// In en, this message translates to:
  /// **'Email copied!'**
  String get emailCopied;

  /// No description provided for @copyEmail.
  ///
  /// In en, this message translates to:
  /// **'Copy Email'**
  String get copyEmail;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @instagramUsername.
  ///
  /// In en, this message translates to:
  /// **'@onjpa57'**
  String get instagramUsername;

  /// No description provided for @instagramUrl.
  ///
  /// In en, this message translates to:
  /// **'https://instagram.com/onjpa57'**
  String get instagramUrl;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @facebookPage.
  ///
  /// In en, this message translates to:
  /// **'Facebook Page'**
  String get facebookPage;

  /// No description provided for @facebookShareUrl.
  ///
  /// In en, this message translates to:
  /// **'https://www.facebook.com/share/1GFE5AQ6CN/'**
  String get facebookShareUrl;

  /// No description provided for @registrationForm.
  ///
  /// In en, this message translates to:
  /// **'Registration Form'**
  String get registrationForm;

  /// No description provided for @registrationLink.
  ///
  /// In en, this message translates to:
  /// **'Registration Form Link'**
  String get registrationLink;

  /// No description provided for @registrationFormUrl.
  ///
  /// In en, this message translates to:
  /// **'https://forms.gle/G76ABDGG2Pms1M7b6'**
  String get registrationFormUrl;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'App Features'**
  String get features;

  /// No description provided for @customTests.
  ///
  /// In en, this message translates to:
  /// **'Custom Tests'**
  String get customTests;

  /// No description provided for @questionsForEachSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Questions for each specialty'**
  String get questionsForEachSpecialty;

  /// No description provided for @smartSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Smart Suggestions'**
  String get smartSuggestions;

  /// No description provided for @suggestionsBasedOnAnswers.
  ///
  /// In en, this message translates to:
  /// **'Suggestions based on your answers'**
  String get suggestionsBasedOnAnswers;

  /// No description provided for @easyInterface.
  ///
  /// In en, this message translates to:
  /// **'Easy Interface'**
  String get easyInterface;

  /// No description provided for @simpleAndEasyDesign.
  ///
  /// In en, this message translates to:
  /// **'Simple and easy design'**
  String get simpleAndEasyDesign;

  /// No description provided for @continuousUpdates.
  ///
  /// In en, this message translates to:
  /// **'Continuous Updates'**
  String get continuousUpdates;

  /// No description provided for @upcomingImprovements.
  ///
  /// In en, this message translates to:
  /// **'Upcoming improvements and additions'**
  String get upcomingImprovements;

  /// No description provided for @noQuestionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No questions available'**
  String get noQuestionsAvailable;

  /// No description provided for @noSpecificSuggestionsFound.
  ///
  /// In en, this message translates to:
  /// **'No specific recommendations found'**
  String get noSpecificSuggestionsFound;

  /// No description provided for @pleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get pleaseTryAgain;

  /// No description provided for @selectSpecialtyHint.
  ///
  /// In en, this message translates to:
  /// **'Please select a specialty to continue'**
  String get selectSpecialtyHint;

  /// No description provided for @selectAnswerHint.
  ///
  /// In en, this message translates to:
  /// **'Please select an answer to continue'**
  String get selectAnswerHint;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNoInternet;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error! Status: {status}'**
  String errorNetwork(Object status);

  /// No description provided for @errorLoadQuestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to load questions. {error}'**
  String errorLoadQuestions(Object error);

  /// No description provided for @errorSubmitAnswers.
  ///
  /// In en, this message translates to:
  /// **'Failed to get recommendations. {error}'**
  String errorSubmitAnswers(Object error);

  /// No description provided for @answersSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Answers submitted successfully!'**
  String get answersSubmittedSuccessfully;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @answerYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get answerYes;

  /// No description provided for @answerNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get answerNo;

  /// No description provided for @answerNotSure.
  ///
  /// In en, this message translates to:
  /// **'Not Sure'**
  String get answerNotSure;

  /// No description provided for @questionProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionProgress(Object current, Object total);

  /// No description provided for @answerAllQuestions.
  ///
  /// In en, this message translates to:
  /// **'Please answer all questions before submitting.'**
  String get answerAllQuestions;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @returnToMainPage.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get returnToMainPage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
