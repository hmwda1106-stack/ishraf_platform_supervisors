# Verification Gaps

هذا الملف يسجل فقط المناطق التي لا يمكن توثيقها بالكامل دون تخمين. وجود gap هنا لا يعني أن endpoint غير مستخدمة؛ بل يعني أن واحدًا من المصادر الأربعة لا يقدّم عقدًا صريحًا بما يكفي لكل تفصيل مطلوب.

## Partial Schema Precision Gaps

### `POST /students` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/students/CreateStudentPage.tsx:185`

### `PATCH /students/{id}` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/students/StudentDetailPage.tsx:255`

### `POST /students/{id}/parents` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/students/student-workflows.ts:157`

### `POST /students/{id}/promotions` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/students/StudentDetailPage.tsx:323`

### `PATCH /attendance/records/{attendanceId}` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx:70`

### `POST /attendance/sessions` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:157`

### `PUT /attendance/sessions/{id}/records` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx:59`

### `POST /assessments` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:178`

### `PUT /assessments/{id}/scores` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx:67`

### `PATCH /assessments/scores/{studentAssessmentId}` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx:78`

### `POST /assessments/types` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/assessments/AssessmentTypesPage.tsx:30`

### `POST /behavior/categories` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/behavior/BehaviorCategoriesPage.tsx:34`

### `POST /behavior/records` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:293`

### `PATCH /behavior/records/{id}` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx:65`

### `POST /homework` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/homework/HomeworkListPage.tsx:156`

### `PUT /homework/{id}/submissions` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/homework/HomeworkDetailPage.tsx:51`

### `POST /transport/assignments` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:110`

### `PATCH /transport/assignments/{id}/deactivate` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:134`

### `POST /transport/buses` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/BusesPage.tsx:130`

### `POST /transport/route-assignments` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx:102`

### `PATCH /transport/route-assignments/{id}/deactivate` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx:117`

### `POST /transport/routes` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/RoutesPage.tsx:44`

### `POST /transport/routes/{routeId}/stops` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/RouteDetailPage.tsx:61`

### `PUT /transport/students/{studentId}/home-location` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/students/CreateStudentPage.tsx:240`, `admin-dashboard/src/features/students/StudentHomeLocationSection.tsx:106`

### `POST /transport/trips` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/TripsListPage.tsx:72`

### `POST /transport/trips/{id}/events` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/TripDetailPage.tsx:113`

### `POST /transport/trips/{id}/locations` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/transport/TripDetailPage.tsx:98`

### `POST /communication/announcements` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/communication/AnnouncementsPage.tsx:51`

### `POST /communication/messages` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/communication/ConversationPage.tsx:57`, `admin-dashboard/src/features/communication/InboxPage.tsx:57`

### `POST /communication/notifications` — request body
- OpenAPI request schema مفتوحة؛ الحقول موثقة من examples فقط، لذلك required/optional غير محسوم بالكامل.
- callsites: `admin-dashboard/src/features/communication/NotificationsPage.tsx:76`
