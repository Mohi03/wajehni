// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'وجهني';

  @override
  String get mainHeader => 'وجهني';

  @override
  String get mainSubtitle => 'دليلك الذكي لاختيار التخصص الجامعي';

  @override
  String get appDescription => 'تطبيق وجهني يساعدك في اختيار التخصص المناسب لك بناءً على إجاباتك على مجموعة من الأسئلة المخصصة لكل تخصص. هذا التطبيق إصدار تجريبي وقد يحتوي على بعض الأخطاء أو المشاكل. نرحب بأي ملاحظات أو اقتراحات لتحسين التجربة.';

  @override
  String get selectSpecialty => 'اختر الشعبة';

  @override
  String get startTest => 'ابدأ الاختبار';

  @override
  String get loadingQuestions => 'جارٍ تحميل الأسئلة...';

  @override
  String get question => 'السؤال';

  @override
  String get next => 'التالي';

  @override
  String get previous => 'السابق';

  @override
  String get submit => 'إرسال';

  @override
  String get startOver => 'ابدأ من جديد';

  @override
  String get startOverConfirmationTitle => 'تأكيد البدء من جديد';

  @override
  String get startOverConfirmationMessage => 'هل أنت متأكد أنك تريد البدء من جديد؟ سيتم حذف جميع الإجابات الحالية.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get settings => 'الإعدادات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get appInfo => 'معلومات التطبيق';

  @override
  String get version => 'الإصدار: 1.0.0';

  @override
  String get howToUse => 'كيفية الاستخدام';

  @override
  String get step1 => '1. اختر شعبتك';

  @override
  String get step2 => '2. أجب على الأسئلة بصدق ودقة';

  @override
  String get step3 => '3. احصل على التوصيات المناسبة';

  @override
  String get support => 'الدعم الفني';

  @override
  String get technicalSupport => 'الدعم الفني';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailAddress => 'ONJPA57@gmail.com';

  @override
  String get emailCopied => 'تم نسخ البريد الإلكتروني!';

  @override
  String get copyEmail => 'نسخ البريد الإلكتروني';

  @override
  String get instagram => 'انستغرام';

  @override
  String get instagramUsername => '@onjpa57';

  @override
  String get instagramUrl => 'https://instagram.com/onjpa57';

  @override
  String get facebook => 'فيسبوك';

  @override
  String get facebookPage => 'صفحة الفيسبوك';

  @override
  String get facebookShareUrl => 'https://www.facebook.com/share/1GFE5AQ6CN/';

  @override
  String get registrationForm => 'استمارة التسجيل';

  @override
  String get registrationLink => 'رابط استمارة الانخراط';

  @override
  String get registrationFormUrl => 'https://forms.gle/G76ABDGG2Pms1M7b6';

  @override
  String get features => 'مميزات التطبيق';

  @override
  String get customTests => 'اختبارات مخصصة';

  @override
  String get questionsForEachSpecialty => 'أسئلة لكل تخصص';

  @override
  String get smartSuggestions => 'توصيات ذكية';

  @override
  String get suggestionsBasedOnAnswers => 'اقتراحات حسب إجاباتك';

  @override
  String get easyInterface => 'واجهة سهلة';

  @override
  String get simpleAndEasyDesign => 'تصميم بسيط وسهل';

  @override
  String get continuousUpdates => 'تحديثات مستمرة';

  @override
  String get upcomingImprovements => 'تحسينات وإضافات قادمة';

  @override
  String get noQuestionsAvailable => 'لا توجد أسئلة متاحة';

  @override
  String get noSpecificSuggestionsFound => 'لم يتم العثور على توصيات محددة';

  @override
  String get pleaseTryAgain => 'الرجاء المحاولة مرة أخرى';

  @override
  String get selectSpecialtyHint => 'يرجى اختيار الشعبة للمتابعة';

  @override
  String get selectAnswerHint => 'يرجى اختيار إجابة للمتابعة';

  @override
  String get errorNoInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String errorNetwork(Object status) {
    return 'خطأ في الشبكة! الحالة: $status';
  }

  @override
  String errorLoadQuestions(Object error) {
    return 'فشل تحميل الأسئلة. $error';
  }

  @override
  String errorSubmitAnswers(Object error) {
    return 'فشل الحصول على الاقتراحات. $error';
  }

  @override
  String get answersSubmittedSuccessfully => 'تم إرسال الإجابات بنجاح!';

  @override
  String get home => 'الرئيسية';

  @override
  String get backToHome => 'العودة للصفحة الرئيسية';

  @override
  String get answerYes => 'نعم';

  @override
  String get answerNo => 'لا';

  @override
  String get answerNotSure => 'لست متأكد';

  @override
  String questionProgress(Object current, Object total) {
    return 'السؤال $current من $total';
  }

  @override
  String get answerAllQuestions => 'يرجى الإجابة على جميع الأسئلة قبل الإرسال.';

  @override
  String get suggestions => 'التوصيات';

  @override
  String get returnToMainPage => 'العودة للصفحة الرئيسية';
}
