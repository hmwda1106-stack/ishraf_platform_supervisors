# التوثيق العكسي لقدرات الباك إند غير المستخدمة في لوحة الإدارة

Generated at: 2026-03-28T00:14:09.373Z

## المقدمة والمنهجية

هذا الملف يبدأ من **القدرات الخلفية الفعلية** ثم يقارنها بما تستخدمه لوحة الإدارة الحالية، بدل الانطلاق من الـ frontend callsites فقط.

مصادر الحقيقة المعتمدة:
- `Public-Doc/docs/openapi/ishraf-platform.openapi.json`
- `Public-Doc/docs/postman/ishraf-platform.postman_collection.json`
- `Public-Doc/docs/API_REFERENCE.md`
- `Public-Doc/docs/BACKEND_WAVE1_STATUS.md`
- `Public-Doc/docs/OPENAPI_POSTMAN_AUDIT.md`
- `Public-Doc/docs/frontend-execution/admin-dashboard/ENDPOINT_MAP.md`
- `admin-dashboard/src` عبر الاكتشاف المباشر
- `Public-Doc/docs/doc-endpoint-admin-dashboard/DISCOVERY_MATRIX.md` كمرجع تغطية للاستخدام الحالي فقط

منهج المقارنة متعددة المستويات:
- **Level 1**: endpoint coverage
- **Level 2**: request surface coverage (`query` و`body`)
- **Level 3**: response / data surface coverage
- **Level 4**: domain / relationship coverage المبني على العلاقات المعلنة في المراجع الخلفية

مهم:
- تصنيف "غير مستخدم" هنا لا يعني أنه يجب بناؤه فورًا، بل يعني أنه **موجود في الباك ومهمل في لوحة الإدارة الحالية**.
- المقارنة الأدنى من مستوى endpoint تعتمد على static token presence في الملفات المستهلكة الحالية، مع توثيق أي مناطق لا يمكن حسمها دون تخمين داخل قسم `Verification Gaps`.

## الملخص الرقمي

- إجمالي backend endpoints من OpenAPI الحالية: **123**
- Runtime endpoint count الموثق في audit: **123**
- Used in admin dashboard: **106**
- Unused but admin-direct: **4**
- Unused but admin-shared: **1**
- Unused but admin-adjacent: **10**
- Backend capabilities not used but still relevant to admin scope: **15**
- Out of scope for admin dashboard comparison: **2**
- Forward docs alignment with current discovery: **matched (106/106)**

## Coverage Summary Matrix

| Domain | Backend Total | Used | Unused Admin-direct | Unused Admin-shared | Unused Admin-adjacent | Out Of Scope |
| --- | --- | --- | --- | --- | --- | --- |
| Health | 2 | 0 | 0 | 0 | 0 | 2 |
| Auth | 7 | 7 | 0 | 0 | 0 | 0 |
| Users | 5 | 5 | 0 | 0 | 0 | 0 |
| Academic Structure | 24 | 20 | 4 | 0 | 0 | 0 |
| Students | 8 | 8 | 0 | 0 | 0 | 0 |
| Attendance | 5 | 5 | 0 | 0 | 0 | 0 |
| Assessments | 8 | 8 | 0 | 0 | 0 | 0 |
| Behavior | 7 | 7 | 0 | 0 | 0 | 0 |
| Homework | 5 | 5 | 0 | 0 | 0 | 0 |
| Transport | 26 | 24 | 0 | 0 | 2 | 0 |
| Communication | 12 | 11 | 0 | 1 | 0 | 0 |
| Reporting | 14 | 6 | 0 | 0 | 8 | 0 |

## Unused Endpoint Inventory — Admin-direct

