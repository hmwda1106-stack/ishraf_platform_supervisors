# Backend Request: Teacher / Supervisor UserId Resolver

## Status

- **Requested:** 2026-03-28
- **Adopted by backend:** 2026-03-29
- **Final contract:** frontend sends `users.id` for `teacherId` and `supervisorId`
- **Legacy compatibility:** backend still accepts `teachers.id / supervisors.id`

## Executive Summary

هذا الطلب هو أعلى أولوية خلفية متبقية بعد اكتمال إعادة هيكلة لوحة الإدارة والمرور الحي على سلاسل القبول.

الحالة الحالية المثبتة:
- [LIVE_ACCEPTANCE_AUDIT.md](./LIVE_ACCEPTANCE_AUDIT.md): `pass`
- [READ_ROUTE_STABILITY_AUDIT.md](./READ_ROUTE_STABILITY_AUDIT.md): `41 pass / 0 fail / 0 skipped`
- [OPERATIONAL_ACCEPTANCE_AUDIT.md](./OPERATIONAL_ACCEPTANCE_AUDIT.md): `9 pass / 0 fail / 0 skipped`

النتيجة:
- لا يوجد الآن كسر تشغيلي على happy paths الإدارية.
- لكن ما زالت هناك dependency هيكلية في العقد الخلفي تخص:
  - `teacherId`
  - `supervisorId`

هذه dependency تمنع الفرونت من الاعتماد على `users.id` بشكل موحّد كما يحدث الآن بنجاح في:
- `parentId`
- `driverId`

الفرونت الحالي يغطي الفجوة عبر:
- searchable account pickers
- blocking قبل الإرسال
- منع الإدخال اليدوي الخام للـ profile ids

لكن هذا **ليس resolver رسميًا** من الباك، بل mitigation آمن فقط.

## Scope and Source of Truth

هذا الطلب مبني فقط على:
- [API_REFERENCE.md](../../API_REFERENCE.md)
- `OpenAPI`: `Public-Doc/docs/openapi/ishraf-platform.openapi.json`
- `Postman`: `Public-Doc/docs/postman/ishraf-platform.postman_collection.json`
- [ENDPOINT_MAP.md](./ENDPOINT_MAP.md)
- [RESIDUAL_BACKEND_DEPENDENCIES_BACKLOG.md](./RESIDUAL_BACKEND_DEPENDENCIES_BACKLOG.md)
- نتائج القبول الحي المذكورة أعلاه

مهم:
- هذا الطلب لا يفترض behavior غير موثق.
- ولا يطلب تغييرًا وظيفيًا في منطق الأعمال نفسه.
- المطلوب هو **توحيد identifier contract** أو كشف resolver رسمي له.

## Confirmed Current Backend Behavior

المراجع الحالية تثبت صراحة:

### Teacher assignments

- `POST /api/v1/academic-structure/teacher-assignments`
- قيمة `teacherId` الحالية هي:
  - `teachers.id`
  - وليست `users.id`

المرجع:
- [API_REFERENCE.md](../../API_REFERENCE.md) عند:
  - `POST /academic-structure/teacher-assignments`
  - الملاحظة: `teacherId` هنا هو معرّف جدول `teachers.id` وليس `users.id`

### Supervisor assignments

- `POST /api/v1/academic-structure/supervisor-assignments`
- قيمة `supervisorId` الحالية هي:
  - `supervisors.id`
  - وليست `users.id`

المرجع:
- [API_REFERENCE.md](../../API_REFERENCE.md) عند:
  - `POST /academic-structure/supervisor-assignments`
  - الملاحظة: `supervisorId` هنا هو معرّف جدول `supervisors.id` وليس `users.id`

### Shared operational impact

المراجع نفسها تثبت أن `teacherId` و`supervisorId` لا يقتصران على assignment endpoints فقط، بل يظهران أيضًا في:
- create flows
- list filters
- behavior actor selection

من الأمثلة المؤكدة:
- `POST /attendance/sessions`
- `POST /assessments`
- `POST /behavior/records`
- `POST /homework`
- `GET /attendance/sessions` with `teacherId`
- `GET /assessments` with `teacherId`
- `GET /behavior/records` with `teacherId` or `supervisorId`
- `GET /homework` with `teacherId`

