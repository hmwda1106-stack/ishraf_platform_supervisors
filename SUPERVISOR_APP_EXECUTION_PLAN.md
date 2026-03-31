# خطة التنفيذ المتسلسلة - تطبيق المشرف (Supervisor App)

## مقدمة

هذه الخطة مبنية على التحليل الشامل لملفات التوثيق في مجلد `Public-Doc` وتلتزم بالقواعد العامة المحددة في `/workspace/قواعد عامة.md`.

---

## المرحلة 0: التحضير والإعداد (Day 1)

### الهدف
إعداد بيئة العمل وفهم العقود النهائية قبل البدء بالبناء.

### المهام

#### 0.1 مراجعة الوثائق المصدرية
- [ ] قراءة `supervisor-app/README.md` - فهم النطاق
- [ ] قراءة `supervisor-app/SCREENS_AND_TASKS.md` - الشاشات المطلوبة
- [ ] قراءة `supervisor-app/ENDPOINT_MAP.md` - جميع endpoints
- [ ] قراءة `supervisor-app/QA_AND_ACCEPTANCE.md` - معايير القبول
- [ ] قراءة `BACKEND_WAVE1_STATUS.md` - جاهزية الباك إند
- [ ] قراءة `API_REFERENCE.md` - العقود التفصيلية

#### 0.2 التحقق من بيئة التطوير
```bash
# التحقق من Flutter version
flutter --version
# المطلوب: Flutter 3.x + Dart 3.11+

# التحقق من الاتصال بالـ staging backend
curl https://ishraf-platform-backend-staging.onrender.com/health

# التحقق من جاهزية الـ API
curl https://ishraf-platform-backend-staging.onrender.com/api/v1/health/ready
```

#### 0.3 إعداد Postman Collection للاختبار
- [ ] استيراد `ishraf-platform.postman_collection.json`
- [ ] إعداد Environment Variables:
  - `base_url`: `https://ishraf-platform-backend-staging.onrender.com/api/v1`
  - `supervisor_token`: (سيتم الحصول عليه بعد login)

#### 0.4 إنشاء ملف اختبار الـ Endpoints
```bash
mkdir -p /workspace/test_endpoints
touch /workspace/test_endpoints/supervisor_endpoints_test.sh
```

---

## المرحلة 1: تأسيس المعمارية وهيكل المشروع (Day 2-3)

### الهدف
بناء الأساس المعماري للتطبيق قبل أي شاشة.

### 1.1 تحديث pubspec.yaml

#### الإضافات المطلوبة:
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  flutter_riverpod: ^2.4.9
  
  # Navigation
  go_router: ^13.1.0
  
  # HTTP & API
  http: ^1.2.0
  dio: ^5.4.0
  
  # Local Storage
  shared_preferences: ^2.2.2
  flutter_secure_storage: ^9.0.0
  
  # Localization
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  
  # Utilities
  equatable: ^2.0.5
  json_annotation: ^4.8.1
  freezed_annotation: ^2.4.1
  
  # UI Components
  google_fonts: ^6.1.0
  flutter_svg: ^2.0.9
  
  # Forms & Validation
  formz: ^0.7.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.8
  json_serializable: ^6.7.1
  freezed: ^2.4.6
  mockito: ^5.4.4
