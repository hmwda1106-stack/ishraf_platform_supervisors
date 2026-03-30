# Behavior

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Behavior**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `GET /behavior/categories`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: categories list
- `admin-dashboard/src/features/behavior/BehaviorCategoriesPage.tsx:29` (route /behavior/categories) عبر direct apiClient
- `admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx:41` (route /behavior/:id) عبر direct apiClient
- `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:87` (route /behavior) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Behavior Categories
- OpenAPI description: List behavior categories used in behavior forms. There is no behaviorType query filter in v1. Allowed roles: admin, teacher, supervisor.
- ENDPOINT_MAP purpose: list categories

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- Postman request note: Purpose: List behavior categories used in behavior forms. There is no behaviorType query filter in v1. Roles: admin, teacher, supervisor Auth: Bearer access token required
- ENDPOINT_MAP note: selector source; no `behaviorType` filter in v1

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: categories list.
- يظهر ضمن هذه المسارات/السياقات: `route /behavior/categories`, `route /behavior/:id`, `route /behavior`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/behavior/BehaviorCategoriesPage.tsx`, `admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx`, `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /behavior/categories`
- `GET /behavior/records`
- `POST /behavior/records`
- `GET /behavior/records/{id}`
- `PATCH /behavior/records/{id}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Behavior Categories` داخل `Behavior`

## `POST /behavior/categories`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: categories form
- `admin-dashboard/src/features/behavior/BehaviorCategoriesPage.tsx:34` (route /behavior/categories) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Behavior Category
- OpenAPI description: Create a behavior category definition. Allowed roles: admin.
- ENDPOINT_MAP purpose: create category

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
| `behaviorType` | `string` | unknown | — | — | request example |
| `defaultSeverity` | `number` | unknown | — | — | request example |
| `isActive` | `boolean` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a behavior category definition. Roles: admin Auth: Bearer access token required Body schema: CreateBehaviorCategoryRequest
- ENDPOINT_MAP note: no category update/deactivate public API in v1

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
| `code` | `string` | unknown | — | — | response.data example |
| `name` | `string` | unknown | — | — | response.data example |
| `behaviorType` | `string` | unknown | — | — | response.data example |
| `defaultSeverity` | `number` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `code`, `name`, `behaviorType`, `defaultSeverity`, `isActive`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: categories form.
- يظهر ضمن هذه المسارات/السياقات: `route /behavior/categories`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/behavior/BehaviorCategoriesPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `code`, `name`, `behaviorType`, `defaultSeverity`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /behavior/categories`
- `GET /behavior/records`
- `POST /behavior/records`
- `GET /behavior/records/{id}`
- `PATCH /behavior/records/{id}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Behavior Category` داخل `Behavior`

## `GET /behavior/records`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: records list
- `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:161` (route /behavior) عبر useListQuery

