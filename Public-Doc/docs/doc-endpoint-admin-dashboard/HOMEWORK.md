# Homework

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Homework**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `GET /homework`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: homework list
- `admin-dashboard/src/features/homework/HomeworkListPage.tsx:102` (route /homework) عبر useListQuery

**Purpose**
- OpenAPI summary: List Homework
- OpenAPI description: List homework with pagination and academic filters. Allowed roles: admin, teacher. Derived data: Homework lists are enriched by SQL views such as vw_homework_details.
- ENDPOINT_MAP purpose: list homework

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `page` | `query` | `integer` | no | Pagination page number. | min=1 |
| `limit` | `query` | `integer` | no | Pagination page size. | min=1 \| max=100 |
| `sortBy` | `query` | `string (dueDate, assignedDate, createdAt, title)` | no | Sort field whitelist. | enum=dueDate, assignedDate, createdAt, title |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `classId` | `query` | `string` | no | Filter by class id. | pattern=^[0-9]+$ |
| `subjectId` | `query` | `string` | no | Filter by subject id. | pattern=^[0-9]+$ |
| `teacherId` | `query` | `string` | no | Filter by teacher profile id. | pattern=^[0-9]+$ |
| `academicYearId` | `query` | `string` | no | Filter by academic year id. | pattern=^[0-9]+$ |
| `semesterId` | `query` | `string` | no | Filter by semester id. | pattern=^[0-9]+$ |
| `assignedDate` | `query` | `string` | no | Filter by exact assigned date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dueDate` | `query` | `string` | no | Filter by exact due date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateFrom` | `query` | `string` | no | Filter from date range. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateTo` | `query` | `string` | no | Filter to date range. | pattern=^\d{4}-\d{2}-\d{2}$ |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=dueDate, assignedDate, createdAt, title.
- `sortOrder`: enum=asc, desc.
- `classId`: pattern=^[0-9]+$.
- `subjectId`: pattern=^[0-9]+$.
- `teacherId`: pattern=^[0-9]+$.
- `academicYearId`: pattern=^[0-9]+$.
- `semesterId`: pattern=^[0-9]+$.
- `assignedDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dueDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateFrom`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateTo`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: List homework with pagination and academic filters. Roles: admin, teacher Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, classId, subjectId, teacherId, academicYearId, semesterId, assignedDate, dueDate, dateFrom, dateTo Derived data: Homework lists are enriched by SQL views such as vw_homework_details.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: homework list.
- يظهر ضمن هذه المسارات/السياقات: `route /homework`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/homework/HomeworkListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /homework`
- `GET /homework/{id}`
- `PUT /homework/{id}/submissions`
- `GET /homework/students/{studentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Homework` داخل `Homework`

## `POST /homework`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: homework form
- `admin-dashboard/src/features/homework/HomeworkListPage.tsx:156` (route /homework) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Homework
- OpenAPI description: Create homework for a class and subject. Teachers may omit teacherId and rely on the authenticated teacher profile. Allowed roles: admin, teacher. Note: The selected subjectId must have an active subject offering for the selected semesterId.
- ENDPOINT_MAP purpose: create homework

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
| `teacherId` | `string` | unknown | — | — | request example |
| `classId` | `string` | unknown | — | — | request example |
| `subjectId` | `string` | unknown | — | — | request example |
| `academicYearId` | `string` | unknown | — | — | request example |
| `semesterId` | `string` | unknown | — | — | request example |
| `title` | `string` | unknown | — | — | request example |
| `description` | `string` | unknown | — | — | request example |
| `assignedDate` | `string` | unknown | — | — | request example |
| `dueDate` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create homework for a class and subject. Teachers may omit teacherId and rely on the authenticated teacher profile. Roles: admin, teacher Auth: Bearer access token required Body schema: CreateHomeworkRequest Note: The selected subjectId must have an active subject offering for the selected semesterId.
- ENDPOINT_MAP note: admin and teacher manage; subject must have active offering for the selected semester

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
| `title` | `string` | unknown | — | — | response.data example |
| `assignedDate` | `string` | unknown | — | — | response.data example |
| `dueDate` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `subjectId` | `string` | unknown | — | — | response.data example |
| `submittedCount` | `number` | unknown | — | — | response.data example |
| `expectedCount` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `teacherId`, `classId`, `subjectId`, `academicYearId`, `semesterId`, `title`, `description`, `assignedDate`, `dueDate`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: homework form.
- يظهر ضمن هذه المسارات/السياقات: `route /homework`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/homework/HomeworkListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `title`, `assignedDate`, `dueDate`, `classId`, `subjectId`, `submittedCount`, `expectedCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /homework`
- `GET /homework/{id}`
- `PUT /homework/{id}/submissions`
- `GET /homework/students/{studentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Homework` داخل `Homework`

## `GET /homework/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: homework detail
- `admin-dashboard/src/features/homework/HomeworkDetailPage.tsx:30` (route /homework/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Homework
- OpenAPI description: Return one homework detail including roster-level submission summary. Allowed roles: admin, teacher. Derived data: Homework detail is enriched through SQL views such as vw_homework_details and vw_homework_submission_details.
- ENDPOINT_MAP purpose: homework detail

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Homework numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return one homework detail including roster-level submission summary. Roles: admin, teacher Auth: Bearer access token required Derived data: Homework detail is enriched through SQL views such as vw_homework_details and vw_homework_submission_details.
- ENDPOINT_MAP note: detail source

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
| `title` | `string` | unknown | — | — | response.data example |
| `assignedDate` | `string` | unknown | — | — | response.data example |
| `dueDate` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `subjectId` | `string` | unknown | — | — | response.data example |
| `submittedCount` | `number` | unknown | — | — | response.data example |
| `expectedCount` | `number` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: homework detail.
- يظهر ضمن هذه المسارات/السياقات: `route /homework/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/homework/HomeworkDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `title`, `assignedDate`, `dueDate`, `classId`, `subjectId`, `submittedCount`, `expectedCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /homework`
- `POST /homework`
- `PUT /homework/{id}/submissions`
- `GET /homework/students/{studentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Homework` داخل `Homework`

## `PUT /homework/{id}/submissions`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: submission management
- `admin-dashboard/src/features/homework/HomeworkDetailPage.tsx:51` (route /homework/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Save Homework Submissions
- OpenAPI description: Create or update the homework submission roster. Allowed roles: admin, teacher.
- ENDPOINT_MAP purpose: update submission state

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Homework numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `records` | `array` | unknown | — | — | request example |
| `records[].studentId` | `string` | unknown | — | — | request example |
| `records[].status` | `string` | unknown | — | — | request example |
| `records[].submittedAt` | `string` | unknown | — | — | request example |
| `records[].notes` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create or update the homework submission roster. Roles: admin, teacher Auth: Bearer access token required Body schema: SaveHomeworkSubmissionsRequest
- ENDPOINT_MAP note: suitable for admin intervention

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
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `records`, `records[].studentId`, `records[].status`, `records[].submittedAt`, `records[].notes`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: submission management.
- يظهر ضمن هذه المسارات/السياقات: `route /homework/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/homework/HomeworkDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /homework`
- `POST /homework`
- `GET /homework/{id}`
- `GET /homework/students/{studentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Save Homework Submissions` داخل `Homework`

## `GET /homework/students/{studentId}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student homework tab
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:214` (route /students/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Student Homework
- OpenAPI description: Return homework assigned to one student. Parents are restricted to their linked children. Allowed roles: admin, teacher, parent. Note: If the student exists but has no homework yet, the response remains 200 with items=[]. Derived data: Student homework uses view-backed projections such as vw_homework_details and vw_homework_submission_details.
- ENDPOINT_MAP purpose: student homework list

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `parent`
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
- Postman request note: Purpose: Return homework assigned to one student. Parents are restricted to their linked children. Roles: admin, teacher, parent Auth: Bearer access token required Note: If the student exists but has no homework yet, the response remains 200 with items=[]. Derived data: Student homework uses view-backed projections such as vw_homework_details and vw_homework_submission_details.
- ENDPOINT_MAP note: non-paginated; same `studentId` as `/students/:id`

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
| `items` | `array` | unknown | — | — | response.data example |
| `items[].homeworkId` | `string` | unknown | — | — | response.data example |
| `items[].title` | `string` | unknown | — | — | response.data example |
| `items[].status` | `string` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student homework tab.
- يظهر ضمن هذه المسارات/السياقات: `route /students/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/StudentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `items`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /homework`
- `POST /homework`
- `GET /homework/{id}`
- `PUT /homework/{id}/submissions`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Student Homework` داخل `Homework`
