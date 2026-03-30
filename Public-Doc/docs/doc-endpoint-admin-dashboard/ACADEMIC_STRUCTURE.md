# Academic Structure

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Academic Structure**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `GET /academic-structure/academic-years`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: years list
- `admin-dashboard/src/features/academic/AcademicYearsPage.tsx:29` (route /years) عبر direct apiClient
- `admin-dashboard/src/features/academic/ClassesPage.tsx:28` (route /classes) عبر direct apiClient
- `admin-dashboard/src/features/academic/SemestersPage.tsx:30` (route /semesters) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx:46` (route /subject-offerings) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:47` (route /subjects) عبر direct apiClient
- `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx:61` (route /supervisor-assignments) عبر direct apiClient
- `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx:61` (route /teacher-assignments) عبر direct apiClient
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:76` (route /assessments) عبر direct apiClient
- `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:66` (route /attendance) عبر direct apiClient
- `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:92` (route /behavior) عبر direct apiClient
- `admin-dashboard/src/features/homework/HomeworkListPage.tsx:57` (route /homework) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:181` (route /students/:id) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentsListPage.tsx:87` (route /students) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Academic Years
- OpenAPI description: List all academic years. Allowed roles: admin.
- ENDPOINT_MAP purpose: list academic years

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
- Postman request note: Purpose: List all academic years. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: selector source

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `array` | yes | — | — | response schema |
| `data[]` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(array)` | `array` | yes | — | — | response.data schema |
| `[]` | `object` | yes | GenericObject schema | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: years list.
- يظهر ضمن هذه المسارات/السياقات: `route /years`, `route /classes`, `route /semesters`, `route /subject-offerings`, `route /subjects`, `route /supervisor-assignments`, `route /teacher-assignments`, `route /assessments`, `route /attendance`, `route /behavior`, `route /homework`, `route /students/:id`, `route /students`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/AcademicYearsPage.tsx`, `admin-dashboard/src/features/academic/ClassesPage.tsx`, `admin-dashboard/src/features/academic/SemestersPage.tsx`, `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx`, `admin-dashboard/src/features/academic/SubjectsPage.tsx`, `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx`, `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx`, `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`, `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx`, `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx`, `admin-dashboard/src/features/homework/HomeworkListPage.tsx`, `admin-dashboard/src/features/students/StudentDetailPage.tsx`, `admin-dashboard/src/features/students/StudentsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`
- `PATCH /academic-structure/academic-years/{id}`
- `PATCH /academic-structure/academic-years/{id}/activate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Academic Years` داخل `Academic Structure`

## `POST /academic-structure/academic-years`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: years form
- `admin-dashboard/src/features/academic/AcademicYearsPage.tsx:35` (route /years) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Academic Year
- OpenAPI description: Create an academic year record. Allowed roles: admin.
- ENDPOINT_MAP purpose: create academic year

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `name` | `string` | yes | — | minLength=1 \| maxLength=50 | request schema (CreateAcademicYearRequest) |
| `startDate` | `string` | yes | — | pattern=^\d{4}-\d{2}-\d{2}$ | request schema (CreateAcademicYearRequest) |
| `endDate` | `string` | yes | — | pattern=^\d{4}-\d{2}-\d{2}$ | request schema (CreateAcademicYearRequest) |
| `isActive` | `boolean` | no | — | — | request schema (CreateAcademicYearRequest) |

**Backend Validation Rules**
- `name`: minLength=1 | maxLength=50.
- `startDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `endDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: Create an academic year record. Roles: admin Auth: Bearer access token required Body schema: CreateAcademicYearRequest
- ENDPOINT_MAP note: date constraints قد تفشل

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `name` | `string` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `name`, `startDate`, `endDate`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: years form.
- يظهر ضمن هذه المسارات/السياقات: `route /years`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/AcademicYearsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `name`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`
- `PATCH /academic-structure/academic-years/{id}`
- `PATCH /academic-structure/academic-years/{id}/activate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Academic Year` داخل `Academic Structure`

