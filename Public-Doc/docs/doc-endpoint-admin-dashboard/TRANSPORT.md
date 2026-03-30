# Transport

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Transport**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `POST /transport/assignments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: assignment form
- `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:110` (route /assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Transport Assignment
- OpenAPI description: Create an active student bus assignment. Allowed roles: admin.
- ENDPOINT_MAP purpose: create student transport assignment

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
| `studentId` | `string` | unknown | — | — | request example |
| `routeId` | `string` | unknown | — | — | request example |
| `stopId` | `string` | unknown | — | — | request example |
| `startDate` | `string` | unknown | — | — | request example |
| `endDate` | `null` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create an active student bus assignment. Roles: admin Auth: Bearer access token required Body schema: CreateTransportAssignmentRequest
- ENDPOINT_MAP note: one active assignment only

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `assignmentId` | `string` | unknown | — | — | response.data example |
| `student.studentId` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `route.id` | `string` | unknown | — | — | response.data example |
| `route.routeName` | `string` | unknown | — | — | response.data example |
| `stop.id` | `string` | unknown | — | — | response.data example |
| `stop.stopName` | `string` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `null` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `studentId`, `routeId`, `stopId`, `startDate`, `endDate`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: assignment form.
- يظهر ضمن هذه المسارات/السياقات: `route /assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `assignmentId`, `student`, `route`, `stop`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`
- `GET /transport/buses`
- `POST /transport/buses`
- `GET /transport/route-assignments`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Transport Assignment` داخل `Transport`

