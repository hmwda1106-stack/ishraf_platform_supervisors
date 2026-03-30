# Communication

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Communication**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `GET /communication/announcements`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: admin announcement list
- `admin-dashboard/src/features/communication/AnnouncementsPage.tsx:34` (route /announcements) عبر direct apiClient

**Purpose**
- OpenAPI summary: List All Announcements
- OpenAPI description: List all announcements, including expired ones, for admin management. Allowed roles: admin.
- ENDPOINT_MAP purpose: list all announcements

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
- Postman request note: Purpose: List all announcements, including expired ones, for admin management. Roles: admin Auth: Bearer access token required
- ENDPOINT_MAP note: includes expired items

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: admin announcement list.
- يظهر ضمن هذه المسارات/السياقات: `route /announcements`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/AnnouncementsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /communication/announcements`
- `GET /communication/announcements/active`
- `POST /communication/messages`
- `PATCH /communication/messages/{messageId}/read`
- `GET /communication/messages/conversations/{otherUserId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List All Announcements` داخل `Communication`

## `POST /communication/announcements`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: announcement form
- `admin-dashboard/src/features/communication/AnnouncementsPage.tsx:51` (route /announcements) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Announcement
- OpenAPI description: Create an announcement. targetRole narrows the feed; null targets all active users. Allowed roles: admin.
- ENDPOINT_MAP purpose: create announcement

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
| `title` | `string` | unknown | — | — | request example |
| `content` | `string` | unknown | — | — | request example |
| `targetRole` | `string` | unknown | — | — | request example |
| `expiresAt` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create an announcement. targetRole narrows the feed; null targets all active users. Roles: admin Auth: Bearer access token required Body schema: CreateAnnouncementRequest
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
| `content` | `string` | unknown | — | — | response.data example |
| `targetRole` | `null` | unknown | — | — | response.data example |
| `publishedAt` | `string` | unknown | — | — | response.data example |
| `expiresAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `title`, `content`, `targetRole`, `expiresAt`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: announcement form.
- يظهر ضمن هذه المسارات/السياقات: `route /announcements`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/AnnouncementsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `title`, `content`, `targetRole`, `publishedAt`, `expiresAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /communication/announcements`
- `GET /communication/announcements/active`
- `POST /communication/messages`
- `PATCH /communication/messages/{messageId}/read`
- `GET /communication/messages/conversations/{otherUserId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Announcement` داخل `Communication`

## `GET /communication/announcements/active`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: shared preview/feed
- `admin-dashboard/src/features/communication/AnnouncementsPage.tsx:43` (route /announcements) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Active Announcements
- OpenAPI description: Return the active announcement feed visible to the authenticated role. Allowed roles: admin, parent, teacher, supervisor, driver. Derived data: The feed uses SQL views such as vw_active_announcements and targetRole filtering.
- ENDPOINT_MAP purpose: active announcement feed

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `parent`, `teacher`, `supervisor`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- Postman request note: Purpose: Return the active announcement feed visible to the authenticated role. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required Derived data: The feed uses SQL views such as vw_active_announcements and targetRole filtering.
- ENDPOINT_MAP note: role-filtered but admin can read

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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: shared preview/feed.
- يظهر ضمن هذه المسارات/السياقات: `route /announcements`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/AnnouncementsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(array)`, ``.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `GET /communication/announcements`
- `POST /communication/announcements`
- `POST /communication/messages`
- `PATCH /communication/messages/{messageId}/read`
- `GET /communication/messages/conversations/{otherUserId}`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Active Announcements` داخل `Communication`

## `POST /communication/messages`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: compose/conversation
- `admin-dashboard/src/features/communication/ConversationPage.tsx:57` (route /communication/conversations/:otherUserId) عبر direct apiClient
- `admin-dashboard/src/features/communication/InboxPage.tsx:57` (route /inbox) عبر direct apiClient

**Purpose**
- OpenAPI summary: Send Message
- OpenAPI description: Send a direct message to another active user. Allowed roles: admin, parent, teacher, supervisor, driver.
- ENDPOINT_MAP purpose: send direct message

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `parent`, `teacher`, `supervisor`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `receiverUserId` | `string` | unknown | — | — | request example |
| `messageBody` | `string` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Send a direct message to another active user. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required Body schema: SendMessageRequest
- ENDPOINT_MAP note: any active user

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
| `senderUserId` | `string` | unknown | — | — | response.data example |
| `receiverUserId` | `string` | unknown | — | — | response.data example |
| `messageBody` | `string` | unknown | — | — | response.data example |
| `sentAt` | `string` | unknown | — | — | response.data example |
| `readAt` | `null` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `receiverUserId`, `messageBody`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: compose/conversation.
- يظهر ضمن هذه المسارات/السياقات: `route /communication/conversations/:otherUserId`, `route /inbox`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/ConversationPage.tsx`, `admin-dashboard/src/features/communication/InboxPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `senderUserId`, `receiverUserId`, `messageBody`, `sentAt`, `readAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `PATCH /communication/messages/{messageId}/read`
- `GET /communication/messages/conversations/{otherUserId}`
- `GET /communication/messages/inbox`
- `GET /communication/messages/sent`
- `GET /communication/announcements`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Send Message` داخل `Communication`

## `PATCH /communication/messages/{messageId}/read`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: inbox/conversation
- `admin-dashboard/src/features/communication/ConversationPage.tsx:48` (route /communication/conversations/:otherUserId) عبر direct apiClient
- `admin-dashboard/src/features/communication/InboxPage.tsx:51` (route /inbox) عبر direct apiClient

**Purpose**
- OpenAPI summary: Mark Message Read
- OpenAPI description: Mark one received message as read. Allowed roles: admin, parent, teacher, supervisor, driver.
- ENDPOINT_MAP purpose: mark message read

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `parent`, `teacher`, `supervisor`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `messageId` | `path` | `string` | yes | Message numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `messageId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Mark one received message as read. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required
- ENDPOINT_MAP note: receiver only

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
| `senderUserId` | `string` | unknown | — | — | response.data example |
| `receiverUserId` | `string` | unknown | — | — | response.data example |
| `messageBody` | `string` | unknown | — | — | response.data example |
| `sentAt` | `string` | unknown | — | — | response.data example |
| `readAt` | `null` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `messageId`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: inbox/conversation.
- يظهر ضمن هذه المسارات/السياقات: `route /communication/conversations/:otherUserId`, `route /inbox`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/ConversationPage.tsx`, `admin-dashboard/src/features/communication/InboxPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `senderUserId`, `receiverUserId`, `messageBody`, `sentAt`, `readAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /communication/messages`
- `GET /communication/messages/conversations/{otherUserId}`
- `GET /communication/messages/inbox`
- `GET /communication/messages/sent`
- `GET /communication/announcements`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Mark Message Read` داخل `Communication`

## `GET /communication/messages/conversations/{otherUserId}`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: conversation view
- `admin-dashboard/src/features/communication/ConversationPage.tsx:36` (route /communication/conversations/:otherUserId) عبر direct apiClient

**Purpose**
- OpenAPI summary: Get Conversation
- OpenAPI description: List a direct conversation thread with another user. The default sort is ascending by sentAt. Allowed roles: admin, parent, teacher, supervisor, driver.
- ENDPOINT_MAP purpose: conversation

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `parent`, `teacher`, `supervisor`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `otherUserId` | `path` | `string` | yes | The other conversation participant user id. | pattern=^[0-9]+$ |

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `page` | `query` | `integer` | no | Pagination page number. | min=1 |
| `limit` | `query` | `integer` | no | Pagination page size. | min=1 \| max=100 |
| `sortBy` | `query` | `string (sentAt)` | no | Sort field whitelist. | enum=sentAt |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `otherUserId`: pattern=^[0-9]+$.
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=sentAt.
- `sortOrder`: enum=asc, desc.
- Postman request note: Purpose: List a direct conversation thread with another user. The default sort is ascending by sentAt. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder
- ENDPOINT_MAP note: default `sentAt asc`

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
- Path params الإلزامية: `otherUserId`.
- لا توجد query params إلزامية موثقة صراحة.
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data.items`, `data.items[]`, `data.pagination.page`, `data.pagination.limit`, `data.pagination.totalItems`, `data.pagination.totalPages`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |
| `404` | Primary resource not found | Not Found |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: conversation view.
- يظهر ضمن هذه المسارات/السياقات: `route /communication/conversations/:otherUserId`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/ConversationPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /communication/messages`
- `PATCH /communication/messages/{messageId}/read`
- `GET /communication/messages/inbox`
- `GET /communication/messages/sent`
- `GET /communication/announcements`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Get Conversation` داخل `Communication`

## `GET /communication/messages/inbox`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: inbox screen
- `admin-dashboard/src/features/communication/InboxPage.tsx:33` (route /inbox) عبر direct apiClient
- `admin-dashboard/src/shared/layouts/Sidebar.tsx:61` ([shared] sidebar unread counters) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Inbox
- OpenAPI description: List inbox messages for the authenticated user with unreadCount metadata. Allowed roles: admin, parent, teacher, supervisor, driver.
- ENDPOINT_MAP purpose: inbox

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `parent`, `teacher`, `supervisor`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `page` | `query` | `integer` | no | Pagination page number. | min=1 |
| `limit` | `query` | `integer` | no | Pagination page size. | min=1 \| max=100 |
| `sortBy` | `query` | `string (sentAt)` | no | Sort field whitelist. | enum=sentAt |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `isRead` | `query` | `boolean` | no | Filter by read state. | — |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=sentAt.
- `sortOrder`: enum=asc, desc.
- Postman request note: Purpose: List inbox messages for the authenticated user with unreadCount metadata. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, isRead
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: inbox screen.
- يظهر ضمن هذه المسارات/السياقات: `route /inbox`, `[shared] sidebar unread counters`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/InboxPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /communication/messages`
- `PATCH /communication/messages/{messageId}/read`
- `GET /communication/messages/conversations/{otherUserId}`
- `GET /communication/messages/sent`
- `GET /communication/announcements`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Inbox` داخل `Communication`

## `GET /communication/messages/sent`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: sent screen
- `admin-dashboard/src/features/communication/SentPage.tsx:25` (route /sent) عبر direct apiClient

**Purpose**
- OpenAPI summary: List Sent Messages
- OpenAPI description: List sent messages for the authenticated user. Allowed roles: admin, parent, teacher, supervisor, driver.
- ENDPOINT_MAP purpose: sent

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `parent`, `teacher`, `supervisor`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `page` | `query` | `integer` | no | Pagination page number. | min=1 |
| `limit` | `query` | `integer` | no | Pagination page size. | min=1 \| max=100 |
| `sortBy` | `query` | `string (sentAt)` | no | Sort field whitelist. | enum=sentAt |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `receiverUserId` | `query` | `string` | no | Filter by receiver user id. | pattern=^[0-9]+$ |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=sentAt.
- `sortOrder`: enum=asc, desc.
- `receiverUserId`: pattern=^[0-9]+$.
- Postman request note: Purpose: List sent messages for the authenticated user. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, receiverUserId
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: sent screen.
- يظهر ضمن هذه المسارات/السياقات: `route /sent`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/SentPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /communication/messages`
- `PATCH /communication/messages/{messageId}/read`
- `GET /communication/messages/conversations/{otherUserId}`
- `GET /communication/messages/inbox`
- `GET /communication/announcements`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List Sent Messages` داخل `Communication`

## `POST /communication/notifications`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: manual notification form
- `admin-dashboard/src/features/communication/NotificationsPage.tsx:76` (route /notifications) عبر direct apiClient

**Purpose**
- OpenAPI summary: Create Notification
- OpenAPI description: Create a manual notification for one user. notificationType is free-form and can coexist with automation-generated values. Allowed roles: admin.
- ENDPOINT_MAP purpose: create manual notification

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
| `userId` | `string` | unknown | — | — | request example |
| `title` | `string` | unknown | — | — | request example |
| `message` | `string` | unknown | — | — | request example |
| `notificationType` | `string` | unknown | — | — | request example |
| `referenceType` | `null` | unknown | — | — | request example |
| `referenceId` | `null` | unknown | — | — | request example |

**Backend Validation Rules**
- لا توجد constraints بنيوية مفصلة لكل حقول body في OpenAPI الحالية؛ الحقول موثقة من schema/examples الرسمية فقط.
- Postman request note: Purpose: Create a manual notification for one user. notificationType is free-form and can coexist with automation-generated values. Roles: admin Auth: Bearer access token required Body schema: CreateNotificationRequest
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
| `userId` | `string` | unknown | — | — | response.data example |
| `title` | `string` | unknown | — | — | response.data example |
| `message` | `string` | unknown | — | — | response.data example |
| `notificationType` | `string` | unknown | — | — | response.data example |
| `referenceType` | `string` | unknown | — | — | response.data example |
| `referenceId` | `string` | unknown | — | — | response.data example |
| `isRead` | `boolean` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- توجد حقول body موثقة من examples فقط، لذلك حالة الإلزام لبعضها ما زالت `unknown`: `userId`, `title`, `message`, `notificationType`, `referenceType`, `referenceId`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.
- Schema الـ request في OpenAPI مفتوحة/عامة؛ أسماء الحقول موثقة من example الرسمي أو Postman وليس من properties مفصلة.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: manual notification form.
- يظهر ضمن هذه المسارات/السياقات: `route /notifications`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/NotificationsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `userId`, `title`, `message`, `notificationType`, `referenceType`, `referenceId`, `isRead`, `createdAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `PATCH /communication/notifications/{notificationId}/read`
- `GET /communication/notifications/me`
- `GET /communication/announcements`
- `POST /communication/announcements`
- `GET /communication/announcements/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Create Notification` داخل `Communication`

## `PATCH /communication/notifications/{notificationId}/read`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: notification center
- `admin-dashboard/src/features/communication/NotificationsPage.tsx:70` (route /notifications) عبر direct apiClient

**Purpose**
- OpenAPI summary: Mark Notification Read
- OpenAPI description: Mark one notification as read. Allowed roles: admin, parent, teacher, supervisor, driver.
- ENDPOINT_MAP purpose: mark notification read

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `parent`, `teacher`, `supervisor`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `notificationId` | `path` | `string` | yes | Notification numeric string identifier. | pattern=^[0-9]+$ |

**Query Params**
لا يوجد.

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `notificationId`: pattern=^[0-9]+$.
- Postman request note: Purpose: Mark one notification as read. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required
- ENDPOINT_MAP note: owner only

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
| `userId` | `string` | unknown | — | — | response.data example |
| `title` | `string` | unknown | — | — | response.data example |
| `message` | `string` | unknown | — | — | response.data example |
| `notificationType` | `string` | unknown | — | — | response.data example |
| `referenceType` | `string` | unknown | — | — | response.data example |
| `referenceId` | `string` | unknown | — | — | response.data example |
| `isRead` | `boolean` | unknown | — | — | response.data example |
| `createdAt` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- Path params الإلزامية: `notificationId`.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: notification center.
- يظهر ضمن هذه المسارات/السياقات: `route /notifications`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/NotificationsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `userId`, `title`, `message`, `notificationType`, `referenceType`, `referenceId`, `isRead`, `createdAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /communication/notifications`
- `GET /communication/notifications/me`
- `GET /communication/announcements`
- `POST /communication/announcements`
- `GET /communication/announcements/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Mark Notification Read` داخل `Communication`

## `GET /communication/notifications/me`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: notification center
- `admin-dashboard/src/features/communication/NotificationsPage.tsx:52` (route /notifications) عبر direct apiClient
- `admin-dashboard/src/shared/layouts/Sidebar.tsx:75` ([shared] sidebar unread counters) عبر direct apiClient

**Purpose**
- OpenAPI summary: List My Notifications
- OpenAPI description: List notifications for the authenticated user with unreadCount metadata. Allowed roles: admin, parent, teacher, supervisor, driver. Derived data: Notification lists rely on views such as vw_notification_details and vw_user_notification_summary.
- ENDPOINT_MAP purpose: my notifications

**Auth / Role**
- Security: `bearerAuth`
- Allowed roles: `admin`, `parent`, `teacher`, `supervisor`, `driver`
- ENDPOINT_MAP auth note: Bearer

**Path Params**
لا يوجد.

**Query Params**
| Param | In | Type | Required | Description | Constraints |
| --- | --- | --- | --- | --- | --- |
| `page` | `query` | `integer` | no | Pagination page number. | min=1 |
| `limit` | `query` | `integer` | no | Pagination page size. | min=1 \| max=100 |
| `sortBy` | `query` | `string (createdAt, readAt)` | no | Sort field whitelist. | enum=createdAt, readAt |
| `sortOrder` | `query` | `string (asc, desc)` | no | Sort direction. | enum=asc, desc |
| `isRead` | `query` | `boolean` | no | Filter by read state. | — |
| `notificationType` | `query` | `string` | no | Filter by notification type. | — |

**Body Params**
لا توجد body params.

**Backend Validation Rules**
- `page`: min=1.
- `limit`: min=1 | max=100.
- `sortBy`: enum=createdAt, readAt.
- `sortOrder`: enum=asc, desc.
- Postman request note: Purpose: List notifications for the authenticated user with unreadCount metadata. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required Query params: page, limit, sortBy, sortOrder, isRead, notificationType Derived data: Notification lists rely on views such as vw_notification_details and vw_user_notification_summary.
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
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: notification center.
- يظهر ضمن هذه المسارات/السياقات: `route /notifications`, `[shared] sidebar unread counters`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/communication/NotificationsPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `items`, `pagination`, `unreadCount`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /communication/notifications`
- `PATCH /communication/notifications/{notificationId}/read`
- `GET /communication/announcements`
- `POST /communication/announcements`
- `GET /communication/announcements/active`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `List My Notifications` داخل `Communication`
