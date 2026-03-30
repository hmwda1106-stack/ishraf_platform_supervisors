# Students

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Students**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `GET /students`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: students list
- `admin-dashboard/src/features/reporting/ReportsHubPage.tsx:37` (route /reports) عبر useListQuery
- `admin-dashboard/src/features/students/student-workflows.ts:85` ([helper] student workflows) عبر direct apiClient
- `admin-dashboard/src/features/students/student-workflows.ts:114` ([helper] student workflows) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentsListPage.tsx:97` (route /students) عبر useListQuery

**Purpose**
- OpenAPI summary: List Students
- OpenAPI description: List students with pagination and filters. Allowed roles: admin.
- ENDPOINT_MAP purpose: list students

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `page` | `query` | `integer` | no | Pagination page number. | min=1 |
| `limit` | `query` | `integer` | no | Pagination page size. | min=1 \| max=100 |
| `sortBy` | `query` | `string (createdAt, academicNo, fullName, enrollmentDate)` | no | Sort field whitelist. | enum=createdAt, academicNo, fullName, enrollmentDate |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `classId` | `query` | `string` | no | Filter by class id. | pattern=^[0-9]+$ |
| `academicYearId` | `query` | `string` | no | Filter by academic year id. | pattern=^[0-9]+$ |
| `status` | `query` | `string` | no | Filter by student status. | — |
| `gender` | `query` | `string` | no | Filter by gender. | — |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=createdAt, academicNo, fullName, enrollmentDate.
- `sortOrder`: enum=asc, desc.
- `classId`: pattern=^[0-9]+$.
- `academicYearId`: pattern=^[0-9]+$.
- Postman request note: Purpose: List students with pagination and filters. Roles: admin Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, classId, academicYearId, status, gender
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: students list.
- يظهر ضمن هذه المسارات/السياقات: `route /reports`, `[helper] student workflows`, `route /students`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/reporting/ReportsHubPage.tsx`, `admin-dashboard/src/features/students/student-workflows.ts`, `admin-dashboard/src/features/students/StudentsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /students`
- `GET /students/{id}`
- `PATCH /students/{id}`
- `GET /students/{id}/parents`
- `POST /students/{id}/parents`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Students` داخل `Students`

## `POST /students`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: create student form
- `admin-dashboard/src/features/students/CreateStudentPage.tsx:185` (route /students/create) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Student
- OpenAPI description: Create a student in the selected class. Allowed roles: admin.
- ENDPOINT_MAP purpose: create student

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
| `academicNo` | `string` | unknown | — | — | request example |
| `fullName` | `string` | unknown | — | — | request example |
| `dateOfBirth` | `string` | unknown | — | — | request example |
| `gender` | `string` | unknown | — | — | request example |
| `classId` | `string` | unknown | — | — | request example |
| `status` | `string` | unknown | — | — | request example |
| `enrollmentDate` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a student in the selected class. Roles: admin Auth: Bearer access token required Body schema: CreateStudentRequest
- ENDPOINT_MAP note: duplicate academic number -> `409`

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
| `academicNo` | `string` | unknown | — | — | response.data example |
| `fullName` | `string` | unknown | — | — | response.data example |
| `gender` | `string` | unknown | — | — | response.data example |
| `status` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `section` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `academicNo`, `fullName`, `dateOfBirth`, `gender`, `classId`, `status`, `enrollmentDate`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: create student form.
- يظهر ضمن هذه المسارات/السياقات: `route /students/create`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/CreateStudentPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `academicNo`, `fullName`, `gender`, `status`, `classId`, `className`, `section`, `academicYearId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /students`
- `GET /students/{id}`
- `PATCH /students/{id}`
- `GET /students/{id}/parents`
- `POST /students/{id}/parents`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Student` داخل `Students`