```

### 1.2 هيكل المجلدات Feature-Based

```
lib/
├── main.dart                          # نقطة الدخول
├── app.dart                           # Widget root مع Theme & Localization
│
├── core/                              # Core utilities المشتركة
│   ├── constants/
│   │   ├── api_constants.dart         # Base URLs, timeouts
│   │   ├── app_constants.dart         # App names, versions
│   │   └── storage_keys.dart          # SharedPreferences keys
│   │
│   ├── errors/
│   │   ├── exceptions.dart            # Custom exceptions
│   │   └── failures.dart              # Failure classes
│   │
│   ├── network/
│   │   ├── api_client.dart            # Dio/HTTP client setup
│   │   ├── network_info.dart          # Connectivity check
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart  # Token injection
│   │       ├── logging_interceptor.dart
│   │       └── error_interceptor.dart
│   │
│   ├── theme/
│   │   ├── app_theme.dart             # Light/Dark themes
│   │   ├── color_tokens.dart          # Color palette
│   │   ├── typography.dart            # Text styles
│   │   └── spacing.dart               # Spacing tokens
│   │
│   ├── localization/
│   │   ├── app_localizations.dart     # Localization delegate
│   │   ├── l10n.yaml                  # Configuration
│   │   └── translations/
│   │       ├── ar.json                # Arabic translations
│   │       └── en.json                # English translations
│   │
│   └── utils/
│       ├── date_formatter.dart
│       ├── validators.dart
│       └── extensions.dart
│
├── data/                              # Data Layer
│   ├── models/                        # Shared models
│   │   ├── user_model.dart
│   │   ├── token_model.dart
│   │   └── pagination_model.dart
│   │
│   └── repositories/                  # Repository implementations
│       ├── auth_repository_impl.dart
│       ├── behavior_repository_impl.dart
│       ├── attendance_repository_impl.dart
│       ├── reporting_repository_impl.dart
│       └── communication_repository_impl.dart
│
├── domain/                            # Domain Layer (Business Logic)
│   ├── entities/                      # Pure business objects
│   │   ├── user.dart
│   │   ├── student.dart
│   │   ├── behavior_record.dart
│   │   ├── attendance_session.dart
│   │   ├── message.dart
│   │   └── notification.dart
│   │
│   ├── repositories/                  # Repository interfaces
│   │   ├── auth_repository.dart
│   │   ├── behavior_repository.dart
│   │   ├── attendance_repository.dart
│   │   ├── reporting_repository.dart
│   │   └── communication_repository.dart
│   │
│   └── usecases/                      # Use Cases
│       ├── auth/
│       │   ├── login_usecase.dart
│       │   ├── logout_usecase.dart
│       │   ├── refresh_token_usecase.dart
│       │   └── get_current_user_usecase.dart
│       ├── behavior/
│       │   ├── get_categories_usecase.dart
│       │   ├── create_record_usecase.dart
│       │   ├── update_record_usecase.dart
│       │   └── get_records_usecase.dart
│       └── ... (similar for other modules)
│
├── features/                          # Feature Modules
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── forgot_password_screen.dart
│   │   │   │   └── reset_password_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── login_form.dart
│   │   │   │   └── password_field.dart
│   │   │   └── state/
│   │   │       ├── auth_state.dart
│   │   │       └── auth_notifier.dart
│   │   └── data/
│   │       ├── models/
│   │       │   └── login_request_model.dart
│   │       └── datasources/
│   │           └── auth_remote_datasource.dart
│   │
│   ├── dashboard/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── supervisor_dashboard_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── assigned_classes_card.dart
│   │   │   │   ├── recent_behavior_card.dart
│   │   │   │   └── announcements_banner.dart
│   │   │   └── state/
│   │   │       └── dashboard_state.dart
│   │   └── data/
│   │       └── datasources/
│   │           └── dashboard_remote_datasource.dart
│   │
│   ├── behavior/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── behavior_categories_screen.dart
│   │   │   │   ├── behavior_records_list_screen.dart
│   │   │   │   ├── create_behavior_record_screen.dart
│   │   │   │   ├── behavior_record_detail_screen.dart
│   │   │   │   └── edit_behavior_record_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── behavior_category_tile.dart
│   │   │   │   ├── behavior_record_card.dart
│   │   │   │   └── severity_indicator.dart
│   │   │   └── state/
│   │   │       └── behavior_state.dart
│   │   └── data/
│   │       ├── models/
│   │       │   └── behavior_record_model.dart
│   │       └── datasources/
│   │           └── behavior_remote_datasource.dart
│   │
│   ├── attendance/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── attendance_sessions_list_screen.dart
│   │   │   │   ├── attendance_session_detail_screen.dart
│   │   │   │   └── update_attendance_record_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── session_card.dart
│   │   │   │   └── attendance_status_chip.dart
│   │   │   └── state/
│   │   │       └── attendance_state.dart
│   │   └── data/
│   │       ├── models/
│   │       │   └── attendance_session_model.dart
│   │       └── datasources/
│   │           └── attendance_remote_datasource.dart
│   │
│   ├── reporting/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── student_profile_report_screen.dart
│   │   │   │   ├── attendance_summary_screen.dart
│   │   │   │   ├── assessment_summary_screen.dart
│   │   │   │   └── behavior_summary_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── student_profile_header.dart
│   │   │   │   └── summary_chart.dart
│   │   │   └── state/
│   │   │       └── reporting_state.dart
│   │   └── data/
│   │       └── datasources/
│   │           └── reporting_remote_datasource.dart
│   │
│   ├── communication/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── messages_inbox_screen.dart
│   │   │   │   ├── messages_sent_screen.dart
│   │   │   │   ├── conversation_detail_screen.dart
│   │   │   │   ├── compose_message_screen.dart
│   │   │   │   ├── notifications_screen.dart
│   │   │   │   └── active_announcements_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── message_tile.dart
│   │   │   │   └── notification_card.dart
│   │   │   └── state/
│   │   │       └── communication_state.dart
│   │   └── data/
│   │       └── datasources/
│   │           └── communication_remote_datasource.dart
│   │
│   ├── profile/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── user_profile_screen.dart
│   │   │   │   ├── change_password_screen.dart
│   │   │   │   └── settings_screen.dart
│   │   │   └── widgets/
│   │   │       ├── profile_header.dart
│   │   │       └── setting_tile.dart
│   │   └── state/
│   │       └── profile_state.dart
│   │
│   └── app_shell/
│       └── presentation/
│           ├── app_shell.dart              # Bottom Navigation
│           └── widgets/
│               └── nav_bar_item.dart
│
└── routing/                         # Navigation System
    ├── app_router.dart              # GoRouter configuration
    ├── routes.dart                  # Route constants
    └── route_guards.dart            # Auth guards
```

### 1.3 إنشاء الملفات الأساسية

#### 1.3.1 core/constants/api_constants.dart
```dart
class ApiConstants {
  static const String baseUrl = 
      'https://ishraf-platform-backend-staging.onrender.com/api/v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Endpoints - Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String me = '/auth/me';
  static const String changePassword = '/auth/change-password';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  
  // Endpoints - Reporting
  static const String supervisorDashboard = '/reporting/dashboards/supervisor/me';
  static const String studentProfile = '/reporting/students/';
  static const String attendanceSummary = '/reports/attendance-summary';
  static const String assessmentSummary = '/reports/assessment-summary';
  static const String behaviorSummary = '/reports/behavior-summary';
  
  // Endpoints - Behavior
  static const String behaviorCategories = '/behavior/categories';
  static const String behaviorRecords = '/behavior/records';
  static const String studentBehaviorRecords = '/behavior/students/';
  
  // Endpoints - Attendance
  static const String attendanceSessions = '/attendance/sessions';
  static const String attendanceRecords = '/attendance/records/';
  
