# مخطط تنفيذ تطبيق المشرف (Supervisor App) - Flutter Blueprint

## 1. ملخص فهم مجلد Public-Doc

### 1.1 نظرة عامة على النظام
منصة "إشراف" هي منصة تعليمية ذكية مبنية على معمارية **Modular Monolith** (قرار Wave 1)، وتتضمن:
- 5 تطبيقات جوالة (Flutter): ولي الأمر، المعلم، المشرف، السائق، ولوحة إدارة ويب
- قاعدة بيانات PostgreSQL رئيسية
- Firebase للإشعارات الفورية (مؤجل لـ Wave 2)
- Google Maps للتتبع (مؤجل لـ Wave 2)

### 1.2 الملفات المصدرية الرئيسية
| الملف | النوع | الأهمية |
|------|-------|---------|
| `supervisor-app/README.md` | دليل تنفيذي | SSOT لتطبيق المشرف |
| `supervisor-app/SCREENS_AND_TASKS.md` | شاشات ومهام | تحديد الشاشات المطلوبة |
| `supervisor-app/ENDPOINT_MAP.md` | خريطة API | جميع endpoints للمشرف |
| `supervisor-app/QA_AND_ACCEPTANCE.md` | قبول وتحقق | معايير القبول |
| `BACKEND_WAVE1_STATUS.md` | حالة الباك إند | جاهزية الـ endpoints |
| `API_REFERENCE.md` | مرجع API | العقود البشرية |
| `COMMON_FRONTEND_RULES.md` | قواعد مشتركة | معايير الفرونت إند |
| `AUTH_AND_SESSION_RULES.md` | مصادقة | دورة الجلسة |
| `DELIVERY_SEQUENCE.md` | تسلسل التنفيذ | ترتيب البناء |

### 1.3 التصنيف حسب المجالات
#### متطلبات وظيفية
- الإشراف على الصفوف المسندة فقط
- متابعة السلوكيات اليومية للطلاب
- مراجعة الحضور والغياب (بدون إنشاء جلسات)
- الوصول إلى تقارير الطلاب ضمن النطاق
- التواصل الداخلي (رسائل، إشعارات، إعلانات)

#### تدفقات المستخدم
1. Login → Dashboard → عمليات يومية
2. Scope-limited access (فقط الصفوف المسندة)
3. Role-based navigation

#### صلاحيات المشرف
- ✅ قراءة تحديث سجلات الحضور
- ✅ إنشاء/تحديث سجلات سلوكية
- ✅ قراءة تقارير الطلاب (للصفوف المسندة)
- ✅ التواصل الداخلي
- ❌ إنشاء جلسات حضور
- ❌ إدارة البيانات الرئيسية (admin-only)
- ❌ الوصول خارج نطاق الصفوف المسندة

---

## 2. فهم دور المشرف

### 2.1 من هو المشرف؟
المشرف هو مستخدم بنظام `supervisor` role، مسؤول عن متابعة مجموعة من الصفوف الدراسية المسندة إليه.

### 2.2 المسؤوليات الأساسية
| المسؤولية | الوصف | التكرار |
|----------|-------|---------|
| متابعة السلوكيات | تسجيل ومراجعة السجلات السلوكية للطلاب | يومي |
| الإشراف على الحضور | مراجعة وتصحيح سجلات الحضور | يومي |
| مراجعة التقارير | الاطلاع على أداء الطلاب في الصفوف المسندة | أسبوعي |
| التواصل | تبادل الرسائل مع المعلمين والإدارة | حسب الحاجة |
| متابعة الإعلانات | الاطلاع على الإعلانات النشطة | يومي |

### 2.3 الكيانات التي يديرها
- **الفصول الدراسية**: فقط الصفوف المسندة عبر `SUPERVISOR_CLASSES`
- **الطلاب**: طلاب الصفوف المسندة فقط
- **سجلات السلوك**: إنشاء وتحديث ضمن النطاق
- **سجلات الحضور**: قراءة وتحديث فقط

### 2.4 العمليات اليومية
```
Morning Flow:
1. Login → Dashboard
2. Review active announcements
3. Check notifications
4. Review behavior records from previous day
5. Monitor attendance sessions for assigned classes

During Day:
1. Record new behavior incidents
2. Update existing behavior records
3. Correct attendance records if needed
4. Respond to messages

End of Day:
1. Review daily summary
2. Check unread notifications
3. Send necessary communications
```

### 2.5 القيود الهامة (Scope Enforcement)
- لا يمكن الوصول إلى طالب خارج الصفوف المسندة
- لا يمكن إنشاء جلسة حضور جديدة
- جميع الـ endpoints ترجع `403` أو `404` عند تجاوز النطاق
- Empty states شائعة عندما لا توجد بيانات

---

## 3. User Flow الكامل للمشرف

### 3.1 Auth Flow
```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐     ┌──────────────┐
│   Splash    │────▶│    Login     │────▶│  Dashboard  │────▶│  App Shell   │
└─────────────┘     └──────────────┘     └─────────────┘     └──────────────┘
                           │
                           ▼
                    ┌──────────────┐
                    │Forgot Password│
                    └──────────────┘
```

### 3.2 Main Navigation Flow
```
                                    ┌─────────────────┐
                                    │   App Shell     │
                                    │  (Bottom Nav)   │
                                    └────────┬────────┘
                                             │
        ┌──────────────┬──────────────┬──────┼──────┬──────────────┬──────────────┐
        │              │              │      │      │              │              │
        ▼              ▼              ▼      ▼      ▼              ▼              ▼
   ┌─────────┐   ┌─────────┐   ┌─────────┐ ┌─────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐
   │Dashboard│   │Behavior │   │Attendance│ │Msgs │ │Reports  │ │Profile  │ │Settings │
   └────┬────┘   └────┬────┘   └────┬────┘ └──┬──┘ └────┬────┘ └────┬────┘ └────┬────┘
        │             │              │         │       │           │           │
        ▼             ▼              ▼         ▼       ▼           ▼           ▼
   Classes      Categories     Sessions   Inbox   Students   Change     Language
   Summary      List           Detail     Sent    Profile    Password   Theme
   Behaviors    Create         Update     Conv    Reports    Logout
   Announcements Records
```

### 3.3 Detailed Screen Flows

#### Behavior Recording Flow
```
Dashboard ──▶ Behavior ──▶ Categories ──▶ Select Student ──▶ 
Create Form ──▶ Submit ──▶ Confirmation ──▶ Back to List
```

#### Attendance Correction Flow
```
Dashboard ──▶ Attendance ──▶ Sessions List ──▶ Session Detail ──▶
Select Record ──▶ Update Status ──▶ Add Notes ──▶ Save
```

#### Student Report Flow
```
Dashboard ──▶ Reports ──▶ Student Search/Select ──▶ Profile ──▶
[Attendance Tab | Assessment Tab | Behavior Tab]
```

---

## 4. Screen Map الكامل

### 4.1 قائمة الشاشات الكاملة