## `GET /students/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student detail
- `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:124` (route /behavior) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:169` (route /students/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Student
- OpenAPI description: Return one student by id. Allowed roles: admin.
- ENDPOINT_MAP purpose: student detail

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Student numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return one student by id. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: basis for profile page

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
| `academicNo` | `string` | unknown | — | — | response.data example |
| `fullName` | `string` | unknown | — | — | response.data example |
| `gender` | `string` | unknown | — | — | response.data example |
| `status` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `section` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student detail.
- يظهر ضمن هذه المسارات/السياقات: `route /behavior`, `route /students/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx`, `admin-dashboard/src/features/students/StudentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `academicNo`, `fullName`, `gender`, `status`, `classId`, `className`, `section`, `academicYearId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /students`
- `POST /students`
- `PATCH /students/{id}`
- `GET /students/{id}/parents`
- `POST /students/{id}/parents`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Student` داخل `Students`

## `PATCH /students/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: edit student
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:255` (route /students/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Update Student
- OpenAPI description: Update student profile fields and lifecycle status. Allowed roles: admin.
- ENDPOINT_MAP purpose: update student

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Student numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `fullName` | `string` | unknown | — | — | request example |
| `status` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Update student profile fields and lifecycle status. Roles: admin Auth: Bearer access token required Body schema: UpdateStudentRequest
- ENDPOINT_MAP note: class/year changes affect downstream modules

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
| `academicNo` | `string` | unknown | — | — | response.data example |
| `fullName` | `string` | unknown | — | — | response.data example |
| `gender` | `string` | unknown | — | — | response.data example |
| `status` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `section` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `fullName`, `status`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: edit student.
- يظهر ضمن هذه المسارات/السياقات: `route /students/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/StudentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `academicNo`, `fullName`, `gender`, `status`, `classId`, `className`, `section`, `academicYearId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /students`
- `POST /students`
- `GET /students/{id}`
- `GET /students/{id}/parents`
- `POST /students/{id}/parents`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Update Student` داخل `Students`

## `GET /students/{id}/parents`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: parents tab
- `admin-dashboard/src/features/students/student-workflows.ts:149` ([helper] student workflows) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:174` (route /students/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Student Parents
- OpenAPI description: Return parent links for one student. Allowed roles: admin.
- ENDPOINT_MAP purpose: list linked parents

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Student numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return parent links for one student. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: required in student detail

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: parents tab.
- يظهر ضمن هذه المسارات/السياقات: `[helper] student workflows`, `route /students/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/student-workflows.ts`, `admin-dashboard/src/features/students/StudentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /students/{id}/parents`
- `GET /students`
- `POST /students`
- `GET /students/{id}`
- `PATCH /students/{id}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Student Parents` داخل `Students`

## `POST /students/{id}/parents`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: parent linking form
- `admin-dashboard/src/features/students/student-workflows.ts:157` ([helper] student workflows) عبر direct apiClient

**Purpose**
- OpenAPI summary: Link Parent to Student
- OpenAPI description: Link an existing parent to a student. parentId may be either the parent user id returned by /users?role=parent or the underlying parent profile id. Allowed roles: admin. Note: The backend resolves parentId to the stored parent profile id automatically. Prefer sending the user id returned by /users?role=parent in admin frontend flows.
- ENDPOINT_MAP purpose: link parent

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Student numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `parentId` | `string` | unknown | — | — | request example |
| `relationType` | `string` | unknown | — | — | request example |
| `isPrimary` | `boolean` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Link an existing parent to a student. parentId may be either the parent user id returned by /users?role=parent or the underlying parent profile id. Roles: admin Auth: Bearer access token required Body schema: LinkStudentParentRequest Note: The backend resolves parentId to the stored parent profile id automatically. Prefer sending the user id returned by /users?role=parent in admin frontend flows.
- ENDPOINT_MAP note: prefer `users.id` from `/users?role=parent`; backend also accepts `parents.id`; duplicate link -> `409`

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
| `fullName` | `string` | unknown | — | — | response.data example |
| `email` | `string` | unknown | — | — | response.data example |
| `phone` | `string` | unknown | — | — | response.data example |
| `role` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |
| `updatedAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `parentId`, `relationType`, `isPrimary`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: parent linking form.
- يظهر ضمن هذه المسارات/السياقات: `[helper] student workflows`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/student-workflows.ts`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /students/{id}/parents`
- `GET /students`
- `POST /students`
- `GET /students/{id}`
- `PATCH /students/{id}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Link Parent to Student` داخل `Students`

## `POST /students/{id}/promotions`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: promotion form
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:323` (route /students/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Promote Student
- OpenAPI description: Promote a student to another class for a target academic year. Allowed roles: admin.
- ENDPOINT_MAP purpose: promote student

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Student numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `toClassId` | `string` | unknown | — | — | request example |
| `academicYearId` | `string` | unknown | — | — | request example |
| `notes` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Promote a student to another class for a target academic year. Roles: admin Auth: Bearer access token required Body schema: PromoteStudentRequest
- ENDPOINT_MAP note: needs confirmation

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
| `academicNo` | `string` | unknown | — | — | response.data example |
| `fullName` | `string` | unknown | — | — | response.data example |
| `gender` | `string` | unknown | — | — | response.data example |
| `status` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `className` | `string` | unknown | — | — | response.data example |
| `section` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `toClassId`, `academicYearId`, `notes`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: promotion form.
- يظهر ضمن هذه المسارات/السياقات: `route /students/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/StudentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `academicNo`, `fullName`, `gender`, `status`, `classId`, `className`, `section`, `academicYearId`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /students`
- `POST /students`
- `GET /students/{id}`
- `PATCH /students/{id}`
- `GET /students/{id}/parents`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Promote Student` داخل `Students`

## `PATCH /students/{studentId}/parents/{parentId}/primary`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: parent actions
- `admin-dashboard/src/features/students/student-workflows.ts:165` ([helper] student workflows) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:310` (route /students/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Set Primary Parent
- OpenAPI description: Mark one linked parent as the primary parent for that student. parentId may be either the parent user id returned by /users?role=parent or the underlying parent profile id. Allowed roles: admin. Note: The backend resolves parentId to the stored parent profile id automatically. Prefer sending the user id returned by /users?role=parent in admin frontend flows.
- ENDPOINT_MAP purpose: set primary parent

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `studentId` | `path` | `string` | yes | Student numeric string identifier. This is the same id used by /students/:id. | pattern=^[0-9]+$ |
| `parentId` | `path` | `string` | yes | Parent identifier. These student-parent endpoints accept either the parent user id from /users?role=parent or the underlying parent profile id. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `studentId`: pattern=^[0-9]+$.
- `parentId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Mark one linked parent as the primary parent for that student. parentId may be either the parent user id returned by /users?role=parent or the underlying parent profile id. Roles: admin Auth: Bearer access token required Note: The backend resolves parentId to the stored parent profile id automatically. Prefer sending the user id returned by /users?role=parent in admin frontend flows.
- ENDPOINT_MAP note: `parentId` may be the parent `users.id` from `/users?role=parent` or the stored `parents.id`; prefer `users.id` in admin UI

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
| `fullName` | `string` | unknown | — | — | response.data example |
| `email` | `string` | unknown | — | — | response.data example |
| `phone` | `string` | unknown | — | — | response.data example |
| `role` | `string` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |
| `updatedAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `studentId`, `parentId`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: parent actions.
- يظهر ضمن هذه المسارات/السياقات: `[helper] student workflows`, `route /students/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/student-workflows.ts`, `admin-dashboard/src/features/students/StudentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /students`
- `POST /students`
- `GET /students/{id}`
- `PATCH /students/{id}`
- `GET /students/{id}/parents`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Set Primary Parent` داخل `Students`