  // Endpoints - Communication
  static const String recipients = '/communication/recipients';
  static const String messages = '/communication/messages';
  static const String inbox = '/communication/messages/inbox';
  static const String sent = '/communication/messages/sent';
  static const String conversations = '/communication/messages/conversations/';
  static const String notifications = '/communication/notifications/me';
  static const String announcements = '/communication/announcements/active';
}
```

#### 1.3.2 core/constants/storage_keys.dart
```dart
class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String currentUser = 'current_user';
  static const String languageCode = 'language_code';
  static const String themeMode = 'theme_mode';
  static const String onboardingComplete = 'onboarding_complete';
}
```

#### 1.3.3 core/theme/color_tokens.dart
```dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF0D47A1);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF26A69A);
  static const Color secondaryLight = Color(0xFF64DBCB);
  static const Color secondaryDark = Color(0xFF00796B);
  
  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Neutral Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8F9FA);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  
  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkBorder = Color(0xFF424242);
}
```

#### 1.3.4 core/localization/translations/ar.json
```json
{
  "app": {
    "name": "إشراف - المشرف",
    "loading": "جاري التحميل...",
    "error": "حدث خطأ",
    "retry": "إعادة المحاولة",
    "noData": "لا توجد بيانات",
    "save": "حفظ",
    "cancel": "إلغاء",
    "delete": "حذف",
    "edit": "تعديل",
    "add": "إضافة",
    "search": "بحث",
    "filter": "تصفية",
    "confirm": "تأكيد",
    "back": "رجوع"
  },
  "auth": {
    "login": "تسجيل الدخول",
    "logout": "تسجيل الخروج",
    "identifier": "اسم المستخدم أو البريد الإلكتروني",
    "password": "كلمة المرور",
    "forgotPassword": "نسيت كلمة المرور؟",
    "resetPassword": "إعادة تعيين كلمة المرور",
    "changePassword": "تغيير كلمة المرور",
    "currentPassword": "كلمة المرور الحالية",
    "newPassword": "كلمة المرور الجديدة",
    "confirmPassword": "تأكيد كلمة المرور",
    "loginError": "بيانات الدخول غير صحيحة",
    "sessionExpired": "انتهت الجلسة، يرجى تسجيل الدخول مجددًا"
  },
  "navigation": {
    "dashboard": "الرئيسية",
    "behavior": "السلوك",
    "attendance": "الحضور",
    "messages": "الرسائل",
    "reports": "التقارير",
    "profile": "الملف الشخصي",
    "settings": "الإعدادات"
  },
  "dashboard": {
    "title": "لوحة التحكم",
    "assignedClasses": "الفصول المسندة",
    "recentBehaviors": "آخر السجلات السلوكية",
    "announcements": "الإعلانات",
    "noClassesAssigned": "لا توجد فصول مسندة إليك",
    "noRecentBehaviors": "لا توجد سجلات سلوكية حديثة",
    "noAnnouncements": "لا توجد إعلانات حالية"
  },
  "behavior": {
    "categories": "فئات السلوك",
    "records": "السجلات السلوكية",
    "createRecord": "تسجيل سلوك جديد",
    "recordDetail": "تفاصيل السجل",
    "editRecord": "تعديل السجل",
    "student": "الطالب",
    "category": "الفئة",
    "date": "التاريخ",
    "description": "الوصف",
    "severity": "الشدة",
    "low": "منخفضة",
    "medium": "متوسطة",
    "high": "عالية",
    "selectStudent": "اختر الطالب",
    "selectCategory": "اختر الفئة",
    "recordCreated": "تم إنشاء السجل بنجاح",
    "recordUpdated": "تم تحديث السجل بنجاح"
  },
  "attendance": {
    "sessions": "جلسات الحضور",
    "sessionDetail": "تفاصيل الجلسة",
    "updateRecord": "تحديث سجل الحضور",
    "status": "الحالة",
    "present": "حاضر",
    "absent": "غائب",
    "excused": "بعذر",
    "late": "متأخر",
    "notes": "ملاحظات",
    "date": "التاريخ",
    "class": "الصف",
    "noSessions": "لا توجد جلسات حضور"
  },
  "reports": {
    "studentProfile": "ملف الطالب",
    "attendanceSummary": "ملخص الحضور",
    "assessmentSummary": "ملخص التقييمات",
    "behaviorSummary": "ملخص السلوك",
    "selectStudent": "اختر طالباً",
    "noReportsAvailable": "لا توجد تقارير متاحة"
  },
  "communication": {
    "inbox": "صندوق الوارد",
    "sent": "المرسلة",
    "compose": "رسالة جديدة",
    "conversation": "المحادثة",
    "notifications": "الإشعارات",
    "announcements": "الإعلانات",
    "recipient": "المستلم",
    "messageBody": "نص الرسالة",
    "sendMessage": "إرسال",
    "markAsRead": "تحديد كمقروء",
    "noMessages": "لا توجد رسائل",
    "noNotifications": "لا توجد إشعارات"
  },
  "profile": {
    "title": "الملف الشخصي",
    "name": "الاسم",
    "email": "البريد الإلكتروني",
    "role": "الدور",
    "department": "القسم",
    "changePassword": "تغيير كلمة المرور",
    "language": "اللغة",
    "theme": "السمة",
    "logout": "تسجيل الخروج"
  },
  "settings": {
    "title": "الإعدادات",
    "language": "اللغة",
    "theme": "السمة",
    "light": "فاتح",
    "dark": "داكن",
    "system": "حسب النظام",
    "arabic": "العربية",
    "english": "English"
  },
  "validation": {
    "required": "هذا الحقل مطلوب",
    "invalidEmail": "البريد الإلكتروني غير صالح",
    "passwordTooShort": "كلمة المرور قصيرة جداً",
    "passwordsDoNotMatch": "كلمات المرور غير متطابقة",
    "invalidInput": "إدخال غير صالح"
  },
  "errors": {
    "networkError": "خطأ في الاتصال، تحقق من الإنترنت",
    "serverError": "خطأ في الخادم، حاول لاحقاً",
    "unauthorized": "غير مصرح لك، يرجى تسجيل الدخول",
    "forbidden": "ليس لديك صلاحية للوصول",
    "notFound": "البيانات غير موجودة",
    "timeout": "انتهت مهلة الاتصال",
    "unknown": "حدث خطأ غير معروف"
  }
}
```

#### 1.3.5 core/localization/translations/en.json
```json
{
  "app": {
    "name": "Ishraf - Supervisor",
    "loading": "Loading...",
    "error": "An error occurred",
    "retry": "Retry",
    "noData": "No data available",
    "save": "Save",
    "cancel": "Cancel",
    "delete": "Delete",
    "edit": "Edit",
    "add": "Add",
    "search": "Search",
    "filter": "Filter",
    "confirm": "Confirm",
    "back": "Back"
  },
  "auth": {
    "login": "Login",
    "logout": "Logout",
    "identifier": "Username or Email",
    "password": "Password",
    "forgotPassword": "Forgot Password?",
    "resetPassword": "Reset Password",
    "changePassword": "Change Password",
    "currentPassword": "Current Password",
    "newPassword": "New Password",
    "confirmPassword": "Confirm Password",
    "loginError": "Invalid credentials",
    "sessionExpired": "Session expired, please login again"
  },
  "navigation": {
    "dashboard": "Dashboard",
    "behavior": "Behavior",
    "attendance": "Attendance",
    "messages": "Messages",
    "reports": "Reports",
    "profile": "Profile",
    "settings": "Settings"
  },
  "dashboard": {
    "title": "Dashboard",
    "assignedClasses": "Assigned Classes",
    "recentBehaviors": "Recent Behavior Records",
    "announcements": "Announcements",
    "noClassesAssigned": "No classes assigned to you",
    "noRecentBehaviors": "No recent behavior records",
    "noAnnouncements": "No active announcements"
  },
  "behavior": {
    "categories": "Behavior Categories",
    "records": "Behavior Records",
    "createRecord": "Create New Record",
    "recordDetail": "Record Details",
    "editRecord": "Edit Record",
    "student": "Student",
    "category": "Category",
    "date": "Date",
    "description": "Description",
    "severity": "Severity",
    "low": "Low",
    "medium": "Medium",
    "high": "High",
    "selectStudent": "Select Student",
    "selectCategory": "Select Category",
    "recordCreated": "Record created successfully",
    "recordUpdated": "Record updated successfully"
  },
  "attendance": {
    "sessions": "Attendance Sessions",
    "sessionDetail": "Session Details",
    "updateRecord": "Update Attendance Record",
    "status": "Status",
    "present": "Present",
    "absent": "Absent",
    "excused": "Excused",
    "late": "Late",
    "notes": "Notes",
    "date": "Date",
    "class": "Class",
    "noSessions": "No attendance sessions"
  },
  "reports": {
    "studentProfile": "Student Profile",
    "attendanceSummary": "Attendance Summary",
    "assessmentSummary": "Assessment Summary",
    "behaviorSummary": "Behavior Summary",
    "selectStudent": "Select a Student",
    "noReportsAvailable": "No reports available"
  },
  "communication": {
    "inbox": "Inbox",
    "sent": "Sent",
    "compose": "New Message",
    "conversation": "Conversation",
    "notifications": "Notifications",
    "announcements": "Announcements",
    "recipient": "Recipient",
    "messageBody": "Message Body",
    "sendMessage": "Send",
    "markAsRead": "Mark as Read",
    "noMessages": "No messages",
    "noNotifications": "No notifications"
  },
  "profile": {
    "title": "Profile",
    "name": "Name",
    "email": "Email",
    "role": "Role",
    "department": "Department",
    "changePassword": "Change Password",
    "language": "Language",
    "theme": "Theme",
    "logout": "Logout"
  },
  "settings": {
    "title": "Settings",
    "language": "Language",
    "theme": "Theme",
    "light": "Light",
    "dark": "Dark",
    "system": "System",
    "arabic": "العربية",
    "english": "English"
  },
  "validation": {
    "required": "This field is required",
    "invalidEmail": "Invalid email address",
    "passwordTooShort": "Password is too short",
    "passwordsDoNotMatch": "Passwords do not match",
    "invalidInput": "Invalid input"
  },
  "errors": {
    "networkError": "Network error, check your internet",
    "serverError": "Server error, try again later",
    "unauthorized": "Unauthorized, please login",
    "forbidden": "You don't have permission to access",
    "notFound": "Data not found",
    "timeout": "Connection timeout",
    "unknown": "An unknown error occurred"
  }
}
```

### 1.4 إنشاء نظام التنقل (GoRouter)

#### routing/routes.dart
```dart
class AppRoutes {
  // Auth
  static const String splash = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  
  // Main
  static const String dashboard = '/dashboard';
  