## `GET /academic-structure/academic-years/{academicYearId}/semesters`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: semesters list
- `admin-dashboard/src/features/academic/SemestersPage.tsx:42` (route /semesters) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx:49` (route /subject-offerings) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:50` (route /subjects) عبر direct apiClient
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:86` (route /assessments) عبر direct apiClient
- `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:76` (route /attendance) عبر direct apiClient
- `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:117` (route /behavior) عبر direct apiClient
- `admin-dashboard/src/features/homework/HomeworkListPage.tsx:68` (route /homework) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Semesters
- OpenAPI description: List semesters for the selected academic year. Allowed roles: admin.
- ENDPOINT_MAP purpose: list semesters

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `academicYearId` | `path` | `string` | yes | Academic year numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `academicYearId`: pattern=^[0-9]+$.
- Postman request note: Purpose: List semesters for the selected academic year. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: ضمن year detail

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `array` | yes | — | — | response schema |
| `data[]` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(array)` | `array` | yes | — | — | response.data schema |
| `[]` | `object` | yes | GenericObject schema | — | response.data schema |

**Required vs Optional Fields**
- Path params الإلزامية: `academicYearId`.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: semesters list.
- يظهر ضمن هذه المسارات/السياقات: `route /semesters`, `route /subject-offerings`, `route /subjects`, `route /assessments`, `route /attendance`, `route /behavior`, `route /homework`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SemestersPage.tsx`, `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx`, `admin-dashboard/src/features/academic/SubjectsPage.tsx`, `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`, `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx`, `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx`, `admin-dashboard/src/features/homework/HomeworkListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /academic-structure/academic-years/{academicYearId}/semesters`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `PATCH /academic-structure/academic-years/{id}`
- `PATCH /academic-structure/academic-years/{id}/activate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Semesters` داخل `Academic Structure`

## `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: semesters form
- `admin-dashboard/src/features/academic/SemestersPage.tsx:49` (route /semesters) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Semester
- OpenAPI description: Create a semester under the selected academic year. Allowed roles: admin.
- ENDPOINT_MAP purpose: create semester

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `academicYearId` | `path` | `string` | yes | Academic year numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `name` | `string` | yes | — | minLength=1 \| maxLength=50 | request schema (CreateSemesterRequest) |
| `startDate` | `string` | yes | — | pattern=^\d{4}-\d{2}-\d{2}$ | request schema (CreateSemesterRequest) |
| `endDate` | `string` | yes | — | pattern=^\d{4}-\d{2}-\d{2}$ | request schema (CreateSemesterRequest) |
| `isActive` | `boolean` | no | — | — | request schema (CreateSemesterRequest) |

**Backend Validation Rules**
- `academicYearId`: pattern=^[0-9]+$.
- `name`: minLength=1 | maxLength=50.
- `startDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `endDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: Create a semester under the selected academic year. Roles: admin Auth: Bearer access token required Body schema: CreateSemesterRequest
- ENDPOINT_MAP note: مرتبط بسنة محددة

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `name` | `string` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `academicYearId`.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `name`, `startDate`, `endDate`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: semesters form.
- يظهر ضمن هذه المسارات/السياقات: `route /semesters`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SemestersPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `name`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `PATCH /academic-structure/academic-years/{id}`
- `PATCH /academic-structure/academic-years/{id}/activate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Semester` داخل `Academic Structure`

## `PATCH /academic-structure/academic-years/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: edit year
- `admin-dashboard/src/features/academic/AcademicYearsPage.tsx:45` (route /years) عبر direct apiClient

