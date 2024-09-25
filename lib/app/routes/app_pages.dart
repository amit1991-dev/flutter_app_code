import 'package:get/get.dart';
import 'package:getx/app/bindings/helper_binding.dart';
import 'package:getx/app/ui/android/home/gravity/ai_page.dart';
// import 'package:getx/app/ui/android/home/gravity/batch_files_section/lectures_subjects_page.dart';
import 'package:getx/app/ui/android/home/gravity/batch_modules_section/batch_modules_for_subject_page.dart';
import 'package:getx/app/ui/android/home/gravity/dpp_result_question_page.dart';
import 'package:getx/app/ui/android/home/gravity/dpp_single_question_page.dart';

import 'package:getx/app/ui/android/home/gravity/post_test_page.dart';
import 'package:getx/app/ui/android/home/gravity/previous_year_section/previous_exams_questions.dart';
import 'package:getx/app/ui/android/home/gravity/results_page.dart';
import 'package:getx/app/ui/android/home/gravity/test_page.dart';
import 'package:getx/app/ui/android/home/gravity/test_report_page.dart';


import 'package:getx/app/ui/android/hosts/add_helper.dart';
import 'package:getx/app/ui/android/hosts/event_helper_page.dart';
import '../bindings/home_binding.dart';
import '../bindings/root_bindings.dart';
import '../ui/android/authentication/login.dart';
import '../ui/android/authentication/otp_verification.dart';
import '../ui/android/booting/splash.dart';

import '../ui/android/helpers/profile_page.dart';
import '../ui/android/home/bookings.dart';
import '../ui/android/home/event_page.dart';
import '../ui/android/home/event_type_events.dart';
import '../ui/android/home/gravity/batch_files_section/file_subject_chapters_page.dart';
import '../ui/android/home/gravity/batch_files_section/file_subjects_page.dart';
import '../ui/android/home/gravity/batch_files_section/files_chapter_page.dart';
// import '../ui/android/home/gravity/batch_lectures_section/lecture_chapter_page.dart';
// import '../ui/android/home/gravity/batch_lectures_section/lecture_subject_chapters_page.dart';
// import '../ui/android/home/gravity/batch_lectures_section/lectures_subjects_page.dart';
import '../ui/android/home/gravity/batch_modules_section/module_chapter_page.dart';
import '../ui/android/home/gravity/batch_modules_section/module_chapters_page.dart';
import '../ui/android/home/gravity/batch_modules_section/modules_subjects_page.dart';
import '../ui/android/home/gravity/batch_page.dart';
import '../ui/android/home/gravity/batch_lectures_section/lecture_page.dart';
// import '../ui/android/home/gravity/previous_exams_chapters.dart';
import '../ui/android/home/gravity/dpp_test_page.dart';
import '../ui/android/home/gravity/previous_year_section/previous_exams_chapters.dart';
import '../ui/android/home/gravity/previous_year_section/previous_exams_subjects.dart';
import '../ui/android/home/gravity/quiz_page.dart';
import '../ui/android/home/gravity/result_question_page.dart';
import '../ui/android/home/gravity/single_question_page.dart';
import '../ui/android/home/gravity/stream_page.dart';
import '../ui/android/home/gravity/video_page.dart';
import '../ui/android/home/notifications.dart';
import '../ui/android/home/previous_year_questions_page.dart';
import '../ui/android/home/profile_page.dart';
import '../ui/android/home/search_events.dart';
import '../ui/android/home/ticket_selection.dart';
import '../ui/android/hosts/home_page.dart';
import '../ui/android/hosts/home_page_create.dart';
import '../ui/android/hosts/home_page_profile.dart';
import '../ui/android/hosts/phases_page.dart';
import '../ui/android/hosts/scanner.dart';
import '../ui/android/hosts/wallet.dart';
import '../ui/android/onboarding/onboarding.dart';
// import '../ui/android/widgets/gravity/previous_year_exam_list.dart';
import '../ui/android/widgets/image_viewer.dart';
import '../ui/android/widgets/payment_status_widget.dart';