| ID | اسم الشاشة | النوع | المستوى | Parent |
|----|-----------|-------|---------|--------|
| S01 | SplashScreen | System | Root | - |
| S02 | LoginScreen | Auth | Root | - |
| S03 | ForgotPasswordScreen | Auth | Root | Login |
| S04 | ResetPasswordScreen | Auth | Root | Forgot |
| S05 | SupervisorDashboard | Main | Level 1 | App Shell |
| S06 | BehaviorCategoriesList | Feature | Level 2 | Behavior |
| S07 | BehaviorRecordsList | Feature | Level 2 | Behavior |
| S08 | CreateBehaviorRecord | Feature | Level 3 | Records/Categories |
| S09 | BehaviorRecordDetail | Feature | Level 3 | Records |
| S10 | EditBehaviorRecord | Feature | Level 3 | Detail |
| S11 | StudentBehaviorTimeline | Feature | Level 3 | Student Profile |
| S12 | AttendanceSessionsList | Feature | Level 2 | Attendance |
| S13 | AttendanceSessionDetail | Feature | Level 3 | Sessions |
| S14 | UpdateAttendanceRecord | Feature | Level 4 | Session Detail |
| S15 | StudentProfileReport | Feature | Level 2 | Reports |
| S16 | AttendanceSummaryReport | Feature | Level 3 | Student Profile |
| S17 | AssessmentSummaryReport | Feature | Level 3 | Student Profile |
| S18 | BehaviorSummaryReport | Feature | Level 3 | Student Profile |
| S19 | MessagesInbox | Feature | Level 2 | Messages |
| S20 | MessagesSent | Feature | Level 2 | Messages |
| S21 | ConversationDetail | Feature | Level 3 | Inbox/Sent |
| S22 | ComposeMessage | Feature | Level 3 | Messages |
| S23 | NotificationsList | Feature | Level 2 | Messages |
| S24 | ActiveAnnouncements | Feature | Level 2 | Dashboard |
| S25 | UserProfile | Feature | Level 2 | Profile |
| S26 | ChangePassword | Feature | Level 3 | Profile |
| S27 | Settings | Feature | Level 2 | Profile |
| S28 | LanguageSelector | Feature | Level 3 | Settings |
| S29 | ThemeSelector | Feature | Level 3 | Settings |

### 4.2 تفاصيل كل شاشة

#### S01: SplashScreen
- **الهدف**: تهيئة التطبيق والتحقق من الجلسة
- **البيانات**: Token validity check
- **الإجراءات**: Auto-navigate based on auth state
- **الحالات**: Loading, Error, Success

#### S02: LoginScreen
- **الهدف**: تسجيل دخول المشرف
- **العناصر**: Identifier field, Password field, Login button, Forgot password link
- **التحقق**: Email/phone format, Required fields
- **الأخطاء**: 401, 403, 429 handling

#### S05: SupervisorDashboard
- **الهدف**: نظرة عامة على الصفوف المسندة والنشاط اليومي
- **البيانات**: 
  - Assigned classes list
  - Recent behavior records
  - Active announcements
  - Quick stats
- **الإجراءات**: Quick access to main features
- **الحالات**: Empty (no classes), Loading, Error

#### S06-S11: Behavior Module
- **S06 Categories List**: عرض فئات السلوك المتاحة
- **S07 Records List**: قائمة السجلات السلوكية مع فلترة
- **S08 Create**: نموذج إنشاء سجل سلوكي جديد
- **S09 Detail**: عرض تفاصيل سجل سلوكي
- **S10 Edit**: تعديل سجل موجود
- **S11 Timeline**: الخط الزمني لسلوك طالب محدد

#### S12-S14: Attendance Module
- **S12 Sessions List**: قائمة جلسات الحضور للصفوف المسندة
- **S13 Session Detail**: تفاصيل جلسة مع قائمة الطلاب
- **S14 Update Record**: تحديث حالة حضور طالب

#### S15-S18: Reports Module
- **S15 Student Profile**: الملف الشامل للطالب
- **S16 Attendance Summary**: ملخص الحضور
- **S17 Assessment Summary**: ملخص التقييمات
- **S18 Behavior Summary**: ملخص السلوك

#### S19-S24: Communication Module
- **S19 Inbox**: صندوق الوارد
- **S20 Sent**: الرسائل المرسلة
- **S21 Conversation**: محادثة مع مستخدم
- **S22 Compose**: كتابة رسالة جديدة
- **S23 Notifications**: قائمة الإشعارات
- **S24 Announcements**: الإعلانات النشطة

#### S25-S29: Profile & Settings
- **S25 Profile**: معلومات المستخدم الحالي
- **S26 Change Password**: تغيير كلمة المرور
- **S27 Settings**: الإعدادات العامة
- **S28 Language**: اختيار اللغة (AR/EN)
- **S29 Theme**: اختيار الثيم (Light/Dark)

---

## 5. Navigation Architecture

### 5.1 Navigation Type: Hybrid (Bottom Navigation + Nested Navigation)

```dart
// Main Navigation Structure
AppShell (Stateful)
├── BottomNavigationBar (5 tabs)
│   ├── Dashboard Tab
│   ├── Behavior Tab
│   ├── Attendance Tab
│   ├── Messages Tab (with badge)
│   └── Profile Tab
├── Nested Navigator per tab
└── Global Overlay for modals
```

### 5.2 Routing Strategy

```dart
// Route naming convention
const routes = {
  // Auth
  '/login': LoginScreen,
  '/forgot-password': ForgotPasswordScreen,
  '/reset-password': ResetPasswordScreen,
  
  // Main
  '/dashboard': DashboardScreen,
  
  // Behavior
  '/behavior/categories': BehaviorCategoriesScreen,
  '/behavior/records': BehaviorRecordsScreen,
  '/behavior/records/create': CreateBehaviorRecordScreen,
  '/behavior/records/:id': BehaviorRecordDetailScreen,
  '/behavior/records/:id/edit': EditBehaviorRecordScreen,
  '/behavior/students/:studentId/timeline': StudentBehaviorTimelineScreen,
  
  // Attendance
  '/attendance/sessions': AttendanceSessionsScreen,
  '/attendance/sessions/:id': AttendanceSessionDetailScreen,
  '/attendance/records/:recordId/update': UpdateAttendanceRecordScreen,
  
  // Reports
  '/reports/students/:studentId': StudentProfileReportScreen,
  '/reports/students/:studentId/attendance': AttendanceSummaryScreen,
  '/reports/students/:studentId/assessment': AssessmentSummaryScreen,
  '/reports/students/:studentId/behavior': BehaviorSummaryScreen,
  
  // Communication
  '/messages/inbox': MessagesInboxScreen,
  '/messages/sent': MessagesSentScreen,
  '/messages/conversations/:otherUserId': ConversationDetailScreen,
  '/messages/compose': ComposeMessageScreen,
  '/messages/compose/:recipientId': ComposeMessageScreen,
  '/notifications': NotificationsScreen,
  '/announcements': AnnouncementsScreen,
  
  // Profile
  '/profile': ProfileScreen,
  '/profile/change-password': ChangePasswordScreen,
  '/settings': SettingsScreen,
  '/settings/language': LanguageSelectorScreen,
  '/settings/theme': ThemeSelectorScreen,
};
```

### 5.3 Deep Linking Readiness

```dart
// Future deep link patterns
const deepLinkPatterns = {
  'student_profile': '/reports/students/{studentId}',
  'behavior_record': '/behavior/records/{id}',
  'attendance_session': '/attendance/sessions/{id}',
  'conversation': '/messages/conversations/{otherUserId}',
  'notification': '/notifications?notificationId={id}',
};
```

### 5.4 Navigation Guards

```dart
// Auth Guard
class AuthGuard extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    final requiresAuth = route.settings.requiresAuth ?? true;
    if (requiresAuth && !AuthService.isAuthenticated) {
      navigator?.pushReplacementNamed('/login');
    }
  }
}

// Scope Guard (for student/class access)
class ScopeGuard {
  static Future<bool> canAccessStudent(String studentId) async {
    // Call backend to verify student is within supervisor's scope
    // Return false if 403/404
  }
}
```

### 5.5 Back Behavior

```dart
// Custom back button handling
PopScope(
  canPop: false,
  onPopInvoked: (didPop) async {
    if (!didPop) {
      // Confirm exit on dashboard
      if (currentRoute == '/dashboard') {
        final shouldExit = await showExitConfirmation();
        if (shouldExit) navigator?.pop();
      } else {
        navigator?.pop();
      }
    }
  },
  child: ...
)
```