**Purpose**
- OpenAPI summary: Update Academic Year
- OpenAPI description: Update an academic year. Allowed roles: admin.
- ENDPOINT_MAP purpose: update year

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Academic year numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `name` | `string` | no | — | minLength=1 \| maxLength=50 | request schema (UpdateAcademicYearRequest) |
| `startDate` | `string` | no | — | pattern=^\d{4}-\d{2}-\d{2}$ | request schema (UpdateAcademicYearRequest) |
| `endDate` | `string` | no | — | pattern=^\d{4}-\d{2}-\d{2}$ | request schema (UpdateAcademicYearRequest) |
| `isActive` | `boolean` | no | — | — | request schema (UpdateAcademicYearRequest) |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- `name`: minLength=1 | maxLength=50.
- `startDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `endDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: Update an academic year. Roles: admin Auth: Bearer access token required Body schema: UpdateAcademicYearRequest
- ENDPOINT_MAP note: راعِ active year rules

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `name` | `string` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- body موجودة لكن الحقول الإلزامية ليست محددة بالكامل في schema المرجعية؛ تم الاعتماد على examples فقط حيث أمكن.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: edit year.
- يظهر ضمن هذه المسارات/السياقات: `route /years`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/AcademicYearsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `name`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`
- `PATCH /academic-structure/academic-years/{id}/activate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Update Academic Year` داخل `Academic Structure`

## `PATCH /academic-structure/academic-years/{id}/activate`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: year actions
- `admin-dashboard/src/features/academic/AcademicYearsPage.tsx:55` (route /years) عبر direct apiClient

**Purpose**
- OpenAPI summary: Activate Academic Year
- OpenAPI description: Activate the selected academic year and deactivate any other active year. Allowed roles: admin.
- ENDPOINT_MAP purpose: activate year

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Academic year numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Activate the selected academic year and deactivate any other active year. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: مهم نظاميًا

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `name` | `string` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: year actions.
- يظهر ضمن هذه المسارات/السياقات: `route /years`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/AcademicYearsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `name`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`
- `PATCH /academic-structure/academic-years/{id}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Activate Academic Year` داخل `Academic Structure`

## `GET /academic-structure/classes`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: classes list
- `admin-dashboard/src/features/academic/ClassesPage.tsx:41` (route /classes) عبر direct apiClient
- `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx:67` (route /supervisor-assignments) عبر direct apiClient
- `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx:67` (route /teacher-assignments) عبر direct apiClient
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:66` (route /assessments) عبر direct apiClient
- `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:56` (route /attendance) عبر direct apiClient
- `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:97` (route /behavior) عبر direct apiClient
- `admin-dashboard/src/features/homework/HomeworkListPage.tsx:47` (route /homework) عبر direct apiClient
- `admin-dashboard/src/features/students/CreateStudentPage.tsx:113` (route /students/create) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:186` (route /students/:id) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentsListPage.tsx:92` (route /students) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Classes
- OpenAPI description: List classes. Allowed roles: admin.
- ENDPOINT_MAP purpose: list classes

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
- Postman request note: Purpose: List classes. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: used across many screens

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `array` | yes | — | — | response schema |
| `data[]` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(array)` | `array` | yes | — | — | response.data schema |
| `[]` | `object` | yes | GenericObject schema | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: classes list.
- يظهر ضمن هذه المسارات/السياقات: `route /classes`, `route /supervisor-assignments`, `route /teacher-assignments`, `route /assessments`, `route /attendance`, `route /behavior`, `route /homework`, `route /students/create`, `route /students/:id`, `route /students`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/ClassesPage.tsx`, `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx`, `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx`, `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`, `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx`, `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx`, `admin-dashboard/src/features/homework/HomeworkListPage.tsx`, `admin-dashboard/src/features/students/CreateStudentPage.tsx`, `admin-dashboard/src/features/students/StudentDetailPage.tsx`, `admin-dashboard/src/features/students/StudentsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /academic-structure/classes`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Classes` داخل `Academic Structure`

## `POST /academic-structure/classes`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: classes form
- `admin-dashboard/src/features/academic/ClassesPage.tsx:56` (route /classes) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Class
- OpenAPI description: Create a class section. Allowed roles: admin.
- ENDPOINT_MAP purpose: create class

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `gradeLevelId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateClassRequest) |
| `academicYearId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateClassRequest) |
| `className` | `string` | yes | — | minLength=1 \| maxLength=50 | request schema (CreateClassRequest) |
| `section` | `string` | yes | — | minLength=1 \| maxLength=50 | request schema (CreateClassRequest) |
| `capacity` | `integer` | no | — | min=1 | request schema (CreateClassRequest) |
| `isActive` | `boolean` | no | — | — | request schema (CreateClassRequest) |