| Method | Path | Domain | Role Scope | Why Relevant | Why Currently Unused | Potential Admin Value |
| --- | --- | --- | --- | --- | --- | --- |
| `GET` | `/academic-structure/academic-years/{id}` | Academic Structure | `admin` | امتداد مباشر لإدارة master data الأكاديمية مع payload detail مستقل عن صفوف القوائم. | الواجهة الحالية تعتمد على list pages وmodals، بدون شاشات detail/drill-down مستقلة لهذه الكيانات. | إتاحة detail payload أوضح، edit hydration أدق، وتقليل الاعتماد على صفوف الجداول كمصدر الحالة الوحيد. |
| `GET` | `/academic-structure/classes/{id}` | Academic Structure | `admin` | امتداد مباشر لإدارة master data الأكاديمية مع payload detail مستقل عن صفوف القوائم. | الواجهة الحالية تعتمد على list pages وmodals، بدون شاشات detail/drill-down مستقلة لهذه الكيانات. | إتاحة detail payload أوضح، edit hydration أدق، وتقليل الاعتماد على صفوف الجداول كمصدر الحالة الوحيد. |
| `GET` | `/academic-structure/subject-offerings/{id}` | Academic Structure | `admin` | امتداد مباشر لإدارة master data الأكاديمية مع payload detail مستقل عن صفوف القوائم. | الواجهة الحالية تعتمد على list pages وmodals، بدون شاشات detail/drill-down مستقلة لهذه الكيانات. | إتاحة detail payload أوضح، edit hydration أدق، وتقليل الاعتماد على صفوف الجداول كمصدر الحالة الوحيد. |
| `GET` | `/academic-structure/subjects/{id}` | Academic Structure | `admin` | امتداد مباشر لإدارة master data الأكاديمية مع payload detail مستقل عن صفوف القوائم. | الواجهة الحالية تعتمد على list pages وmodals، بدون شاشات detail/drill-down مستقلة لهذه الكيانات. | إتاحة detail payload أوضح، edit hydration أدق، وتقليل الاعتماد على صفوف الجداول كمصدر الحالة الوحيد. |

## Unused Endpoint Inventory — Admin-shared

| Method | Path | Domain | Role Scope | Why Relevant | Why Currently Unused | Potential Admin Value |
| --- | --- | --- | --- | --- | --- | --- |
| `GET` | `/communication/recipients` | Communication | `admin`, `teacher`, `parent`, `supervisor`, `driver` | دليل recipients الرسمي لأسطح messaging ويمنع الاعتماد على `/users` كحل بديل عام. | لوحة الإدارة ما زالت تبني بعض قوائم المراسلة من `/users` بدل directory التخصصي للمراسلة. | توحيد compose flows على contract backend الصحيح، وتحسين البحث/الفلترة/الاستبعاد الذاتي للمستلمين. |

## Unused Endpoint Inventory — Admin-adjacent