---

## 6. تخطيط الشاشات التفصيلي

### 6.1 LoginScreen

```dart
LoginScreen Layout:
┌─────────────────────────────────────┐
│                                     │
│           [Logo]                    │
│         Ishraf Platform             │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Email or Phone              │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Password                    │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │         LOGIN               │   │
│  └─────────────────────────────┘   │
│                                     │
│      Forgot Password?               │
│                                     │
│  ───────── Language: AR/EN ──────── │
│                                     │
└─────────────────────────────────────┘

States:
- Initial: Empty fields, enabled login button
- Loading: Disabled form, loading indicator on button
- Error: Error message below fields
- Success: Navigate to dashboard

Validation:
- Identifier: Required, email or phone format
- Password: Required, min 8 characters

Error Handling:
- 401: "Invalid credentials"
- 403: "Account is not active"
- 429: "Too many attempts. Try again in X minutes"
```

### 6.2 SupervisorDashboard

```dart
Dashboard Layout:
┌─────────────────────────────────────┐
│ Header: Welcome, [Name]    [Profile]│
├─────────────────────────────────────┤
│ Quick Stats Row:                    │
│ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐   │
│ │Classes│ │Students│ │Behaviors│ │Today││
│ │  3   │ │  75   │ │  12   │ │  5  ││
│ └─────┘ └─────┘ └─────┘ └─────┘   │
├─────────────────────────────────────┤
│ My Classes                          │
│ ┌───────────────────────────────┐  │
│ │ Class 1-A    [View Details>] │  │
│ │ Class 2-B    [View Details>] │  │
│ │ Class 3-C    [View Details>] │  │
│ └───────────────────────────────┘  │
├─────────────────────────────────────┤
│ Recent Behavior Records             │
│ ┌───────────────────────────────┐  │
│ │ Ahmed M. - Positive - 2min   │  │
│ │ Sara K. - Negative - 15min   │  │
│ │ [View All>]                   │  │
│ └───────────────────────────────┘  │
├─────────────────────────────────────┤
│ Active Announcements                │
│ ┌───────────────────────────────┐  │
│ │ ⚠️ Important Notice           │  │
│ │ Meeting tomorrow at 10AM     │  │
│ └───────────────────────────────┘  │
└─────────────────────────────────────┘

Empty States:
- No classes: "No classes assigned yet. Contact admin."
- No behaviors: "No behavior records in the past 7 days"
- No announcements: "No active announcements"
```

### 6.3 BehaviorRecordsList

```dart
Behavior Records List Layout:
┌─────────────────────────────────────┐
│ [<Back] Behavior Records   [Filter]│
├─────────────────────────────────────┤
│ Search: [🔍 Search by student...]  │
│ Filters: [Class▼] [Type▼] [Date▼] │
├─────────────────────────────────────┤
│ [+ New Record]                      │
├─────────────────────────────────────┤
│ ┌───────────────────────────────┐  │
│ │ 📕 Ahmed Mohamed              │  │
│ │ Class: 1-A | Positive         │  │
│ │ Category: Participation       │  │
│ │ Date: Mar 30, 2024            │  │
│ │ Severity: ★☆☆☆☆              │  │
│ └───────────────────────────────┘  │
│ ┌───────────────────────────────┐  │
│ │ 📗 Sara Khalid                │  │
│ │ Class: 2-B | Negative         │  │
│ │ Category: Disruption          │  │
│ │ Date: Mar 29, 2024            │  │
│ │ Severity: ★★★☆☆              │  │
│ └───────────────────────────────┘  │
├─────────────────────────────────────┤
│ Pagination: < 1 2 3 >              │
└─────────────────────────────────────┘

Filter Options:
- Class: Multi-select from assigned classes
- Behavior Type: Positive/Negative/All
- Date Range: From/To date picker
- Severity: 1-5 stars range

Empty State:
"No behavior records found matching your filters"
```

### 6.4 CreateBehaviorRecord

```dart
Create Behavior Record Layout:
┌─────────────────────────────────────┐
│ [<Back] New Behavior Record        │
├─────────────────────────────────────┤
│                                     │
│ Student *                           │
│ ┌───────────────────────────────┐  │
│ │ Select Student        [▼]    │  │
│ └───────────────────────────────┘  │
│ (Filtered by assigned classes)     │
│                                     │
│ Category *                          │
│ ┌───────────────────────────────┐  │
│ │ Select Category       [▼]    │  │
│ └───────────────────────────────┘  │
│                                     │
│ Behavior Type *                     │
│ ○ Positive  ● Negative             │
│                                     │
│ Date *                              │
│ ┌───────────────────────────────┐  │
│ │ 📅 Mar 30, 2024       [📅]   │  │
│ └───────────────────────────────┘  │
│                                     │
│ Severity (1-5)                      │
│ ★★★★★                               │
│                                     │
│ Description                         │
│ ┌───────────────────────────────┐  │
│ │ Describe the behavior...      │  │
│ │                               │  │
│ │                               │  │
│ └───────────────────────────────┘  │
│                                     │
│ ┌───────────────────────────────┐  │
│ │         SAVE RECORD           │  │
│ └───────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘

Validation:
- Student: Required
- Category: Required
- Type: Required
- Date: Required, cannot be future
- Severity: Optional, default 3
- Description: Optional, max 500 chars

Success Action:
- Show confirmation snackbar
- Navigate back to records list
- Or "Add Another" option
```

### 6.5 AttendanceSessionsList

```dart
Attendance Sessions List Layout:
┌─────────────────────────────────────┐
│ [<Back] Attendance Sessions [Filter]│
├─────────────────────────────────────┤
│ Date: [📅 Today ▼]                  │
│ Class: [All Classes ▼]              │
├─────────────────────────────────────┤
│ ┌───────────────────────────────┐  │
│ │ Class 1-A - Math              │  │
│ │ Date: Mar 30, 2024 8:00 AM   │  │
│ │ Teacher: Mr. Ahmed            │  │
│ │ Present: 22/25                │  │
│ │ [View Details>]               │  │
│ └───────────────────────────────┘  │
│ ┌───────────────────────────────┐  │
│ │ Class 2-B - Science           │  │
│ │ Date: Mar 30, 2024 9:00 AM   │  │
│ │ Teacher: Ms. Fatima           │  │
│ │ Present: 20/23                │  │
│ │ [View Details>]               │  │
│ └───────────────────────────────┘  │
├─────────────────────────────────────┤
│ Pagination: < 1 2 3 >              │
└─────────────────────────────────────┘

Note: Supervisor cannot create sessions
Only view and update existing records
```

### 6.6 AttendanceSessionDetail

```dart
Attendance Session Detail Layout:
┌─────────────────────────────────────┐
│ [<Back] Class 1-A - Math           │
│        Mar 30, 2024 8:00 AM        │
├─────────────────────────────────────┤
│ Teacher: Mr. Ahmed                 │
│ Total Students: 25                 │
│ Present: 22 | Absent: 3            │
├─────────────────────────────────────┤
│ Student List                        │
│ ┌───────────────────────────────┐  │
│ │ ☑ Ahmed Mohamed      [Edit]  │  │
│ │    Status: Present            │  │
│ └───────────────────────────────┘  │
│ ┌───────────────────────────────┐  │
│ │ ☐ Sara Khalid        [Edit]  │  │
│ │    Status: Absent             │  │
│ │    Notes: No reason provided  │  │
│ └───────────────────────────────┘  │
│ ... (scrollable list)              │
└─────────────────────────────────────┘

Edit Action:
- Opens bottom sheet or dialog
- Change status: Present/Absent/Late/Excused
- Add/Edit notes
- Save triggers PATCH /attendance/records/:id
```