  // Behavior
  static const String behaviorCategories = '/behavior/categories';
  static const String behaviorRecords = '/behavior/records';
  static const String createBehaviorRecord = '/behavior/create';
  static const String behaviorRecordDetail = '/behavior/:id';
  static const String editBehaviorRecord = '/behavior/:id/edit';
  static const String studentBehaviorTimeline = '/students/:studentId/behavior';
  
  // Attendance
  static const String attendanceSessions = '/attendance/sessions';
  static const String attendanceSessionDetail = '/attendance/sessions/:id';
  static const String updateAttendanceRecord = '/attendance/records/:recordId/update';
  
  // Reporting
  static const String studentProfile = '/reports/students/:studentId';
  static const String attendanceSummary = '/reports/students/:studentId/attendance';
  static const String assessmentSummary = '/reports/students/:studentId/assessment';
  static const String behaviorSummary = '/reports/students/:studentId/behavior';
  
  // Communication
  static const String inbox = '/messages/inbox';
  static const String sent = '/messages/sent';
  static const String conversation = '/messages/conversation/:userId';
  static const String composeMessage = '/messages/compose';
  static const String notifications = '/notifications';
  static const String announcements = '/announcements';
  
  // Profile
  static const String profile = '/profile';
  static const String changePassword = '/profile/change-password';
  static const String settings = '/settings';
  static const String languageSelector = '/settings/language';
  static const String themeSelector = '/settings/theme';
}
```

#### routing/app_router.dart
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';
import '../features/app_shell/presentation/app_shell.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/dashboard/presentation/screens/supervisor_dashboard_screen.dart';
// Import other screens...

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash redirects to login or dashboard based on auth state
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Auth routes (outside app shell)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          return ResetPasswordScreen(token: token);
        },
      ),
      
      // Main app shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (context, state) => const SupervisorDashboardScreen(),
          ),
          
          // Behavior module
          GoRoute(
            path: AppRoutes.behaviorCategories,
            name: 'behaviorCategories',
            builder: (context, state) => const BehaviorCategoriesScreen(),
          ),
          GoRoute(
            path: AppRoutes.behaviorRecords,
            name: 'behaviorRecords',
            builder: (context, state) => const BehaviorRecordsListScreen(),
          ),
          GoRoute(
            path: AppRoutes.createBehaviorRecord,
            name: 'createBehaviorRecord',
            builder: (context, state) => const CreateBehaviorRecordScreen(),
          ),
          GoRoute(
            path: AppRoutes.behaviorRecordDetail,
            name: 'behaviorRecordDetail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return BehaviorRecordDetailScreen(recordId: id);
            },
          ),
          
          // Attendance module
          GoRoute(
            path: AppRoutes.attendanceSessions,
            name: 'attendanceSessions',
            builder: (context, state) => const AttendanceSessionsListScreen(),
          ),
          GoRoute(
            path: AppRoutes.attendanceSessionDetail,
            name: 'attendanceSessionDetail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return AttendanceSessionDetailScreen(sessionId: id);
            },
          ),
          
          // Reporting module
          GoRoute(
            path: AppRoutes.studentProfile,
            name: 'studentProfile',
            builder: (context, state) {
              final studentId = state.pathParameters['studentId']!;
              return StudentProfileReportScreen(studentId: studentId);
            },
          ),
          
          // Communication module
          GoRoute(
            path: AppRoutes.inbox,
            name: 'inbox',
            builder: (context, state) => const MessagesInboxScreen(),
          ),
          GoRoute(
            path: AppRoutes.conversation,
            name: 'conversation',
            builder: (context, state) {
              final userId = state.pathParameters['userId']!;
              return ConversationDetailScreen(otherUserId: userId);
            },
          ),
          GoRoute(
            path: AppRoutes.composeMessage,
            name: 'composeMessage',
            builder: (context, state) {
              final recipientId = state.uri.queryParameters['to'];
              return ComposeMessageScreen(recipientId: recipientId);
            },
          ),
          GoRoute(
            path: AppRoutes.notifications,
            name: 'notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
          
          // Profile module
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const UserProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.changePassword,
            name: 'changePassword',
            builder: (context, state) => const ChangePasswordScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    
    // Redirect logic based on auth state
    redirect: (context, state) {
      final isLoggedIn = context.read<AuthProvider>().isLoggedIn;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isResettingPassword = state.matchedLocation == AppRoutes.resetPassword;
      
      if (!isLoggedIn && !isLoggingIn && !isResettingPassword) {
        return AppRoutes.login;
      }
      
      if (isLoggedIn && isLoggingIn) {
        return AppRoutes.dashboard;
      }
      
      return null;
    },
    
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    ),
  );
}
```

