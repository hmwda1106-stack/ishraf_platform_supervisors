# Users

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Users**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `GET /users`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: users list
- `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx:26` (route /supervisor-assignments) عبر direct apiClient
- `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx:26` (route /teacher-assignments) عبر direct apiClient
- `admin-dashboard/src/features/communication/InboxPage.tsx:41` (route /inbox) عبر direct apiClient
- `admin-dashboard/src/features/communication/NotificationsPage.tsx:60` (route /notifications) عبر direct apiClient
- `admin-dashboard/src/features/communication/SentPage.tsx:33` (route /sent) عبر direct apiClient
- `admin-dashboard/src/features/students/student-workflows.ts:25` ([helper] student workflows) عبر direct apiClient
- `admin-dashboard/src/features/transport/BusesPage.tsx:29` (route /buses) عبر direct apiClient
- `admin-dashboard/src/features/users/UsersListPage.tsx:82` (route /users) عبر useListQuery

**Purpose**
- OpenAPI summary: List Users
- OpenAPI description: List users with pagination and filters. Allowed roles: admin.
- ENDPOINT_MAP purpose: list users

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
| `sortBy` | `query` | `string (createdAt)` | no | Sort field whitelist. | enum=createdAt |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `role` | `query` | `string` | no | Filter by role. | — |
| `isActive` | `query` | `boolean` | no | Filter by active status. | — |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=createdAt.
- `sortOrder`: enum=asc, desc.
- Postman request note: Purpose: List users with pagination and filters. Roles: admin Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, role, isActive
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: users list.
- يظهر ضمن هذه المسارات/السياقات: `route /supervisor-assignments`, `route /teacher-assignments`, `route /inbox`, `route /notifications`, `route /sent`, `[helper] student workflows`, `route /buses`, `route /users`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/academic/SupervisorAssignmentsPage.tsx`, `admin-dashboard/src/features/academic/TeacherAssignmentsPage.tsx`, `admin-dashboard/src/features/communication/InboxPage.tsx`, `admin-dashboard/src/features/communication/NotificationsPage.tsx`, `admin-dashboard/src/features/communication/SentPage.tsx`, `admin-dashboard/src/features/students/student-workflows.ts`, `admin-dashboard/src/features/transport/BusesPage.tsx`, `admin-dashboard/src/features/users/UsersListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /users`
- `GET /users/{id}`
- `PATCH /users/{id}`
- `PATCH /users/{id}/status`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Users` داخل `Users`

## `POST /users`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: create user form
- `admin-dashboard/src/features/users/CreateUserPage.tsx:67` (route /users/create) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create User
- OpenAPI description: Create a new user for any supported role. profile is role-specific. Allowed roles: admin.
- ENDPOINT_MAP purpose: create user

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
| `role` | `string (admin, parent, teacher, supervisor, driver)` | yes | — | enum=admin, parent, teacher, supervisor, driver | request schema (CreateUserRequest) |
| `fullName` | `string` | yes | — | minLength=1 \| maxLength=150 | request schema (CreateUserRequest) |
| `email` | `string` | no | — | format=email | request schema (CreateUserRequest) |
| `phone` | `string` | no | — | minLength=1 \| maxLength=50 | request schema (CreateUserRequest) |
| `password` | `string` | yes | — | minLength=8 \| maxLength=72 | request schema (CreateUserRequest) |
| `profile` | `object` | no | — | additionalProperties=true | request schema (CreateUserRequest) |

**Backend Validation Rules**
- `role`: enum=admin, parent, teacher, supervisor, driver.
- `fullName`: minLength=1 | maxLength=150.
- `email`: format=email.
- `phone`: minLength=1 | maxLength=50.
- `password`: minLength=8 | maxLength=72.
- `profile`: additionalProperties=true.
- Postman request note: Purpose: Create a new user for any supported role. profile is role-specific. Roles: admin Auth: Bearer access token required Body schema: CreateUserRequest
- ENDPOINT_MAP note: duplicate email/phone -> `409`

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
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `role`, `fullName`, `password`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: create user form.
- يظهر ضمن هذه المسارات/السياقات: `route /users/create`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/users/CreateUserPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /users`
- `GET /users/{id}`
- `PATCH /users/{id}`
- `PATCH /users/{id}/status`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create User` داخل `Users`

## `GET /users/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: user detail
- `admin-dashboard/src/features/communication/ConversationPage.tsx:27` (route /communication/conversations/:otherUserId) عبر direct apiClient
- `admin-dashboard/src/features/users/UserDetailPage.tsx:30` (route /users/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get User
- OpenAPI description: Return one user by id. Allowed roles: admin.
- ENDPOINT_MAP purpose: user detail

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | User numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return one user by id. Roles: admin Auth: Bearer access token required
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: user detail.
- يظهر ضمن هذه المسارات/السياقات: `route /communication/conversations/:otherUserId`, `route /users/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/ConversationPage.tsx`, `admin-dashboard/src/features/users/UserDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /users`
- `POST /users`
- `PATCH /users/{id}`
- `PATCH /users/{id}/status`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get User` داخل `Users`

## `PATCH /users/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: edit form
- `admin-dashboard/src/features/users/UserDetailPage.tsx:71` (route /users/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Update User
- OpenAPI description: Update basic user fields and role-specific profile fields. Allowed roles: admin.
- ENDPOINT_MAP purpose: update user

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | User numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `fullName` | `string` | no | — | minLength=1 \| maxLength=150 | request schema (UpdateUserRequest) |
| `email` | `string` | no | — | format=email | request schema (UpdateUserRequest) |
| `phone` | `string` | no | — | minLength=1 \| maxLength=50 | request schema (UpdateUserRequest) |
| `profile` | `object` | no | — | additionalProperties=true | request schema (UpdateUserRequest) |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- `fullName`: minLength=1 | maxLength=150.
- `email`: format=email.
- `phone`: minLength=1 | maxLength=50.
- `profile`: additionalProperties=true.
- Postman request note: Purpose: Update basic user fields and role-specific profile fields. Roles: admin Auth: Bearer access token required Body schema: UpdateUserRequest
- ENDPOINT_MAP note: لا تفترض update شامل لكل شيء من شاشة واحدة

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: edit form.
- يظهر ضمن هذه المسارات/السياقات: `route /users/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/users/UserDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /users`
- `POST /users`
- `GET /users/{id}`
- `PATCH /users/{id}/status`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Update User` داخل `Users`

## `PATCH /users/{id}/status`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: list/detail actions
- `admin-dashboard/src/features/users/UserDetailPage.tsx:83` (route /users/:id) عبر direct apiClient

**Purpose**
- OpenAPI summary: Update User Status
- OpenAPI description: Activate or deactivate a user account. Allowed roles: admin.
- ENDPOINT_MAP purpose: activate/deactivate

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | User numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `isActive` | `boolean` | yes | — | — | request schema (UpdateUserStatusRequest) |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Activate or deactivate a user account. Roles: admin Auth: Bearer access token required Body schema: UpdateUserStatusRequest
- ENDPOINT_MAP note: استخدم dialog تأكيد

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: list/detail actions.
- يظهر ضمن هذه المسارات/السياقات: `route /users/:id`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/users/UserDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /users`
- `POST /users`
- `GET /users/{id}`
- `PATCH /users/{id}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Update User Status` داخل `Users`