**Backend Validation Rules**
- `gradeLevelId`: pattern=^[0-9]+$.
- `academicYearId`: pattern=^[0-9]+$.
- `className`: minLength=1 | maxLength=50.
- `section`: minLength=1 | maxLength=50.
- `capacity`: min=1.
- Postman request note: Purpose: Create a class section. Roles: admin Auth: Bearer access token required Body schema: CreateClassRequest
- ENDPOINT_MAP note: depends on grade/year

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `section` | `string` | unknown | — | — | response.data example |
| `gradeLevelId` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `gradeLevelId`, `academicYearId`, `className`, `section`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: classes form.
- يظهر ضمن هذه المسارات/السياقات: `route /classes`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/ClassesPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `className`, `section`, `gradeLevelId`, `academicYearId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/classes`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Class` داخل `Academic Structure`

## `GET /academic-structure/grade-levels`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: grade levels list
- `admin-dashboard/src/features/academic/ClassesPage.tsx:34` (route /classes) عبر direct apiClient
- `admin-dashboard/src/features/academic/GradeLevelsPage.tsx:26` (route /grade-levels) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx:76` (route /subject-offerings) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:72` (route /subjects) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Grade Levels
- OpenAPI description: List grade levels. Allowed roles: admin.
- ENDPOINT_MAP purpose: list grade levels

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
- Postman request note: Purpose: List grade levels. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: selector source

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `array` | yes | — | — | response schema |
| `data[]` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(array)` | `array` | yes | — | — | response.data schema |
| `[]` | `object` | yes | GenericObject schema | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: grade levels list.
- يظهر ضمن هذه المسارات/السياقات: `route /classes`, `route /grade-levels`, `route /subject-offerings`, `route /subjects`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/ClassesPage.tsx`, `admin-dashboard/src/features/academic/GradeLevelsPage.tsx`, `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx`, `admin-dashboard/src/features/academic/SubjectsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /academic-structure/grade-levels`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Grade Levels` داخل `Academic Structure`

## `POST /academic-structure/grade-levels`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: grade levels form
- `admin-dashboard/src/features/academic/GradeLevelsPage.tsx:32` (route /grade-levels) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Grade Level
- OpenAPI description: Create a grade level. Allowed roles: admin.
- ENDPOINT_MAP purpose: create grade level

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `name` | `string` | yes | — | minLength=1 \| maxLength=100 | request schema (CreateGradeLevelRequest) |
| `levelOrder` | `integer` | yes | — | min=1 | request schema (CreateGradeLevelRequest) |

**Backend Validation Rules**
- `name`: minLength=1 | maxLength=100.
- `levelOrder`: min=1.
- Postman request note: Purpose: Create a grade level. Roles: admin Auth: Bearer access token required Body schema: CreateGradeLevelRequest
- ENDPOINT_MAP note: master data

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `section` | `string` | unknown | — | — | response.data example |
| `gradeLevelId` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `name`, `levelOrder`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: grade levels form.
- يظهر ضمن هذه المسارات/السياقات: `route /grade-levels`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/GradeLevelsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `className`, `section`, `gradeLevelId`, `academicYearId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/grade-levels`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Grade Level` داخل `Academic Structure`

## `PATCH /academic-structure/semesters/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: edit semester
- `admin-dashboard/src/features/academic/SemestersPage.tsx:68` (route /semesters) عبر direct apiClient