---

## المرحلة 2: طبقة البيانات والاتصال (Day 4-5)

### الهدف
بناء طبقة الاتصال مع الـ API وطبقةrepositories.

### 2.1 إنشاء API Client

#### core/network/api_client.dart
```dart
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../constants/storage_keys.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class ApiClient {
  late final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  
  ApiClient(this._secureStorage) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add interceptors
    _dio.interceptors.add(AuthInterceptor(_secureStorage));
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
  }
  
  Dio get dio => _dio;
  
  Future<void> setAuthToken(String token) async {
    await _secureStorage.write(key: StorageKeys.accessToken, value: token);
  }
  
  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: StorageKeys.accessToken);
  }
  
  Future<void> clearAuthToken() async {
    await _secureStorage.delete(key: StorageKeys.accessToken);
    await _secureStorage.delete(key: StorageKeys.refreshToken);
  }
}
```

#### core/network/interceptors/auth_interceptor.dart
```dart
import 'package:dio/dio.dart';
import '../../constants/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;
  
  AuthInterceptor(this._secureStorage);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.read(key: StorageKeys.accessToken);
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      final refreshToken = await _secureStorage.read(key: StorageKeys.refreshToken);
      
      if (refreshToken != null) {
        try {
          final response = await Dio().post(
            '${err.requestOptions.baseUrl}/auth/refresh',
            data: {'refreshToken': refreshToken},
          );
          
          final newToken = response.data['data']['tokens']['accessToken'];
          await _secureStorage.write(key: StorageKeys.accessToken, value: newToken);
          
          // Retry the original request
          final opts = Options(
            method: err.requestOptions.method,
            headers: {
              ...err.requestOptions.headers,
              'Authorization': 'Bearer $newToken',
            },
          );
          
          final retryResponse = await Dio().request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: opts,
          );
          
          return handler.resolve(retryResponse);
        } catch (_) {
          // Refresh failed, clear tokens
          await _secureStorage.delete(key: StorageKeys.accessToken);
          await _secureStorage.delete(key: StorageKeys.refreshToken);
        }
      }
    }
    
    handler.next(err);
  }
}
```

### 2.2 إنشاء Domain Entities

#### domain/entities/user.dart
```dart
import 'package:equatable/equatable.dart';

enum UserRole {
  admin,
  teacher,
  supervisor,
  parent,
  driver,
}

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? department;
  final DateTime createdAt;
  
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.department,
    required this.createdAt,
  });
  
  bool get isSupervisor => role == UserRole.supervisor;
  
  @override
  List<Object?> get props => [id, name, email, role, department, createdAt];
}
```

