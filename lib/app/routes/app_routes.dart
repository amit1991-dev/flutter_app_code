part of './app_pages.dart';

abstract class Routes{

  //============================Common Routes for all!
  //Auth
  static const INITIAL = '/splash';
  static const OTP_VERIFICATION = '/otp_verification';
  static const LOGIN = '/login';
  static const ONBOARDING = '/onboarding';

  //INFO
  static const TERMS_CONDITIONS = '/terms_conditions';
  static const POLICY = '/policy';
  static const ABOUT = '/about';

  //==============================User Specific routes
  static const PROFILE = '/profile';
  // static const SEARCH = '/search';
  static const HOME = '/home';
  static const EVENT = '/event';
  static const IMAGE_VIEWER = '/image_viewer';
  static const EVENT_TICKETS = '/event_tickets';
  static const EVENT_TYPE_EVENTS = '/event_type_events';
  static const SEARCH = '/search';
  static const BOOKINGS = '/bookings';
  static const NOTIFICATIONS = '/user_notifications';
  static const BOOKING = '/booking';
  static const PAYMENT_BOOKING_STATUS = '/payment_status';

  //===============================Host Specific Routes
  static const HOST_EVENT = '/host_event';
  static const HOST_HOME = '/host_home';
  static const HOST_BOOKINGS = '/host_bookings';
  static const HOST_PROFILE = '/host_profile';
  static const HOST_CREATE_EVENT = '/host_create_event';
  static const HOST_EVENT_DETAILS = '/host_event_details';
  static const HOST_SCANNER = '/host_scanner';
  static const HOST_SCANNED = '/host_scanned';
  static const HOST_WALLET = '/host_wallet';
  static const HOST_NOTIFICATIONS = '/host_notifications';
  static const HOST_HELPERS = '/host_helpers';
  static const HOST_ADD_HELPERS = '/host_add_new';
  static const HOST_EVENT_PHASES = '/host_event_phases';

  //===============================Host Specific Routes

  static const HELPER_SCANNED = '/helper_scanned';
  static const HELPER_SCANNER = '/helper_scanner';
  static const HELPER_HOME = '/helper_home';
  static const HELPER_EVENT = '/helper_event';
  static const HELPER_PROFILE = '/helper_profile';

  //=================================Student routes

  static const STREAMS = '/streams';


  static const EXAM_PAGE = '/exam_page';
  static const SUBJECTS_EXAM_PAGE = '/subjects_exam_page';
  static const CHAPTERS_EXAM_PAGE = '/chapters_exam_page';
  // static const EXAM_PAGE = '/exam_page';


  static const PREVIOUS_YEAR_QUESTIONS_PAGE = '/previous_year_questions_page';


  static const BATCH_PAGE = '/batch_page';
  static const My_Batches = '/my_batches';

  //golu
  static const BATCH_SUBJECT_PAGE = '/batch_subject_page';
  static const BATCH_SUBJECT_CHAPTER_PAGE = '/batch_subject_chapter_page';
  static const BATCH_SUBJECT_CHAPTER_LECTURE_PAGE = '/batch_subject_chapter_lecture_page';

  

  static const BATCH_SUBJECT_CW_TESTS_PAGE = '/batch_subject_cw_tests_page';
  static const BATCH_SUBJECT_CONTENT_CW_TESTS_PAGE = '/batch_subject_content_cw_tests_page';


  static const BATCH_SUBJECT_DPP_TESTS_PAGE = '/batch_subject_dpp_tests_page';
  static const BATCH_SUBJECT_CHAPTER_DPP_TESTS_PAGE = '/batch_subject_chapter_dpp_tests_page';
  static const BATCH_SUBJECT_CHAPTER_CONTENT_DPP_TESTS_PAGE = '/batch_subject_chapter_content_dpp_tests_page';
  static const DPP_TEST_REPORT_PAGE = '/dpp_test_report_page';
  static const DPP_TEST_PAGE = '/dpp_test_page';
  static const POST_DPP_TEST_PAGE = '/post_dpp_test_page';
  static const DPP_TEST_RESULT_QUESTION_PAGE = '/dpp_test_result_question_page';
  static const SINGLE_DPP_QUESTION_PAGE = '/single_dpp_question_page';
  static const DPP_TEST_RESULT_PAGE = '/dpp_test_result_page';






  //golu
  static const BATCH_MODULE_SUBJECTS_PAGE = '/batch_module_subjects_page';
  static const BATCH_LECTURE_SUBJECTS_PAGE = '/batch_lecture_subjects_page';

  static const BATCH_FILE_SUBJECTS_PAGE = '/batch_file_subjects_page';
  static const BATCH_FILE_SUBJECT_CHAPTERS_PAGE = '/batch_file_subject_chapters_page';
  static const BATCH_SUBJECT_CHAPTER_FILES_PAGE = '/batch_subject_chapter_files_page';

  static const BATCH_SUBJECT_MODULES_PAGE = '/batch_subject_modules_page';
  static const BATCH_SUBJECT_LECTURES_PAGE = '/batch_subject_lectures_page';
  // static const BATCH_SUBJECT_FILES_CHAPTERS_PAGE = '/batch_subject_files_page';
  static const MODULE_PAGE = '/module_page';
  static const MODULE_CHAPTER_PAGE = '/module_chapter_page';
  static const LECTURE_CHAPTER_PAGE = '/lecture_chapter_page';
  static const LECTURE_PAGE = '/lecture_page';
  static const VIDEO_PAGE = '/video_page';
  static const QUIZ_PAGE = '/quiz_page';
  static const GRAVITY_AI_PAGE = '/gravity_ai_page';
  static const STREAM_PAGE = '/stream_page';
  static const TEST_REPORT_PAGE = '/test_report';
  static const TEST_PAGE = '/test_page';
  static const POST_TEST_PAGE = '/post_test_page';
  static const TEST_RESULT_QUESTION_PAGE = '/test_result_question_page';
  static const SINGLE_QUESTION_PAGE = '/single_question_page';
  static const TEST_RESULT_PAGE = '/test_result';

}