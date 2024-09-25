

class RequestPaths{
  static const String WHOAMI="/user/authentication/whoami";
  static const String LOGIN="/user/authentication/login";
  static const String LOGOUT="/user/authentication/logout";
  static const String SENDOTP="/user/verification/send_otp";


  // User Paths
  static const String GET_EVENTS="/user/events";
  static const String GET_EVENT="/user/events/single";
  static const String GET_BOOKINGS="/user/events/bookings";
  static const String GET_BOOKING="$GET_BOOKINGS/single";
  static const String GET_NOTIFICATIONS="/user/events/user_notifications";
  static const String GET_EVENTS_SEARCH="/user/events/search";
  static const String GET_EVENTS_FEATURED="/user/events/featured";
  static const String GET_EVENTS_TODAY="/user/events/today";
  static const String GET_EVENTS_UPCOMING="/user/events";
  static const String GET_EVENTS_CATEGORY="$GET_EVENTS/category";
  static const String POST_SAVE_EMAIL="/user/users/profile/update_email";
  static const String POST_USER_SWITCH_TO_CLIENT="/user/users/profile/switch_to_host";
  static const String CREATE_ORDER="/user/events/create_order_for_tickets";



  static const String RZP_CREATE_ORDER="/webhook/create_order";

  // Host Paths
  // -- Events
  static const String GET_HOST_EVENTS=GET_EVENTS;
  static const String GET_HELPER_EVENTS=GET_EVENTS;
  static const String POST_CREATE_EVENT="${RequestPaths.GET_HOST_EVENTS}/create";
  static const String POST_CREATE_BOOKING="${RequestPaths.GET_HOST_EVENTS}/book_tickets";
  static const String POST_HOST_EVENT_UPDATE="${RequestPaths.GET_HOST_EVENTS}/edit";
  static const String POST_HOST_EVENT_ADD_MEDIA="${RequestPaths.GET_HOST_EVENTS}/add_media";
  // static const String POST_HOST_EVENT_REMOVE_MEDIA="${RequestPaths.GET_HOST_EVENTS}/remove_media";
  static const String POST_HOST_INFO_EDIT="/user/users/host_profile/edit_host_info";
  static const String POST_HOST_SWITCH_TO_CLIENT="/user/users/host_profile/switch_to_client";
  static const String POST_HOST_EVENT_ADD_DP="${RequestPaths.GET_HOST_EVENTS}/add_picture";
  static const String POST_HOST_EVENT_REMOVE_MEDIA="${RequestPaths.GET_HOST_EVENTS}/remove_media";
  static const String POST_HOST_EVENT_REMOVE_DP="${RequestPaths.GET_HOST_EVENTS}/remove_picture";
  static const String POST_HOST_CREATE_PHASE="${RequestPaths.GET_HOST_EVENTS}/create_phase";
  static const String POST_HOST_ADD_HELPER="${RequestPaths.GET_HOST_EVENTS}/add_helper";
  static const String POST_HOST_REMOVE_HELPER="${RequestPaths.GET_HOST_EVENTS}/remove_helper";
  static const String POST_HOST_DELETE_PHASE="${RequestPaths.GET_HOST_EVENTS}/delete_phase";
  static const String POST_HOST_CREATE_CATEGORY="${RequestPaths.GET_HOST_EVENTS}/create_phase_category";
  static const String POST_HOST_DELETE_CATEGORY="${RequestPaths.GET_HOST_EVENTS}/delete_category";
  static const String POST_HOST_CREATE_TICKET="${RequestPaths.GET_HOST_EVENTS}/create_ticket";
  static const String POST_HOST_DELETE_TICKET="${RequestPaths.GET_HOST_EVENTS}/delete_ticket";
  static const String POST_HOST_CREATE_HIGHLIGHT="${RequestPaths.GET_HOST_EVENTS}/create_highlight";
  static const String POST_HOST_DELETE_HIGHLIGHT="${RequestPaths.GET_HOST_EVENTS}/delete_highlight";
  static const String GET_HOST_EVENT_PHASES="${RequestPaths.GET_HOST_EVENTS}/get_phases";
  static const String GET_HOST_PHASE_CATEGORIES="${RequestPaths.GET_HOST_EVENTS}/get_phase_categories";
  static const String GET_HOST_PHASE="${RequestPaths.GET_HOST_EVENTS}/get_phase";
  static const String GET_HOST_CATEGORY="${RequestPaths.GET_HOST_EVENTS}/get_phase_category";
  static const String GET_HOST_TICKET="${RequestPaths.GET_HOST_EVENTS}/get_category_ticket";