#### domain/entities/behavior_record.dart
```dart
import 'package:equatable/equatable.dart';

enum SeverityLevel {
  low,
  medium,
  high,
}

class BehaviorRecord extends Equatable {
  final String id;
  final String studentId;
  final String studentName;
  final String categoryId;
  final String categoryName;
  final String? supervisorId;
  final String? description;
  final SeverityLevel? severity;
  final DateTime behaviorDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const BehaviorRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.categoryId,
    required this.categoryName,
    this.supervisorId,
    this.description,
    this.severity,
    required this.behaviorDate,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object?> get props => [
    id,
    studentId,
    studentName,
    categoryId,
    categoryName,
    supervisorId,
    description,
    severity,
    behaviorDate,
    createdAt,
    updatedAt,
  ];
}
```

### 2.3 إنشاء Repository Interfaces

#### domain/repositories/auth_repository.dart
```dart
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String identifier,
    required String password,
  });
  
  Future<void> logout();
  
  Future<User> getCurrentUser();
  
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  
  Future<void> forgotPassword({required String identifier});
  
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
  
  Future<void> refreshToken();
}
```

#### domain/repositories/behavior_repository.dart
```dart
import '../entities/behavior_record.dart';

abstract class BehaviorRepository {
  Future<List<BehaviorCategory>> getCategories();
  
  Future<List<BehaviorRecord>> getRecords({
    int page = 1,
    int limit = 20,
    String? studentId,
    String? categoryId,
    SeverityLevel? severity,
  });
  
  Future<BehaviorRecord> getRecordById(String id);
  
  Future<BehaviorRecord> createRecord({
    required String studentId,
    required String categoryId,
    required DateTime behaviorDate,
    String? description,
    SeverityLevel? severity,
  });
  
  Future<BehaviorRecord> updateRecord({
    required String id,
    String? categoryId,
    String? description,
    SeverityLevel? severity,
    DateTime? behaviorDate,
  });
  
  Future<List<BehaviorRecord>> getStudentBehaviorTimeline(String studentId);
}

class BehaviorCategory extends Equatable {
  final String id;
  final String name;
  final String? description;
  
  const BehaviorCategory({
    required this.id,
    required this.name,
    this.description,
  });
  
  @override
  List<Object?> get props => [id, name, description];
}
```

### 2.4 إنشاء Data Models

#### data/models/user_model.dart
```dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.department,
    required super.createdAt,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.supervisor,
      ),
      department: json['department'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
      'department': department,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
```

---

## المرحلة 3: حالة المصادقة والتخزين المحلي (Day 6)

### الهدف
بناء نظام المصادقة وإدارة الجلسة.

### 3.1 إنشاء Auth State Management

#### features/auth/presentation/state/auth_state.dart
```dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  
  const AuthAuthenticated(this.user);
  
  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  
  const AuthError(this.message);
  
  @override
  List<Object?> get props => [message];
}
```

