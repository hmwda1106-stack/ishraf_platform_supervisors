# Admin Acceptance Gates Report

Generated at: 2026-03-29T22:27:09.740Z

## Summary

- Overall result: pass
- Live read-route audit ready: no
- Contract gate failures: 0
- Prerequisite gate failures: 0
- Selector gate failures: 0
- Error gate failures: 0
- Route gate failures: 0

## Contract Alignment Gate

- Result: pass
- Checks: 37
- Failures: 0

| Endpoint | Backend Docs | Query Params | Search | Consumers | Result |
| --- | --- | --- | --- | --- | --- |
| `/academic-structure/subject-offerings` | OpenAPI, Postman | `semesterId, gradeLevelId, subjectId, isActive` | no | direct GET only | pass |
| `/assessments` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, assessmentTypeId, classId, subjectId, teacherId, academicYearId, semesterId, assessmentDate, dateFrom, dateTo, isPublished` | no | admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:135 | pass |
| `/attendance/sessions` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, classId, subjectId, teacherId, academicYearId, semesterId, sessionDate, dateFrom, dateTo` | no | admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:124 | pass |
| `/behavior/records` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, studentId, behaviorCategoryId, behaviorType, academicYearId, semesterId, teacherId, supervisorId, behaviorDate, dateFrom, dateTo` | no | admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:192 | pass |
| `/communication/messages/conversations/:param` | OpenAPI | `page, limit, sortBy, sortOrder` | no | direct GET only | pass |
| `/communication/messages/inbox` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, isRead` | no | direct GET only | pass |
| `/communication/messages/sent` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, receiverUserId` | no | direct GET only | pass |
| `/communication/notifications/me` | OpenAPI, Postman | `page, limit, isRead, notificationType` | no | direct GET only | pass |
| `/communication/recipients` | OpenAPI, Postman | `page, limit, search, role` | yes | admin-dashboard/src/features/communication/recipient-directory.ts:17 | pass |
| `/homework` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, classId, subjectId, teacherId, academicYearId, semesterId, assignedDate, dueDate, dateFrom, dateTo` | no | admin-dashboard/src/features/homework/HomeworkListPage.tsx:122 | pass |
| `/students` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, status, gender, academicYearId, classId` | no | admin-dashboard/src/features/reporting/ReportsHubPage.tsx:39<br>admin-dashboard/src/features/students/StudentsListPage.tsx:107 | pass |
| `/transport/trips` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, tripStatus, tripType, dateFrom, dateTo` | no | admin-dashboard/src/features/transport/TripsListPage.tsx:89 | pass |
| `/transport/trips/:param/students` | OpenAPI | `search, stopId` | yes | direct GET only | pass |
| `/users` | OpenAPI, Postman | `page, limit, sortBy, sortOrder, role, isActive` | no | admin-dashboard/src/features/users/UsersListPage.tsx:106 | pass |

## Prerequisite Gate

- Result: pass
- Checks: 19
- Failures: 0

| Check | Result | Details |
| --- | --- | --- |
| /students/create -> GuardedCreateStudentPage | pass | expected `GuardedCreateStudentPage`, found `GuardedCreateStudentPage` |
| /attendance -> GuardedAttendanceSessionsPage | pass | expected `GuardedAttendanceSessionsPage`, found `GuardedAttendanceSessionsPage` |
| /assessments -> GuardedAssessmentsListPage | pass | expected `GuardedAssessmentsListPage`, found `GuardedAssessmentsListPage` |
| /behavior -> GuardedBehaviorRecordsPage | pass | expected `GuardedBehaviorRecordsPage`, found `GuardedBehaviorRecordsPage` |
| /homework -> GuardedHomeworkListPage | pass | expected `GuardedHomeworkListPage`, found `GuardedHomeworkListPage` |
| /academic -> AcademicIndexRedirect | pass | expected `AcademicIndexRedirect`, found `AcademicIndexRedirect` |
| /transport -> TransportIndexRedirect | pass | expected `TransportIndexRedirect`, found `TransportIndexRedirect` |
| /academic/teacher-assignments -> GuardedTeacherAssignmentsPage | pass | expected `GuardedTeacherAssignmentsPage`, found `GuardedTeacherAssignmentsPage` |
| /academic/supervisor-assignments -> GuardedSupervisorAssignmentsPage | pass | expected `GuardedSupervisorAssignmentsPage`, found `GuardedSupervisorAssignmentsPage` |
| Sidebar uses operations readiness hook | pass | src/shared/layouts/Sidebar.tsx |
| Academic layout uses tab readiness hook | pass | src/features/academic/AcademicLayout.tsx |
| Transport layout uses tab readiness hook | pass | src/features/transport/TransportLayout.tsx |
| Guarded create student page uses RoutePrerequisiteGuard | pass | src/features/students/GuardedCreateStudentPage.tsx |
| Guarded attendance page uses RoutePrerequisiteGuard | pass | src/features/attendance/GuardedAttendanceSessionsPage.tsx |
| Guarded assessments page uses RoutePrerequisiteGuard | pass | src/features/assessments/GuardedAssessmentsListPage.tsx |
| Guarded behavior page uses RoutePrerequisiteGuard | pass | src/features/behavior/GuardedBehaviorRecordsPage.tsx |
| Guarded homework page uses RoutePrerequisiteGuard | pass | src/features/homework/GuardedHomeworkListPage.tsx |
| Guarded teacher assignments page uses RoutePrerequisiteGuard | pass | src/features/academic/GuardedTeacherAssignmentsPage.tsx |
| Guarded supervisor assignments page uses RoutePrerequisiteGuard | pass | src/features/academic/GuardedSupervisorAssignmentsPage.tsx |

