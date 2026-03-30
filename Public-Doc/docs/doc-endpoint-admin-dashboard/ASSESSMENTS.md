# Assessments

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Assessments**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `GET /assessments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: assessments list
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:111` (route /assessments) عبر useListQuery

**Purpose**
- OpenAPI summary: List Assessments
- OpenAPI description: List assessments with pagination and filters. Allowed roles: admin, teacher.
- ENDPOINT_MAP purpose: list assessments

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
| `sortBy` | `query` | `string (assessmentDate, createdAt, title)` | no | Sort field whitelist. | enum=assessmentDate, createdAt, title |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `assessmentTypeId` | `query` | `string` | no | Filter by assessment type id. | pattern=^[0-9]+$ |
| `classId` | `query` | `string` | no | Filter by class id. | pattern=^[0-9]+$ |
| `subjectId` | `query` | `string` | no | Filter by subject id. | pattern=^[0-9]+$ |
| `teacherId` | `query` | `string` | no | Filter by teacher profile id. | pattern=^[0-9]+$ |
| `academicYearId` | `query` | `string` | no | Filter by academic year id. | pattern=^[0-9]+$ |
| `semesterId` | `query` | `string` | no | Filter by semester id. | pattern=^[0-9]+$ |
| `assessmentDate` | `query` | `string` | no | Filter by exact assessment date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateFrom` | `query` | `string` | no | Filter from assessment date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateTo` | `query` | `string` | no | Filter to assessment date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `isPublished` | `query` | `boolean` | no | Filter by publication state. | — |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=assessmentDate, createdAt, title.
- `sortOrder`: enum=asc, desc.
- `assessmentTypeId`: pattern=^[0-9]+$.
- `classId`: pattern=^[0-9]+$.
- `subjectId`: pattern=^[0-9]+$.
- `teacherId`: pattern=^[0-9]+$.
- `academicYearId`: pattern=^[0-9]+$.
- `semesterId`: pattern=^[0-9]+$.
- `assessmentDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateFrom`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateTo`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: List assessments with pagination and filters. Roles: admin, teacher Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, assessmentTypeId, classId, subjectId, teacherId, academicYearId, semesterId, assessmentDate, dateFrom, dateTo, isPublished
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: assessments list.
- يظهر ضمن هذه المسارات/السياقات: `route /assessments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /assessments`
- `GET /assessments/{id}`
- `GET /assessments/{id}/scores`
- `PUT /assessments/{id}/scores`
- `PATCH /assessments/scores/{studentAssessmentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Assessments` داخل `Assessments`

## `POST /assessments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: create assessment
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:178` (route /assessments) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Assessment
- OpenAPI description: Create an assessment. Teachers may omit teacherId and rely on the authenticated teacher profile. Allowed roles: admin, teacher. Note: The selected subjectId must have an active subject offering for the selected semesterId.
- ENDPOINT_MAP purpose: create assessment

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
| `assessmentTypeId` | `string` | unknown | — | — | request example |
| `classId` | `string` | unknown | — | — | request example |
| `subjectId` | `string` | unknown | — | — | request example |
| `teacherId` | `string` | unknown | — | — | request example |
| `academicYearId` | `string` | unknown | — | — | request example |
| `semesterId` | `string` | unknown | — | — | request example |
| `title` | `string` | unknown | — | — | request example |
| `description` | `string` | unknown | — | — | request example |
| `maxScore` | `number` | unknown | — | — | request example |
| `weight` | `number` | unknown | — | — | request example |
| `assessmentDate` | `string` | unknown | — | — | request example |
| `isPublished` | `boolean` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create an assessment. Teachers may omit teacherId and rely on the authenticated teacher profile. Roles: admin, teacher Auth: Bearer access token required Body schema: CreateAssessmentRequest Note: The selected subjectId must have an active subject offering for the selected semesterId.
- ENDPOINT_MAP note: depends on academic structure; subject must have active offering for the selected semester

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
| `assessmentTypeId` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `subjectId` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |
| `semesterId` | `string` | unknown | — | — | response.data example |
| `maxScore` | `number` | unknown | — | — | response.data example |
| `weight` | `number` | unknown | — | — | response.data example |
| `assessmentDate` | `string` | unknown | — | — | response.data example |
| `isPublished` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `assessmentTypeId`, `classId`, `subjectId`, `teacherId`, `academicYearId`, `semesterId`, `title`, `description`, `maxScore`, `weight`, `assessmentDate`, `isPublished`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: create assessment.
- يظهر ضمن هذه المسارات/السياقات: `route /assessments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `title`, `assessmentTypeId`, `classId`, `subjectId`, `academicYearId`, `semesterId`, `maxScore`, `weight`, `assessmentDate`, `isPublished`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /assessments`
- `GET /assessments/{id}`
- `GET /assessments/{id}/scores`
- `PUT /assessments/{id}/scores`
- `PATCH /assessments/scores/{studentAssessmentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Assessment` داخل `Assessments`

## `GET /assessments/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: detail screen
- `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx:34` (route /assessments/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Assessment
- OpenAPI description: Return one assessment detail record. Allowed roles: admin, teacher.
- ENDPOINT_MAP purpose: assessment detail

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Assessment numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: List assessment types. Roles: admin, teacher Auth: Bearer access token required
- ENDPOINT_MAP note: score entry source

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
| `assessmentTypeId` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `subjectId` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |
| `semesterId` | `string` | unknown | — | — | response.data example |
| `maxScore` | `number` | unknown | — | — | response.data example |
| `weight` | `number` | unknown | — | — | response.data example |
| `assessmentDate` | `string` | unknown | — | — | response.data example |
| `isPublished` | `boolean` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: detail screen.
- يظهر ضمن هذه المسارات/السياقات: `route /assessments/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `title`, `assessmentTypeId`, `classId`, `subjectId`, `academicYearId`, `semesterId`, `maxScore`, `weight`, `assessmentDate`, `isPublished`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /assessments`
- `POST /assessments`
- `GET /assessments/{id}/scores`
- `PUT /assessments/{id}/scores`
- `PATCH /assessments/scores/{studentAssessmentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Assessment Types` داخل `Assessments`

## `GET /assessments/{id}/scores`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: scores screen
- `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx:42` (route /assessments/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Assessment Scores
- OpenAPI description: Return the score roster for one assessment. Allowed roles: admin, teacher.
- ENDPOINT_MAP purpose: read scores

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Assessment numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return the score roster for one assessment. Roles: admin, teacher Auth: Bearer access token required
- ENDPOINT_MAP note: roster-aware view

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: scores screen.
- يظهر ضمن هذه المسارات/السياقات: `route /assessments/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `PUT /assessments/{id}/scores`
- `GET /assessments`
- `POST /assessments`
- `GET /assessments/{id}`
- `PATCH /assessments/scores/{studentAssessmentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Assessment Scores` داخل `Assessments`

## `PUT /assessments/{id}/scores`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: score entry
- `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx:67` (route /assessments/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Save Assessment Scores
- OpenAPI description: Create or update the full score roster for an assessment. Allowed roles: admin, teacher.
- ENDPOINT_MAP purpose: bulk save scores

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Assessment numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `records` | `array` | unknown | — | — | request example |
| `records[].studentId` | `string` | unknown | — | — | request example |
| `records[].score` | `number` | unknown | — | — | request example |
| `records[].remarks` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create or update the full score roster for an assessment. Roles: admin, teacher Auth: Bearer access token required Body schema: SaveAssessmentScoresRequest
- ENDPOINT_MAP note: duplicate grade conflicts must surface

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
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `records`, `records[].studentId`, `records[].score`, `records[].remarks`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: score entry.
- يظهر ضمن هذه المسارات/السياقات: `route /assessments/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /assessments/{id}/scores`
- `GET /assessments`
- `POST /assessments`
- `GET /assessments/{id}`
- `PATCH /assessments/scores/{studentAssessmentId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Save Assessment Scores` داخل `Assessments`

## `PATCH /assessments/scores/{studentAssessmentId}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: row action
- `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx:78` (route /assessments/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Update Student Assessment Score
- OpenAPI description: Update one student score row. Allowed roles: admin, teacher.
- ENDPOINT_MAP purpose: update one score

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `studentAssessmentId` | `path` | `string` | yes | Student assessment score numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `score` | `number` | unknown | — | — | request example |
| `remarks` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `studentAssessmentId`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Update one student score row. Roles: admin, teacher Auth: Bearer access token required Body schema: UpdateStudentAssessmentScoreRequest
- ENDPOINT_MAP note: row-level edit

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `studentAssessmentId` | `string` | unknown | — | — | response.data example |
| `assessmentId` | `string` | unknown | — | — | response.data example |
| `studentId` | `string` | unknown | — | — | response.data example |
| `fullName` | `string` | unknown | — | — | response.data example |
| `score` | `number` | unknown | — | — | response.data example |
| `percentage` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `studentAssessmentId`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `score`, `remarks`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: row action.
- يظهر ضمن هذه المسارات/السياقات: `route /assessments/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `studentAssessmentId`, `assessmentId`, `studentId`, `fullName`, `score`, `percentage`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /assessments`
- `POST /assessments`
- `GET /assessments/{id}`
- `GET /assessments/{id}/scores`
- `PUT /assessments/{id}/scores`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Update Student Assessment Score` داخل `Assessments`

## `GET /assessments/types`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: selectors
- `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:61` (route /assessments) عبر direct apiClient
- `admin-dashboard/src/features/assessments/AssessmentTypesPage.tsx:25` (route /assessments/types) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Assessment Types
- OpenAPI description: List assessment types. Allowed roles: admin, teacher.
- ENDPOINT_MAP purpose: list assessment types

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- Postman request note: Purpose: List assessment types. Roles: admin, teacher Auth: Bearer access token required
- ENDPOINT_MAP note: used in create assessment

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: selectors.
- يظهر ضمن هذه المسارات/السياقات: `route /assessments`, `route /assessments/types`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx`, `admin-dashboard/src/features/assessments/AssessmentTypesPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /assessments/types`
- `GET /assessments`
- `POST /assessments`
- `GET /assessments/{id}`
- `GET /assessments/{id}/scores`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Assessment Types` داخل `Assessments`

## `POST /assessments/types`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: types form
- `admin-dashboard/src/features/assessments/AssessmentTypesPage.tsx:30` (route /assessments/types) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Assessment Type
- OpenAPI description: Create a reusable assessment type. Allowed roles: admin.
- ENDPOINT_MAP purpose: create assessment type

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
| `code` | `string` | unknown | — | — | request example |
| `name` | `string` | unknown | — | — | request example |
| `description` | `string` | unknown | — | — | request example |
| `isActive` | `boolean` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a reusable assessment type. Roles: admin Auth: Bearer access token required Body schema: CreateAssessmentTypeRequest
- ENDPOINT_MAP note: admin-only

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
| `assessmentTypeId` | `string` | unknown | — | — | response.data example |
| `classId` | `string` | unknown | — | — | response.data example |
| `subjectId` | `string` | unknown | — | — | response.data example |
| `academicYearId` | `string` | unknown | — | — | response.data example |
| `semesterId` | `string` | unknown | — | — | response.data example |
| `maxScore` | `number` | unknown | — | — | response.data example |
| `weight` | `number` | unknown | — | — | response.data example |
| `assessmentDate` | `string` | unknown | — | — | response.data example |
| `isPublished` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `code`, `name`, `description`, `isActive`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: types form.
- يظهر ضمن هذه المسارات/السياقات: `route /assessments/types`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/assessments/AssessmentTypesPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `title`, `assessmentTypeId`, `classId`, `subjectId`, `academicYearId`, `semesterId`, `maxScore`, `weight`, `assessmentDate`, `isPublished`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /assessments/types`
- `GET /assessments`
- `POST /assessments`
- `GET /assessments/{id}`
- `GET /assessments/{id}/scores`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Assessment Type` داخل `Assessments`