**Purpose**
- OpenAPI summary: List Behavior Records
- OpenAPI description: List behavior records with pagination and filters. Allowed roles: admin, teacher, supervisor.
- ENDPOINT_MAP purpose: list records

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
| `sortBy` | `query` | `string (behaviorDate, createdAt, severity)` | no | Sort field whitelist. | enum=behaviorDate, createdAt, severity |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `studentId` | `query` | `string` | no | Filter by student id. | pattern=^[0-9]+$ |
| `behaviorCategoryId` | `query` | `string` | no | Filter by behavior category id. | pattern=^[0-9]+$ |
| `behaviorType` | `query` | `string` | no | Filter by behavior type. | — |
| `academicYearId` | `query` | `string` | no | Filter by academic year id. | pattern=^[0-9]+$ |
| `semesterId` | `query` | `string` | no | Filter by semester id. | pattern=^[0-9]+$ |
| `teacherId` | `query` | `string` | no | Filter by teacher profile id. | pattern=^[0-9]+$ |
| `supervisorId` | `query` | `string` | no | Filter by supervisor profile id. | pattern=^[0-9]+$ |
| `behaviorDate` | `query` | `string` | no | Filter by exact behavior date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateFrom` | `query` | `string` | no | Filter from behavior date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateTo` | `query` | `string` | no | Filter to behavior date. | pattern=^\d{4}-\d{2}-\d{2}$ |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=behaviorDate, createdAt, severity.
- `sortOrder`: enum=asc, desc.
- `studentId`: pattern=^[0-9]+$.
- `behaviorCategoryId`: pattern=^[0-9]+$.
- `academicYearId`: pattern=^[0-9]+$.
- `semesterId`: pattern=^[0-9]+$.
- `teacherId`: pattern=^[0-9]+$.
- `supervisorId`: pattern=^[0-9]+$.
- `behaviorDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateFrom`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateTo`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: List behavior records with pagination and filters. Roles: admin, teacher, supervisor Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, studentId, behaviorCategoryId, behaviorType, academicYearId, semesterId, teacherId, supervisorId, behaviorDate, dateFrom, dateTo
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: records list.
- يظهر ضمن هذه المسارات/السياقات: `route /behavior`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /behavior/records`
- `GET /behavior/records/{id}`
- `PATCH /behavior/records/{id}`
- `GET /behavior/categories`
- `POST /behavior/categories`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Behavior Records` داخل `Behavior`

## `POST /behavior/records`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: create record form
- `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:293` (route /behavior) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Behavior Record
- OpenAPI description: Create a behavior record for one student. Allowed roles: admin, teacher, supervisor. Side effects: Negative behavior categories trigger parent notifications through the internal automation service.
- ENDPOINT_MAP purpose: create record

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `studentId` | `string` | unknown | — | — | request example |
| `behaviorCategoryId` | `string` | unknown | — | — | request example |
| `academicYearId` | `string` | unknown | — | — | request example |
| `semesterId` | `string` | unknown | — | — | request example |
| `description` | `string` | unknown | — | — | request example |
| `severity` | `number` | unknown | — | — | request example |
| `behaviorDate` | `string` | unknown | — | — | request example |
| `teacherId` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a behavior record for one student. Roles: admin, teacher, supervisor Auth: Bearer access token required Body schema: CreateBehaviorRecordRequest Side effects: Negative behavior categories trigger parent notifications through the internal automation service.
- ENDPOINT_MAP note: no root `/behavior` endpoint; negative category triggers notifications

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
| `studentId` | `string` | unknown | — | — | response.data example |
| `studentFullName` | `string` | unknown | — | — | response.data example |
| `behaviorCategoryId` | `string` | unknown | — | — | response.data example |
| `behaviorName` | `string` | unknown | — | — | response.data example |
| `behaviorType` | `string` | unknown | — | — | response.data example |
| `severity` | `number` | unknown | — | — | response.data example |
| `behaviorDate` | `string` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `studentId`, `behaviorCategoryId`, `academicYearId`, `semesterId`, `description`, `severity`, `behaviorDate`, `teacherId`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: create record form.
- يظهر ضمن هذه المسارات/السياقات: `route /behavior`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `studentId`, `studentFullName`, `behaviorCategoryId`, `behaviorName`, `behaviorType`, `severity`, `behaviorDate`, `createdAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /behavior/records`
- `GET /behavior/records/{id}`
- `PATCH /behavior/records/{id}`
- `GET /behavior/categories`
- `POST /behavior/categories`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Behavior Record` داخل `Behavior`