## `PATCH /transport/assignments/{id}/deactivate`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: assignment actions
- `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:134` (route /assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: Deactivate Transport Assignment
- OpenAPI description: Deactivate an active student bus assignment. Allowed roles: admin.
- ENDPOINT_MAP purpose: deactivate assignment

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Student bus assignment numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `endDate` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Deactivate an active student bus assignment. Roles: admin Auth: Bearer access token required Body schema: DeactivateTransportAssignmentRequest
- ENDPOINT_MAP note: no general edit flow in v1

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `assignmentId` | `string` | unknown | — | — | response.data example |
| `student.studentId` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `route.id` | `string` | unknown | — | — | response.data example |
| `route.routeName` | `string` | unknown | — | — | response.data example |
| `stop.id` | `string` | unknown | — | — | response.data example |
| `stop.stopName` | `string` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `null` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `endDate`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: assignment actions.
- يظهر ضمن هذه المسارات/السياقات: `route /assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `assignmentId`, `student`, `route`, `stop`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /transport/assignments`
- `GET /transport/assignments/active`
- `GET /transport/buses`
- `POST /transport/buses`
- `GET /transport/route-assignments`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Deactivate Transport Assignment` داخل `Transport`

## `GET /transport/assignments/active`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: active assignments screen
- `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:54` (route /assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Active Transport Assignments
- OpenAPI description: List active student bus assignments. Allowed roles: admin.
- ENDPOINT_MAP purpose: list active assignments

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
- Postman request note: Purpose: List active student bus assignments. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: operational oversight screen

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: active assignments screen.
- يظهر ضمن هذه المسارات/السياقات: `route /assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/buses`
- `POST /transport/buses`
- `GET /transport/route-assignments`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Active Transport Assignments` داخل `Transport`

## `GET /transport/buses`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: buses list
- `admin-dashboard/src/features/transport/BusesPage.tsx:84` (route /buses) عبر direct apiClient
- `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx:53` (route /route-assignments) عبر direct apiClient
- `admin-dashboard/src/features/transport/TripsListPage.tsx:44` (route /trips) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Buses
- OpenAPI description: List buses used in transport setup. Allowed roles: admin.
- ENDPOINT_MAP purpose: list buses

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
- Postman request note: Purpose: List buses used in transport setup. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: master data

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: buses list.
- يظهر ضمن هذه المسارات/السياقات: `route /buses`, `route /route-assignments`, `route /trips`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/BusesPage.tsx`, `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx`, `admin-dashboard/src/features/transport/TripsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /transport/buses`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`
- `GET /transport/route-assignments`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Buses` داخل `Transport`

## `POST /transport/buses`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: buses form
- `admin-dashboard/src/features/transport/BusesPage.tsx:130` (route /buses) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Bus
- OpenAPI description: Create a bus and optionally assign a driver. The request accepts the driver user id from /users?role=driver or the legacy driver profile id. Allowed roles: admin. Note: Frontend should send the driver user id returned by GET /users?role=driver. The backend resolves it internally to the stored driver profile id. Note: Legacy integrations may still send the driver profile id directly.
- ENDPOINT_MAP purpose: create bus

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
| `plateNumber` | `string` | unknown | — | — | request example |
| `driverId` | `string` | unknown | — | — | request example |
| `capacity` | `number` | unknown | — | — | request example |
| `status` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a bus and optionally assign a driver. The request accepts the driver user id from /users?role=driver or the legacy driver profile id. Roles: admin Auth: Bearer access token required Body schema: CreateBusRequest Note: Frontend should send the driver user id returned by GET /users?role=driver. The backend resolves it internally to the stored driver profile id. Note: Legacy integrations may still send the driver profile id directly.
- ENDPOINT_MAP note: send `driverId` as the selected driver `users.id` from `/users?role=driver`; legacy `drivers.id` still works; duplicate plate -> `409`

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
| `plateNumber` | `string` | unknown | — | — | response.data example |
| `capacity` | `number` | unknown | — | — | response.data example |
| `status` | `string` | unknown | — | — | response.data example |
| `driver.driverId` | `string` | unknown | — | — | response.data example |
| `driver.userId` | `string` | unknown | — | — | response.data example |
| `driver.fullName` | `string` | unknown | — | — | response.data example |
| `driver.email` | `string` | unknown | — | — | response.data example |
| `driver.phone` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `plateNumber`, `driverId`, `capacity`, `status`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: buses form.
- يظهر ضمن هذه المسارات/السياقات: `route /buses`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/BusesPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `plateNumber`, `capacity`, `status`, `driver`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/buses`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`
- `GET /transport/route-assignments`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Bus` داخل `Transport`

## `GET /transport/route-assignments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: route assignments list
- `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx:48` (route /route-assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Route Assignments
- OpenAPI description: List recurring bus-to-route assignments for admin transport management. Allowed roles: admin.
- ENDPOINT_MAP purpose: list recurring route assignments

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
- Postman request note: Purpose: List recurring bus-to-route assignments for admin transport management. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: new primary transport setup surface

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: route assignments list.
- يظهر ضمن هذه المسارات/السياقات: `route /route-assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /transport/route-assignments`
- `PATCH /transport/route-assignments/{id}/deactivate`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Route Assignments` داخل `Transport`

## `POST /transport/route-assignments`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: route assignment form
- `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx:102` (route /route-assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Route Assignment
- OpenAPI description: Create a recurring bus-to-route assignment used by the driver daily workflow. Allowed roles: admin.
- ENDPOINT_MAP purpose: create recurring route assignment

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
| `busId` | `string` | unknown | — | — | request example |
| `routeId` | `string` | unknown | — | — | request example |
| `startDate` | `string` | unknown | — | — | request example |
| `endDate` | `null` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a recurring bus-to-route assignment used by the driver daily workflow. Roles: admin Auth: Bearer access token required Body schema: CreateTransportRouteAssignmentRequest
- ENDPOINT_MAP note: use this for recurring bus-to-route setup

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `routeAssignmentId` | `string` | unknown | — | — | response.data example |
| `bus.id` | `string` | unknown | — | — | response.data example |
| `bus.plateNumber` | `string` | unknown | — | — | response.data example |
| `bus.capacity` | `number` | unknown | — | — | response.data example |
| `bus.status` | `string` | unknown | — | — | response.data example |
| `driver.driverId` | `string` | unknown | — | — | response.data example |
| `driver.userId` | `string` | unknown | — | — | response.data example |
| `driver.fullName` | `string` | unknown | — | — | response.data example |
| `driver.email` | `string` | unknown | — | — | response.data example |
| `driver.phone` | `string` | unknown | — | — | response.data example |
| `route.id` | `string` | unknown | — | — | response.data example |
| `route.routeName` | `string` | unknown | — | — | response.data example |
| `route.startPoint` | `string` | unknown | — | — | response.data example |
| `route.endPoint` | `string` | unknown | — | — | response.data example |
| `route.estimatedDurationMinutes` | `number` | unknown | — | — | response.data example |
| `route.isActive` | `boolean` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `null` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `busId`, `routeId`, `startDate`, `endDate`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: route assignment form.
- يظهر ضمن هذه المسارات/السياقات: `route /route-assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `routeAssignmentId`, `bus`, `driver`, `route`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/route-assignments`
- `PATCH /transport/route-assignments/{id}/deactivate`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Route Assignment` داخل `Transport`

## `PATCH /transport/route-assignments/{id}/deactivate`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: route assignment actions
- `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx:117` (route /route-assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: Deactivate Route Assignment
- OpenAPI description: Deactivate a recurring bus-to-route assignment. Legacy trips remain intact. Allowed roles: admin.
- ENDPOINT_MAP purpose: deactivate recurring route assignment

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Transport route assignment numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `endDate` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Deactivate a recurring bus-to-route assignment. Legacy trips remain intact. Roles: admin Auth: Bearer access token required Body schema: DeactivateTransportRouteAssignmentRequest
- ENDPOINT_MAP note: keeps history instead of deleting

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `routeAssignmentId` | `string` | unknown | — | — | response.data example |
| `bus.id` | `string` | unknown | — | — | response.data example |
| `bus.plateNumber` | `string` | unknown | — | — | response.data example |
| `bus.capacity` | `number` | unknown | — | — | response.data example |
| `bus.status` | `string` | unknown | — | — | response.data example |
| `driver.driverId` | `string` | unknown | — | — | response.data example |
| `driver.userId` | `string` | unknown | — | — | response.data example |
| `driver.fullName` | `string` | unknown | — | — | response.data example |
| `driver.email` | `string` | unknown | — | — | response.data example |
| `driver.phone` | `string` | unknown | — | — | response.data example |
| `route.id` | `string` | unknown | — | — | response.data example |
| `route.routeName` | `string` | unknown | — | — | response.data example |
| `route.startPoint` | `string` | unknown | — | — | response.data example |
| `route.endPoint` | `string` | unknown | — | — | response.data example |
| `route.estimatedDurationMinutes` | `number` | unknown | — | — | response.data example |
| `route.isActive` | `boolean` | unknown | — | — | response.data example |
| `startDate` | `string` | unknown | — | — | response.data example |
| `endDate` | `null` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `endDate`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: route assignment actions.
- يظهر ضمن هذه المسارات/السياقات: `route /route-assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `routeAssignmentId`, `bus`, `driver`, `route`, `startDate`, `endDate`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/route-assignments`
- `POST /transport/route-assignments`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Deactivate Route Assignment` داخل `Transport`

## `GET /transport/routes`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: routes list
- `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx:58` (route /route-assignments) عبر direct apiClient
- `admin-dashboard/src/features/transport/RouteDetailPage.tsx:31` (route /transport/routes/:routeId) عبر direct apiClient
- `admin-dashboard/src/features/transport/RoutesPage.tsx:27` (route /routes) عبر direct apiClient
- `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:59` (route /assignments) عبر direct apiClient
- `admin-dashboard/src/features/transport/TripsListPage.tsx:49` (route /trips) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Routes
- OpenAPI description: List transport routes. Allowed roles: admin.
- ENDPOINT_MAP purpose: list routes

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
- Postman request note: Purpose: List transport routes. Roles: admin Auth: Bearer access token required
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: routes list.
- يظهر ضمن هذه المسارات/السياقات: `route /route-assignments`, `route /transport/routes/:routeId`, `route /routes`, `route /assignments`, `route /trips`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/RouteAssignmentsPage.tsx`, `admin-dashboard/src/features/transport/RouteDetailPage.tsx`, `admin-dashboard/src/features/transport/RoutesPage.tsx`, `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx`, `admin-dashboard/src/features/transport/TripsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /transport/routes`
- `GET /transport/routes/{routeId}/stops`
- `POST /transport/routes/{routeId}/stops`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Routes` داخل `Transport`

## `POST /transport/routes`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: routes form
- `admin-dashboard/src/features/transport/RoutesPage.tsx:44` (route /routes) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Route
- OpenAPI description: Create a transport route. Allowed roles: admin.
- ENDPOINT_MAP purpose: create route

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
| `routeName` | `string` | unknown | — | — | request example |
| `startPoint` | `string` | unknown | — | — | request example |
| `endPoint` | `string` | unknown | — | — | request example |
| `estimatedDurationMinutes` | `number` | unknown | — | — | request example |
| `isActive` | `boolean` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a transport route. Roles: admin Auth: Bearer access token required Body schema: CreateRouteRequest
- ENDPOINT_MAP note: unique route naming

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
| `routeName` | `string` | unknown | — | — | response.data example |
| `startPoint` | `string` | unknown | — | — | response.data example |
| `endPoint` | `string` | unknown | — | — | response.data example |
| `estimatedDurationMinutes` | `number` | unknown | — | — | response.data example |
| `isActive` | `boolean` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `routeName`, `startPoint`, `endPoint`, `estimatedDurationMinutes`, `isActive`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: routes form.
- يظهر ضمن هذه المسارات/السياقات: `route /routes`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/RoutesPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `routeName`, `startPoint`, `endPoint`, `estimatedDurationMinutes`, `isActive`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/routes`
- `GET /transport/routes/{routeId}/stops`
- `POST /transport/routes/{routeId}/stops`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Route` داخل `Transport`

## `GET /transport/routes/{routeId}/stops`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: route detail
- `admin-dashboard/src/features/transport/RouteDetailPage.tsx:41` (route /transport/routes/:routeId) عبر direct apiClient
- `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:71` (route /assignments) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Route Stops
- OpenAPI description: List route stops in stopOrder order. Allowed roles: admin.
- ENDPOINT_MAP purpose: list stops

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `routeId` | `path` | `string` | yes | Route numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `routeId`: pattern=^[0-9]+$.
- Postman request note: Purpose: List route stops in stopOrder order. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: no pagination in v1

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
- Path params الإلزامية: `routeId`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: route detail.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/routes/:routeId`, `route /assignments`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/RouteDetailPage.tsx`, `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /transport/routes/{routeId}/stops`
- `GET /transport/routes`
- `POST /transport/routes`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Route Stops` داخل `Transport`

## `POST /transport/routes/{routeId}/stops`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: route stops form
- `admin-dashboard/src/features/transport/RouteDetailPage.tsx:61` (route /transport/routes/:routeId) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Route Stop
- OpenAPI description: Create a stop under the selected route. Allowed roles: admin.
- ENDPOINT_MAP purpose: create stop

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `routeId` | `path` | `string` | yes | Route numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `stopName` | `string` | unknown | — | — | request example |
| `latitude` | `number` | unknown | — | — | request example |
| `longitude` | `number` | unknown | — | — | request example |
| `stopOrder` | `number` | unknown | — | — | request example |

**Backend Validation Rules**
- `routeId`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a stop under the selected route. Roles: admin Auth: Bearer access token required Body schema: CreateRouteStopRequest
- ENDPOINT_MAP note: stop order uniqueness matters

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `stopId` | `string` | unknown | — | — | response.data example |
| `stopName` | `string` | unknown | — | — | response.data example |
| `latitude` | `number` | unknown | — | — | response.data example |
| `longitude` | `number` | unknown | — | — | response.data example |
| `stopOrder` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `routeId`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `stopName`, `latitude`, `longitude`, `stopOrder`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: route stops form.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/routes/:routeId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/RouteDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `stopId`, `stopName`, `latitude`, `longitude`, `stopOrder`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/routes/{routeId}/stops`
- `GET /transport/routes`
- `POST /transport/routes`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Route Stop` داخل `Transport`

## `DELETE /transport/students/{studentId}/home-location`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student transport tab
- `admin-dashboard/src/features/students/StudentHomeLocationSection.tsx:117` عبر direct apiClient

**Purpose**
- OpenAPI summary: Delete Student Home Location
- OpenAPI description: Delete the current saved home location for one student. Allowed roles: admin.
- ENDPOINT_MAP purpose: delete student home location

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
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
- Postman request note: Purpose: Delete the current saved home location for one student. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: remove only if truly obsolete

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `student.studentId` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `homeLocation.locationId` | `string` | unknown | — | — | response.data example |
| `homeLocation.addressLabel` | `string` | unknown | — | — | response.data example |
| `homeLocation.addressText` | `string` | unknown | — | — | response.data example |
| `homeLocation.latitude` | `number` | unknown | — | — | response.data example |
| `homeLocation.longitude` | `number` | unknown | — | — | response.data example |
| `homeLocation.source` | `string` | unknown | — | — | response.data example |
| `homeLocation.status` | `string` | unknown | — | — | response.data example |
| `homeLocation.submittedByUserId` | `string` | unknown | — | — | response.data example |
| `homeLocation.approvedByUserId` | `string` | unknown | — | — | response.data example |
| `homeLocation.approvedAt` | `string` | unknown | — | — | response.data example |
| `homeLocation.notes` | `null` | unknown | — | — | response.data example |
| `homeLocation.createdAt` | `string` | unknown | — | — | response.data example |
| `homeLocation.updatedAt` | `string` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student transport tab.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/StudentHomeLocationSection.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `homeLocation`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/students/{studentId}/home-location`
- `PUT /transport/students/{studentId}/home-location`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Delete Student Home Location` داخل `Transport`

## `GET /transport/students/{studentId}/home-location`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student transport tab
- `admin-dashboard/src/features/students/StudentHomeLocationSection.tsx:56` عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Student Home Location
- OpenAPI description: Return the current saved home location reference for one student. In this round the endpoint is admin-only. Allowed roles: admin. Note: If the student exists but no home location has been saved yet, the response remains 200 with homeLocation=null.
- ENDPOINT_MAP purpose: read student home location

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
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
- Postman request note: Purpose: Return the current saved home location reference for one student. In this round the endpoint is admin-only. Roles: admin Auth: Bearer access token required Note: If the student exists but no home location has been saved yet, the response remains 200 with homeLocation=null.
- ENDPOINT_MAP note: reference-only transport layer

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `student.studentId` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `homeLocation.locationId` | `string` | unknown | — | — | response.data example |
| `homeLocation.addressLabel` | `string` | unknown | — | — | response.data example |
| `homeLocation.addressText` | `string` | unknown | — | — | response.data example |
| `homeLocation.latitude` | `number` | unknown | — | — | response.data example |
| `homeLocation.longitude` | `number` | unknown | — | — | response.data example |
| `homeLocation.source` | `string` | unknown | — | — | response.data example |
| `homeLocation.status` | `string` | unknown | — | — | response.data example |
| `homeLocation.submittedByUserId` | `string` | unknown | — | — | response.data example |
| `homeLocation.approvedByUserId` | `string` | unknown | — | — | response.data example |
| `homeLocation.approvedAt` | `string` | unknown | — | — | response.data example |
| `homeLocation.notes` | `null` | unknown | — | — | response.data example |
| `homeLocation.createdAt` | `string` | unknown | — | — | response.data example |
| `homeLocation.updatedAt` | `string` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student transport tab.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/StudentHomeLocationSection.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `homeLocation`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `DELETE /transport/students/{studentId}/home-location`
- `PUT /transport/students/{studentId}/home-location`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Student Home Location` داخل `Transport`

## `PUT /transport/students/{studentId}/home-location`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: student transport tab
- `admin-dashboard/src/features/students/CreateStudentPage.tsx:240` (route /students/create) عبر direct apiClient
- `admin-dashboard/src/features/students/StudentHomeLocationSection.tsx:106` عبر direct apiClient

**Purpose**
- OpenAPI summary: Save Student Home Location
- OpenAPI description: Create or update the current student home location reference. v1 uses admin as the submitting source. Allowed roles: admin. Note: Admin may save pending, approved, or rejected locations. Only approved locations appear in the driver roster.
- ENDPOINT_MAP purpose: save student home location

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `studentId` | `path` | `string` | yes | Student numeric string identifier. This is the same id used by /students/:id. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `addressLabel` | `string` | unknown | — | — | request example |
| `addressText` | `string` | unknown | — | — | request example |
| `latitude` | `number` | unknown | — | — | request example |
| `longitude` | `number` | unknown | — | — | request example |
| `status` | `string` | unknown | — | — | request example |
| `notes` | `null` | unknown | — | — | request example |

**Backend Validation Rules**
- `studentId`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create or update the current student home location reference. v1 uses admin as the submitting source. Roles: admin Auth: Bearer access token required Body schema: SaveStudentHomeLocationRequest Note: Admin may save pending, approved, or rejected locations. Only approved locations appear in the driver roster.
- ENDPOINT_MAP note: admin-managed in this round

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `student.studentId` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `homeLocation.locationId` | `string` | unknown | — | — | response.data example |
| `homeLocation.addressLabel` | `string` | unknown | — | — | response.data example |
| `homeLocation.addressText` | `string` | unknown | — | — | response.data example |
| `homeLocation.latitude` | `number` | unknown | — | — | response.data example |
| `homeLocation.longitude` | `number` | unknown | — | — | response.data example |
| `homeLocation.source` | `string` | unknown | — | — | response.data example |
| `homeLocation.status` | `string` | unknown | — | — | response.data example |
| `homeLocation.submittedByUserId` | `string` | unknown | — | — | response.data example |
| `homeLocation.approvedByUserId` | `string` | unknown | — | — | response.data example |
| `homeLocation.approvedAt` | `string` | unknown | — | — | response.data example |
| `homeLocation.notes` | `null` | unknown | — | — | response.data example |
| `homeLocation.createdAt` | `string` | unknown | — | — | response.data example |
| `homeLocation.updatedAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `studentId`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `addressLabel`, `addressText`, `latitude`, `longitude`, `status`, `notes`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: student transport tab.
- يظهر ضمن هذه المسارات/السياقات: `route /students/create`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/students/CreateStudentPage.tsx`, `admin-dashboard/src/features/students/StudentHomeLocationSection.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `student`, `homeLocation`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `DELETE /transport/students/{studentId}/home-location`
- `GET /transport/students/{studentId}/home-location`
- `POST /transport/assignments`
- `PATCH /transport/assignments/{id}/deactivate`
- `GET /transport/assignments/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Save Student Home Location` داخل `Transport`

## `GET /transport/trips`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: trips list
- `admin-dashboard/src/features/transport/TripsListPage.tsx:54` (route /trips) عبر useListQuery

**Purpose**
- OpenAPI summary: List Trips
- OpenAPI description: List trips with pagination. Drivers only see trips within their scope. Allowed roles: admin, driver.
- ENDPOINT_MAP purpose: list trips

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `page` | `query` | `integer` | no | Pagination page number. | min=1 |
| `limit` | `query` | `integer` | no | Pagination page size. | min=1 \| max=100 |
| `sortBy` | `query` | `string (tripDate, tripStatus, startedAt, createdAt)` | no | Sort field whitelist. | enum=tripDate, tripStatus, startedAt, createdAt |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `busId` | `query` | `string` | no | Filter by bus id. | pattern=^[0-9]+$ |
| `routeId` | `query` | `string` | no | Filter by route id. | pattern=^[0-9]+$ |
| `tripType` | `query` | `string` | no | Filter by trip type. | — |
| `tripStatus` | `query` | `string` | no | Filter by trip status. | — |
| `tripDate` | `query` | `string` | no | Filter by exact trip date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateFrom` | `query` | `string` | no | Filter from trip date. | pattern=^\d{4}-\d{2}-\d{2}$ |
| `dateTo` | `query` | `string` | no | Filter to trip date. | pattern=^\d{4}-\d{2}-\d{2}$ |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=tripDate, tripStatus, startedAt, createdAt.
- `sortOrder`: enum=asc, desc.
- `busId`: pattern=^[0-9]+$.
- `routeId`: pattern=^[0-9]+$.
- `tripDate`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateFrom`: pattern=^\d{4}-\d{2}-\d{2}$.
- `dateTo`: pattern=^\d{4}-\d{2}-\d{2}$.
- Postman request note: Purpose: List trips with pagination. Drivers only see trips within their scope. Roles: admin, driver Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, busId, routeId, tripType, tripStatus, tripDate, dateFrom, dateTo
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: trips list.
- يظهر ضمن هذه المسارات/السياقات: `route /trips`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /transport/trips`
- `GET /transport/trips/{id}`
- `POST /transport/trips/{id}/end`
- `GET /transport/trips/{id}/events`
- `POST /transport/trips/{id}/events`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Trips` داخل `Transport`

## `POST /transport/trips`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: manual/exception trip form
- `admin-dashboard/src/features/transport/TripsListPage.tsx:72` (route /trips) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Trip
- OpenAPI description: Create a trip for a bus and route. Drivers and admins can create trips. Allowed roles: admin, driver.
- ENDPOINT_MAP purpose: create trip

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `busId` | `string` | unknown | — | — | request example |
| `routeId` | `string` | unknown | — | — | request example |
| `tripDate` | `string` | unknown | — | — | request example |
| `tripType` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a trip for a bus and route. Drivers and admins can create trips. Roles: admin, driver Auth: Bearer access token required Body schema: CreateTripRequest
- ENDPOINT_MAP note: keep as fallback; no longer the preferred daily flow

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
| `tripDate` | `string` | unknown | — | — | response.data example |
| `tripType` | `string` | unknown | — | — | response.data example |
| `tripStatus` | `string` | unknown | — | — | response.data example |
| `startedAt` | `string` | unknown | — | — | response.data example |
| `endedAt` | `null` | unknown | — | — | response.data example |
| `bus.id` | `string` | unknown | — | — | response.data example |
| `bus.plateNumber` | `string` | unknown | — | — | response.data example |
| `driver.driverId` | `string` | unknown | — | — | response.data example |
| `driver.fullName` | `string` | unknown | — | — | response.data example |
| `route.id` | `string` | unknown | — | — | response.data example |
| `route.routeName` | `string` | unknown | — | — | response.data example |
| `latestLocation.latitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.longitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.recordedAt` | `string` | unknown | — | — | response.data example |
| `eventSummary.boardedCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.droppedOffCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.absentCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.totalEvents` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `busId`, `routeId`, `tripDate`, `tripType`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: manual/exception trip form.
- يظهر ضمن هذه المسارات/السياقات: `route /trips`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripsListPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `tripDate`, `tripType`, `tripStatus`, `startedAt`, `endedAt`, `bus`, `driver`, `route`, `latestLocation`, `eventSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/trips`
- `GET /transport/trips/{id}`
- `POST /transport/trips/{id}/end`
- `GET /transport/trips/{id}/events`
- `POST /transport/trips/{id}/events`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Trip` داخل `Transport`

## `GET /transport/trips/{id}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: trip detail screen
- `admin-dashboard/src/features/transport/TripDetailPage.tsx:69` (route /transport/trips/:tripId) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Trip
- OpenAPI description: Return one trip detail including latest location, route stops, and event summary. Allowed roles: admin, driver. Derived data: Trip detail aggregates transport views such as vw_trip_details, vw_route_stops, and vw_latest_trip_location.
- ENDPOINT_MAP purpose: trip detail

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Trip numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return one trip detail including latest location, route stops, and event summary. Roles: admin, driver Auth: Bearer access token required Derived data: Trip detail aggregates transport views such as vw_trip_details, vw_route_stops, and vw_latest_trip_location.
- ENDPOINT_MAP note: source of truth for trip view

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `trip.id` | `string` | unknown | — | — | response.data example |
| `trip.tripDate` | `string` | unknown | — | — | response.data example |
| `trip.tripType` | `string` | unknown | — | — | response.data example |
| `trip.tripStatus` | `string` | unknown | — | — | response.data example |
| `trip.startedAt` | `string` | unknown | — | — | response.data example |
| `trip.endedAt` | `null` | unknown | — | — | response.data example |
| `trip.bus.id` | `string` | unknown | — | — | response.data example |
| `trip.bus.plateNumber` | `string` | unknown | — | — | response.data example |
| `trip.driver.driverId` | `string` | unknown | — | — | response.data example |
| `trip.driver.fullName` | `string` | unknown | — | — | response.data example |
| `trip.route.id` | `string` | unknown | — | — | response.data example |
| `trip.route.routeName` | `string` | unknown | — | — | response.data example |
| `latestLocation.latitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.longitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.recordedAt` | `string` | unknown | — | — | response.data example |
| `routeStops` | `array` | unknown | — | — | response.data example |
| `routeStops[].stopId` | `string` | unknown | — | — | response.data example |
| `routeStops[].stopName` | `string` | unknown | — | — | response.data example |
| `routeStops[].latitude` | `number` | unknown | — | — | response.data example |
| `routeStops[].longitude` | `number` | unknown | — | — | response.data example |
| `routeStops[].stopOrder` | `number` | unknown | — | — | response.data example |
| `eventSummary.boardedCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.droppedOffCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.absentCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.totalEvents` | `number` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: trip detail screen.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/trips/:tripId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `trip`, `latestLocation`, `routeStops`, `eventSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/trips`
- `POST /transport/trips`
- `POST /transport/trips/{id}/end`
- `GET /transport/trips/{id}/events`
- `POST /transport/trips/{id}/events`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Trip` داخل `Transport`

## `POST /transport/trips/{id}/end`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: trip action
- `admin-dashboard/src/features/transport/TripDetailPage.tsx:92` (route /transport/trips/:tripId) عبر direct apiClient

**Purpose**
- OpenAPI summary: End Trip
- OpenAPI description: Mark a trip as ended. Allowed roles: admin, driver.
- ENDPOINT_MAP purpose: end trip

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Trip numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Mark a trip as ended. Roles: admin, driver Auth: Bearer access token required
- ENDPOINT_MAP note: no more locations after end

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
| `tripDate` | `string` | unknown | — | — | response.data example |
| `tripType` | `string` | unknown | — | — | response.data example |
| `tripStatus` | `string` | unknown | — | — | response.data example |
| `startedAt` | `string` | unknown | — | — | response.data example |
| `endedAt` | `null` | unknown | — | — | response.data example |
| `bus.id` | `string` | unknown | — | — | response.data example |
| `bus.plateNumber` | `string` | unknown | — | — | response.data example |
| `driver.driverId` | `string` | unknown | — | — | response.data example |
| `driver.fullName` | `string` | unknown | — | — | response.data example |
| `route.id` | `string` | unknown | — | — | response.data example |
| `route.routeName` | `string` | unknown | — | — | response.data example |
| `latestLocation.latitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.longitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.recordedAt` | `string` | unknown | — | — | response.data example |
| `eventSummary.boardedCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.droppedOffCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.absentCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.totalEvents` | `number` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: trip action.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/trips/:tripId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `tripDate`, `tripType`, `tripStatus`, `startedAt`, `endedAt`, `bus`, `driver`, `route`, `latestLocation`, `eventSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/trips`
- `POST /transport/trips`
- `GET /transport/trips/{id}`
- `GET /transport/trips/{id}/events`
- `POST /transport/trips/{id}/events`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `End Trip` داخل `Transport`

## `GET /transport/trips/{id}/events`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: trip events tab
- `admin-dashboard/src/features/transport/TripDetailPage.tsx:75` (route /transport/trips/:tripId) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Trip Events
- OpenAPI description: List student events recorded for a trip. Allowed roles: admin, driver.
- ENDPOINT_MAP purpose: list trip events

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Trip numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: List student events recorded for a trip. Roles: admin, driver Auth: Bearer access token required
- ENDPOINT_MAP note: use with trip detail

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: trip events tab.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/trips/:tripId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /transport/trips/{id}/events`
- `GET /transport/trips`
- `POST /transport/trips`
- `GET /transport/trips/{id}`
- `POST /transport/trips/{id}/end`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Trip Events` داخل `Transport`

## `POST /transport/trips/{id}/events`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: event panel
- `admin-dashboard/src/features/transport/TripDetailPage.tsx:113` (route /transport/trips/:tripId) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Trip Student Event
- OpenAPI description: Create one trip student event. stopId is required for boarded and dropped_off events, and must be omitted for absent. Allowed roles: admin, driver. Note: Trip student event validation is trip-date aware: the student must have a transport assignment covering the trip date and route. Side effects: Dropped-off events trigger parent notifications through the internal automation service.
- ENDPOINT_MAP purpose: post trip student event

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Trip numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `studentId` | `string` | unknown | — | — | request example |
| `eventType` | `string` | unknown | — | — | request example |
| `stopId` | `string` | unknown | — | — | request example |
| `notes` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create one trip student event. stopId is required for boarded and dropped_off events, and must be omitted for absent. Roles: admin, driver Auth: Bearer access token required Body schema: CreateTripStudentEventRequest Note: Trip student event validation is trip-date aware: the student must have a transport assignment covering the trip date and route. Side effects: Dropped-off events trigger parent notifications through the internal automation service.
- ENDPOINT_MAP note: now validates against assignment coverage on the trip date itself

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `tripStudentEventId` | `string` | unknown | — | — | response.data example |
| `student.studentId` | `string` | unknown | — | — | response.data example |
| `student.academicNo` | `string` | unknown | — | — | response.data example |
| `student.fullName` | `string` | unknown | — | — | response.data example |
| `eventType` | `string` | unknown | — | — | response.data example |
| `eventTime` | `string` | unknown | — | — | response.data example |
| `stop.stopId` | `string` | unknown | — | — | response.data example |
| `stop.stopName` | `string` | unknown | — | — | response.data example |
| `notes` | `null` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `studentId`, `eventType`, `stopId`, `notes`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: event panel.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/trips/:tripId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `tripStudentEventId`, `student`, `eventType`, `eventTime`, `stop`, `notes`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/trips/{id}/events`
- `GET /transport/trips`
- `POST /transport/trips`
- `GET /transport/trips/{id}`
- `POST /transport/trips/{id}/end`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Trip Student Event` داخل `Transport`

## `POST /transport/trips/{id}/locations`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: tracking panel
- `admin-dashboard/src/features/transport/TripDetailPage.tsx:98` (route /transport/trips/:tripId) عبر direct apiClient

**Purpose**
- OpenAPI summary: Record Trip Location
- OpenAPI description: Record one location point for a started trip. Allowed roles: admin, driver.
- ENDPOINT_MAP purpose: post location

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Trip numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `latitude` | `number` | unknown | — | — | request example |
| `longitude` | `number` | unknown | — | — | request example |

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Record one location point for a started trip. Roles: admin, driver Auth: Bearer access token required Body schema: RecordTripLocationRequest
- ENDPOINT_MAP note: mostly driver flow, admin can inspect/use

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
| `tripDate` | `string` | unknown | — | — | response.data example |
| `tripType` | `string` | unknown | — | — | response.data example |
| `tripStatus` | `string` | unknown | — | — | response.data example |
| `startedAt` | `string` | unknown | — | — | response.data example |
| `endedAt` | `null` | unknown | — | — | response.data example |
| `bus.id` | `string` | unknown | — | — | response.data example |
| `bus.plateNumber` | `string` | unknown | — | — | response.data example |
| `driver.driverId` | `string` | unknown | — | — | response.data example |
| `driver.fullName` | `string` | unknown | — | — | response.data example |
| `route.id` | `string` | unknown | — | — | response.data example |
| `route.routeName` | `string` | unknown | — | — | response.data example |
| `latestLocation.latitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.longitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.recordedAt` | `string` | unknown | — | — | response.data example |
| `eventSummary.boardedCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.droppedOffCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.absentCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.totalEvents` | `number` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `id`.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `latitude`, `longitude`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: tracking panel.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/trips/:tripId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `tripDate`, `tripType`, `tripStatus`, `startedAt`, `endedAt`, `bus`, `driver`, `route`, `latestLocation`, `eventSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/trips`
- `POST /transport/trips`
- `GET /transport/trips/{id}`
- `POST /transport/trips/{id}/end`
- `GET /transport/trips/{id}/events`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Record Trip Location` داخل `Transport`

## `POST /transport/trips/{id}/start`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: trip action
- `admin-dashboard/src/features/transport/TripDetailPage.tsx:86` (route /transport/trips/:tripId) عبر direct apiClient

**Purpose**
- OpenAPI summary: Start Trip
- OpenAPI description: Mark a scheduled trip as started. Allowed roles: admin, driver. Side effects: Trip start triggers parent notifications per assigned student through the internal automation service.
- ENDPOINT_MAP purpose: start trip

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Trip numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- Postman request note: Purpose: Mark a scheduled trip as started. Roles: admin, driver Auth: Bearer access token required Side effects: Trip start triggers parent notifications per assigned student through the internal automation service.
- ENDPOINT_MAP note: triggers parent notifications

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
| `tripDate` | `string` | unknown | — | — | response.data example |
| `tripType` | `string` | unknown | — | — | response.data example |
| `tripStatus` | `string` | unknown | — | — | response.data example |
| `startedAt` | `string` | unknown | — | — | response.data example |
| `endedAt` | `null` | unknown | — | — | response.data example |
| `bus.id` | `string` | unknown | — | — | response.data example |
| `bus.plateNumber` | `string` | unknown | — | — | response.data example |
| `driver.driverId` | `string` | unknown | — | — | response.data example |
| `driver.fullName` | `string` | unknown | — | — | response.data example |
| `route.id` | `string` | unknown | — | — | response.data example |
| `route.routeName` | `string` | unknown | — | — | response.data example |
| `latestLocation.latitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.longitude` | `number` | unknown | — | — | response.data example |
| `latestLocation.recordedAt` | `string` | unknown | — | — | response.data example |
| `eventSummary.boardedCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.droppedOffCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.absentCount` | `number` | unknown | — | — | response.data example |
| `eventSummary.totalEvents` | `number` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: trip action.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/trips/:tripId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `tripDate`, `tripType`, `tripStatus`, `startedAt`, `endedAt`, `bus`, `driver`, `route`, `latestLocation`, `eventSummary`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/trips`
- `POST /transport/trips`
- `GET /transport/trips/{id}`
- `POST /transport/trips/{id}/end`
- `GET /transport/trips/{id}/events`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Start Trip` داخل `Transport`

## `GET /transport/trips/{id}/students`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: trip detail / manual ops
- `admin-dashboard/src/features/transport/TripDetailPage.tsx:81` (route /transport/trips/:tripId) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Trip Student Roster
- OpenAPI description: Return the full student roster for one trip, including assigned stop coordinates, the latest event state inside the same trip, and approved home location when available. Allowed roles: admin, driver. Note: The roster returns all students assigned to the trip route for the trip date, even when no trip event has been recorded yet. Note: If the trip exists but has no eligible students, the response remains 200 with students=[]. Note: Only approved homeLocation data is exposed to the driver-facing roster. Derived data: Roster rows are derived from trip-date transport assignments, route stop coordinates, approved student_transport_home_locations, and the latest trip_student_events row per student inside the same trip.
- ENDPOINT_MAP purpose: trip roster

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `id` | `path` | `string` | yes | Trip numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `search` | `query` | `string` | no | Filter roster rows by student full name or academic number. | — |
| `stopId` | `query` | `string` | no | Filter roster rows by assigned stop id. | pattern=^[0-9]+$ |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `id`: pattern=^[0-9]+$.
- `stopId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Return the full student roster for one trip, including assigned stop coordinates, the latest event state inside the same trip, and approved home location when available. Roles: admin, driver Auth: Bearer access token required Query params: search, stopId Note: The roster returns all students assigned to the trip route for the trip date, even when no trip event has been recorded yet. Note: If the trip exists but has no eligible students, the response remains 200 with students=[]. Note: Only approved homeLocation data is exposed to the driver-facing roster. Derived data: Roster rows are derived from trip-date transport assignments, route stop coordinates, approved student_transport_home_locations, and the latest trip_student_events row per student inside the same trip.
- ENDPOINT_MAP note: source of truth for trip students; includes stop coordinates and optional approved home location

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `tripId` | `string` | unknown | — | — | response.data example |
| `tripStatus` | `string` | unknown | — | — | response.data example |
| `students` | `array` | unknown | — | — | response.data example |
| `students[].studentId` | `string` | unknown | — | — | response.data example |
| `students[].academicNo` | `string` | unknown | — | — | response.data example |
| `students[].fullName` | `string` | unknown | — | — | response.data example |
| `students[].assignedStop.stopId` | `string` | unknown | — | — | response.data example |
| `students[].assignedStop.stopName` | `string` | unknown | — | — | response.data example |
| `students[].assignedStop.latitude` | `number` | unknown | — | — | response.data example |
| `students[].assignedStop.longitude` | `number` | unknown | — | — | response.data example |
| `students[].assignedStop.stopOrder` | `number` | unknown | — | — | response.data example |
| `students[].homeLocation.latitude` | `number` | unknown | — | — | response.data example |
| `students[].homeLocation.longitude` | `number` | unknown | — | — | response.data example |
| `students[].homeLocation.addressLabel` | `string` | unknown | — | — | response.data example |
| `students[].homeLocation.addressText` | `string` | unknown | — | — | response.data example |
| `students[].currentTripEventType` | `string` | unknown | — | — | response.data example |
| `students[].lastEvent.eventType` | `string` | unknown | — | — | response.data example |
| `students[].lastEvent.eventTime` | `string` | unknown | — | — | response.data example |
| `students[].lastEvent.stopId` | `string` | unknown | — | — | response.data example |

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: trip detail / manual ops.
- يظهر ضمن هذه المسارات/السياقات: `route /transport/trips/:tripId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/transport/TripDetailPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `tripId`, `tripStatus`, `students`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /transport/trips`
- `POST /transport/trips`
- `GET /transport/trips/{id}`
- `POST /transport/trips/{id}/end`
- `GET /transport/trips/{id}/events`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Trip Student Roster` داخل `Transport`
