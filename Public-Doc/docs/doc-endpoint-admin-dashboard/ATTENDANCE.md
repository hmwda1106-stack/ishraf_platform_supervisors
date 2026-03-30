# Attendance

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Attendance**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `PATCH /attendance/records/{attendanceId}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: detail action
- `admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx:70` (route /attendance/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Update Attendance Record
- OpenAPI description: Update one attendance record status or notes. Allowed roles: admin, teacher, supervisor. Side effects: If the record changes into absent, the internal automation service may create notifications for linked parents.
- ENDPOINT_MAP purpose: update one record

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `attendanceId` | `path` | `string` | yes | Attendance record numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `status` | `string` | unknown | — | — | request example |
| `notes` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `attendanceId`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Update one attendance record status or notes. Roles: admin, teacher, supervisor Auth: Bearer access token required Body schema: UpdateAttendanceRecordRequest Side effects: If the record changes into absent, the internal automation service may create notifications for linked parents.
- ENDPOINT_MAP note: may trigger absent automation

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `attendanceId` | `string` | unknown | — | — | response.data example |
| `attendanceSessionId` | `string` | unknown | — | — | response.data example |
| `studentId` | `string` | unknown | — | — | response.data example |
| `fullName` | `string` | unknown | — | — | response.data example |
| `status` | `string` | unknown | — | — | response.data example |
| `recordedAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `attendanceId`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `status`, `notes`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: detail action.
- يظهر ضمن هذه المسارات/السياقات: `route /attendance/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `attendanceId`, `attendanceSessionId`, `studentId`, `fullName`, `status`, `recordedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /attendance/sessions`
- `POST /attendance/sessions`
- `GET /attendance/sessions/{id}`
- `PUT /attendance/sessions/{id}/records`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Update Attendance Record` داخل `Attendance`

## `GET /attendance/sessions`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: sessions list
- `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:101` (route /attendance) عبر useListQuery

**Purpose**
- OpenAPI summary: List Attendance Sessions
- OpenAPI description: List attendance sessions with pagination. There is no root /attendance endpoint. Allowed roles: admin, teacher, supervisor. Note: Empty collections return 200 with items=[] and pagination metadata.
- ENDPOINT_MAP purpose: list sessions

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `page` | `query` | `integer` | no | Pagination page number. | min=1 |
| `limit` | `query` | `integer` | no | Pagination page size. | min=1 \| max=100 |
| `sortBy` | `query` | `string (sessionDate, periodNo, createdAt)` | no | Sort field whitelist. | enum=sessionDate, periodNo, createdAt |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `classId` | `query` | `string` | no | Filter by class id. | pattern=^[0-9]+$ |
| `subjectId` | `query` | `string` | no | Filter by subject id. | pattern=^[0-9]+$ |
| `teacherId` | `query` | `string` | no | Filter by teacher profile id. | pattern=^[0-9]+$ |
| `academicYearId` | `query` | `string` | no | Filter by academic year id. | pattern=^[0-9]+$ |
| `semesterId` | `query` | `string` | no | Filter by semester id. | pattern=^[0-9]+$ |
| `sessionDate` | `query` | `string` | no | Filter by exact session date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateFrom` | `query` | `string` | no | Filter from session date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateTo` | `query` | `string` | no | Filter to session date. | pattern=^\d{4}-\d{2}-\d{2}$ |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=sessionDate, periodNo, createdAt.
- `sortOrder`: enum=asc, desc.
- `classId`: pattern=^[0-9]+$.
- `subjectId`: pattern=^[0-9]+$.
- `teacherId`: pattern=^[0-9]+$.
- `academicYearId`: pattern=^[0-9]+$.
- `semesterId`: pattern=^[0-9]+$.
- `sessionDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateFrom`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateTo`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: List attendance sessions with pagination. There is no root /attendance endpoint. Roles: admin, teacher, supervisor Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, classId, subjectId, teacherId, academicYearId, semesterId, sessionDate, dateFrom, dateTo Note: Empty collections return 200 with items=[] and pagination metadata.
- ENDPOINT_MAP note: paginated

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data.items` | `array` | yes | — | — | response schema |
| `data.items[]` | `object` | yes | GenericObject schema | — | response schema |
| `data.pagination.page` | `integer` | yes | — | min=1 | response schema (Pagination) |
| `data.pagination.limit` | `integer` | yes | — | min=1 \| max=100 | response schema (Pagination) |
| `data.pagination.totalItems` | `integer` | yes | — | min=0 | response schema (Pagination) |
| `data.pagination.totalPages` | `integer` | yes | — | min=0 | response schema (Pagination) |
| `data.unreadCount` | `integer` | no | — | min=0 | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `items` | `array` | yes | — | — | response.data schema |
| `items[]` | `object` | yes | GenericObject schema | — | response.data schema |
| `pagination.page` | `integer` | yes | — | min=1 | response.data schema (Pagination) |
| `pagination.limit` | `integer` | yes | — | min=1 \| max=100 | response.data schema (Pagination) |
| `pagination.totalItems` | `integer` | yes | — | min=0 | response.data schema (Pagination) |
| `pagination.totalPages` | `integer` | yes | — | min=0 | response.data schema (Pagination) |
| `unreadCount` | `integer` | no | — | min=0 | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data.items`, `data.items[]`, `data.pagination.page`, `data.pagination.limit`, `data.pagination.totalItems`, `data.pagination.totalPages`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: sessions list.
- يظهر ضمن هذه المسارات/السياقات: `route /attendance`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /attendance/sessions`
- `GET /attendance/sessions/{id}`
- `PUT /attendance/sessions/{id}/records`
- `PATCH /attendance/records/{attendanceId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Attendance Sessions` داخل `Attendance`