**Purpose**
- OpenAPI summary: Update Semester
- OpenAPI description: Update semester dates or activation state. Allowed roles: admin.
- ENDPOINT_MAP purpose: update semester

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Semester numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `name` | `string` | no | — | minLength=1 \| maxLength=50 | request schema (UpdateSemesterRequest) |
| `startDate` | `string` | no | — | pattern=^\d{4}-\d{2}-\d{2}$ | request schema (UpdateSemesterRequest) |
| `endDate` | `string` | no | — | pattern=^\d{4}-\d{2}-\d{2}$ | request schema (UpdateSemesterRequest) |
| `isActive` | `boolean` | no | — | — | request schema (UpdateSemesterRequest) |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- `name`: minLength=1 | maxLength=50.
- `startDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `endDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: Update semester dates or activation state. Roles: admin Auth: Bearer access token required Body schema: UpdateSemesterRequest
- ENDPOINT_MAP note: يؤثر على reporting period

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `name` | `string` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- body موجودة لكن الحقول الإلزامية ليست محددة بالكامل في schema المرجعية؛ تم الاعتماد على examples فقط حيث أمكن.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: edit semester.
- يظهر ضمن هذه المسارات/السياقات: `route /semesters`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SemestersPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `name`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`
- `PATCH /academic-structure/academic-years/{id}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Update Semester` داخل `Academic Structure`

## `GET /academic-structure/subject-offerings`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: semester subject availability list
- `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx:99` (route /subject-offerings) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx:124` (route /subject-offerings) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:88` (route /subjects) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:141` (route /subjects) عبر direct apiClient
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:95` (route /assessments) عبر direct apiClient
- `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:85` (route /attendance) عبر direct apiClient
- `admin-dashboard/src/features/homework/HomeworkListPage.tsx:83` (route /homework) عبر direct apiClient

**Purpose**
- OpenAPI summary: [NEW] List Subject Offerings
- OpenAPI description: List subject offerings with optional academic year, semester, grade level, subject, and activation filters. Allowed roles: admin. Note: [NEW] This is the canonical list surface for semester-aware subject availability.
- ENDPOINT_MAP purpose: list subject offerings

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `academicYearId` | `query` | `string` | no | Filter by academic year id. | pattern=^[0-9]+$ |
| `semesterId` | `query` | `string` | no | Filter by semester id. | pattern=^[0-9]+$ |
| `gradeLevelId` | `query` | `string` | no | Filter by grade level id. | pattern=^[0-9]+$ |
| `subjectId` | `query` | `string` | no | Filter by subject id. | pattern=^[0-9]+$ |
| `isActive` | `query` | `boolean` | no | Filter by activation state. | — |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `academicYearId`: pattern=^[0-9]+$.
- `semesterId`: pattern=^[0-9]+$.
- `gradeLevelId`: pattern=^[0-9]+$.
- `subjectId`: pattern=^[0-9]+$.
- Postman request note: Purpose: List subject offerings with optional academic year, semester, grade level, subject, and activation filters. Roles: admin Auth: Bearer access token required Query params: academicYearId, semesterId, gradeLevelId, subjectId, isActive Note: [NEW] This is the canonical list surface for semester-aware subject availability.
- ENDPOINT_MAP note: canonical semester-aware subject surface

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `array` | yes | — | — | response schema |
| `data[]` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(array)` | `array` | yes | — | — | response.data schema |
| `[]` | `object` | yes | GenericObject schema | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: semester subject availability list.
- يظهر ضمن هذه المسارات/السياقات: `route /subject-offerings`, `route /subjects`, `route /assessments`, `route /attendance`, `route /homework`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx`, `admin-dashboard/src/features/academic/SubjectsPage.tsx`, `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`, `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx`, `admin-dashboard/src/features/homework/HomeworkListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /academic-structure/subject-offerings`
- `PATCH /academic-structure/subject-offerings/{id}`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `[NEW] List Subject Offerings` داخل `Academic Structure`

## `POST /academic-structure/subject-offerings`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: semester subject activation form
- `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx:138` (route /subject-offerings) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:155` (route /subjects) عبر direct apiClient