### 6.7 StudentProfileReport

```dart
Student Profile Report Layout:
┌─────────────────────────────────────┐
│ [<Back] Student Profile            │
├─────────────────────────────────────┤
│ ┌───────────────────────────────┐  │
│ │ [Avatar] Ahmed Mohamed        │  │
│ │ Class: 1-A                    │  │
│ │ Academic No: 2024001          │  │
│ │ Parents: Father, Mother       │  │
│ └───────────────────────────────┘  │
├─────────────────────────────────────┤
│ Tabs: [Overview] [Attendance]      │
│       [Assessments] [Behavior]     │
├─────────────────────────────────────┤
│ Overview Tab Content:               │
│ Quick Stats:                        │
│ Attendance Rate: 88%               │
│ Avg Assessment: 85%                │
│ Behavior Records: 5 (3 pos, 2 neg) │
└─────────────────────────────────────┘

Tab Navigation:
- Each tab loads corresponding summary endpoint
- Smooth transitions between tabs
- Maintain scroll position per tab
```

### 6.8 MessagesInbox

```dart
Messages Inbox Layout:
┌─────────────────────────────────────┐
│ [<Back] Inbox           [Compose+] │
├─────────────────────────────────────┤
│ Unread: 5                           │
├─────────────────────────────────────┤
│ ┌───────────────────────────────┐  │
│ │ ● Admin                       │  │
│ │ Meeting Reminder              │  │
│ │ Dear supervisors, please...   │  │
│ │ 10:30 AM • Unread             │  │
│ └───────────────────────────────┘  │
│ ┌───────────────────────────────┐  │
│ │ ○ Mr. Ahmed (Teacher)         │  │
│ │ Regarding student behavior    │  │
│ │ I wanted to inform you...     │  │
│ │ Yesterday • Read              │  │
│ └───────────────────────────────┘  │
├─────────────────────────────────────┤
│ Pagination: < 1 2 3 >              │
└─────────────────────────────────────┘

Actions:
- Tap: Open conversation
- Long press: Mark as read/unread, Delete
- Pull to refresh
```

---

## 7. استراتيجية العرض UI

### 7.1 Design Tokens

```dart
// Spacing Scale
Spacing: {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
}

// Typography Scale
Typography: {
  displayLarge: TextStyle(fontSize: 32, fontWeight: bold),
  displayMedium: TextStyle(fontSize: 28, fontWeight: bold),
  headlineLarge: TextStyle(fontSize: 24, fontWeight: w600),
  headlineMedium: TextStyle(fontSize: 20, fontWeight: w600),
  titleLarge: TextStyle(fontSize: 18, fontWeight: w600),
  titleMedium: TextStyle(fontSize: 16, fontWeight: w500),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: normal),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: normal),
  labelLarge: TextStyle(fontSize: 14, fontWeight: w500),
  labelMedium: TextStyle(fontSize: 12, fontWeight: w500),
}

// Border Radius
Radius: {
  sm: 4,
  md: 8,
  lg: 12,
  xl: 16,
  full: 999,
}

// Elevation
Elevation: {
  none: 0,
  sm: 1,
  md: 2,
  lg: 4,
  xl: 8,
}
```

### 7.2 Color Palette

```dart
// Primary Colors (Brand)
Primary: {
  main: #1976D2,
  light: #42A5F5,
  dark: #1565C0,
  contrast: #FFFFFF,
}

// Semantic Colors
Success: #4CAF50
Warning: #FF9800
Error: #F44336
Info: #2196F3

// Neutral Colors
Neutral: {
  0: #FFFFFF,
  50: #FAFAFA,
  100: #F5F5F5,
  200: #EEEEEE,
  300: #E0E0E0,
  400: #BDBDBD,
  500: #9E9E9E,
  600: #757575,
  700: #616161,
  800: #424242,
  900: #212121,
  1000: #000000,
}

// Behavior Colors
BehaviorPositive: #4CAF50
BehaviorNegative: #F44336

// Attendance Colors
AttendancePresent: #4CAF50
AttendanceAbsent: #F44336
AttendanceLate: #FF9800
AttendanceExcused: #2196F3
```

### 7.3 Component Library

```dart
// Reusable Components List
Components:
- AppButton (primary, secondary, text, icon)
- AppTextField (outlined, filled, underlined)
- AppCard (elevated, outlined, filled)
- AppChip (filter, action, input)
- AppAvatar (image, letter, icon)
- AppBadge (notification, status)
- AppDialog (confirm, alert, form)
- AppBottomSheet (action, form)
- AppSnackbar (info, success, error, warning)
- AppProgressBar (linear, circular)
- AppPagination
- AppEmptyState
- AppErrorState
- AppLoadingIndicator
- AppSearchBar
- AppFilterChip
- AppSegmentedControl
- AppRatingStars
- AppDateTimePicker
```

### 7.4 Layout Patterns

```dart
// Common Layout Patterns
Patterns:
1. List Pattern (most screens)
   - Header with title + actions
   - Search/Filter bar
   - Scrollable list content
   - Pagination footer

2. Detail Pattern
   - Header with back + title
   - Summary cards section
   - Tabbed content area
   - Action buttons (fixed bottom or inline)

3. Form Pattern
   - Header with back + title
   - Scrollable form content
   - Grouped fields with section headers
   - Validation messages inline
   - Submit button (sticky bottom)

4. Dashboard Pattern
   - Welcome header
   - Quick stats row
   - Section cards (scrollable)
   - Quick action FAB

5. Master-Detail Pattern
   - List on mobile (navigate to detail)
   - Split view on tablet
```

### 7.5 Responsive Behavior

```dart
// Breakpoints
Breakpoints: {
  phone: 0-599,
  tablet: 600-1023,
  desktop: 1024+,
}

// Adaptive Layouts
Adaptations:
- Phone: Single column, bottom nav
- Tablet: Two columns possible, navigation rail option
- Desktop: Consider web version with drawer nav

// Font Scaling
- Use MediaQuery.textScaler
- Support dynamic type sizes
- Minimum touch target: 48x48
```

---

## 8. استراتيجية الثيمين

### 8.1 Light Theme

```dart
LightThemeData:
brightness: Brightness.light
primaryColor: #1976D2
scaffoldBackgroundColor: #FAFAFA
surfaceColor: #FFFFFF
errorColor: #F44336

colorScheme: ColorScheme.light(
  primary: #1976D2,
  onPrimary: #FFFFFF,
  secondary: #03DAC6,
  onSecondary: #000000,
  surface: #FFFFFF,
  onSurface: #212121,
  error: #F44336,
  onError: #FFFFFF,
)

cardTheme: CardTheme(
  color: #FFFFFF,
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: 12),
)

appBarTheme: AppBarTheme(
  backgroundColor: #1976D2,
  foregroundColor: #FFFFFF,
  elevation: 2,
)

inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: #F5F5F5,
  border: OutlineInputBorder(borderRadius: 8),
)
```

### 8.2 Dark Theme

```dart
DarkThemeData:
brightness: Brightness.dark
primaryColor: #90CAF9
scaffoldBackgroundColor: #121212
surfaceColor: #1E1E1E
errorColor: #CF6679

colorScheme: ColorScheme.dark(
  primary: #90CAF9,
  onPrimary: #000000,
  secondary: #03DAC6,
  onSecondary: #000000,
  surface: #1E1E1E,
  onSurface: #E0E0E0,
  error: #CF6679,
  onError: #000000,
)

cardTheme: CardTheme(
  color: #1E1E1E,
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: 12),
)

appBarTheme: AppBarTheme(
  backgroundColor: #1E1E1E,
  foregroundColor: #E0E0E0,
  elevation: 0,
)

inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: #2C2C2C,
  border: OutlineInputBorder(borderRadius: 8),
)
```