//golu 

import '../ui/android/home/gravity/batch_subject_page.dart';
import '../ui/android/home/gravity/batch_subject_chapter_page.dart';
import '../ui/android/home/gravity/batch_subject_chapter_lecture_page.dart';
import '../ui/android/home/gravity/my_batches.dart';

import '../ui/android/home/gravity/batch_subject_cw_tests_page.dart';
import '../ui/android/home/gravity/batch_subject_content_cw_tests_page.dart';


import '../ui/android/home/gravity/batch_subject_dpp_tests_page.dart';
import '../ui/android/home/gravity/batch_subject_chapter_dpp_tests_page.dart';
import '../ui/android/home/gravity/batch_subject_chapter_content_dpp_tests_page.dart';
import 'package:getx/app/ui/android/home/gravity/dpp_test_report_page.dart';
import 'package:getx/app/ui/android/home/gravity/dpp_result_page.dart';
import 'package:getx/app/ui/android/home/gravity/dpp_post_test_page.dart';





//golu 

import '../bindings/host_binding.dart';
import '../ui/android/helpers/event_page.dart';
import '../ui/android/helpers/home_page.dart';
import '../ui/android/helpers/scanned.dart';
import '../ui/android/helpers/scanner.dart';
import '../ui/android/home/booking_page.dart';
import '../ui/android/home/home_page_bottom_bar.dart';
import '../ui/android/hosts/edit_event_details.dart';
import '../ui/android/hosts/event_page.dart';
import '../ui/android/hosts/host_bookings.dart';
import '../ui/android/hosts/notifications.dart';
import '../ui/android/hosts/scanned.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    //Common Pages
    GetPage(name: Routes.INITIAL, page: () => Splash(), binding: RootBindings()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage(),binding: RootBindings()),
    GetPage(name: Routes.ONBOARDING, page: () => Onboarding(),binding: RootBindings()),
    GetPage(name: Routes.OTP_VERIFICATION, page: () => OTPVerification()),

  

    //General Page
    GetPage(name: Routes.IMAGE_VIEWER, page: () => ImageViewer()),

    //User Pages
    // GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.HOME, page: () => HomePageBottomBar(), binding: HomeBinding()),
    GetPage( name: Routes.EVENT, page: () => EventPage(), binding: HomeBinding()),
    // GetPage( name: Routes.STREAMS, page: () => StreamPage(), binding: HomeBinding()),
    GetPage( name: Routes.STREAM_PAGE, page: () => StreamPage(), binding: HomeBinding()),

    GetPage( name: Routes.EXAM_PAGE, page: () => PreviousYearExamPage(), binding: HomeBinding()),
    GetPage( name: Routes.SUBJECTS_EXAM_PAGE, page: () => PreviousYearExamSubjectsPage(), binding: HomeBinding()),
    GetPage( name: Routes.CHAPTERS_EXAM_PAGE, page: () => PreviousYearExamsChapters(), binding: HomeBinding()),

    GetPage( name: Routes.BATCH_PAGE, page: () => BatchPage(), binding: HomeBinding()),

  //golu
    
    GetPage( name: Routes.PREVIOUS_YEAR_QUESTIONS_PAGE, page: () =>PreviousYearQuestionsPage(), binding: HomeBinding()),


    GetPage( name: Routes.My_Batches, page: () => MyBatches(), binding: HomeBinding()),
    GetPage( name: Routes.BATCH_SUBJECT_PAGE, page: () => BatchSubjectPage(), binding: HomeBinding()),
    GetPage( name: Routes.BATCH_SUBJECT_CHAPTER_PAGE, page: () => BatchSubjectChapterPage(), binding: HomeBinding()),
    GetPage(name: Routes.BATCH_SUBJECT_CHAPTER_LECTURE_PAGE, page: () => BatchSubjectChapterLecturePage(), binding: HomeBinding()),
  
    GetPage( name: Routes.BATCH_SUBJECT_CW_TESTS_PAGE, page: () => BatchSubjectCwTestsPage(), binding: HomeBinding()),

    GetPage( name: Routes.BATCH_SUBJECT_CONTENT_CW_TESTS_PAGE, page: () => BatchSubjectContentCwTestsPage(), binding: HomeBinding()),

    GetPage( name: Routes.BATCH_SUBJECT_DPP_TESTS_PAGE, page: () => BatchSubjectDppTestsPage(), binding: HomeBinding()),
    GetPage( name: Routes.BATCH_SUBJECT_CHAPTER_DPP_TESTS_PAGE, page: () => BatchSubjectChapterDppTestsPage(), binding: HomeBinding()),
    GetPage( name: Routes.BATCH_SUBJECT_CHAPTER_CONTENT_DPP_TESTS_PAGE, page: () => BatchSubjectChapterContentDppTestsPage(), binding: HomeBinding()),
    GetPage( name: Routes.DPP_TEST_REPORT_PAGE, page: () => DppTestReportPage(), binding: HomeBinding()),
    
    GetPage( name: Routes.DPP_TEST_PAGE, page: () => DppTestPage(), binding: HomeBinding()),
    GetPage( name: Routes.POST_DPP_TEST_PAGE, page: () => DppPostTestPage(), binding: HomeBinding()),
    GetPage( name: Routes.DPP_TEST_RESULT_PAGE, page: () => DppTestResultPage(), binding: HomeBinding()),
    GetPage( name: Routes.DPP_TEST_RESULT_QUESTION_PAGE, page: () => DppResultQuestionPage(), binding: HomeBinding()),
    GetPage( name: Routes.SINGLE_DPP_QUESTION_PAGE, page: () => DppSingleQuestionPage(), binding: HomeBinding()),


  //golu



    GetPage( name: Routes.BATCH_MODULE_SUBJECTS_PAGE, page: () => ModulesSubjectsPage(), binding: HomeBinding()),
    // GetPage( name: Routes.BATCH_LECTURE_SUBJECTS_PAGE, page: () => LecturesSubjectsPage(), binding: HomeBinding()),

    // GetPage( name: Routes.BATCH_SUBJECT_MODULES_PAGE, page: () => BatchModulesForSubjectsPage(), binding: HomeBinding()),
    // GetPage( name: Routes.BATCH_SUBJECT_LECTURES_PAGE, page: () => LectureSubjectChaptersPage(), binding: HomeBinding()),

    GetPage( name: Routes.BATCH_FILE_SUBJECT_CHAPTERS_PAGE, page: () => FileSubjectChaptersPage(), binding: HomeBinding()),
    GetPage( name: Routes.BATCH_FILE_SUBJECTS_PAGE, page: () => FileSubjectsPage(), binding: HomeBinding()),
    GetPage( name: Routes.BATCH_SUBJECT_CHAPTER_FILES_PAGE, page: () => FileChapterPage(), binding: HomeBinding()),

    // GetPage( name: Routes.LECTURE_CHAPTER_PAGE, page: () => LectureChapterPage(), binding: HomeBinding()),
    // GetPage( name: Routes.MODULE_PAGE, page: () => ModuleChaptersPage(), binding: HomeBinding()),
    GetPage( name: Routes.MODULE_CHAPTER_PAGE, page: () => ModuleChapterPage(), binding: HomeBinding()),
    GetPage( name: Routes.LECTURE_PAGE, page: () => LecturePage(), binding: HomeBinding()),
    GetPage( name: Routes.VIDEO_PAGE, page: () => VideoPage(), binding: HomeBinding()),
    GetPage( name: Routes.QUIZ_PAGE, page: () => QuizPage(), binding: HomeBinding()),
    GetPage( name: Routes.TEST_REPORT_PAGE, page: () => TestReportPage(), binding: HomeBinding()),
    GetPage( name: Routes.TEST_PAGE, page: () => TestPage(), binding: HomeBinding()),
    GetPage( name: Routes.POST_TEST_PAGE, page: () => PostTestPage(), binding: HomeBinding()),
    GetPage( name: Routes.TEST_RESULT_PAGE, page: () => TestResultPage(), binding: HomeBinding()),
    GetPage( name: Routes.TEST_RESULT_QUESTION_PAGE, page: () => ResultQuestionPage(), binding: HomeBinding()),
    GetPage( name: Routes.SINGLE_QUESTION_PAGE, page: () => SingleQuestionPage(), binding: HomeBinding()),
    GetPage( name: Routes.GRAVITY_AI_PAGE, page: () => AIPage(), binding: HomeBinding()),
    GetPage( name: Routes.EVENT_TICKETS, page: () => TicketSelection(), binding: HomeBinding()),
    GetPage(name: Routes.EVENT_TYPE_EVENTS, page: () => EventTypeEvents(), binding: HomeBinding()),
    GetPage(name: Routes.SEARCH, page: () => UserSearchEvents(), binding: HomeBinding()),
    GetPage(name: Routes.BOOKINGS, page: () => BookingsPage(), binding: HomeBinding()),
    GetPage(name: Routes.NOTIFICATIONS, page: () => NotificationsPage(), binding: HomeBinding()),
    GetPage(name: Routes.BOOKING, page: () => BookingPage(), binding: HomeBinding()),
    GetPage(name: Routes.PAYMENT_BOOKING_STATUS, page: () => const PaymentStatus(), binding: HomeBinding()),
    GetPage(name: Routes.PROFILE, page: () => UserProfilePage(),binding: HomeBinding()),


    //Host Pages
    GetPage(name: Routes.HOST_HOME, page: () => HostHomePage(), binding: HostBinding()),// also used for the EVENTS of a host
    // GetPage(name: Routes.HOST_EVENT, page: () => HostEventPage(), binding: HostBinding()),
    GetPage(name: Routes.HOST_BOOKINGS, page: () => HostBookings(), binding: HostBinding()),
    GetPage(name: Routes.HOST_PROFILE, page: () => HostHomeProfile(), binding: HostBinding()),
    GetPage(name: Routes.HOST_CREATE_EVENT, page: () => HostHomeCreateEvent(), binding: HostBinding()),
    GetPage(name: Routes.HOST_EVENT_DETAILS, page: () => HostDetailsEventPage(), binding: HostBinding()),
    GetPage(name: Routes.HOST_EVENT_PHASES, page: () => HostEventPhasesPage(), binding: HostBinding()),
    GetPage(name: Routes.HOST_SCANNER, page: () => ScannerPage(), binding: HostBinding()),
    GetPage(name: Routes.HOST_SCANNED, page: () => ScannedBookingPage(), binding: HostBinding()),
    GetPage(name: Routes.HOST_WALLET, page: () => HostWallet(), binding: HostBinding()),
    GetPage(name: Routes.HOST_NOTIFICATIONS, page: () => HostNotificationsPage(), binding: HostBinding()),
    GetPage(name: Routes.HOST_HELPERS, page: () => HostEventHelpersPage(), binding: HostBinding()),
    GetPage(name: Routes.HOST_ADD_HELPERS, page: () => AddHelperPage(), binding: HostBinding()),

    //helper pages
    GetPage(name: Routes.HELPER_SCANNER, page: () => HelperScannerPage(), binding: HelperBinding()),
    GetPage(name: Routes.HELPER_SCANNED, page: () => HelperScannedBookingPage(), binding: HelperBinding()),
    GetPage(name: Routes.HELPER_HOME, page: () => HelperHomePage(), binding: HelperBinding()),
    GetPage(name: Routes.HELPER_EVENT, page: () => HelperEventPage(), binding: HelperBinding()),
    GetPage(name: Routes.HELPER_EVENT, page: () => HelperProfilePage(), binding: HelperBinding()),





  ];
}