**Purpose**
- OpenAPI summary: [NEW] Create Subject Offering
- OpenAPI description: Link an existing subject to a semester without changing the subject master data. Allowed roles: admin. Note: [NEW] Subject offerings are the official semester-aware layer for subject availability.
- ENDPOINT_MAP purpose: create subject offering

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `subjectId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateSubjectOfferingRequest) |
| `semesterId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateSubjectOfferingRequest) |
| `isActive` | `boolean` | no | — | — | request schema (CreateSubjectOfferingRequest) |

**Backend Validation Rules**
- `subjectId`: pattern=^[0-9]+$.
- `semesterId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Link an existing subject to a semester without changing the subject master data. Roles: admin Auth: Bearer access token required Body schema: CreateSubjectOfferingRequest Note: [NEW] Subject offerings are the official semester-aware layer for subject availability.
- ENDPOINT_MAP note: use after subject creation when the subject should be available in a semester

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |
| `subject.id` | `string` | unknown | — | — | response.data example |
| `subject.name` | `string` | unknown | — | — | response.data example |
| `subject.code` | `string` | unknown | — | — | response.data example |
| `subject.isActive` | `boolean` | unknown | — | — | response.data example |
| `subject.gradeLevel.id` | `string` | unknown | — | — | response.data example |
| `subject.gradeLevel.name` | `string` | unknown | — | — | response.data example |
| `subject.gradeLevel.levelOrder` | `number` | unknown | — | — | response.data example |
| `semester.id` | `string` | unknown | — | — | response.data example |
| `semester.name` | `string` | unknown | — | — | response.data example |
| `semester.startDate` | `string` | unknown | — | — | response.data example |
| `semester.endDate` | `string` | unknown | — | — | response.data example |
| `semester.isActive` | `boolean` | unknown | — | — | response.data example |
| `semester.academicYear.id` | `string` | unknown | — | — | response.data example |
| `semester.academicYear.name` | `string` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |
| `updatedAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `subjectId`, `semesterId`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: semester subject activation form.
- يظهر ضمن هذه المسارات/السياقات: `route /subject-offerings`, `route /subjects`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx`, `admin-dashboard/src/features/academic/SubjectsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `isActive`, `subject`, `semester`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/subject-offerings`
- `PATCH /academic-structure/subject-offerings/{id}`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `[NEW] Create Subject Offering` داخل `Academic Structure`

## `PATCH /academic-structure/subject-offerings/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: offering status action
- `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx:167` (route /subject-offerings) عبر direct apiClient

**Purpose**
- OpenAPI summary: [NEW] Update Subject Offering
- OpenAPI description: Update a subject offering activation state. This round only supports isActive changes. Allowed roles: admin.
- ENDPOINT_MAP purpose: update subject offering

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Subject offering numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `isActive` | `boolean` | yes | — | — | request schema (UpdateSubjectOfferingRequest) |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Update a subject offering activation state. This round only supports isActive changes. Roles: admin Auth: Bearer access token required Body schema: UpdateSubjectOfferingRequest
- ENDPOINT_MAP note: current round supports activation state only

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |
| `subject.id` | `string` | unknown | — | — | response.data example |
| `subject.name` | `string` | unknown | — | — | response.data example |
| `subject.code` | `string` | unknown | — | — | response.data example |
| `subject.isActive` | `boolean` | unknown | — | — | response.data example |
| `subject.gradeLevel.id` | `string` | unknown | — | — | response.data example |
| `subject.gradeLevel.name` | `string` | unknown | — | — | response.data example |
| `subject.gradeLevel.levelOrder` | `number` | unknown | — | — | response.data example |
| `semester.id` | `string` | unknown | — | — | response.data example |
| `semester.name` | `string` | unknown | — | — | response.data example |
| `semester.startDate` | `string` | unknown | — | — | response.data example |
| `semester.endDate` | `string` | unknown | — | — | response.data example |
| `semester.isActive` | `boolean` | unknown | — | — | response.data example |
| `semester.academicYear.id` | `string` | unknown | — | — | response.data example |
| `semester.academicYear.name` | `string` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |
| `updatedAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `isActive`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: offering status action.
- يظهر ضمن هذه المسارات/السياقات: `route /subject-offerings`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `isActive`, `subject`, `semester`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/subject-offerings`
- `POST /academic-structure/subject-offerings`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `[NEW] Update Subject Offering` داخل `Academic Structure`