| Method | Path | Domain | Role Scope | Why Relevant | Why Currently Unused | Potential Admin Value |
| --- | --- | --- | --- | --- | --- | --- |
| `GET` | `/transport/route-assignments/me` | Transport | `driver` | جزء من daily transport workflow المشتق مباشرة من route assignments التي يديرها admin. | هذه endpoints مهيأة لتطبيق السائق، بينما لوحة الإدارة ما زالت تركز على surfaces الإدارة والـ fallback اليدوي. | بناء أدوات ops أو simulation أو troubleshooting لسير عمل السائق اليومي انطلاقًا من surfaces الإدارة. |
| `POST` | `/transport/trips/ensure-daily` | Transport | `driver` | جزء من daily transport workflow المشتق مباشرة من route assignments التي يديرها admin. | هذه endpoints مهيأة لتطبيق السائق، بينما لوحة الإدارة ما زالت تركز على surfaces الإدارة والـ fallback اليدوي. | بناء أدوات ops أو simulation أو troubleshooting لسير عمل السائق اليومي انطلاقًا من surfaces الإدارة. |
| `GET` | `/reporting/dashboards/parent/me` | Reporting | `parent` | سطح companion role مرتبط مباشرة بدومينات يديرها admin: الطلاب، التقارير، والنقل. | لا يوجد داخل لوحة الإدارة surface لمعاينة parent-facing contracts أو parity checks عبر role preview. | دعم QA وظيفي أو surfaces معاينة لما يراه ولي الأمر دون مغادرة دومين الإدارة. |
| `GET` | `/reporting/dashboards/parent/me/students/{studentId}/profile` | Reporting | `parent` | سطح companion role مرتبط مباشرة بدومينات يديرها admin: الطلاب، التقارير، والنقل. | لا يوجد داخل لوحة الإدارة surface لمعاينة parent-facing contracts أو parity checks عبر role preview. | دعم QA وظيفي أو surfaces معاينة لما يراه ولي الأمر دون مغادرة دومين الإدارة. |
| `GET` | `/reporting/dashboards/parent/me/students/{studentId}/reports/assessment-summary` | Reporting | `parent` | سطح companion role مرتبط مباشرة بدومينات يديرها admin: الطلاب، التقارير، والنقل. | لا يوجد داخل لوحة الإدارة surface لمعاينة parent-facing contracts أو parity checks عبر role preview. | دعم QA وظيفي أو surfaces معاينة لما يراه ولي الأمر دون مغادرة دومين الإدارة. |
| `GET` | `/reporting/dashboards/parent/me/students/{studentId}/reports/attendance-summary` | Reporting | `parent` | سطح companion role مرتبط مباشرة بدومينات يديرها admin: الطلاب، التقارير، والنقل. | لا يوجد داخل لوحة الإدارة surface لمعاينة parent-facing contracts أو parity checks عبر role preview. | دعم QA وظيفي أو surfaces معاينة لما يراه ولي الأمر دون مغادرة دومين الإدارة. |
| `GET` | `/reporting/dashboards/parent/me/students/{studentId}/reports/behavior-summary` | Reporting | `parent` | سطح companion role مرتبط مباشرة بدومينات يديرها admin: الطلاب، التقارير، والنقل. | لا يوجد داخل لوحة الإدارة surface لمعاينة parent-facing contracts أو parity checks عبر role preview. | دعم QA وظيفي أو surfaces معاينة لما يراه ولي الأمر دون مغادرة دومين الإدارة. |
| `GET` | `/reporting/dashboards/supervisor/me` | Reporting | `supervisor` | يكشف ما تدعمه طبقة reporting للأدوار التشغيلية المجاورة التي تُنشئ الإدارة بنيتها الأساسية. | التركيز الحالي في admin dashboard على سطح الإدارة فقط، من دون view parity لشاشات roles الأخرى. | إتاحة monitoring/parity planning أو لوحات معاينة للأدوار التنفيذية المشتقة من بنية الإدارة. |
| `GET` | `/reporting/dashboards/teacher/me` | Reporting | `teacher` | يكشف ما تدعمه طبقة reporting للأدوار التشغيلية المجاورة التي تُنشئ الإدارة بنيتها الأساسية. | التركيز الحالي في admin dashboard على سطح الإدارة فقط، من دون view parity لشاشات roles الأخرى. | إتاحة monitoring/parity planning أو لوحات معاينة للأدوار التنفيذية المشتقة من بنية الإدارة. |
| `GET` | `/reporting/transport/parent/me/students/{studentId}/live-status` | Reporting | `parent` | سطح companion role مرتبط مباشرة بدومينات يديرها admin: الطلاب، التقارير، والنقل. | لا يوجد داخل لوحة الإدارة surface لمعاينة parent-facing contracts أو parity checks عبر role preview. | دعم QA وظيفي أو surfaces معاينة لما يراه ولي الأمر دون مغادرة دومين الإدارة. |

## Out Of Scope Backend Endpoints

| Method | Path | Domain | Role Scope | Why Relevant | Why Currently Unused | Potential Admin Value |
| --- | --- | --- | --- | --- | --- | --- |
| `GET` | `/health` | Health | `public` | سطح تشغيلي بنيوي للبنية التحتية، وليس capability product داخل لوحة الإدارة. | خارج نطاق product UI الحالي؛ تستعمل عادة في health checks وdeployment probes. | قيمة منخفضة داخل لوحة الإدارة نفسها؛ أعلى قيمة لها تبقى في infra tooling. |
| `GET` | `/health/ready` | Health | `public` | سطح تشغيلي بنيوي للبنية التحتية، وليس capability product داخل لوحة الإدارة. | خارج نطاق product UI الحالي؛ تستعمل عادة في health checks وdeployment probes. | قيمة منخفضة داخل لوحة الإدارة نفسها؛ أعلى قيمة لها تبقى في infra tooling. |

## Partially Used Endpoint Inventory

### `GET /behavior/records`

- Domain: **Behavior**
- Current frontend callsites: `admin-dashboard/src/features/behavior/BehaviorRecordsPage.tsx:161`
- Unused query surface (static): `dateFrom`, `dateTo`, `supervisorId`
- Unused body surface (static): —
- Unused response/data surface (static): —
- Notes: سجلات السلوك تستعمل المسار فعليًا، لكن جزءًا من filters والاستجابة لا يزال غير ممثل بوضوح في الواجهة.

### `GET /assessments`