### 8.3 Theme Switching Implementation

```dart
// Theme Provider
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    // Persist to SharedPreferences
  }
  
  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

// Theme Persistence
class ThemeStorage {
  static const String _key = 'theme_mode';
  
  static Future<ThemeMode> load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    return ThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeMode.system,
    );
  }
  
  static Future<void> save(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }
}
```

### 8.4 Surface Levels (Dark Theme)

```dart
// Elevation overlays for dark theme
Dark Theme Surface Levels:
Level 0: #121212 (base)
Level 1: #1E1E1E (+8% white overlay)
Level 2: #2C2C2C (+12% white overlay)
Level 3: #3A3A3A (+16% white overlay)
Level 4: #484848 (+20% white overlay)

Usage:
- Level 0: Scaffold background
- Level 1: Cards, dialogs
- Level 2: Elevated components
- Level 3: Modal sheets
- Level 4: Floating elements
```

### 8.5 Text Contrast Rules

```dart
// WCAG AA Compliance (minimum 4.5:1 for normal text)
Light Theme:
- Primary text on white: #212121 (contrast: 16.1:1) ✓
- Secondary text on white: #757575 (contrast: 4.6:1) ✓
- Primary text on primary: #FFFFFF on #1976D2 (contrast: 4.5:1) ✓

Dark Theme:
- Primary text on dark: #E0E0E0 on #121212 (contrast: 12.6:1) ✓
- Secondary text on dark: #BDBDBD on #121212 (contrast: 8.2:1) ✓
- Primary text on primary: #000000 on #90CAF9 (contrast: 8.4:1) ✓
```

---

## 9. استراتيجية اللغتين

### 9.1 Localization Setup

```dart
// Supported Locales
supportedLocales: [
  Locale('ar'), // Arabic (RTL)
  Locale('en'), // English (LTR)
]

// Localization Delegate
delegate: AppLocalizationDelegate(
  supportedLocales: supportedLocales,
)
```

### 9.2 Localization Keys Structure

```dart
// Hierarchical key structure
localizationKeys = {
  // Auth
  'auth.login.title': {
    'ar': 'تسجيل الدخول',
    'en': 'Login',
  },
  'auth.login.identifier.hint': {
    'ar': 'البريد الإلكتروني أو الهاتف',
    'en': 'Email or Phone',
  },
  'auth.login.password.hint': {
    'ar': 'كلمة المرور',
    'en': 'Password',
  },
  
  // Navigation
  'nav.dashboard': {
    'ar': 'الرئيسية',
    'en': 'Dashboard',
  },
  'nav.behavior': {
    'ar': 'السلوك',
    'en': 'Behavior',
  },
  'nav.attendance': {
    'ar': 'الحضور',
    'en': 'Attendance',
  },
  'nav.messages': {
    'ar': 'الرسائل',
    'en': 'Messages',
  },
  'nav.profile': {
    'ar': 'الملف الشخصي',
    'en': 'Profile',
  },
  
  // Behavior
  'behavior.record.create': {
    'ar': 'تسجيل سلوك جديد',
    'en': 'New Behavior Record',
  },
  'behavior.type.positive': {
    'ar': 'إيجابي',
    'en': 'Positive',
  },
  'behavior.type.negative': {
    'ar': 'سلبي',
    'en': 'Negative',
  },
  
  // Attendance
  'attendance.status.present': {
    'ar': 'حاضر',
    'en': 'Present',
  },
  'attendance.status.absent': {
    'ar': 'غائب',
    'en': 'Absent',
  },
  'attendance.status.late': {
    'ar': 'متأخر',
    'en': 'Late',
  },
  'attendance.status.excused': {
    'ar': 'بعذر',
    'en': 'Excused',
  },
  
  // Common
  'common.save': {
    'ar': 'حفظ',
    'en': 'Save',
  },
  'common.cancel': {
    'ar': 'إلغاء',
    'en': 'Cancel',
  },
  'common.delete': {
    'ar': 'حذف',
    'en': 'Delete',
  },
  'common.edit': {
    'ar': 'تعديل',
    'en': 'Edit',
  },
  'common.loading': {
    'ar': 'جاري التحميل...',
    'en': 'Loading...',
  },
  'common.error': {
    'ar': 'حدث خطأ',
    'en': 'An error occurred',
  },
  'common.empty': {
    'ar': 'لا توجد بيانات',
    'en': 'No data available',
  },
}
```

### 9.3 RTL Support

```dart
// MaterialApp configuration
MaterialApp(
  locale: currentLocale,
  localizationsDelegates: [
    AppLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: supportedLocales,
  builder: (context, child) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: child!,
    );
  },
)

// RTL-aware widgets
Row(
  children: [
    Icon(Icons.arrow_back), // Automatically flips in RTL
    Text(context.loc.general.back),
  ],
)

// Using directional icons
Icon(
  Directionality.of(context) == TextDirection.rtl
      ? Icons.arrow_forward
      : Icons.arrow_back,
)
```

### 9.4 Layout Mirroring

```dart
// Padding/Margin awareness
Padding(
  padding: EdgeInsetsDirectional.only(
    start: 16, // Right in LTR, Left in RTL
    end: 8,
  ),
  child: ...
)

// Alignment awareness
Align(
  alignment: AlignmentDirectional.centerStart,
  child: ...
)

// Icon mirroring for directional actions
Transform.flip(
  flipX: Directionality.of(context) == TextDirection.rtl,
  child: Icon(Icons.arrow_forward),
)
```

### 9.5 Text Expansion Handling

```dart
// Allow text to expand naturally
Text(
  context.loc.auth.login.title,
  maxLines: null, // Allow wrapping
  overflow: TextOverflow.visible,
)

// Button sizing
SizedBox(
  width: double.infinity, // Full width for RTL safety
  child: ElevatedButton(
    child: Text(context.loc.common.save),
  ),
)

// Avoid hardcoded widths
Container(
  constraints: BoxConstraints(
    minWidth: 100,
    maxWidth: double.infinity,
  ),
)
```

### 9.6 Date & Number Formatting

```dart
// Date formatting per locale
class DateFormatter {
  static String formatDate(DateTime date, Locale locale) {
    if (locale.languageCode == 'ar') {
      return DateFormat('dd MMMM yyyy', 'ar').format(date);
      // Output: ٣٠ مارس ٢٠٢٤
    } else {
      return DateFormat('MMMM dd, yyyy').format(date);
      // Output: March 30, 2024
    }
  }
  
  static String formatTime(DateTime time, Locale locale) {
    if (locale.languageCode == 'ar') {
      return DateFormat('hh:mm a', 'ar').format(time);
      // Output: ١٠:٣٠ ص
    } else {
      return DateFormat('hh:mm a').format(time);
      // Output: 10:30 AM
    }
  }
}

// Number formatting
class NumberFormatter {
  static String formatNumber(num number, Locale locale) {
    if (locale.languageCode == 'ar') {
      return NumberFormat.decimalPattern('ar').format(number);
      // Output: ١,٢٣٤
    } else {
      return NumberFormat.decimalPattern().format(number);
      // Output: 1,234
    }
  }
  
  static String formatPercentage(double value, Locale locale) {
    if (locale.languageCode == 'ar') {
      return NumberFormat.percentPattern('ar').format(value);
      // Output: ٨٥٪
    } else {
      return NumberFormat.percentPattern().format(value);
      // Output: 85%
    }
  }
}
```

### 9.7 Localization Persistence