## `POST /attendance/sessions`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: create session form
- `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:157` (route /attendance) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Attendance Session
- OpenAPI description: Create an attendance session for a class and subject. Allowed roles: admin, teacher. Note: The selected subjectId must have an active subject offering for the selected semesterId.
- ENDPOINT_MAP purpose: create session

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `classId` | `string` | unknown | — | — | request example |
| `subjectId` | `string` | unknown | — | — | request example |
| `academicYearId` | `string` | unknown | — | — | request example |
| `semesterId` | `string` | unknown | — | — | request example |
| `sessionDate` | `string` | unknown | — | — | request example |
| `periodNo` | `number` | unknown | — | — | request example |
| `title` | `string` | unknown | — | — | request example |
| `notes` | `string` | unknown | — | — | request example |
| `teacherId` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create an attendance session for a class and subject. Roles: admin, teacher Auth: Bearer access token required Body schema: CreateAttendanceSessionRequest Note: The selected subjectId must have an active subject offering for the selected semesterId.
- ENDPOINT_MAP note: no root `/attendance` endpoint; duplicate session handled as conflict; subject must have active offering for the selected semester

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
| `classId` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `subjectId` | `string` | unknown | — | — | response.data example |
| `subjectName` | `string` | unknown | — | — | response.data example |
| `sessionDate` | `string` | unknown | — | — | response.data example |
| `periodNo` | `number` | unknown | — | — | response.data example |
| `presentCount` | `number` | unknown | — | — | response.data example |
| `absentCount` | `number` | unknown | — | — | response.data example |
| `expectedCount` | `number` | unknown | — | — | response.data example |
| `recordedCount` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `classId`, `subjectId`, `academicYearId`, `semesterId`, `sessionDate`, `periodNo`, `title`, `notes`, `teacherId`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: create session form.
- يظهر ضمن هذه المسارات/السياقات: `route /attendance`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `classId`, `className`, `subjectId`, `subjectName`, `sessionDate`, `periodNo`, `presentCount`, `absentCount`, `expectedCount`, `recordedCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /attendance/sessions`
- `GET /attendance/sessions/{id}`
- `PUT /attendance/sessions/{id}/records`
- `PATCH /attendance/records/{attendanceId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Attendance Session` داخل `Attendance`

## `GET /attendance/sessions/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: session detail
- `admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx:38` (route /attendance/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Attendance Session
- OpenAPI description: Return one attendance session including its student roster. Allowed roles: admin, teacher, supervisor.
- ENDPOINT_MAP purpose: session detail

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Attendance session numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return one attendance session including its student roster. Roles: admin, teacher, supervisor Auth: Bearer access token required
- ENDPOINT_MAP note: before mark/update

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
| `classId` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `subjectId` | `string` | unknown | — | — | response.data example |
| `subjectName` | `string` | unknown | — | — | response.data example |
| `sessionDate` | `string` | unknown | — | — | response.data example |
| `periodNo` | `number` | unknown | — | — | response.data example |
| `presentCount` | `number` | unknown | — | — | response.data example |
| `absentCount` | `number` | unknown | — | — | response.data example |
| `expectedCount` | `number` | unknown | — | — | response.data example |
| `recordedCount` | `number` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: session detail.
- يظهر ضمن هذه المسارات/السياقات: `route /attendance/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `classId`, `className`, `subjectId`, `subjectName`, `sessionDate`, `periodNo`, `presentCount`, `absentCount`, `expectedCount`, `recordedCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /attendance/sessions`
- `POST /attendance/sessions`
- `PUT /attendance/sessions/{id}/records`
- `PATCH /attendance/records/{attendanceId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Attendance Session` داخل `Attendance`

## `PUT /attendance/sessions/{id}/records`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: mark attendance screen
- `admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx:59` (route /attendance/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Save Attendance Records
- OpenAPI description: Save the full attendance roster snapshot for one session. Allowed roles: admin, teacher, supervisor. Side effects: Any newly absent record can trigger parent notifications through the internal automation service.
- ENDPOINT_MAP purpose: bulk save records

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Attendance session numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `records` | `array` | unknown | — | — | request example |
| `records[].studentId` | `string` | unknown | — | — | request example |
| `records[].status` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Save the full attendance roster snapshot for one session. Roles: admin, teacher, supervisor Auth: Bearer access token required Body schema: SaveAttendanceRecordsRequest Side effects: Any newly absent record can trigger parent notifications through the internal automation service.
- ENDPOINT_MAP note: full roster snapshot required; absent triggers automation

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
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `records`, `records[].studentId`, `records[].status`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`, `data[]`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: mark attendance screen.
- يظهر ضمن هذه المسارات/السياقات: `route /attendance/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/attendance/AttendanceSessionDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /attendance/sessions`
- `POST /attendance/sessions`
- `GET /attendance/sessions/{id}`
- `PATCH /attendance/records/{attendanceId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Save Attendance Records` داخل `Attendance`