  static const String WALLETS_PATH="/user/finance/wallet";
  static const String GET_HOST_WALLET="$WALLETS_PATH/single";
  static const String GET_USER_WALLET="$WALLETS_PATH/user_wallet/";
  // static const String GET_HOST_EVENTS=GET_EVENTS;

  static const String GET_HOST_INFO="/user/users/host_profile/host_info";
  static const String GET_HOST_BOOKINGS="${RequestPaths.GET_HOST_EVENTS}/bookings/";
  static const String POST_ENTRY="${RequestPaths.GET_HOST_EVENTS}/bookings/single";


  //===========================================NEW==============================================//
  static const String GET_STUDENT_CENTER="/user/students";
  static const String GET_STUDENT_STREAMS="$GET_STUDENT_CENTER/streams";
  static const String GET_STUDENT_BATCHES="$GET_STUDENT_CENTER/batches";
  static const String GET_STUDENT_MODULES="$GET_STUDENT_CENTER/modules";
  static const String GET_STUDENT_LECTURES="$GET_STUDENT_CENTER/batches";
  static const String GET_STUDENT_FILES="$GET_STUDENT_CENTER/institute_files";
  static const String GET_STUDENT_EXAMS="$GET_STUDENT_CENTER/exams";
  static const String GET_STUDENT_STREAM="$GET_STUDENT_CENTER/stream";
  static const String GET_STUDENT_NOTIFICATIONS="$GET_STUDENT_CENTER/notifications";
  static const String GET_STUDENT_STREAM_TESTS="$GET_STUDENT_CENTER/stream_tests";
  static const String GET_STUDENT_TESTS="$GET_STUDENT_CENTER/tests";
  static const String GET_STUDENT_TEST_STATE="$GET_STUDENT_CENTER/test_state";
  static const String GET_STUDENT_TEST_PDF="$GET_STUDENT_CENTER/test_pdf";
  static const String GET_STUDENT_STREAM_TESTINFO="$GET_STUDENT_CENTER/test_report";
  static const String GET_STUDENT_QUESTION="$GET_STUDENT_CENTER/question_get";
  static const String GET_STUDENT_TEST_RESULT="$GET_STUDENT_CENTER/test_result";
  static const String GET_STUDENT_TEST_RESULTS="$GET_STUDENT_CENTER/test_results";
  static const String GET_STUDENTS_SEARCH="$GET_STUDENT_CENTER/search";
  static const String POST_CREATE_TEST_ATTEMPT="$GET_STUDENT_CENTER/create_test_attempt";
  static const String POST_QUERY_AI="$GET_STUDENT_CENTER/query_ai";
  static const String POST_SAVE_TEST_STATE="$GET_STUDENT_CENTER/update_test_state";
  static const String POST_UPDATE_USER_DETAILS="$GET_STUDENT_CENTER";
  static const String POST_SUBMIT_TEST="$GET_STUDENT_CENTER/test_submit_general";
  static const String GET_GRAVITY_RESULTS="/user/general/results";

//dpp_tests
  static const String GET_STUDENT_STREAM_DPP_TESTINFO="$GET_STUDENT_CENTER/dpp_test_report";
  static const String POST_CREATE_DPP_TEST_ATTEMPT="$GET_STUDENT_CENTER/create_dpp_test_attempt";
  static const String GET_STUDENT_DPP_TEST_STATE="$GET_STUDENT_CENTER/dpp_test_state";
  static const String POST_SAVE_DPP_TEST_STATE="$GET_STUDENT_CENTER/update_dpp_test_state";
  static const String POST_SUBMIT_DPP_TEST="$GET_STUDENT_CENTER/test_submit_dpp";
  static const String GET_STUDENT_DPP_QUESTION="$GET_STUDENT_CENTER/dpp_question_get";
  static const String GET_STUDENT_DPP_TEST_RESULT="$GET_STUDENT_CENTER/test_result_dpp";

  // static const String GET_STUDENT_DPP_TEST_RESULT="$GET_STUDENT_CENTER/dpp_test_result_with_questions";
  
  static const String GET_STUDENT_TEST_RESULT_QUESTIONS="$GET_STUDENT_CENTER/test_result_with_questions";








}