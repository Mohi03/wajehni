// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Wejehni';

  @override
  String get mainHeader => 'Wejehni';

  @override
  String get mainSubtitle => 'Your smart guide to choosing a university major';

  @override
  String get appDescription => 'Wejehni helps you choose the right specialty based on your answers to a set of questions for each specialty. This is a trial version and may contain some errors. We welcome any feedback or suggestions to improve the experience.';

  @override
  String get selectSpecialty => 'Select Specialty';

  @override
  String get startTest => 'Start Test';

  @override
  String get loadingQuestions => 'Loading questions...';

  @override
  String get question => 'Question';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Previous';

  @override
  String get submit => 'Submit';

  @override
  String get startOver => 'Start Over';

  @override
  String get startOverConfirmationTitle => 'Confirm Start Over';

  @override
  String get startOverConfirmationMessage => 'Are you sure you want to start over? All current answers will be deleted.';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get appInfo => 'App Info';

  @override
  String get version => 'Version: 1.0.0';

  @override
  String get howToUse => 'How to Use';

  @override
  String get step1 => '1. Select your specialty';

  @override
  String get step2 => '2. Answer the questions honestly and accurately';

  @override
  String get step3 => '3. Get suitable recommendations';

  @override
  String get support => 'Support';

  @override
  String get technicalSupport => 'Technical Support';

  @override
  String get email => 'Email';

  @override
  String get emailAddress => 'ONJPA57@gmail.com';

  @override
  String get emailCopied => 'Email copied!';

  @override
  String get copyEmail => 'Copy Email';

  @override
  String get instagram => 'Instagram';

  @override
  String get instagramUsername => '@onjpa57';

  @override
  String get instagramUrl => 'https://instagram.com/onjpa57';

  @override
  String get facebook => 'Facebook';

  @override
  String get facebookPage => 'Facebook Page';

  @override
  String get facebookShareUrl => 'https://www.facebook.com/share/1GFE5AQ6CN/';

  @override
  String get registrationForm => 'Registration Form';

  @override
  String get registrationLink => 'Registration Form Link';

  @override
  String get registrationFormUrl => 'https://forms.gle/G76ABDGG2Pms1M7b6';

  @override
  String get features => 'App Features';

  @override
  String get customTests => 'Custom Tests';

  @override
  String get questionsForEachSpecialty => 'Questions for each specialty';

  @override
  String get smartSuggestions => 'Smart Suggestions';

  @override
  String get suggestionsBasedOnAnswers => 'Suggestions based on your answers';

  @override
  String get easyInterface => 'Easy Interface';

  @override
  String get simpleAndEasyDesign => 'Simple and easy design';

  @override
  String get continuousUpdates => 'Continuous Updates';

  @override
  String get upcomingImprovements => 'Upcoming improvements and additions';

  @override
  String get noQuestionsAvailable => 'No questions available';

  @override
  String get noSpecificSuggestionsFound => 'No specific recommendations found';

  @override
  String get pleaseTryAgain => 'Please try again';

  @override
  String get selectSpecialtyHint => 'Please select a specialty to continue';

  @override
  String get selectAnswerHint => 'Please select an answer to continue';

  @override
  String get errorNoInternet => 'No internet connection';

  @override
  String errorNetwork(Object status) {
    return 'Network error! Status: $status';
  }

  @override
  String errorLoadQuestions(Object error) {
    return 'Failed to load questions. $error';
  }

  @override
  String errorSubmitAnswers(Object error) {
    return 'Failed to get recommendations. $error';
  }

  @override
  String get answersSubmittedSuccessfully => 'Answers submitted successfully!';

  @override
  String get home => 'Home';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get answerYes => 'Yes';

  @override
  String get answerNo => 'No';

  @override
  String get answerNotSure => 'Not Sure';

  @override
  String questionProgress(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String get answerAllQuestions => 'Please answer all questions before submitting.';

  @override
  String get suggestions => 'Suggestions';

  @override
  String get returnToMainPage => 'Back to Home';
}