- Domain: **Assessments**
- Current frontend callsites: `admin-dashboard/src/features/assessments/AssessmentsListPage.tsx:111`
- Unused query surface (static): `dateFrom`, `dateTo`
- Unused body surface (static): —
- Unused response/data surface (static): —
- Notes: قائمة التقييمات الحالية تستخدم السطح الأساسي، لكن ليس كل فلاتر الباك أو فروع الاستجابة ظاهرة في UI.

### `GET /attendance/sessions`

- Domain: **Attendance**
- Current frontend callsites: `admin-dashboard/src/features/attendance/AttendanceSessionsPage.tsx:101`
- Unused query surface (static): `dateFrom`, `dateTo`
- Unused body surface (static): —
- Unused response/data surface (static): —
- Notes: الواجهة تغطي الإنشاء والقائمة، لكن جزءًا من أسطح الفلترة أو response data ما زال غير مستثمر.

### `GET /communication/messages/conversations/{otherUserId}`

- Domain: **Communication**
- Current frontend callsites: `admin-dashboard/src/features/communication/ConversationPage.tsx:36`
- Unused query surface (static): `page`
- Unused body surface (static): —
- Unused response/data surface (static): `pagination`
- Notes: الفروقات هنا ناتجة عن مقارنة static بين العقد الخلفي والملفات المستهلكة الحالية، وليست حكمًا على جودة التنفيذ الوظيفي الحالي.

### `GET /homework`

- Domain: **Homework**
- Current frontend callsites: `admin-dashboard/src/features/homework/HomeworkListPage.tsx:102`
- Unused query surface (static): `dateFrom`, `dateTo`
- Unused body surface (static): —
- Unused response/data surface (static): —
- Notes: قائمة الواجبات الحالية لا تستثمر كامل filters الزمنية والسكوب المتاحة في الباك.

### `GET /transport/trips`

- Domain: **Transport**
- Current frontend callsites: `admin-dashboard/src/features/transport/TripsListPage.tsx:54`
- Unused query surface (static): `dateFrom`, `dateTo`
- Unused body surface (static): —
- Unused response/data surface (static): —
- Notes: الفروقات هنا ناتجة عن مقارنة static بين العقد الخلفي والملفات المستهلكة الحالية، وليست حكمًا على جودة التنفيذ الوظيفي الحالي.

### `PATCH /assessments/scores/{studentAssessmentId}`

- Domain: **Assessments**
- Current frontend callsites: `admin-dashboard/src/features/assessments/AssessmentDetailPage.tsx:78`
- Unused query surface (static): —
- Unused body surface (static): `remarks`
- Unused response/data surface (static): —
- Notes: الفروقات هنا ناتجة عن مقارنة static بين العقد الخلفي والملفات المستهلكة الحالية، وليست حكمًا على جودة التنفيذ الوظيفي الحالي.

### `POST /students/{id}/promotions`

- Domain: **Students**
- Current frontend callsites: `admin-dashboard/src/features/students/StudentDetailPage.tsx:323`
- Unused query surface (static): —
- Unused body surface (static): `toClassId`
- Unused response/data surface (static): —
- Notes: الفروقات هنا ناتجة عن مقارنة static بين العقد الخلفي والملفات المستهلكة الحالية، وليست حكمًا على جودة التنفيذ الوظيفي الحالي.

### `POST /transport/assignments`

- Domain: **Transport**
- Current frontend callsites: `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:110`
- Unused query surface (static): —
- Unused body surface (static): `endDate`
- Unused response/data surface (static): —
- Notes: الفروقات هنا ناتجة عن مقارنة static بين العقد الخلفي والملفات المستهلكة الحالية، وليست حكمًا على جودة التنفيذ الوظيفي الحالي.

### `PATCH /transport/assignments/{id}/deactivate`

- Domain: **Transport**
- Current frontend callsites: `admin-dashboard/src/features/transport/TransportAssignmentsPage.tsx:134`
- Unused query surface (static): —
- Unused body surface (static): `endDate`
- Unused response/data surface (static): —
- Notes: الفروقات هنا ناتجة عن مقارنة static بين العقد الخلفي والملفات المستهلكة الحالية، وليست حكمًا على جودة التنفيذ الوظيفي الحالي.

### `GET /transport/trips/{id}/students`

- Domain: **Transport**
- Current frontend callsites: `admin-dashboard/src/features/transport/TripDetailPage.tsx:81`
- Unused query surface (static): `search`
- Unused body surface (static): —
- Unused response/data surface (static): —
- Notes: الفروقات هنا ناتجة عن مقارنة static بين العقد الخلفي والملفات المستهلكة الحالية، وليست حكمًا على جودة التنفيذ الوظيفي الحالي.

