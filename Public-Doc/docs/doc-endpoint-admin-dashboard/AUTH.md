# Auth

هذا الملف يوثق فقط الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` ضمن دومين **Auth**، وتمت مطابقتها مع `OpenAPI` و`Postman` و`ENDPOINT_MAP` قبل الكتابة.

## `POST /auth/change-password`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: password screen
- `admin-dashboard/src/features/auth/ChangePasswordPage.tsx:27` (route /change-password) عبر direct apiClient

**Purpose**
- OpenAPI summary: Change Password
- OpenAPI description: Change the current authenticated user password. Allowed roles: admin, parent, teacher, supervisor, driver.
- ENDPOINT_MAP purpose: change password

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
| `currentPassword` | `string` | yes | — | minLength=1 | request schema (ChangePasswordRequest) |
| `newPassword` | `string` | yes | — | minLength=8 \| maxLength=72 | request schema (ChangePasswordRequest) |

**Backend Validation Rules**
- `currentPassword`: minLength=1.
- `newPassword`: minLength=8 | maxLength=72.
- Postman request note: Purpose: Change the current authenticated user password. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required Body schema: ChangePasswordRequest
- ENDPOINT_MAP note: بعد النجاح توقّع login جديد

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `null` | yes | — | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(value)` | `null` | yes | — | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `currentPassword`, `newPassword`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: password screen.
- يظهر ضمن هذه المسارات/السياقات: `route /change-password`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/auth/ChangePasswordPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(value)`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /auth/forgot-password`
- `POST /auth/login`
- `POST /auth/logout`
- `GET /auth/me`
- `POST /auth/refresh`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Change Password` داخل `Auth`

## `POST /auth/forgot-password`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: forgot password
- `admin-dashboard/src/features/auth/ForgotPasswordPage.tsx:24` (route /forgot-password) عبر direct apiClient

**Purpose**
- OpenAPI summary: Forgot Password
- OpenAPI description: Request a password reset token for an active account. Staging usually does not expose resetToken in the response. Public endpoint.
- ENDPOINT_MAP purpose: start reset flow

**Auth / Role**
- Security: public / no bearer in OpenAPI
- Allowed roles: `public`
- ENDPOINT_MAP auth note: لا

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `identifier` | `string` | yes | — | minLength=1 | request schema (ForgotPasswordRequest) |

**Backend Validation Rules**
- `identifier`: minLength=1.
- Postman request note: Purpose: Request a password reset token for an active account. Staging usually does not expose resetToken in the response. Roles: public Auth: No bearer token required Body schema: ForgotPasswordRequest
- ENDPOINT_MAP note: لا تعتمد على `resetToken` في staging

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `object` | yes | GenericObject schema | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `name` | `string` | unknown | — | — | response.data example |
| `environment` | `string` | unknown | — | — | response.data example |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `identifier`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `429` | Rate limit reached | Too Many Requests |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: forgot password.
- يظهر ضمن هذه المسارات/السياقات: `route /forgot-password`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/auth/ForgotPasswordPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `name`, `environment`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /auth/change-password`
- `POST /auth/login`
- `POST /auth/logout`
- `GET /auth/me`
- `POST /auth/refresh`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Forgot Password` داخل `Auth`

## `POST /auth/login`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: شاشة الدخول
- `admin-dashboard/src/features/auth/LoginPage.tsx:39` (route /login) عبر direct apiClient

**Purpose**
- OpenAPI summary: Login
- OpenAPI description: Authenticate with email or phone and issue access and refresh tokens. Public endpoint.
- ENDPOINT_MAP purpose: login

**Auth / Role**
- Security: public / no bearer in OpenAPI
- Allowed roles: `public`
- ENDPOINT_MAP auth note: لا

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `identifier` | `string` | yes | — | minLength=1 | request schema (LoginRequest) |
| `password` | `string` | yes | — | minLength=1 | request schema (LoginRequest) |

**Backend Validation Rules**
- `identifier`: minLength=1.
- `password`: minLength=1.
- Postman request note: Purpose: Authenticate with email or phone and issue access and refresh tokens. Roles: public Auth: No bearer token required Body schema: LoginRequest
- ENDPOINT_MAP note: عالج `401/403/429`

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
- حقول body الإلزامية الموثقة: `identifier`, `password`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `429` | Rate limit reached | Too Many Requests |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: شاشة الدخول.
- يظهر ضمن هذه المسارات/السياقات: `route /login`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/auth/LoginPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /auth/change-password`
- `POST /auth/forgot-password`
- `POST /auth/logout`
- `GET /auth/me`
- `POST /auth/refresh`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Login` داخل `Auth`

## `POST /auth/logout`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: profile menu
- `admin-dashboard/src/shared/hooks/useAuth.ts:41` ([shared] auth logout hook) عبر direct apiClient

**Purpose**
- OpenAPI summary: Logout
- OpenAPI description: Revoke the provided refresh token. Public endpoint.
- ENDPOINT_MAP purpose: logout

**Auth / Role**
- Security: public / no bearer in OpenAPI
- Allowed roles: `public`
- ENDPOINT_MAP auth note: لا

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `refreshToken` | `string` | yes | — | minLength=1 | request schema (LogoutRequest) |

**Backend Validation Rules**
- `refreshToken`: minLength=1.
- Postman request note: Purpose: Revoke the provided refresh token. Roles: public Auth: No bearer token required Body schema: LogoutRequest
- ENDPOINT_MAP note: امسح session محليًا دائمًا

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `null` | yes | — | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(value)` | `null` | yes | — | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `refreshToken`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: profile menu.
- يظهر ضمن هذه المسارات/السياقات: `[shared] auth logout hook`.
- يمر عبر طبقة shared/helper فقط في الفرونت الحالي.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(value)`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /auth/change-password`
- `POST /auth/forgot-password`
- `POST /auth/login`
- `GET /auth/me`
- `POST /auth/refresh`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Logout` داخل `Auth`

## `GET /auth/me`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: app bootstrap
- `admin-dashboard/src/shared/components/AuthGuard.tsx:22` ([shared] admin shell bootstrap) عبر direct apiClient

**Purpose**
- OpenAPI summary: Current User
- OpenAPI description: Return the authenticated active user profile used for frontend bootstrap. Allowed roles: admin, parent, teacher, supervisor, driver.
- ENDPOINT_MAP purpose: current user

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
- Postman request note: Purpose: Return the authenticated active user profile used for frontend bootstrap. Roles: admin, parent, teacher, supervisor, driver Auth: Bearer access token required
- ENDPOINT_MAP note: confirms role

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
- لا توجد body params.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `401` | Authentication is missing or expired | Unauthorized |
| `403` | Authenticated but not allowed | Forbidden |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: app bootstrap.
- يظهر ضمن هذه المسارات/السياقات: `[shared] admin shell bootstrap`.
- يمر عبر طبقة shared/helper فقط في الفرونت الحالي.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /auth/change-password`
- `POST /auth/forgot-password`
- `POST /auth/login`
- `POST /auth/logout`
- `POST /auth/refresh`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Current User` داخل `Auth`

## `POST /auth/refresh`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: auth client
- `admin-dashboard/src/api/client.ts:75` ([shared] api client / token refresh) عبر direct axios

**Purpose**
- OpenAPI summary: Refresh Token
- OpenAPI description: Exchange a valid refresh token for a fresh access/refresh pair. Public endpoint.
- ENDPOINT_MAP purpose: refresh session

**Auth / Role**
- Security: public / no bearer in OpenAPI
- Allowed roles: `public`
- ENDPOINT_MAP auth note: لا

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `refreshToken` | `string` | yes | — | minLength=1 | request schema (RefreshTokenRequest) |

**Backend Validation Rules**
- `refreshToken`: minLength=1.
- Postman request note: Purpose: Exchange a valid refresh token for a fresh access/refresh pair. Roles: public Auth: No bearer token required Body schema: RefreshTokenRequest
- ENDPOINT_MAP note: retry once only

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
- حقول body الإلزامية الموثقة: `refreshToken`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: auth client.
- يظهر ضمن هذه المسارات/السياقات: `[shared] api client / token refresh`.
- يمر عبر طبقة shared/helper فقط في الفرونت الحالي.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `id`, `fullName`, `email`, `phone`, `role`, `isActive`, `createdAt`, `updatedAt`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /auth/change-password`
- `POST /auth/forgot-password`
- `POST /auth/login`
- `POST /auth/logout`
- `GET /auth/me`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Refresh Token` داخل `Auth`

## `POST /auth/reset-password`

**Used In**
- الوصف التنفيذي في `ENDPOINT_MAP`: reset password
- `admin-dashboard/src/features/auth/ResetPasswordPage.tsx:32` (route /reset-password) عبر direct apiClient

**Purpose**
- OpenAPI summary: Reset Password
- OpenAPI description: Reset the password using a valid reset token. Successful reset revokes existing refresh tokens. Public endpoint.
- ENDPOINT_MAP purpose: complete reset

**Auth / Role**
- Security: public / no bearer in OpenAPI
- Allowed roles: `public`
- ENDPOINT_MAP auth note: لا

**Path Params**
لا يوجد.

**Query Params**
لا يوجد.

**Body Params**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `token` | `string` | yes | — | minLength=1 | request schema (ResetPasswordRequest) |
| `newPassword` | `string` | yes | — | minLength=8 \| maxLength=72 | request schema (ResetPasswordRequest) |

**Backend Validation Rules**
- `token`: minLength=1.
- `newPassword`: minLength=8 | maxLength=72.
- Postman request note: Purpose: Reset the password using a valid reset token. Successful reset revokes existing refresh tokens. Roles: public Auth: No bearer token required Body schema: ResetPasswordRequest
- ENDPOINT_MAP note: UI جاهز حتى لو كانت آلية التسليم تشغيلية

**Success Response Envelope**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `success` | `const true` | yes | — | const=true | response schema |
| `message` | `string` | yes | — | — | response schema |
| `data` | `null` | yes | — | — | response schema |

**Response Data Shape**
| Field | Type | Required | Description | Constraints | Source |
| --- | --- | --- | --- | --- | --- |
| `(value)` | `null` | yes | — | — | response.data schema |

**Required vs Optional Fields**
- لا يوجد path params.
- لا توجد query params إلزامية موثقة صراحة.
- حقول body الإلزامية الموثقة: `token`, `newPassword`.
- حقول envelope الإلزامية الموثقة: `success`, `message`, `data`.

**Failure Cases**
| Status | Description | Example Message |
| --- | --- | --- |
| `400` | Validation failed | Validation failed |
| `429` | Rate limit reached | Too Many Requests |

**Usage in Admin Dashboard**
- يستخدمه الفرونت لهذا الغرض وفق الخريطة التنفيذية: reset password.
- يظهر ضمن هذه المسارات/السياقات: `route /reset-password`.
- الصفحات/الوحدات المباشرة: `admin-dashboard/src/features/auth/ResetPasswordPage.tsx`.

**Derived Data**
- يمكن اشتقاق البيانات مباشرة من المفاتيح الموثقة في `data`: `(value)`.
- أي اشتقاق في الفرونت يجب أن يبقى محصورًا في الحقول الموثقة أعلاه، خصوصًا عند بناء selectors أو table rows أو detail blocks.

**Related Endpoints**
- `POST /auth/change-password`
- `POST /auth/forgot-password`
- `POST /auth/login`
- `POST /auth/logout`
- `GET /auth/me`

**Verification Sources**
- Frontend discovery: matched
- ENDPOINT_MAP: matched
- OpenAPI: matched
- Postman: matched
- Postman item: `Reset Password` داخل `Auth`