## `GET /academic-structure/subjects`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: subjects list
- `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx:81` (route /subject-offerings) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:78` (route /subjects) عبر direct apiClient
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:126` (route /subjects) عبر direct apiClient
- `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx:73` (route /teacher-assignments) عبر direct apiClient
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:71` (route /assessments) عبر direct apiClient
- `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:61` (route /attendance) عبر direct apiClient
- `admin-dashboard/src/features/homework/HomeworkListPage.tsx:52` (route /homework) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Subjects
- OpenAPI description: List subjects. Allowed roles: admin.
- ENDPOINT_MAP purpose: list subjects

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
- Postman request note: Purpose: List subjects. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: selector source

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `array` | yes | — | — | response schema |
| `data[]` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(array)` | `array` | yes | — | — | response.data schema |
| `[]` | `object` | yes | GenericObject schema | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: subjects list.
- يظهر ضمن هذه المسارات/السياقات: `route /subject-offerings`, `route /subjects`, `route /teacher-assignments`, `route /assessments`, `route /attendance`, `route /homework`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SubjectOfferingsPage.tsx`, `admin-dashboard/src/features/academic/SubjectsPage.tsx`, `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx`, `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`, `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx`, `admin-dashboard/src/features/homework/HomeworkListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /academic-structure/subjects`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Subjects` داخل `Academic Structure`

## `POST /academic-structure/subjects`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: subjects form
- `admin-dashboard/src/features/academic/SubjectsPage.tsx:118` (route /subjects) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Subject
- OpenAPI description: Create a subject under a grade level. Subjects remain grade-level master data and do not accept semesterId. Allowed roles: admin. Note: Use subject-offerings to link a subject into one or more semesters without changing the subject master record.
- ENDPOINT_MAP purpose: create subject

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `name` | `string` | yes | — | minLength=1 \| maxLength=100 | request schema (CreateSubjectRequest) |
| `gradeLevelId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateSubjectRequest) |
| `code` | `string` | no | — | maxLength=50 | request schema (CreateSubjectRequest) |
| `isActive` | `boolean` | no | — | — | request schema (CreateSubjectRequest) |

**Backend Validation Rules**
- `name`: minLength=1 | maxLength=100.
- `gradeLevelId`: pattern=^[0-9]+$.
- `code`: maxLength=50.
- Postman request note: Purpose: Create a subject under a grade level. Subjects remain grade-level master data and do not accept semesterId. Roles: admin Auth: Bearer access token required Body schema: CreateSubjectRequest Note: Use subject-offerings to link a subject into one or more semesters without changing the subject master record.
- ENDPOINT_MAP note: create master subject only; semester availability is handled by `subject-offerings`

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `name` | `string` | unknown | — | — | response.data example |
| `code` | `string` | unknown | — | — | response.data example |
| `gradeLevelId` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `name`, `gradeLevelId`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: subjects form.
- يظهر ضمن هذه المسارات/السياقات: `route /subjects`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SubjectsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `name`, `code`, `gradeLevelId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/subjects`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Subject` داخل `Academic Structure`