```dart
class LocaleStorage {
  static const String _key = 'app_locale';
  
  static Future<Locale?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getString(_key);
    if (localeString != null) {
      final parts = localeString.split('_');
      return Locale(parts[0], parts.length > 1 ? parts[1] : '');
    }
    return null; // Use system locale
  }
  
  static Future<void> save(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.toString());
  }
}
```

---

## 10. تقسيم وحدات التطبيق

### 10.1 Feature Modules

```
Module Structure:
lib/
├── features/
│   ├── auth/
│   ├── dashboard/
│   ├── behavior/
│   ├── attendance/
│   ├── reports/
│   ├── communication/
│   └── profile/
```

### 10.2 Module Details

#### Module 1: Auth
| الخاصية | الوصف |
|---------|-------|
| **الهدف** | إدارة المصادقة والجلسات |
| **الشاشات** | Login, ForgotPassword, ResetPassword |
| **الوظائف** | Login, Logout, Refresh token, Change password |
| **البيانات** | User info, Tokens |
| **الاعتماديات** | None (core module) |
| **المخاطر** | Token expiration, Rate limiting |
| **الأولوية** | P0 (Must have first) |

#### Module 2: Dashboard
| الخاصية | الوصف |
|---------|-------|
| **الهدف** | نظرة عامة سريعة |
| **الشاشات** | Dashboard home, Announcements feed |
| **الوظائف** | Display stats, Quick actions, View announcements |
| **البيانات** | `/reporting/dashboards/supervisor/me` |
| **الاعتماديات** | Auth module |
| **المخاطر** | Empty state when no classes assigned |
| **الأولوية** | P0 |

#### Module 3: Behavior
| الخاصية | الوصف |
|---------|-------|
| **الهدف** | إدارة السجلات السلوكية |
| **الشاشات** | Categories, Records list, Create, Detail, Edit, Timeline |
| **الوظائف** | CRUD operations, Filter, Search |
| **البيانات** | `/behavior/*` endpoints |
| **الاعتماديات** | Auth, Student selection |
| **المخاطر** | Scope failures for non-assigned students |
| **الأولوية** | P0 |

#### Module 4: Attendance
| الخاصية | الوصف |
|---------|-------|
| **الهدف** | مراجعة الحضور وتصحيحه |
| **الشاشات** | Sessions list, Session detail, Update record |
| **الوظائف** | View sessions, Update attendance status |
| **البيانات** | `/attendance/*` endpoints |
| **الاعتماديات** | Auth module |
| **المخاطر** | Cannot create sessions (by design) |
| **الأولوية** | P0 |

#### Module 5: Reports
| الخاصية | الوصف |
|---------|-------|
| **الهدف** | تقارير الطلاب الشاملة |
| **الشاشات** | Student profile, Attendance/Assessment/Behavior summaries |
| **الوظائف** | View reports, Tab navigation |
| **البيانات** | `/reporting/students/:id/*` endpoints |
| **الاعتمداتيات** | Auth, Student scope validation |
| **المخاطر** | 403/404 for out-of-scope students |
| **الأولوية** | P1 |

#### Module 6: Communication
| الخاصية | الوصف |
|---------|-------|
| **الهدف** | الرسائل والإشعارات |
| **الشاشات** | Inbox, Sent, Conversation, Compose, Notifications |
| **الوظائف** | Send/receive messages, Mark read, View notifications |
| **البيانات** | `/communication/*` endpoints |
| **الاعتماديات** | Auth, Recipients endpoint |
| **المخاطر** | Large message lists need pagination |
| **الأولوية** | P1 |

#### Module 7: Profile & Settings
| الخاصية | الوصف |
|---------|-------|
| **الهدف** | إدارة الحساب والإعدادات |
| **الشاشات** | Profile, Change password, Settings, Language, Theme |
| **الوظائف** | View profile, Change password, Toggle theme/language |
| **البيانات** | `/auth/me`, `/auth/change-password` |
| **الاعتماديات** | Auth module |
| **المخاطر** | Password change requires re-login |
| **الأولوية** | P1 |

---

## 11. مراحل البناء

### Phase 1: Foundation & Auth
**الرقم**: 1  
**الاسم**: الأساس والمصادقة  
**الهدف**: بناء البنية التحتية وتدفق المصادقة  

**الشاشات**:
- SplashScreen
- LoginScreen
- ForgotPasswordScreen
- ResetPasswordScreen

**Widgets المطلوبة**:
- AppButton
- AppTextField
- AppLoadingIndicator
- AppSnackbar
- AppDialog

**Navigation implementation**:
- Named routes setup
- Auth guard
- Route observers

**State management**:
- Provider setup
- AuthProvider (login, logout, refresh)
- ThemeProvider
- LocaleProvider

**Models**:
- User
- LoginRequest
- LoginResponse
- TokenPair
- ErrorResponse

**Services**:
- ApiService (HTTP client)
- AuthService (auth operations)
- StorageService (secure storage)

**Theme support**: ✅ Full implementation  
**Localization support**: ✅ AR/EN setup  

**المخاطر**:
- Rate limiting on login (429)
- Token refresh edge cases
- Secure storage platform differences

**معايير القبول**:
- [ ] Login success navigates to dashboard
- [ ] Invalid credentials shows proper error
- [ ] Token refresh works seamlessly
- [ ] Logout clears all data
- [ ] Forgot/reset password flows complete

**Definition of Done**:
- All screens implemented
- All states handled (loading, error, empty, success)
- Unit tests for services
- Integration tests for auth flow
- AR/EN localization complete
- Light/Dark theme working

---

### Phase 2: App Shell & Dashboard
**الرقم**: 2  
**الاسم**: الهيكل الرئيسي واللوحة  
**الهدف**: بناء واجهة التنقل والشاشة الرئيسية  

**الشاشات**:
- AppShell (with BottomNavigation)
- SupervisorDashboard
- ActiveAnnouncements

**Widgets المطلوبة**:
- AppBottomNavigation
- AppCard
- AppAvatar
- AppBadge
- AppEmptyState
- StatsCard
- ClassListItem
- AnnouncementCard

**Navigation implementation**:
- Bottom navigation with 5 tabs
- Nested navigators per tab
- Deep linking preparation

**State management**:
- DashboardProvider
- AnnouncementProvider

**Models**:
- DashboardData
- ClassSummary
- BehaviorRecordPreview
- Announcement

**Services**:
- DashboardService
- AnnouncementService

**Theme support**: ✅ Apply to all new components  
**Localization support**: ✅ All keys translated  

**المخاطر**:
- Empty state when no classes assigned
- Dashboard endpoint may return minimal data initially

**معايير القبول**:
- [ ] Bottom navigation switches tabs correctly
- [ ] Dashboard displays assigned classes
- [ ] Announcements feed shows active items
- [ ] Quick stats calculated correctly
- [ ] Navigation to detail screens works

**Definition of Done**:
- App shell responsive
- All dashboard sections implemented
- Empty states designed
- Pull-to-refresh implemented
- Badge notifications on messages tab

---

### Phase 3: Behavior Module
**الرقم**: 3  
**الاسم**: وحدة السلوك  
**الهدف**: إدارة كاملة للسجلات السلوكية  

**الشاشات**:
- BehaviorCategoriesList
- BehaviorRecordsList
- CreateBehaviorRecord
- BehaviorRecordDetail
- EditBehaviorRecord
- StudentBehaviorTimeline

**Widgets المطلوبة**:
- BehaviorCategoryCard
- BehaviorRecordCard
- StarRating
- BehaviorTypeSelector
- StudentSelector
- DateTimeSelector
- FilterBar

**Navigation implementation**:
- Push/pop for detail screens
- Modal bottom sheet for create/edit
- Filter modal

