import 'package:get/get.dart';
import 'package:unitaapp/app.dart';
import 'package:unitaapp/common/components/custom/scan_meal_page.dart';
import 'package:unitaapp/pages/home/body_type/body_type_assessment_page.dart';
import 'package:unitaapp/pages/home/body_type/body_type_done_page.dart';
import 'package:unitaapp/pages/home/body_type/body_type_start_page.dart';
import 'package:unitaapp/pages/home/gut_health/gut_flow_done_page.dart';
import 'package:unitaapp/pages/home/gut_health/gut_health_start_page.dart';
import 'package:unitaapp/pages/log/log_page.dart';
import 'package:unitaapp/pages/login/login_page.dart';
import 'package:unitaapp/pages/me/setting/billing_subscription_page.dart';
import 'package:unitaapp/pages/me/setting/contact_us_page.dart';
import 'package:unitaapp/pages/me/setting/notification_messages_page.dart';
import 'package:unitaapp/pages/me/setting/setting_page.dart';
import 'package:unitaapp/pages/signup/create_account_page.dart';
import 'package:unitaapp/pages/signup/forget_pwd_captcha_page.dart';
import 'package:unitaapp/pages/signup/forget_pwd_page.dart';
import 'package:unitaapp/pages/signup/signup_flow_born_page.dart';
import 'package:unitaapp/pages/signup/signup_flow_diet_page.dart';
import 'package:unitaapp/pages/signup/signup_flow_gender_page.dart';
import 'package:unitaapp/pages/signup/signup_flow_identify_page.dart';
import 'package:unitaapp/pages/signup/signup_flow_pregnant_page.dart';
import 'package:unitaapp/pages/signup/signup_flow_start_page.dart';
import 'package:unitaapp/pages/signup/signup_page.dart';
import 'package:unitaapp/pages/unibot/unibot_page.dart';
import '../../pages/home/gut_health/gut_health_assessment_page.dart';
import '../../pages/me/me_profile_page.dart';
import '../../pages/me/setting/notification_page.dart';
import '../../pages/me/shopping_cart_page.dart';
import '../../pages/signup/signup_flow_allergies_page.dart';
import '../../pages/signup/signup_flow_goals_page.dart';
import '../../pages/signup/signup_flow_disorders_page.dart';
import '../../pages/signup/signup_flow_conditions_page.dart';
import '../../pages/signup/signup_flow_medicals_page.dart';
import '../../pages/signup/signup_flow_done_page.dart';
import '../../pages/signup/signup_flow_tall_page.dart';
import '../../pages/signup/signup_flow_weight_page.dart';
import '../../pages/signup/signup_flow_diet_duration_page.dart';
import '../../pages/signup/signup_flow_diet_symptom_reduction_page.dart';
import 'names.dart';

// Commented out missing imports
// import 'package:unitaapp/pages/me/setting/add_address_page.dart';
// import 'package:unitaapp/pages/me/setting/add_payment_page.dart';
// import 'package:unitaapp/pages/me/setting/address_page.dart';
// import 'package:unitaapp/pages/me/setting/payment_page.dart';
// import '../../pages/plan/body_page.dart';
// import '../../pages/plan/diet_page.dart';
// import '../../pages/plan/herb/herb_page.dart';
// import '../../pages/plan/mind_page.dart';
// import '../../pages/reports/reports_page.dart';
// import '../../pages/reports/gut_health_report_page.dart';