## Relationship / Schema-Level Gaps

- طبقة `academic-structure` تملك detail surfaces خلفية مستقلة (`academic year`, `class`, `subject`, `subject offering`) بينما لوحة الإدارة الحالية تعتمد أساسًا على list rows وmodals. هذا يترك gap على مستوى drill-down وhydration المنفصل.
- طبقة `communication` تملك directory endpoint تخصصي للمستلمين، لكن الواجهة الحالية لا تبني عليه compose flows بالكامل. هذه فجوة علاقة بين `users` و`communication` لا في capability المراسلة نفسها.
- طبقة `reporting` تكشف dashboards وstudent-scoped surfaces لأدوار مجاورة (`teacher`, `supervisor`, `parent`) بينما admin UI لا تستثمرها حتى كـ preview/parity surfaces.
- طبقة `transport + reporting` توفر parent live-status surface مشتقة من assignment/trip/location/event chain، لكنها غير ممثلة في أي admin monitoring surface حالي.
- طبقة `transport` تدعم driver daily workflow (`route assignments me` ثم `ensure-daily`) فوق البنية التي يديرها admin، لكن لوحة الإدارة لا تعرض هذا الاشتقاق إلا بشكل غير مباشر.

## Prioritized Opportunity List

| Priority | Opportunity | Why It Matters | Backing Endpoints |
| --- | --- | --- | --- |
| High | توحيد دليل المستلمين على `/communication/recipients` | يوحّد compose flows مع عقد backend التخصصي، ويقلل الاعتماد على `/users` كحل عام في المراسلة. | `GET /communication/recipients`<br>`GET /users`<br>`POST /communication/messages` |
| High | إضافة drill-down/detail surfaces لكيانات academic structure | الباك يوفّر detail payloads مستقلة لسنوات/classes/subjects/offerings، ما يفتح باب edit hydration أوضح وتدقيق إداري أدق. | `GET /academic-structure/academic-years/{id}`<br>`GET /academic-structure/classes/{id}`<br>`GET /academic-structure/subjects/{id}`<br>`GET /academic-structure/subject-offerings/{id}` |
| Medium | معاينة dashboards الأدوار المجاورة من منظور الإدارة | يفيد في parity QA والتخطيط للمنتج ومراجعة ما يراه teacher/supervisor/parent فوق نفس البيانات التي تنشئها الإدارة. | `GET /reporting/dashboards/teacher/me`<br>`GET /reporting/dashboards/supervisor/me`<br>`GET /reporting/dashboards/parent/me` |
| Low | أدوات monitoring أو simulation لسير عمل السائق اليومي | ليست surface إدارية أساسية، لكنها قد تفيد العمليات والدعم عند تتبع مشاكل النقل اليومية. | `GET /transport/route-assignments/me`<br>`POST /transport/trips/ensure-daily` |
| Medium | استثمار filters الحالية في القوائم الأكاديمية التشغيلية | التحليل الحالي يبيّن أن بعض query surfaces موجودة خلفيًا لكنها غير مستثمرة بالكامل في شاشات الحضور/الواجبات/التقييمات. | `GET /attendance/sessions`<br>`GET /assessments`<br>`GET /homework` |

## Verification Gaps

- مقارنة الحقول الأدنى من مستوى endpoint تعتمد على static token presence في ملفات المستهلكين الحالية؛ لذلك فهي تثبت "عدم وجود إشارة صريحة" ولا تدّعي تتبعًا runtime كاملًا.
- لا توجد schema قاعدة بيانات تشغيلية مباشرة داخل هذا المستودع يمكن اعتمادها مصدر حقيقة مستقل؛ طبقة العلاقات هنا مبنية فقط على `OpenAPI` و`Postman` و`API_REFERENCE` و`BACKEND_WAVE1_STATUS` و`OPENAPI_POSTMAN_AUDIT`.
- بعض العقود في `OpenAPI` ما تزال تعتمد على examples أو object schemas مفتوحة، لذلك التغطية الأدنى من endpoint قد تبقى جزئية في بعض المسارات دون تخمين.

## Sanity Checks

- Backend total from comparison inventory = **123**
- Classification total = **123**
- Current frontend-used inventory = **106**
- Relevant backend capabilities not used = **15**
- Total backend endpoints not used at all by admin UI = **17**