## Selector Derivation Gate

- Result: pass
- Checks: 49
- Failures: 0

| File | Check | Result |
| --- | --- | --- |
| `src/features/communication/CommunicationLayout.tsx` | Communication layout renders the summary bar | pass |
| `src/features/communication/CommunicationLayout.tsx` | Communication layout renders the unified composer drawer | pass |
| `src/features/communication/CommunicationLayout.tsx` | Communication layout reads query-driven compose state | pass |
| `src/features/communication/SentPage.tsx` | Sent page filters recipients through the backend messaging directory selector | pass |
| `src/features/transport/BusesPage.tsx` | Buses page uses SearchableSelect for drivers | pass |
| `src/features/transport/BusesPage.tsx` | Buses page does not ask for driver profile ids | pass |
| `src/features/transport/BusesPage.tsx` | Buses page does not expose raw driver id input | pass |
| `src/features/transport/TransportAssignmentsPage.tsx` | Transport assignments derive student selector options | pass |
| `src/features/transport/TransportAssignmentsPage.tsx` | Transport assignments use SearchableSelect | pass |
| `src/features/transport/TransportAssignmentsPage.tsx` | Transport assignments do not expose raw student id input | pass |
| `src/features/behavior/BehaviorRecordsPage.tsx` | Behavior records derive student selector options | pass |
| `src/features/behavior/BehaviorRecordsPage.tsx` | Behavior records use SearchableSelect | pass |
| `src/features/behavior/BehaviorRecordsPage.tsx` | Behavior records do not expose raw student id input | pass |
| `src/features/students/CreateStudentPage.tsx` | Create student page uses searchable relation selectors | pass |
| `src/features/students/CreateStudentPage.tsx` | Create student page does not expose raw parent id input | pass |
| `src/features/students/StudentDetailPage.tsx` | Student detail page uses searchable relation selectors | pass |
| `src/features/students/StudentDetailPage.tsx` | Student detail page does not expose raw parent id input | pass |
| `src/features/academic/TeacherAssignmentsPage.tsx` | Teacher assignments page uses searchable selectors | pass |
| `src/features/academic/TeacherAssignmentsPage.tsx` | Teacher assignments page sends selected teacher users.id directly | pass |
| `src/features/academic/TeacherAssignmentsPage.tsx` | Teacher assignments page does not derive teacher profile ids locally | pass |
| `src/features/academic/TeacherAssignmentsPage.tsx` | Teacher assignments page does not expose raw teacher user id input | pass |
| `src/features/academic/SupervisorAssignmentsPage.tsx` | Supervisor assignments page uses searchable selectors | pass |
| `src/features/academic/SupervisorAssignmentsPage.tsx` | Supervisor assignments page sends selected supervisor users.id directly | pass |
| `src/features/academic/SupervisorAssignmentsPage.tsx` | Supervisor assignments page does not derive supervisor profile ids locally | pass |
| `src/features/academic/SupervisorAssignmentsPage.tsx` | Supervisor assignments page does not expose raw supervisor user id input | pass |
| `src/features/monitoring/admin-preview-contract.ts` | Monitoring contract uses parent admin-preview endpoints | pass |
| `src/features/monitoring/admin-preview-contract.ts` | Monitoring contract uses teacher admin-preview endpoints | pass |
| `src/features/monitoring/admin-preview-contract.ts` | Monitoring contract uses supervisor admin-preview endpoints | pass |
| `src/features/monitoring/admin-preview-contract.ts` | Monitoring contract does not derive parent preview from generic student selection helpers | pass |
| `src/features/monitoring/AdminPreviewPage.tsx` | Monitoring page loads parent-first dashboard preview | pass |
| `src/features/monitoring/AdminPreviewPage.tsx` | Monitoring page loads teacher dashboard preview | pass |
| `src/features/monitoring/AdminPreviewPage.tsx` | Monitoring page loads supervisor dashboard preview | pass |
| `src/features/monitoring/AdminPreviewPage.tsx` | Monitoring page does not use the old local student-first aggregation helper | pass |
| `src/features/monitoring/PreviewSurfaces.tsx` | Monitoring preview surfaces render canonical parent dashboard data | pass |
| `src/features/monitoring/PreviewSurfaces.tsx` | Monitoring preview surfaces render canonical teacher dashboard data | pass |
| `src/features/monitoring/PreviewSurfaces.tsx` | Monitoring preview surfaces render canonical supervisor dashboard data | pass |
| `src/features/monitoring/PreviewSurfaces.tsx` | Monitoring preview surfaces open communication from canonical preview context | pass |
| `src/features/monitoring/PreviewSurfaces.tsx` | Parent preview offers a parent-scoped direct message launcher | pass |
| `src/features/monitoring/PreviewSurfaces.tsx` | Monitoring preview surfaces no longer render legacy linked-parent local aggregation copy | pass |
| `src/features/monitoring/PreviewSurfaces.tsx` | Monitoring preview surfaces no longer render teacher homework approximation | pass |
| `src/features/reporting/ReportsHubPage.tsx` | Reports hub launches communication from student reporting context | pass |
| `src/features/reporting/ReportsHubPage.tsx` | Reports hub locks communication launches to student reference context | pass |
| `src/features/reporting/StudentProfileReportPage.tsx` | Student profile report launches communication from report context | pass |
| `src/features/reporting/StudentProfileReportPage.tsx` | Student profile report locks communication launches to the student reference context | pass |
| `src/features/attendance/AttendanceSessionsPage.tsx` | Attendance sessions page uses searchable selectors | pass |
| `src/features/assessments/AssessmentsListPage.tsx` | Assessments page uses searchable selectors | pass |
| `src/features/homework/HomeworkListPage.tsx` | Homework page uses searchable selectors | pass |
| `src/features/academic/SubjectOfferingsPage.tsx` | Subject offerings page uses searchable selectors | pass |
| `src/features/students/StudentsListPage.tsx` | Students list filters use searchable selectors | pass |