#### features/auth/presentation/state/auth_notifier.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  
  AuthNotifier(this._authRepository) : super(AuthInitial()) {
    checkAuthStatus();
  }
  
  Future<void> checkAuthStatus() async {
    state = AuthLoading();
    
    try {
      final user = await _authRepository.getCurrentUser();
      state = AuthAuthenticated(user);
    } catch (_) {
      state = AuthUnauthenticated();
    }
  }
  
  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    state = AuthLoading();
    
    try {
      final user = await _authRepository.login(
        identifier: identifier,
        password: password,
      );
      state = AuthAuthenticated(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
  
  Future<void> logout() async {
    state = AuthLoading();
    
    try {
      await _authRepository.logout();
      state = AuthUnauthenticated();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
  
  bool get isLoggedIn => state is AuthAuthenticated;
  User? get user => state is AuthAuthenticated ? (state as AuthAuthenticated).user : null;
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepository);
});
```

### 3.2 إنشاء Auth Repository Implementation

#### data/repositories/auth_repository_impl.dart
```dart
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../models/token_model.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;
  
  AuthRepositoryImpl(this._apiClient, this._secureStorage);
  
  @override
  Future<User> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.login,
        data: {
          'identifier': identifier,
          'password': password,
        },
      );
      
      final userData = response.data['data']['user'] as Map<String, dynamic>;
      final tokens = response.data['data']['tokens'] as Map<String, dynamic>;
      
      // Store tokens
      await _secureStorage.write(
        key: StorageKeys.accessToken,
        value: tokens['accessToken'] as String,
      );
      await _secureStorage.write(
        key: StorageKeys.refreshToken,
        value: tokens['refreshToken'] as String,
      );
      
      // Store user
      await _secureStorage.write(
        key: StorageKeys.currentUser,
        value: UserModel.fromJson(userData).toJson().toString(),
      );
      
      return UserModel.fromJson(userData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('auth.loginError');
      }
      throw Exception('errors.networkError');
    }
  }
  
  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _secureStorage.read(key: StorageKeys.refreshToken);
      
      if (refreshToken != null) {
        await _apiClient.dio.post(
          ApiConstants.logout,
          data: {'refreshToken': refreshToken},
        );
      }
    } finally {
      // Clear local storage regardless of API call success
      await _secureStorage.delete(key: StorageKeys.accessToken);
      await _secureStorage.delete(key: StorageKeys.refreshToken);
      await _secureStorage.delete(key: StorageKeys.currentUser);
    }
  }
  
  @override
  Future<User> getCurrentUser() async {
    final storedUser = await _secureStorage.read(key: StorageKeys.currentUser);
    final token = await _secureStorage.read(key: StorageKeys.accessToken);
    
    if (storedUser == null || token == null) {
      throw Exception('No active session');
    }
    
    try {
      final response = await _apiClient.dio.get(ApiConstants.me);
      final userData = response.data['data'] as Map<String, dynamic>;
      
      await _secureStorage.write(
        key: StorageKeys.currentUser,
        value: UserModel.fromJson(userData).toJson().toString(),
      );
      
      return UserModel.fromJson(userData);
    } catch (e) {
      // Try to parse from storage
      return UserModel.fromJson(Map<String, dynamic>.from(
        Map.fromEntries(storedUser.split(',').map((e) {
          final parts = e.split(':');
          return MapEntry(parts[0].trim(), parts[1].trim());
        }),
      ));
    }
  }
  
  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiClient.dio.post(
        ApiConstants.changePassword,
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Current password is incorrect');
      }
      rethrow;
    }
  }
  
  @override
  Future<void> forgotPassword({required String identifier}) async {
    try {
      await _apiClient.dio.post(
        ApiConstants.forgotPassword,
        data: {'identifier': identifier},
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        throw Exception('Too many attempts. Please try again later.');
      }
      rethrow;
    }
  }
  
  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _apiClient.dio.post(
        ApiConstants.resetPassword,
        data: {
          'token': token,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Invalid or expired token');
      }
      rethrow;
    }
  }
  
  @override
  Future<void> refreshToken() async {
    final refreshToken = await _secureStorage.read(key: StorageKeys.refreshToken);
    
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }
    
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.refreshToken,
        data: {'refreshToken': refreshToken},
      );
      
      final tokens = response.data['data'] as Map<String, dynamic>;
      
      await _secureStorage.write(
        key: StorageKeys.accessToken,
        value: tokens['accessToken'] as String,
      );
      await _secureStorage.write(
        key: StorageKeys.refreshToken,
        value: tokens['refreshToken'] as String,
      );
    } catch (e) {
      await logout();
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final secureStorage = ref.read(secureStorageProvider);
  return AuthRepositoryImpl(apiClient, secureStorage);
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return ApiClient(secureStorage);
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});
```

---

## المرحلة 4: App Shell ونظام التنقل (Day 7)

### الهدف
بناء الهيكل الرئيسي للتطبيق مع Bottom Navigation.

### 4.1 إنشاء App Shell

#### features/app_shell/presentation/app_shell.dart
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/color_tokens.dart';
import '../../auth/presentation/state/auth_state.dart';
import '../../auth/presentation/state/auth_notifier.dart';

class AppShell extends ConsumerWidget {
  final Widget child;
  
  const AppShell({super.key, required this.child});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final currentLocation = GoRouterState.of(context).uri.path;
    
    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNavBar(context, currentLocation),
    );
  }
  
  Widget _buildBottomNavBar(BuildContext context, String currentLocation) {
    final t = AppLocalizations.of(context);
    
    return NavigationBar(
      selectedIndex: _calculateSelectedIndex(currentLocation),
      onDestinationSelected: (index) => _onItemTapped(index, context),
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primaryLight,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.dashboard_outlined),
          selectedIcon: const Icon(Icons.dashboard),
          label: t.dashboard,
        ),
        NavigationDestination(
          icon: const Icon(Icons.psychology_outlined),
          selectedIcon: const Icon(Icons.psychology),
          label: t.behavior,
        ),
        NavigationDestination(
          icon: const Icon(Icons.event_available_outlined),
          selectedIcon: const Icon(Icons.event_available),
          label: t.attendance,
        ),
        NavigationDestination(
          icon: const Icon(Icons.mail_outlined),
          selectedIcon: const Icon(Icons.mail),
          label: t.messages,
        ),
        NavigationDestination(
          icon: const Icon(Icons.assessment_outlined),
          selectedIcon: const Icon(Icons.assessment),
          label: t.reports,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: t.profile,
        ),
      ],
    );
  }
  
  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/behavior')) return 1;
    if (location.startsWith('/attendance')) return 2;
    if (location.startsWith('/messages') || location.startsWith('/notifications')) return 3;
    if (location.startsWith('/reports')) return 4;
    if (location.startsWith('/profile') || location.startsWith('/settings')) return 5;
    return 0;
  }
  
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/behavior/records');
        break;
      case 2:
        context.go('/attendance/sessions');
        break;
      case 3:
        context.go('/messages/inbox');
        break;
      case 4:
        // Reports needs student selection first
        context.go('/dashboard'); // Navigate to dashboard for now
        break;
      case 5:
        context.go('/profile');
        break;
    }
  }
}
```

---

## المرحلة 5: شاشة Dashboard (Day 8-9)

### الهدف
بناء الشاشة الرئيسية للمشرف.

### 5.1 Dashboard Screen

#### features/dashboard/presentation/screens/supervisor_dashboard_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/color_tokens.dart';
import '../widgets/assigned_classes_card.dart';
import '../widgets/recent_behavior_card.dart';
import '../widgets/announcements_banner.dart';
import '../state/dashboard_state.dart';

class SupervisorDashboardScreen extends ConsumerStatefulWidget {
  const SupervisorDashboardScreen({super.key});
  
  @override
  ConsumerState<SupervisorDashboardScreen> createState() => _SupervisorDashboardScreenState();
}