**State management**:
- BehaviorProvider (CRUD operations)
- FilterState

**Models**:
- BehaviorCategory
- BehaviorRecord
- BehaviorRecordRequest
- BehaviorSummary

**Services**:
- BehaviorService

**Theme support**: ✅ Behavior-specific colors  
**Localization support**: ✅ All behavior terms  

**المخاطر**:
- Scope failures for non-assigned students
- Category list may be empty
- Form validation complexity

**معايير القبول**:
- [ ] Categories list displays correctly
- [ ] Records list with pagination
- [ ] Create record validates and submits
- [ ] Edit record pre-fills data
- [ ] Student timeline shows history
- [ ] Filters work correctly

**Definition of Done**:
- Full CRUD implemented
- All form validations
- Proper error handling
- Scope enforcement verified
- Empty states for all lists

---

### Phase 4: Attendance Module
**الرقم**: 4  
**الاسم**: وحدة الحضور  
**الهدف**: مراجعة وتصحيح سجلات الحضور  

**الشاشات**:
- AttendanceSessionsList
- AttendanceSessionDetail
- UpdateAttendanceRecord

**Widgets المطلوبة**:
- AttendanceSessionCard
- StudentAttendanceRow
- AttendanceStatusChip
- AttendanceEditor (bottom sheet)

**Navigation implementation**:
- List to detail navigation
- Bottom sheet for quick edit

**State management**:
- AttendanceProvider

**Models**:
- AttendanceSession
- AttendanceRecord
- UpdateAttendanceRequest

**Services**:
- AttendanceService

**Theme support**: ✅ Attendance status colors  
**Localization support**: ✅ All status terms  

**المخاطر**:
- Cannot create sessions (expected)
- Session may have many students (performance)

**معايير القبول**:
- [ ] Sessions list with filters
- [ ] Session detail shows roster
- [ ] Update record changes status
- [ ] Notes can be added/edited
- [ ] Changes reflect immediately

**Definition of Done**:
- Read/update flow complete
- Bulk status indication visible
- Proper date filtering
- Performance optimized for large rosters

---

### Phase 5: Reports Module
**الرقم**: 5  
**الاسم**: وحدة التقارير  
**الهدف**: عرض تقارير الطلاب الشاملة  

**الشاشات**:
- StudentProfileReport
- AttendanceSummaryReport
- AssessmentSummaryReport
- BehaviorSummaryReport

**Widgets المطلوبة**:
- StudentProfileHeader
- ReportTabs
- StatCard
- ProgressBar
- ChartWidget (simple)
- ParentInfoCard

**Navigation implementation**:
- Tab navigation within profile
- Deep link to specific student

**State management**:
- ReportProvider
- StudentCache

**Models**:
- StudentProfile
- AttendanceSummary
- AssessmentSummary
- BehaviorSummary

**Services**:
- ReportingService

**Theme support**: ✅ Report visualization colors  
**Localization support**: ✅ All report labels  

**المخاطر**:
- Scope validation critical
- Empty reports when no data
- Multiple API calls per profile

**معايير القبول**:
- [ ] Student search/selection works
- [ ] Profile displays all sections
- [ ] Each tab loads correct data
- [ ] Zero-safe summaries displayed
- [ ] Parent information shown

**Definition of Done**:
- All four report types implemented
- Tab switching smooth
- Loading states per tab
- Error handling per endpoint
- Scope enforcement tested

---

### Phase 6: Communication Module
**الرقم**: 6  
**الاسم**: وحدة التواصل  
**الهدف**: الرسائل والإشعارات الكاملة  

**الشاشات**:
- MessagesInbox
- MessagesSent
- ConversationDetail
- ComposeMessage
- NotificationsList

**Widgets المطلوبة**:
- MessageCard
- ConversationListItem
- MessageBubble
- RecipientSelector
- NotificationCard
- UnreadBadge

**Navigation implementation**:
- Conversation push navigation
- Compose as modal
- Notification tap navigation

**State management**:
- MessagesProvider
- NotificationsProvider

**Models**:
- Message
- Conversation
- Notification
- Recipient

**Services**:
- CommunicationService

**Theme support**: ✅ Message bubble theming  
**Localization support**: ✅ All communication terms  

**المخاطر**:
- Pagination for large message lists
- Real-time updates not available (Wave 1)
- Recipient list may be large

**معايير القبول**:
- [ ] Inbox shows messages with read state
- [ ] Sent folder displays sent messages
- [ ] Conversation shows chronological messages
- [ ] Compose allows recipient selection
- [ ] Notifications list with mark as read
- [ ] Unread counts accurate

**Definition of Done**:
- Full messaging flow
- Pagination implemented
- Mark as read functionality
- Pull-to-refresh on all lists
- Badge counts update

---

### Phase 7: Profile & Settings
**الرقم**: 7  
**الاسم**: الملف الشخصي والإعدادات  
**الهدف**: إدارة الحساب والتفضيلات  

**الشاشات**:
- UserProfile
- ChangePassword
- Settings
- LanguageSelector
- ThemeSelector

**Widgets المطلوبة**:
- ProfileHeader
- SettingItem
- LanguageOption
- ThemePreview
- PasswordForm

**Navigation implementation**:
- Settings as nested section
- Modal for language/theme

**State management**:
- ProfileProvider
- SettingsProvider (theme, locale)

**Models**:
- UserProfile
- ChangePasswordRequest

**Services**:
- ProfileService
- SettingsService

**Theme support**: ✅ Theme switching live  
**Localization support**: ✅ Language switching live  

**المخاطر**:
- Password change invalidates tokens
- Language switch requires rebuild

**معايير القبول**:
- [ ] Profile displays user info
- [ ] Change password validates and updates
- [ ] Language switch persists
- [ ] Theme switch persists
- [ ] Logout confirms and clears

**Definition of Done**:
- All settings functional
- Persistence verified
- Re-login after password change
- System theme detection option

---

## 12. المعمارية المقترحة

### 12.1 Folder Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   └── storage_keys.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── api_interceptor.dart
│   │   └── network_info.dart
│   ├── routing/
│   │   ├── app_router.dart
│   │   ├── route_names.dart
│   │   └── route_guards.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── theme_colors.dart
│   │   └── theme_typography.dart
│   ├── localization/
│   │   ├── app_localizations.dart
│   │   ├── app_localizations_ar.dart
│   │   └── app_localizations_en.dart
│   ├── utils/
│   │   ├── date_formatter.dart
│   │   ├── validators.dart
│   │   └── extensions.dart
│   └── widgets/
│       ├── app_button.dart
│       ├── app_text_field.dart
│       ├── app_card.dart
│       ├── app_loading.dart
│       ├── app_error.dart
│       ├── app_empty.dart
│       ├── app_snackbar.dart
│       └── app_dialog.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── login_request_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       ├── logout_usecase.dart
│   │   │       └── refresh_token_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_provider.dart
│   │       ├── screens/
│   │       │   ├── login_screen.dart
│   │       │   ├── forgot_password_screen.dart
│   │       │   └── reset_password_screen.dart
│   │       └── widgets/
│   │           └── login_form.dart
│   ├── dashboard/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── behavior/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── attendance/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── reports/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── communication/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── profile/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── injection_container.dart
└── config/
    ├── flavor_config.dart
    └── environment_config.dart
```

### 12.2 Architecture Pattern: Clean Architecture + Provider

```
Layers:
1. Presentation Layer (UI + State Management)
   - Screens (full pages)
   - Widgets (reusable components)
   - Providers (state management)

2. Domain Layer (Business Logic)
   - Entities (pure business objects)
   - Repositories (interfaces)
   - Use Cases (business rules)