## Error Mapping Gate

- Result: pass
- Checks: 67
- Failures: 0

| Check | Result | Context |
| --- | --- | --- |
| API client exports getApiErrorCategory | pass | src/api/client.ts |
| API client exports getApiStatusCode | pass | src/api/client.ts |
| API client exports getApiErrorMessage | pass | src/api/client.ts |
| API client exports getApiFieldErrors | pass | src/api/client.ts |
| BackendErrorAlert uses status codes | pass | src/shared/components/BackendErrorAlert.tsx |
| BackendErrorAlert uses translated backend messages | pass | src/shared/components/BackendErrorAlert.tsx |
| admin-dashboard/src/features/academic/AcademicYearsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/academic/AcademicYearsPage.tsx |
| admin-dashboard/src/features/academic/ClassesPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/academic/ClassesPage.tsx |
| admin-dashboard/src/features/academic/GradeLevelsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/academic/GradeLevelsPage.tsx |
| admin-dashboard/src/features/academic/SemestersPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/academic/SemestersPage.tsx |
| admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx |
| admin-dashboard/src/features/academic/SubjectsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/academic/SubjectsPage.tsx |
| admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx |
| admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx |
| admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx |
| admin-dashboard/src/features/assessments/AssessmentsListPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/assessments/AssessmentsListPage.tsx |
| admin-dashboard/src/features/assessments/AssessmentTypesPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/assessments/AssessmentTypesPage.tsx |
| admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx |
| admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx |
| admin-dashboard/src/features/behavior/BehaviorCategoriesPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/behavior/BehaviorCategoriesPage.tsx |
| admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx |
| admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx |
| admin-dashboard/src/features/communication/CommunicationComposerDrawer.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/communication/CommunicationComposerDrawer.tsx |
| admin-dashboard/src/features/communication/ConversationPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/communication/ConversationPage.tsx |
| admin-dashboard/src/features/communication/InboxPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/communication/InboxPage.tsx |
| admin-dashboard/src/features/communication/NotificationsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/communication/NotificationsPage.tsx |
| admin-dashboard/src/features/homework/HomeworkDetailPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/homework/HomeworkDetailPage.tsx |
| admin-dashboard/src/features/homework/HomeworkListPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/homework/HomeworkListPage.tsx |
| admin-dashboard/src/features/students/CreateStudentPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/students/CreateStudentPage.tsx |
| admin-dashboard/src/features/students/StudentDetailPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/students/StudentDetailPage.tsx |
| admin-dashboard/src/features/students/StudentHomeLocationSection.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/students/StudentHomeLocationSection.tsx |
| admin-dashboard/src/features/transport/BusesPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/transport/BusesPage.tsx |
| admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx |
| admin-dashboard/src/features/transport/RouteDetailPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/transport/RouteDetailPage.tsx |
| admin-dashboard/src/features/transport/RoutesPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/transport/RoutesPage.tsx |
| admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx |
| admin-dashboard/src/features/transport/TripDetailPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/transport/TripDetailPage.tsx |
| admin-dashboard/src/features/transport/TripsListPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/transport/TripsListPage.tsx |
| admin-dashboard/src/features/users/CreateUserPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/users/CreateUserPage.tsx |
| admin-dashboard/src/features/users/UserDetailPage.tsx handles mutation errors through shared API translation | pass | admin-dashboard/src/features/users/UserDetailPage.tsx |
| src/features/users/CreateUserPage.tsx reads backend field errors | pass | src/features/users/CreateUserPage.tsx |
| src/features/users/UserDetailPage.tsx reads backend field errors | pass | src/features/users/UserDetailPage.tsx |
| src/features/students/CreateStudentPage.tsx reads backend field errors | pass | src/features/students/CreateStudentPage.tsx |
| src/features/students/StudentDetailPage.tsx reads backend field errors | pass | src/features/students/StudentDetailPage.tsx |
| src/features/academic/GradeLevelsPage.tsx reads backend field errors | pass | src/features/academic/GradeLevelsPage.tsx |
| src/features/academic/SemestersPage.tsx reads backend field errors | pass | src/features/academic/SemestersPage.tsx |
| src/features/academic/SubjectsPage.tsx reads backend field errors | pass | src/features/academic/SubjectsPage.tsx |
| src/features/academic/SubjectOfferingsPage.tsx reads backend field errors | pass | src/features/academic/SubjectOfferingsPage.tsx |
| src/features/academic/TeacherAssignmentsPage.tsx reads backend field errors | pass | src/features/academic/TeacherAssignmentsPage.tsx |
| src/features/academic/SupervisorAssignmentsPage.tsx reads backend field errors | pass | src/features/academic/SupervisorAssignmentsPage.tsx |
| src/features/attendance/AttendanceSessionsPage.tsx reads backend field errors | pass | src/features/attendance/AttendanceSessionsPage.tsx |
| src/features/assessments/AssessmentTypesPage.tsx reads backend field errors | pass | src/features/assessments/AssessmentTypesPage.tsx |
| src/features/assessments/AssessmentsListPage.tsx reads backend field errors | pass | src/features/assessments/AssessmentsListPage.tsx |
| src/features/behavior/BehaviorCategoriesPage.tsx reads backend field errors | pass | src/features/behavior/BehaviorCategoriesPage.tsx |
| src/features/behavior/BehaviorRecordsPage.tsx reads backend field errors | pass | src/features/behavior/BehaviorRecordsPage.tsx |
| src/features/homework/HomeworkListPage.tsx reads backend field errors | pass | src/features/homework/HomeworkListPage.tsx |
| src/features/transport/BusesPage.tsx reads backend field errors | pass | src/features/transport/BusesPage.tsx |
| src/features/transport/RouteAssignmentsPage.tsx reads backend field errors | pass | src/features/transport/RouteAssignmentsPage.tsx |
| src/features/transport/TransportAssignmentsPage.tsx reads backend field errors | pass | src/features/transport/TransportAssignmentsPage.tsx |
| src/features/transport/TripDetailPage.tsx reads backend field errors | pass | src/features/transport/TripDetailPage.tsx |
| src/features/communication/CommunicationComposerDrawer.tsx reads backend field errors | pass | src/features/communication/CommunicationComposerDrawer.tsx |
| src/features/communication/ConversationPage.tsx reads backend field errors | pass | src/features/communication/ConversationPage.tsx |
| src/features/transport/TransportAssignmentsPage.tsx maps backend status codes contextually | pass | src/features/transport/TransportAssignmentsPage.tsx |
| src/features/transport/TripsListPage.tsx maps backend status codes contextually | pass | src/features/transport/TripsListPage.tsx |
| src/features/transport/TripDetailPage.tsx maps backend status codes contextually | pass | src/features/transport/TripDetailPage.tsx |
| src/features/communication/CommunicationComposerDrawer.tsx maps backend status codes contextually | pass | src/features/communication/CommunicationComposerDrawer.tsx |
| src/features/communication/ConversationPage.tsx maps backend status codes contextually | pass | src/features/communication/ConversationPage.tsx |