class RoutePages {
  static final pages = [
    GetPage(
      name: RouteNames.main,
      page: () => const MyHomePage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signUp,
      page: () => const SignUpPage(),
      transition: Transition.native,
      fullscreenDialog: true,
    ),
    GetPage(
      name: RouteNames.login,
      page: () => const LoginPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.forgetPassword,
      page: () => const ForgetPwdCaptchaPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.resetPassword,
      page: () => ForgetPwdPage(
        email: Get.arguments['email'],
        captcha: Get.arguments['captcha'],
      ),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.createAccount,
      page: () => const CreateAccountPage(),
      transition: Transition.native,
      fullscreenDialog: true,
    ),
    GetPage(
      name: RouteNames.signupFlowStart,
      page: () => const SignupFlowStartPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowIdentify,
      page: () => const SignupFlowIdentifyPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowGender,
      page: () => const SignupFlowGenderPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowBorn,
      page: () => SignupFlowBornPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowTall,
      page: () => SignupFlowTallPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowWeight,
      page: () => SignupFlowWeightPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowPregnant,
      page: () => SignupFlowPregnantPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowDiet,
      page: () => SignupFlowDietPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowAllergies,
      page: () => SignupFlowAllergiesPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowGoals,
      page: () => SignupFlowGoalsPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowDisorders,
      page: () => SignupFlowDisordersPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowConditions,
      page: () => SignupFlowConditionsPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowMedicals,
      page: () => SignupFlowMedicalsPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowDone,
      page: () => SignupFlowDonePage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.settings,
      page: () => SettingPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.billingAndSubscription,
      page: () => BillingSubscriptionPage(),
      transition: Transition.noTransition,
    ),
    // GetPage(
    //   name: RouteNames.payment,
    //   page: () => PaymentPage(),
    //   transition: Transition.noTransition,
    // ),
    // GetPage(
    //   name: RouteNames.addPayment,
    //   page: () => AddPaymentPage(payment: Get.arguments),
    //   transition: Transition.noTransition,
    // ),
    // GetPage(
    //   name: RouteNames.address,
    //   page: () => AddressPage(),
    //   transition: Transition.noTransition,
    // ),
    // GetPage(
    //   name: RouteNames.addAddress,
    //   page: () => AddAddressPage(address: Get.arguments),
    //   transition: Transition.noTransition,
    // ),
    GetPage(
      name: RouteNames.notification,
      page: () => NotificationPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.contactUs,
      page: () => ContactUsPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.unibot,
      page: () => UnibotPage(),
      fullscreenDialog: true,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.log,
      page: () => const LogPage(),
      fullscreenDialog: true,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.scanMeal,
      page: () => ScanMealPage(file: Get.arguments),
      transition: Transition.noTransition,
    ),
    // GetPage(
    //   name: RouteNames.mind,
    //   page: () => MindPage(),
    // ),
    // GetPage(
    //   name: RouteNames.body,
    //   page: () => BodyPage(),
    // ),
    GetPage(
      name: RouteNames.bodyTypeStart,
      page: () => const BodyTypeStartPage(),
    ),
    GetPage(
      name: RouteNames.bodyTypeAssessment,
      page: () => BodyTypeAssessmentPage(
          assessmentIndex: Get.arguments['assessmentIndex'],
          assessments: Get.arguments['assessments']),
    ),
    GetPage(
      name: RouteNames.bodyTypeDone,
      page: () => BodyTypeDonePage(),
    ),
    GetPage(
      name: RouteNames.gutHealthStart,
      page: () => const GutHealthStartPage(),
    ),
    GetPage(
      name: RouteNames.gutHealthAssessment,
      page: () => GutHealthAssessmentPage(
          assessmentIndex: Get.arguments['assessmentIndex'],
          assessments: Get.arguments['assessments']),
    ),
    GetPage(
      name: RouteNames.gutHealthDone,
      page: () => GutFlowDonePage(),
    ),
    // GetPage(
    //   name: RouteNames.diet,
    //   page: () => DietPage(),
    // ),
    // GetPage(
    //   name: RouteNames.herb,
    //   page: () => HerbPage(),
    // ),
    GetPage(
      name: RouteNames.shoppingCart,
      page: () => const ShoppingCartPage(),
      transition: Transition.noTransition,
    ),
    // GetPage(
    //   name: RouteNames.reports,
    //   page: () => ReportsPage(),
    // ),
    // GetPage(
    //   name: RouteNames.gutHealthReport,
    //   page: () => GutHealthReportPage(),
    // ),
    GetPage(
      name: RouteNames.profile,
      page: () => MeProfilePage(),
    ),
    GetPage(
      name: RouteNames.notificationMessages,
      page: () => const NotificationMessagesPage(),
    ),
    GetPage(
      name: RouteNames.signupFlowDietDuration,
      page: () => SignupFlowDietDurationPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.signupFlowSymptomReduction,
      page: () => SignupFlowSymptomReductionPage(),
      transition: Transition.noTransition,
    ),
  ];
}