## Problem Statement

منظور النظام الحالي غير مثالي مؤسسيًا:

- المستخدم الإداري يختار الأشخاص من `/users`
- لكن بعض endpoints ما زالت تتطلب `profile ids` من جداول داخلية:
  - `teachers.id`
  - `supervisors.id`
- بينما `/users` لا يكشف هذه القيم رسميًا
- ولا يوجد resolver رسمي عام من `users.id -> profile id`

هذا يجعل الفرونت مضطرًا إلى واحد من خيارين غير مثاليين:

1. الاعتماد على mapping مشتقة من علاقات موجودة أصلًا في البيانات الحالية
2. أو منع الإرسال إذا لم تكن هذه mapping متاحة بشكل موثق وآمن

نحن اعتمدنا الخيار الثاني وقائيًا حتى لا نرمي burden على المستخدم ولا نرسل id خاطئًا إلى الباك.

لكن هذا يترك gap هيكلية:
- إذا أُضيف `teacher` أو `supervisor` جديد
- وكان الحساب موجودًا في `/users`
- لكن لم يوجد assignment سابق يكشف `profile id`
- فلن يكون لدى الفرونت resolver رسمي لإتمام أول assignment أو تفعيل كل filters المرتبطة به

## Why Frontend Cannot Solve This Fully Today

الفرونت لا يستطيع حل هذه النقطة بالكامل من العقود الحالية، للأسباب التالية:

- surface الاختيار الطبيعية في الإدارة هي `/users`
- العقد الحالي في assignment وبعض operational endpoints ما زال يطلب profile ids
- `Users API` لا تعيد `teacherProfileId` أو `supervisorProfileId`
- لا يوجد endpoint resolver رسمي مكشوف في التوثيق الحالي

بالتالي:
- الاشتقاق الحالي من assignment graph هو **best-effort mitigation**
- وليس قدرة عامة مضمونة لكل حساب جديد

## Live Evidence

في البيئة الحالية، لم تظهر failure مباشرة لأن بيانات الـ seed الحالية كانت كافية لحل mapping من assignment graph:

- active teacher users = `3`
- resolved from assignments = `3`
- unresolved = `0`

- active supervisor users = `3`
- resolved from assignments = `3`
- unresolved = `0`

لذلك:
- المشكلة **ليست failure حالية على seed**
- لكنها **contract gap مستقبلية وهيكلية**

## Affected Endpoints

## 1. Direct assignment endpoints

- `POST /api/v1/academic-structure/teacher-assignments`
- `POST /api/v1/academic-structure/supervisor-assignments`

## 2. Operational create endpoints

- `POST /api/v1/attendance/sessions`
- `POST /api/v1/assessments`
- `POST /api/v1/behavior/records`
- `POST /api/v1/homework`

## 3. Operational list filters

- `GET /api/v1/attendance/sessions`
  - `teacherId`
- `GET /api/v1/assessments`
  - `teacherId`
- `GET /api/v1/behavior/records`
  - `teacherId`
  - `supervisorId`
- `GET /api/v1/homework`
  - `teacherId`

## Requested Backend Change

## Preferred option

اعتماد نفس النمط الذي أصبح معتمدًا في:
- `parentId`
- `driverId`

أي:
- قبول `users.id` مباشرة في:
  - `teacherId`
  - `supervisorId`

داخل endpoints الإدارية ذات الصلة.

بمعنى:
- إذا أرسل الفرونت `teacherId = selectedUser.id` لحساب role=`teacher`
  - يحل الباك القيمة داخليًا إلى `teachers.id`
- وإذا أرسل الفرونت `supervisorId = selectedUser.id` لحساب role=`supervisor`
  - يحل الباك القيمة داخليًا إلى `supervisors.id`

## Backward compatibility requirement

لعدم كسر أي عميل قائم:
- يفضل أن تبقى endpoints تقبل أيضًا `teachers.id / supervisors.id` الحالية للتوافق الخلفي
- لكن المسار الموصى به للفرونت من الآن فصاعدًا يكون:
  - `users.id` فقط