## `GET /academic-structure/supervisor-assignments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: assignments list
- `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx:79` (route /supervisor-assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Supervisor Assignments
- OpenAPI description: List supervisor assignments. Allowed roles: admin.
- ENDPOINT_MAP purpose: list supervisor assignments

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
- Postman request note: Purpose: List supervisor assignments. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: admin oversight

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `array` | yes | — | — | response schema |
| `data[]` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(array)` | `array` | yes | — | — | response.data schema |
| `[]` | `object` | yes | GenericObject schema | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: assignments list.
- يظهر ضمن هذه المسارات/السياقات: `route /supervisor-assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /academic-structure/supervisor-assignments`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Supervisor Assignments` داخل `Academic Structure`

## `POST /academic-structure/supervisor-assignments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: assignment form
- `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx:105` (route /supervisor-assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Supervisor Assignment
- OpenAPI description: Assign a supervisor to a class for an academic year. Allowed roles: admin.
- ENDPOINT_MAP purpose: assign supervisor

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `supervisorId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateSupervisorAssignmentRequest) |
| `classId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateSupervisorAssignmentRequest) |
| `academicYearId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateSupervisorAssignmentRequest) |

**Backend Validation Rules**
- `supervisorId`: pattern=^[0-9]+$.
- `classId`: pattern=^[0-9]+$.
- `academicYearId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Assign a supervisor to a class for an academic year. Roles: admin Auth: Bearer access token required Body schema: CreateSupervisorAssignmentRequest
- ENDPOINT_MAP note: foundation لتطبيق المشرف

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `section` | `string` | unknown | — | — | response.data example |
| `gradeLevelId` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `supervisorId`, `classId`, `academicYearId`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: assignment form.
- يظهر ضمن هذه المسارات/السياقات: `route /supervisor-assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `className`, `section`, `gradeLevelId`, `academicYearId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/supervisor-assignments`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Supervisor Assignment` داخل `Academic Structure`

## `GET /academic-structure/teacher-assignments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: assignments list
- `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx:86` (route /teacher-assignments) عبر direct apiClient
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:81` (route /assessments) عبر direct apiClient
- `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:71` (route /attendance) عبر direct apiClient
- `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:102` (route /behavior) عبر direct apiClient
- `admin-dashboard/src/features/homework/HomeworkListPage.tsx:62` (route /homework) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Teacher Assignments
- OpenAPI description: List teacher assignments. Allowed roles: admin.
- ENDPOINT_MAP purpose: list teacher assignments

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
- Postman request note: Purpose: List teacher assignments. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: admin oversight

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `array` | yes | — | — | response schema |
| `data[]` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(array)` | `array` | yes | — | — | response.data schema |
| `[]` | `object` | yes | GenericObject schema | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: assignments list.
- يظهر ضمن هذه المسارات/السياقات: `route /teacher-assignments`, `route /assessments`, `route /attendance`, `route /behavior`, `route /homework`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx`, `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`, `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx`, `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx`, `admin-dashboard/src/features/homework/HomeworkListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /academic-structure/teacher-assignments`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Teacher Assignments` داخل `Academic Structure`

## `POST /academic-structure/teacher-assignments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: assignment form
- `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx:112` (route /teacher-assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Teacher Assignment
- OpenAPI description: Assign a teacher to a class and subject for an academic year. Allowed roles: admin.
- ENDPOINT_MAP purpose: assign teacher

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `teacherId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateTeacherAssignmentRequest) |
| `classId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateTeacherAssignmentRequest) |
| `subjectId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateTeacherAssignmentRequest) |
| `academicYearId` | `string` | yes | — | pattern=^[0-9]+$ | request schema (CreateTeacherAssignmentRequest) |

**Backend Validation Rules**
- `teacherId`: pattern=^[0-9]+$.
- `classId`: pattern=^[0-9]+$.
- `subjectId`: pattern=^[0-9]+$.
- `academicYearId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Assign a teacher to a class and subject for an academic year. Roles: admin Auth: Bearer access token required Body schema: CreateTeacherAssignmentRequest
- ENDPOINT_MAP note: foundation لتطبيق المعلم

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `id` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `section` | `string` | unknown | — | — | response.data example |
| `gradeLevelId` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `teacherId`, `classId`, `subjectId`, `academicYearId`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: assignment form.
- يظهر ضمن هذه المسارات/السياقات: `route /teacher-assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `className`, `section`, `gradeLevelId`, `academicYearId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /academic-structure/teacher-assignments`
- `GET /academic-structure/academic-years`
- `POST /academic-structure/academic-years`
- `GET /academic-structure/academic-years/{academicYearId}/semesters`
- `POST /academic-structure/academic-years/{academicYearId}/semesters`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Teacher Assignment` داخل `Academic Structure`