3. Data Layer (Data Sources)
   - Models (DTOs with JSON serialization)
   - Data Sources (remote/local)
   - Repository Implementations
```

### 12.3 State Management: Provider

```dart
// Provider setup with multi-provider
class AppProviders {
  static List<SingleChildWidget> get providers => [
    // Core
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => LocaleProvider()),
    
    // Features
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => DashboardProvider()),
    ChangeNotifierProvider(create: (_) => BehaviorProvider()),
    ChangeNotifierProvider(create: (_) => AttendanceProvider()),
    ChangeNotifierProvider(create: (_) => ReportProvider()),
    ChangeNotifierProvider(create: (_) => MessagesProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
  ];
}

// Example Provider implementation
class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;
  final StorageService _storage;
  
  User? _user;
  bool _isLoading = false;
  String? _error;
  
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  
  AuthProvider(this._repository, this._storage);
  
  Future<bool> login(String identifier, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final result = await _repository.login(
        LoginRequest(identifier: identifier, password: password),
      );
      
      result.fold(
        (failure) {
          _error = _mapFailureToMessage(failure);
          _isLoading = false;
        },
        (response) async {
          _user = response.user;
          await _storage.saveTokens(response.tokens);
          _isLoading = false;
        },
      );
      
      notifyListeners();
      return _error == null;
    } catch (e) {
      _error = 'Unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<void> logout() async {
    await _repository.logout();
    await _storage.clearTokens();
    _user = null;
    notifyListeners();
  }
}
```

### 12.4 Navigation System: GoRouter

```dart
// Router configuration
final GoRouter router = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: (p0) => true,
  redirect: (context, state) {
    final authService = context.read<AuthProvider>();
    final isLoggedIn = authService.isAuthenticated;
    final isOnAuthRoute = state.matchedLocation.startsWith('/login') ||
                          state.matchedLocation.startsWith('/forgot') ||
                          state.matchedLocation.startsWith('/reset');
    
    if (!isLoggedIn && !isOnAuthRoute) {
      return '/login';
    }
    
    if (isLoggedIn && isOnAuthRoute) {
      return '/dashboard';
    }
    
    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      name: RouteNames.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder: (context, state) => LoginScreen(),
    ),
    // ... more routes
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          name: RouteNames.dashboard,
          builder: (context, state) => DashboardScreen(),
        ),
        // ... nested routes
      ],
    ),
  ],
);
```

### 12.5 Theme System

```dart
// Centralized theme configuration
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      // ... full theme configuration
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      // ... full theme configuration
    );
  }
}
```

### 12.6 Localization System

```dart
// Localization delegate
class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();
  
  @override
  bool isSupported(Locale locale) => 
      ['en', 'ar'].contains(locale.languageCode);
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }
  
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}

// Usage in widgets
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
    return Column(
      children: [
        Text(loc.authLoginTitle),
        TextField(
          decoration: InputDecoration(
            hintText: loc.authLoginIdentifierHint,
          ),
        ),
      ],
    );
  }
}
```

### 12.7 Design Tokens

```dart
// Centralized design tokens
class AppTokens {
  // Spacing
  static const spacing = {
    'xs': 4.0,
    'sm': 8.0,
    'md': 16.0,
    'lg': 24.0,
    'xl': 32.0,
    'xxl': 48.0,
  };
  
  // Border radius
  static const radius = {
    'sm': 4.0,
    'md': 8.0,
    'lg': 12.0,
    'xl': 16.0,
    'full': 999.0,
  };
  
  // Elevation
  static const elevation = {
    'none': 0.0,
    'sm': 1.0,
    'md': 2.0,
    'lg': 4.0,
    'xl': 8.0,
  };
  
  // Animation durations
  static const duration = {
    'instant': Duration(milliseconds: 0),
    'fast': Duration(milliseconds: 150),
    'normal': Duration(milliseconds: 300),
    'slow': Duration(milliseconds: 500),
  };
}
```

### 12.8 Reusable Components Strategy

```dart
// Component creation rules:
// 1. Any widget used 2+ times becomes reusable
// 2. Props should be minimal and focused
// 3. Styling via theme, not hardcoded
// 4. Support all states (loading, error, empty, success)

// Example: AppButton
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType type; // primary, secondary, text
  final ButtonSize size; // small, medium, large
  
  const AppButton({
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.type = ButtonType.primary,
    this.size = ButtonType.medium,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getStyle(context),
        child: isLoading
            ? AppLoadingIndicator(size: Size.small, color: Colors.white)
            : Text(text),
      ),
    );
  }
}
```

---

## 13. استراتيجية التنفيذ النهائية

### 13.1 مبدأ التنفيذ

```
القاعدة الذهبية: "الأساس أولاً، ثم الميزات"

1. لا تنتقل لشاشة جديدة قبل اكتمال السابقة
2. اختبر كل حالة (loading, error, empty, success)
3. وثّق كل قرار معماري
4. راجع الكود قبل الانتقال للمرحلة التالية
```

### 13.2 معايير الجودة لكل مرحلة

```dart
Quality Checklist:
□ All screens implemented per spec
□ All states handled (loading, error, empty, success)
□ Theme support (light/dark)
□ Localization (AR/EN)
□ RTL layout correct
□ Error messages user-friendly
□ API integration complete
□ Unit tests for business logic
□ Widget tests for UI components
□ Integration tests for critical flows
□ Performance acceptable (< 3s screen load)
□ Accessibility (font scaling, contrast)
□ Documentation updated
```

### 13.3 استراتيجية الاختبار

```dart
Testing Pyramid:

1. Unit Tests (70%)
   - Use cases
   - Repositories
   - Providers (business logic)
   - Utilities

2. Widget Tests (20%)
   - Reusable components
   - Screen layouts
   - State changes

3. Integration Tests (10%)
   - Auth flow
   - Critical user journeys
   - API integration
```

### 13.4 استراتيجية النشر

```
Deployment Stages:

Stage 1: Development
- Local testing
- Mock API responses
- Hot reload development

Stage 2: Staging
- Connect to staging backend
- Full integration testing
- QA verification

Stage 3: Production
- Production backend
- Monitoring enabled
- Gradual rollout
```

### 13.5 المراقبة والتحسين

```dart
Monitoring Points:
- API response times
- Error rates per endpoint
- Screen load times
- User session duration
- Feature usage analytics

Continuous Improvement:
- Weekly code reviews
- Bi-weekly performance audits
- Monthly dependency updates
- Quarterly architecture review
```

### 13.6 المخاطر والتخفيف

| الخطر | الاحتمال | التأثير | خطة التخفيف |
|-------|---------|---------|-------------|
| تغييرات API | متوسط | عالي | Abstract API layer, versioning |
| مشاكل الأداء | منخفض | متوسط | Lazy loading, pagination, caching |
| تعقيد الحالة | متوسط | متوسط | Clear state boundaries, documentation |
| تأخير الباك إند | منخفض | عالي | Mock services, parallel development |
| مشاكل RTL | منخفض | متوسط | Early RTL testing, automated checks |

---

## خاتمة

هذا المخطط يمثل blueprint كامل لبناء تطبيق المشرف باستخدام Flutter، مع التركيز على:

1. **تجربة المستخدم**: تقليل التعقيد، وضوح التنقل، حالات واضحة
2. **الجودة التقنية**: Clean Architecture، اختبار شامل، كود قابل للصيانة
3. **الدعم الكامل**: لغتين (AR/EN)، ثيمين (Light/Dark)، RTL
4. **الواقعية**: مبني على عقود API حقيقية،.Scope enforcement، حالات فارغة

الالتزام بهذا المخطط يضمن بناء تطبيق إنتاجي حقيقي قابل للنمو والصيانة.