## `GET /behavior/records/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: detail screen
- `admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx:36` (route /behavior/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Behavior Record
- OpenAPI description: Return one behavior record. Allowed roles: admin, teacher, supervisor.
- ENDPOINT_MAP purpose: record detail

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Behavior record numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return one behavior record. Roles: admin, teacher, supervisor Auth: Bearer access token required
- ENDPOINT_MAP note: detail/edit source

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
| `studentId` | `string` | unknown | — | — | response.data example |
| `studentFullName` | `string` | unknown | — | — | response.data example |
| `behaviorCategoryId` | `string` | unknown | — | — | response.data example |
| `behaviorName` | `string` | unknown | — | — | response.data example |
| `behaviorType` | `string` | unknown | — | — | response.data example |
| `severity` | `number` | unknown | — | — | response.data example |
| `behaviorDate` | `string` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |

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
- يظهر ضمن هذه المسارات/السياقات: `route /behavior/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `studentId`, `studentFullName`, `behaviorCategoryId`, `behaviorName`, `behaviorType`, `severity`, `behaviorDate`, `createdAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /behavior/records`
- `POST /behavior/records`
- `PATCH /behavior/records/{id}`
- `GET /behavior/categories`
- `POST /behavior/categories`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Behavior Record` داخل `Behavior`

## `PATCH /behavior/records/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: edit form
- `admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx:65` (route /behavior/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Update Behavior Record
- OpenAPI description: Update a behavior record payload. Allowed roles: admin, teacher, supervisor.
- ENDPOINT_MAP purpose: update record

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `teacher`, `supervisor`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Behavior record numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `severity` | `number` | unknown | — | — | request example |
| `description` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Update a behavior record payload. Roles: admin, teacher, supervisor Auth: Bearer access token required Body schema: UpdateBehaviorRecordRequest
- ENDPOINT_MAP note: category change may trigger automation

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
| `studentId` | `string` | unknown | — | — | response.data example |
| `studentFullName` | `string` | unknown | — | — | response.data example |
| `behaviorCategoryId` | `string` | unknown | — | — | response.data example |
| `behaviorName` | `string` | unknown | — | — | response.data example |
| `behaviorType` | `string` | unknown | — | — | response.data example |
| `severity` | `number` | unknown | — | — | response.data example |
| `behaviorDate` | `string` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `severity`, `description`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: edit form.
- يظهر ضمن هذه المسارات/السياقات: `route /behavior/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/behavior/BehaviorRecordDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `studentId`, `studentFullName`, `behaviorCategoryId`, `behaviorName`, `behaviorType`, `severity`, `behaviorDate`, `createdAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /behavior/records`
- `POST /behavior/records`
- `GET /behavior/records/{id}`
- `GET /behavior/categories`
- `POST /behavior/categories`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Update Behavior Record` داخل `Behavior`

## `GET /behavior/students/{studentId}/records`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student detail tab
- `admin-dashboard/src/features/reporting/StudentBehaviorSummaryPage.tsx:36` (route /reports/students/:studentId/behavior) عبر direct apiClient
- `admin-dashboard/src/features/reporting/StudentProfileReportPage.tsx:48` (route /reports/students/:studentId) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentDetailPage.tsx:208` (route /students/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Student Behavior Records
- OpenAPI description: Return the student behavior timeline used beside behavior summaries. This endpoint is not paginated. Allowed roles: admin, teacher, supervisor. Note: If the student exists but has no behavior records yet, the response remains 200 with zero-safe summary values and records=[]. Derived data: The response combines behavior detail and summary SQL views such as vw_behavior_details and vw_student_behavior_summary.
- ENDPOINT_MAP purpose: student behavior timeline

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
- Postman request note: Purpose: Return the student behavior timeline used beside behavior summaries. This endpoint is not paginated. Roles: admin, teacher, supervisor Auth: Bearer access token required Note: If the student exists but has no behavior records yet, the response remains 200 with zero-safe summary values and records=[]. Derived data: The response combines behavior detail and summary SQL views such as vw_behavior_details and vw_student_behavior_summary.
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
| `summary.totalBehaviorRecords` | `number` | unknown | — | — | response.data example |
| `summary.positiveCount` | `number` | unknown | — | — | response.data example |
| `summary.negativeCount` | `number` | unknown | — | — | response.data example |
| `summary.negativeSeverityTotal` | `number` | unknown | — | — | response.data example |
| `records` | `array` | unknown | — | — | response.data example |
| `records[].id` | `string` | unknown | — | — | response.data example |
| `records[].studentId` | `string` | unknown | — | — | response.data example |
| `records[].studentFullName` | `string` | unknown | — | — | response.data example |
| `records[].behaviorCategoryId` | `string` | unknown | — | — | response.data example |
| `records[].behaviorName` | `string` | unknown | — | — | response.data example |
| `records[].behaviorType` | `string` | unknown | — | — | response.data example |
| `records[].severity` | `number` | unknown | — | — | response.data example |
| `records[].behaviorDate` | `string` | unknown | — | — | response.data example |
| `records[].createdAt` | `string` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student detail tab.
- يظهر ضمن هذه المسارات/السياقات: `route /reports/students/:studentId/behavior`, `route /reports/students/:studentId`, `route /students/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/reporting/StudentBehaviorSummaryPage.tsx`, `admin-dashboard/src/features/reporting/StudentProfileReportPage.tsx`, `admin-dashboard/src/features/students/StudentDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `summary`, `records`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /behavior/categories`
- `POST /behavior/categories`
- `GET /behavior/records`
- `POST /behavior/records`
- `GET /behavior/records/{id}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Student Behavior Records` داخل `Behavior`
