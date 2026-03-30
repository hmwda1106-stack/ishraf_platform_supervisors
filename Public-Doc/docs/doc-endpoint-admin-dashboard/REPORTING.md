# Reporting

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Reporting**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `GET /reporting/dashboards/admin/me`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: dashboard home
- `admin-dashboard/src/features/dashboard/DashboardPage.tsx:239` (route /dashboard) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Admin Dashboard
- OpenAPI description: Return the admin dashboard surface. Allowed roles: admin.
- ENDPOINT_MAP purpose: admin dashboard

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- Postman request note: Purpose: Return the admin dashboard surface. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: primary landing endpoint

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `summary.totalUsers` | `number` | unknown | — | — | response.data example |
| `summary.totalStudents` | `number` | unknown | — | — | response.data example |
| `summary.activeTrips` | `number` | unknown | — | — | response.data example |
| `summary.unreadNotifications` | `number` | unknown | — | — | response.data example |
| `recentStudents` | `array` | unknown | — | — | response.data example |
| `recentStudents[].id` | `string` | unknown | — | — | response.data example |
| `recentStudents[].academicNo` | `string` | unknown | — | — | response.data example |
| `recentStudents[].fullName` | `string` | unknown | — | — | response.data example |
| `activeTrips` | `array` | unknown | — | — | response.data example |
| `activeTrips[].id` | `string` | unknown | — | — | response.data example |
| `activeTrips[].routeName` | `string` | unknown | — | — | response.data example |
| `activeTrips[].tripStatus` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: dashboard home.
- يظهر ضمن هذه المسارات/السياقات: `route /dashboard`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/dashboard/DashboardPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `summary`, `recentStudents`, `activeTrips`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /reporting/students/{studentId}/profile`
- `GET /reporting/students/{studentId}/reports/assessment-summary`
- `GET /reporting/students/{studentId}/reports/attendance-summary`
- `GET /reporting/students/{studentId}/reports/behavior-summary`
- `GET /reporting/transport/summary`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Admin Dashboard` داخل `Reporting`