## Route Smoke Gate

- Result: pass
- Checks: 42
- Failures: 0

| Route ID | Path | Component | Result |
| --- | --- | --- | --- |
| `dashboard` | `/dashboard` | `DashboardPage` | pass |
| `users.list` | `/users` | `UsersListPage` | pass |
| `users.detail` | `/users/:userId` | `UserDetailPage` | pass |
| `academic.years` | `/academic/years` | `AcademicYearsPage` | pass |
| `academic.semesters` | `/academic/semesters` | `SemestersPage` | pass |
| `academic.gradeLevels` | `/academic/grade-levels` | `GradeLevelsPage` | pass |
| `academic.classes` | `/academic/classes` | `ClassesPage` | pass |
| `academic.subjects` | `/academic/subjects` | `SubjectsPage` | pass |
| `academic.subjectOfferings` | `/academic/subject-offerings` | `SubjectOfferingsPage` | pass |
| `academic.teacherAssignments` | `/academic/teacher-assignments` | `GuardedTeacherAssignmentsPage` | pass |
| `academic.supervisorAssignments` | `/academic/supervisor-assignments` | `GuardedSupervisorAssignmentsPage` | pass |
| `students.list` | `/students` | `StudentsListPage` | pass |
| `students.detail` | `/students/:studentId` | `StudentDetailPage` | pass |
| `attendance.sessions` | `/attendance` | `GuardedAttendanceSessionsPage` | pass |
| `attendance.sessionDetail` | `/attendance/:attendanceSessionId` | `AttendanceSessionDetailPage` | pass |
| `assessments.list` | `/assessments` | `GuardedAssessmentsListPage` | pass |
| `assessments.types` | `/assessments/types` | `AssessmentTypesPage` | pass |
| `assessments.detail` | `/assessments/:assessmentId` | `AssessmentDetailPage` | pass |
| `behavior.records` | `/behavior` | `GuardedBehaviorRecordsPage` | pass |
| `behavior.categories` | `/behavior/categories` | `BehaviorCategoriesPage` | pass |
| `behavior.detail` | `/behavior/:behaviorRecordId` | `BehaviorRecordDetailPage` | pass |
| `homework.list` | `/homework` | `GuardedHomeworkListPage` | pass |
| `homework.detail` | `/homework/:homeworkId` | `HomeworkDetailPage` | pass |
| `transport.buses` | `/transport/buses` | `BusesPage` | pass |
| `transport.routes` | `/transport/routes` | `RoutesPage` | pass |
| `transport.routeDetail` | `/transport/routes/:routeId` | `RouteDetailPage` | pass |
| `transport.routeAssignments` | `/transport/route-assignments` | `RouteAssignmentsPage` | pass |
| `transport.assignments` | `/transport/assignments` | `TransportAssignmentsPage` | pass |
| `transport.trips` | `/transport/trips` | `TripsListPage` | pass |
| `transport.tripDetail` | `/transport/trips/:tripId` | `TripDetailPage` | pass |
| `transport.summary` | `/transport/summary` | `TransportSummaryPage` | pass |
| `communication.inbox` | `/communication/inbox` | `InboxPage` | pass |
| `communication.sent` | `/communication/sent` | `SentPage` | pass |
| `communication.announcements` | `/communication/announcements` | `AnnouncementsPage` | pass |
| `communication.notifications` | `/communication/notifications` | `NotificationsPage` | pass |
| `communication.conversation` | `/communication/conversations/:otherUserId` | `ConversationPage` | pass |
| `monitoring.preview` | `/monitoring` | `AdminPreviewPage` | pass |
| `reports.hub` | `/reports` | `ReportsHubPage` | pass |
| `reports.profile` | `/reports/students/:studentId` | `StudentProfileReportPage` | pass |
| `reports.attendance` | `/reports/students/:studentId/attendance` | `StudentAttendanceSummaryPage` | pass |
| `reports.assessments` | `/reports/students/:studentId/assessments` | `StudentAssessmentSummaryPage` | pass |
| `reports.behavior` | `/reports/students/:studentId/behavior` | `StudentBehaviorSummaryPage` | pass |

## Live Read-Route Audit

- Skipped by default in this gate because `ISHRAF_LOGIN_IDENTIFIER` and `ISHRAF_LOGIN_PASSWORD` are not both available.
- Run `npm.cmd run audit:admin:read-routes` when authenticated fixtures are available.