class _SupervisorDashboardScreenState extends ConsumerState<SupervisorDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardNotifierProvider.notifier).loadDashboard();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final dashboardState = ref.watch(dashboardNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t.dashboardTitle),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: dashboardState.when(
        data: (data) => RefreshIndicator(
          onRefresh: () => ref.read(dashboardNotifierProvider.notifier).loadDashboard(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Announcements Banner
                if (data.announcements.isNotEmpty) ...[
                  AnnouncementsBanner(announcements: data.announcements),
                  const SizedBox(height: 16),
                ],
                
                // Assigned Classes
                AssignedClassesCard(
                  classes: data.assignedClasses,
                  onViewAll: () => context.push('/classes'),
                ),
                const SizedBox(height: 16),
                
                // Recent Behavior Records
                RecentBehaviorCard(
                  records: data.recentBehaviors,
                  onViewAll: () => context.push('/behavior/records'),
                  onCreateNew: () => context.push('/behavior/create'),
                ),
                const SizedBox(height: 16),
                
                // Quick Actions
                _buildQuickActions(context, t),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(error.toString()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(dashboardNotifierProvider.notifier).loadDashboard(),
                child: Text(t.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildQuickActions(BuildContext context, dynamic t) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionChip(
                  avatar: const Icon(Icons.add_circle_outline),
                  label: Text(t.behaviorCreateRecord),
                  onPressed: () => context.push('/behavior/create'),
                ),
                ActionChip(
                  avatar: const Icon(Icons.search),
                  label: Text(t.reportsSelectStudent),
                  onPressed: () => _showStudentSearch(context),
                ),
                ActionChip(
                  avatar: const Icon(Icons.message),
                  label: Text(t.composeMessage),
                  onPressed: () => context.push('/messages/compose'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showStudentSearch(BuildContext context) {
    // TODO: Implement student search dialog
  }
}
```

---

## المرحلة 6: ميزة Behavior (Day 10-13)

### الهدف
بناء جميع شاشات إدارة السلوك.

### 6.1 Behavior Categories Screen
### 6.2 Behavior Records List
### 6.3 Create Behavior Record Form
### 6.4 Behavior Record Detail
### 6.5 Edit Behavior Record

(سيتم تفصيل كل شاشة بنفس النمط السابق)

---

## المرحلة 7: ميزة Attendance (Day 14-16)

### الهدف
بناء شاشات متابعة الحضور.

### 7.1 Attendance Sessions List
### 7.2 Attendance Session Detail
### 7.3 Update Attendance Record

---

## المرحلة 8: ميزة Reporting (Day 17-19)

### الهدف
بناء شاشات تقارير الطلاب.

### 8.1 Student Profile Report
### 8.2 Attendance Summary
### 8.3 Assessment Summary
### 8.4 Behavior Summary

---

## المرحلة 9: ميزة Communication (Day 20-23)

### الهدف
بناء نظام الرسائل والإشعارات.

### 9.1 Messages Inbox
### 9.2 Messages Sent
### 9.3 Conversation Detail
### 9.4 Compose Message
### 9.5 Notifications
### 9.6 Active Announcements

---

## المرحلة 10: الملف الشخصي والإعدادات (Day 24-25)

### الهدف
بناء شاشات الملف الشخصي والإعدادات.

### 10.1 User Profile
### 10.2 Change Password
### 10.3 Settings
### 10.4 Language Selector
### 10.5 Theme Selector

---

## المرحلة 11: الاختبار والتحقق (Day 26-28)

### الهدف
اختبار جميع الميزات والتحقق من معايير القبول.

### 11.1 Unit Tests
### 11.2 Widget Tests
### 11.3 Integration Tests
### 11.4 Manual Testing حسب QA_AND_ACCEPTANCE.md

---

## المرحلة 12: التحسين والنشر (Day 29-30)

### الهدف
تحسين الأداء والاستعداد للنشر.

### 12.1 Performance Optimization
### 12.2 Accessibility Improvements
### 12.3 Build Configuration
### 12.4 Deployment Preparation

---

## ملخص الجدول الزمني

| المرحلة | المدة | الأيام | المخرجات |
|---------|-------|--------|----------|
| 0: التحضير | 1 يوم | 1 | بيئة جاهزة |
| 1: المعمارية | 2 أيام | 2-3 | هيكل المشروع |
| 2: طبقة البيانات | 2 أيام | 4-5 | API & Repositories |
| 3: المصادقة | 1 يوم | 6 | Auth System |
| 4: App Shell | 1 يوم | 7 | Navigation |
| 5: Dashboard | 2 أيام | 8-9 | الشاشة الرئيسية |
| 6: Behavior | 4 أيام | 10-13 | ميزة كاملة |
| 7: Attendance | 3 أيام | 14-16 | ميزة كاملة |
| 8: Reporting | 3 أيام | 17-19 | ميزة كاملة |
| 9: Communication | 4 أيام | 20-23 | ميزة كاملة |
| 10: Profile | 2 أيام | 24-25 | ميزة كاملة |
| 11: الاختبار | 3 أيام | 26-28 | Tests & QA |
| 12: التحسين | 2 أيام | 29-30 | Production Ready |

**الإجمالي: 30 يوم عمل**

---

## معايير Definition of Done لكل مرحلة

1. ✅ الكود مكتوب Clean Code
2. ✅ جميع الحالات (loading, error, empty, success) مدعومة
3. ✅ Localization كامل (AR/EN)
4. ✅ Theme Support (Light/Dark)
5. ✅ RTL/LTR Support
6. ✅ Unit Tests مكتوبة
7. ✅ Widget Tests مكتوبة
8. ✅ Integration مع API الحقيقي
9. ✅ Error Handling شامل
10. ✅ مراجعة الكود

---

## ملاحظات هامة

1. **لا تنتقل للمرحلة التالية قبل إكمال الحالية**
2. **اختبر كل ميزة مباشرة مع الـ staging backend**
3. **التزم بهيكل المجلدات المحدد**
4. **استخدم Provider/Riverpod لإدارة الحالة فقط عند الحاجة**
5. **لا تستخدم mock data بعد بدء الدمج الحقيقي**
6. **راجع SUPERVISOR_APP_BLUEPRINT.md باستمرار**
7. **التزم بـ SCREENS_AND_TASKS.md لتحديد الشاشات**
8. **راجع ENDPOINT_MAP.md قبل أي استدعاء API**
9. **اختبر حسب QA_AND_ACCEPTANCE.md**