## `GET /reporting/students/{studentId}/profile`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student reporting screen
- `admin-dashboard/src/features/reporting/StudentProfileReportPage.tsx:37` (route /reports/students/:studentId) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Student Profile Report
- OpenAPI description: Return the full student profile payload used in admin and staff reporting screens. Allowed roles: admin, teacher, supervisor. Note: If the student exists but has no related attendance, assessment, or behavior rows yet, the response stays 200 with zero-safe summaries. Derived data: This payload combines view-backed projections such as vw_student_profiles, vw_student_attendance_summary, vw_student_assessment_summary, and vw_student_behavior_summary.
- ENDPOINT_MAP purpose: full student profile

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `studentId` | `path` | `string` | yes | Student numeric string identifier. This is the same id used by /students/:id. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `studentId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return the full student profile payload used in admin and staff reporting screens. Roles: admin, teacher, supervisor Auth: Bearer access token required Note: If the student exists but has no related attendance, assessment, or behavior rows yet, the response stays 200 with zero-safe summaries. Derived data: This payload combines view-backed projections such as vw_student_profiles, vw_student_attendance_summary, vw_student_assessment_summary, and vw_student_behavior_summary.
- ENDPOINT_MAP note: same `studentId` as `/students/:id`; shared contract with teacher/supervisor

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `student.id` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `parents` | `array` | unknown | — | — | response.data example |
| `parents[].parentId` | `string` | unknown | — | — | response.data example |
| `parents[].fullName` | `string` | unknown | — | — | response.data example |
| `parents[].relationType` | `string` | unknown | — | — | response.data example |
| `attendanceSummary.totalSessions` | `number` | unknown | — | — | response.data example |
| `attendanceSummary.absentCount` | `number` | unknown | — | — | response.data example |
| `attendanceSummary.attendanceRate` | `number` | unknown | — | — | response.data example |
| `assessmentSummary.overall.assessmentsCount` | `number` | unknown | — | — | response.data example |
| `assessmentSummary.subjects` | `array` | unknown | — | — | response.data example |
| `assessmentSummary.subjects[].subjectId` | `string` | unknown | — | — | response.data example |
| `assessmentSummary.subjects[].subjectName` | `string` | unknown | — | — | response.data example |
| `behaviorSummary.totalBehaviorRecords` | `number` | unknown | — | — | response.data example |
| `behaviorSummary.negativeCount` | `number` | unknown | — | — | response.data example |
| `behaviorSummary.negativeSeverityTotal` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `studentId`.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student reporting screen.
- يظهر ضمن هذه المسارات/السياقات: `route /reports/students/:studentId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/reporting/StudentProfileReportPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `parents`, `attendanceSummary`, `assessmentSummary`, `behaviorSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /reporting/students/{studentId}/reports/assessment-summary`
- `GET /reporting/students/{studentId}/reports/attendance-summary`
- `GET /reporting/students/{studentId}/reports/behavior-summary`
- `GET /reporting/dashboards/admin/me`
- `GET /reporting/transport/summary`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Student Profile Report` داخل `Reporting`

## `GET /reporting/students/{studentId}/reports/assessment-summary`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student reports tab
- `admin-dashboard/src/features/reporting/StudentAssessmentSummaryPage.tsx:25` (route /reports/students/:studentId/assessments) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Student Assessment Summary
- OpenAPI description: Return the student assessment summary. Use assessmentSummary.subjects[] rather than items[]. Allowed roles: admin, teacher, supervisor. Note: No data yet returns 200 with zero-safe overall metrics and an empty subjects array. Derived data: Derived from summary views such as vw_student_assessment_summary.
- ENDPOINT_MAP purpose: assessment summary

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `studentId` | `path` | `string` | yes | Student numeric string identifier. This is the same id used by /students/:id. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `studentId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return the student assessment summary. Use assessmentSummary.subjects[] rather than items[]. Roles: admin, teacher, supervisor Auth: Bearer access token required Note: No data yet returns 200 with zero-safe overall metrics and an empty subjects array. Derived data: Derived from summary views such as vw_student_assessment_summary.
- ENDPOINT_MAP note: no `items[]`; use for charts/tables

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `student.id` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `assessmentSummary.overall.assessmentsCount` | `number` | unknown | — | — | response.data example |
| `assessmentSummary.subjects` | `array` | unknown | — | — | response.data example |
| `assessmentSummary.subjects[].subjectId` | `string` | unknown | — | — | response.data example |
| `assessmentSummary.subjects[].subjectName` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `studentId`.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student reports tab.
- يظهر ضمن هذه المسارات/السياقات: `route /reports/students/:studentId/assessments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/reporting/StudentAssessmentSummaryPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `assessmentSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /reporting/students/{studentId}/reports/attendance-summary`
- `GET /reporting/students/{studentId}/reports/behavior-summary`
- `GET /reporting/students/{studentId}/profile`
- `GET /reporting/dashboards/admin/me`
- `GET /reporting/transport/summary`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Student Assessment Summary` داخل `Reporting`

## `GET /reporting/students/{studentId}/reports/attendance-summary`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student reports tab
- `admin-dashboard/src/features/reporting/StudentAttendanceSummaryPage.tsx:19` (route /reports/students/:studentId/attendance) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Student Attendance Summary
- OpenAPI description: Return the student attendance summary used in charts and cards. Allowed roles: admin, teacher, supervisor. Note: No data yet returns 200 with zero-safe totals, not 404. Derived data: Derived from summary views such as vw_student_attendance_summary.
- ENDPOINT_MAP purpose: attendance summary

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `studentId` | `path` | `string` | yes | Student numeric string identifier. This is the same id used by /students/:id. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `studentId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return the student attendance summary used in charts and cards. Roles: admin, teacher, supervisor Auth: Bearer access token required Note: No data yet returns 200 with zero-safe totals, not 404. Derived data: Derived from summary views such as vw_student_attendance_summary.
- ENDPOINT_MAP note: `200` zero-safe when no attendance data yet

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `student.id` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `attendanceSummary.totalSessions` | `number` | unknown | — | — | response.data example |
| `attendanceSummary.absentCount` | `number` | unknown | — | — | response.data example |
| `attendanceSummary.attendanceRate` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `studentId`.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student reports tab.
- يظهر ضمن هذه المسارات/السياقات: `route /reports/students/:studentId/attendance`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/reporting/StudentAttendanceSummaryPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `attendanceSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /reporting/students/{studentId}/reports/assessment-summary`
- `GET /reporting/students/{studentId}/reports/behavior-summary`
- `GET /reporting/students/{studentId}/profile`
- `GET /reporting/dashboards/admin/me`
- `GET /reporting/transport/summary`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Student Attendance Summary` داخل `Reporting`