النمط المطلوب هنا هو نفس الصياغة التشغيلية الحالية التي اعتمدت سابقًا في:
- `parentId`
- `driverId`

## Acceptable alternative

إذا لم يكن قبول `users.id` مباشرة مناسبًا داخل نفس endpoints، فالبديل المقبول هو توفير resolver رسمي مثل:

- توسيع `GET /users`
- وتوسيع `GET /users/:id`

بحيث تعيد role-specific profile ids مثل:
- `teacherProfileId`
- `supervisorProfileId`

أو توفير endpoint resolver صريح مثل:
- `GET /users/:id/teacher-profile`
- `GET /users/:id/supervisor-profile`

لكن هذا البديل أقل تفضيلًا من توحيد العقد نفسه على `users.id`.

## Expected Validation Behavior

في حال اعتماد `users.id`:
- إذا كان id لا يعود إلى حساب `teacher` فعلي:
  - يرجع الباك `404 Teacher not found`
  - أو خطأ validation equivalent موثق بوضوح
- إذا كان id لا يعود إلى حساب `supervisor` فعلي:
  - يرجع الباك `404 Supervisor not found`
  - أو خطأ validation equivalent موثق بوضوح

مع الحفاظ على باقي قواعد الأعمال الحالية كما هي:
- توافق الصف مع السنة
- توافق المادة مع المستوى
- وجود subject offering عند الحاجة
- وجود teacher assignment عند العمليات التشغيلية التابعة

## What Must Not Change

هذا الطلب لا يطلب:
- تغيير business rules
- تغيير role scope
- تغيير dependency chain التشغيلية
- تغيير response shape الأساسية ما لم يكن ذلك ضروريًا لتوثيق resolver

المطلوب فقط:
- إزالة burden المعرفات الداخلية من الطبقة الإدارية
- وتوحيد contract الإداري مع surface `/users`

## Frontend Outcome If This Is Implemented

إذا نُفذ هذا الطلب، يستطيع الفرونت أن يزيل آخر dependency هيكلية من هذا النوع عبر:

- اعتماد account pickers موحدة بالكامل للمعلمين والمشرفين
- إزالة blocking الوقائي الذي سببه غياب resolver الرسمي
- تفعيل teacher/supervisor filtering على نطاق أوسع بطريقة مضمونة
- منع أي burden معرفات داخلية على المستخدم الإداري

## Priority

- **Priority: High**

ليس لأن هناك كسرًا حيًا الآن، بل لأنه:
- آخر gap هيكلية بارزة في identity-to-domain resolution داخل لوحة الإدارة
- ويؤثر على التوسع المستقبلي ويمنع التوحيد الكامل مع نمط:
  - `parentId`
  - `driverId`

## Requested Documentation Updates

عند اعتماد التعديل، نحتاج تحديثًا متسقًا في:
- [API_REFERENCE.md](../../API_REFERENCE.md)
- `Public-Doc/docs/openapi/ishraf-platform.openapi.json`
- `Public-Doc/docs/postman/ishraf-platform.postman_collection.json`
- [ENDPOINT_MAP.md](./ENDPOINT_MAP.md)

بحيث يثبت صراحة:
- هل `teacherId` و`supervisorId` يقبلان `users.id`
- وهل يبقى قبول `profile ids` القديمة للتوافق الخلفي
- وما هو المسار الموصى به للفرونت

## Requested Final Decision From Backend

نحتاج قرارًا نهائيًا موثقًا بصيغة صريحة لأحد الخيارين:

1. **Adopted:** `teacherId/supervisorId` يقبلان `users.id` مباشرة مع internal resolution
2. **Alternative:** توفير resolver رسمي مكشوف للعلاقة قبل استخدام endpoints الحالية

التوصية التنفيذية من جهة الفرونت:
- اعتماد الخيار الأول

لأنه:
- أبسط
- أكثر اتساقًا
- متسق مع النمط الذي ثبت نجاحه في `parentId` و`driverId`
- ويزيل آخر burden identity mapping من التدفقات الإدارية الحرجة