## `GET /reporting/students/{studentId}/reports/behavior-summary`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student reports tab
- `admin-dashboard/src/features/reporting/StudentBehaviorSummaryPage.tsx:25` (route /reports/students/:studentId/behavior) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Student Behavior Summary
- OpenAPI description: Return the student behavior summary. Use /behavior/students/:studentId/records for the detailed timeline. Allowed roles: admin, teacher, supervisor. Note: No data yet returns 200 with zero-safe totals, not 404. Derived data: Derived from summary views such as vw_student_behavior_summary.
- ENDPOINT_MAP purpose: behavior summary

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `studentId` | `path` | `string` | yes | Student numeric string identifier. This is the same id used by /students/:id. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `studentId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return the student behavior summary. Use /behavior/students/:studentId/records for the detailed timeline. Roles: admin, teacher, supervisor Auth: Bearer access token required Note: No data yet returns 200 with zero-safe totals, not 404. Derived data: Derived from summary views such as vw_student_behavior_summary.
- ENDPOINT_MAP note: no `records[]`; use `/behavior/students/:studentId/records` for timeline

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `student.id` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `behaviorSummary.totalBehaviorRecords` | `number` | unknown | — | — | response.data example |
| `behaviorSummary.negativeCount` | `number` | unknown | — | — | response.data example |
| `behaviorSummary.negativeSeverityTotal` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `studentId`.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student reports tab.
- يظهر ضمن هذه المسارات/السياقات: `route /reports/students/:studentId/behavior`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/reporting/StudentBehaviorSummaryPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `behaviorSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /reporting/students/{studentId}/reports/assessment-summary`
- `GET /reporting/students/{studentId}/reports/attendance-summary`
- `GET /reporting/students/{studentId}/profile`
- `GET /reporting/dashboards/admin/me`
- `GET /reporting/transport/summary`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Student Behavior Summary` داخل `Reporting`

## `GET /reporting/transport/summary`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: transport summary page
- `admin-dashboard/src/features/transport/TransportSummaryPage.tsx:44` (route /summary) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Transport Summary
- OpenAPI description: Return the transport summary surface shared by admin and driver. Allowed roles: admin, driver. Derived data: Transport summaries rely on views such as vw_trip_details, vw_latest_trip_location, vw_active_trip_live_status, and vw_trip_student_event_details.
- ENDPOINT_MAP purpose: transport summary

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- Postman request note: Purpose: Return the transport summary surface shared by admin and driver. Roles: admin, driver Auth: Bearer access token required Derived data: Transport summaries rely on views such as vw_trip_details, vw_latest_trip_location, vw_active_trip_live_status, and vw_trip_student_event_details.
- ENDPOINT_MAP note: admin and driver only

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `summary.activeTripsCount` | `number` | unknown | — | — | response.data example |
| `summary.routesCount` | `number` | unknown | — | — | response.data example |
| `summary.busesCount` | `number` | unknown | — | — | response.data example |
| `activeTrips` | `array` | unknown | — | — | response.data example |
| `activeTrips[].id` | `string` | unknown | — | — | response.data example |
| `activeTrips[].routeName` | `string` | unknown | — | — | response.data example |
| `activeTrips[].tripStatus` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: transport summary page.
- يظهر ضمن هذه المسارات/السياقات: `route /summary`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TransportSummaryPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `summary`, `activeTrips`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /reporting/dashboards/admin/me`
- `GET /reporting/students/{studentId}/profile`
- `GET /reporting/students/{studentId}/reports/assessment-summary`
- `GET /reporting/students/{studentId}/reports/attendance-summary`
- `GET /reporting/students/{studentId}/reports/behavior-summary`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Transport Summary` داخل `Reporting`
