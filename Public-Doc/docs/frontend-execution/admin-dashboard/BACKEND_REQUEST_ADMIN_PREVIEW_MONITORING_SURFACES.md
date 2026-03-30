# Backend Request: Admin Preview / Monitoring Surfaces

## Status

- **Requested:** 2026-03-29
- **Resolved by backend:** 2026-03-29
- **Current frontend state:** fully integrated on `/monitoring` using the approved `admin-preview` endpoints
- **Remaining backend gap:** none for the adopted scope
- **Requested scope:** read-only admin support surfaces only, no impersonation and no mutate flows

## Resolution Note

هذه الوثيقة أصبحت **أرشيفًا للطلب الذي تم حله**.

المرجع الحالي الصحيح للحالة النهائية هو:
- [ADMIN_PREVIEW_MONITORING_COMPLETION_REVIEW.md](./ADMIN_PREVIEW_MONITORING_COMPLETION_REVIEW.md)

مهم:
- لا يوجد الآن gap خلفي متبقٍ ضمن النطاق الذي اعتمده الباك لهذا المسار
- route `/monitoring` أصبح يعتمد فعليًا على `admin-preview endpoints`
- التحقق الحي لهذا المسار مرّ بنجاح

## Executive Summary

تم اعتماد الطلب وتنفيذه.

النتيجة الحالية:
- `/monitoring` يعمل الآن من العقود الإدارية الرسمية
- `parent-first preview` أصبح متاحًا
- `teacher preview` و`supervisor preview` أصبحا canonical backend-driven
- لا يوجد gap خلفي متبقٍ داخل هذا النطاق

المحتوى التالي في هذه الوثيقة محفوظ كأثر تاريخي للطلب الأصلي وسبب تقديمه.

## Scope and Source of Truth

هذا الطلب مبني فقط على:

- [API_REFERENCE.md](../../API_REFERENCE.md)
- `Public-Doc/docs/openapi/ishraf-platform.openapi.json`
- `Public-Doc/docs/postman/ishraf-platform.postman_collection.json`
- [ENDPOINT_MAP.md](./ENDPOINT_MAP.md)
- [RESIDUAL_BACKEND_DEPENDENCIES_BACKLOG.md](./RESIDUAL_BACKEND_DEPENDENCIES_BACKLOG.md)
- التنفيذ الحالي داخل:
  - `admin-dashboard/src/features/monitoring`

مهم:

- لا يوجد هنا افتراض لسلوك غير موثق.
- ولا نطلب bypass للصلاحيات الحالية.
- المطلوب هو **admin-safe support surfaces** فقط.

## Confirmed Current Backend Behavior

الأسطح الحالية المؤكدة في العقود الحالية تنقسم إلى نوعين:

### 1. Admin-safe surfaces currently available

وهذه استخدمها الفرونت بالفعل لبناء نسخة أولية من المعاينة:

- `GET /users?role=parent`
- `GET /users?role=teacher`
- `GET /users?role=supervisor`
- `GET /students/{id}/parents`
- `GET /reporting/students/{studentId}/profile`
- `GET /reporting/students/{studentId}/reports/attendance-summary`
- `GET /reporting/students/{studentId}/reports/assessment-summary`
- `GET /reporting/students/{studentId}/reports/behavior-summary`
- `GET /behavior/students/{studentId}/records`
- `GET /homework/students/{studentId}`
- `GET /transport/assignments/active`
- `GET /reporting/transport/summary`
- `GET /transport/trips/{tripId}`
- `GET /transport/trips/{tripId}/students`
- `GET /transport/trips/{tripId}/events`
- `GET /transport/students/{studentId}/home-location`
- `GET /academic-structure/teacher-assignments`
- `GET /academic-structure/supervisor-assignments`
- `GET /attendance/sessions?teacherId=...`
- `GET /assessments?teacherId=...`
- `GET /behavior/records?teacherId=...`
- `GET /behavior/records?supervisorId=...`
- `GET /homework?teacherId=...`

### 2. Role-owned surfaces currently available

وهذه موجودة لكنها لا تصلح كعقد admin runtime مباشر لأنها `me-scoped`:

- `GET /reporting/dashboards/parent/me`
- `GET /reporting/dashboards/teacher/me`
- `GET /reporting/dashboards/supervisor/me`
- `GET /reporting/dashboards/parent/me/students/{studentId}/profile`
- `GET /reporting/dashboards/parent/me/students/{studentId}/reports/attendance-summary`
- `GET /reporting/dashboards/parent/me/students/{studentId}/reports/assessment-summary`
- `GET /reporting/dashboards/parent/me/students/{studentId}/reports/behavior-summary`
- `GET /reporting/transport/parent/me/students/{studentId}/live-status`

## What Frontend Can Do Today

الفرونت الحالي يستطيع الآن:

- فتح معاينة المعلّم من `users.id`
- فتح معاينة المشرف من `users.id`
- فتح معاينة ولي الأمر **انطلاقًا من الطالب**
- عرض حالة النقل الحية للطالب من surfaces إدارية آمنة
- توفير deep links لإصلاح:
  - parent linking
  - teacher assignments
  - supervisor assignments
  - student reports
  - transport assignments
  - route / trip details

بمعنى آخر:

- `teacher preview`: implemented
- `supervisor preview`: implemented
- `student-scoped parent preview`: implemented
- `parent-first preview`: **not possible yet from backend contracts**

## Problem Statement

الفجوة الحالية ليست في وجود بيانات، بل في **شكل العقد الخلفي**.

### Problem A: No parent-first child resolver

اليوم لا يمكن للإداري أن يبدأ من:

1. اختيار `ولي أمر`
2. ثم يرى قائمة أبنائه من الباك
3. ثم يفتح معاينة أي طالب منهم

لأننا لا نملك surface إدارية آمنة من نوع:

- `parent user id -> linked students`

والبديل الحالي غير مقبول مؤسسيًا إن حاولنا اختراعه من الفرونت:

- البحث العكسي محليًا في كل الطلاب
- أو التخمين من علاقات غير مضمونة

لذلك الفرونت الحالي يعتمد على:

- `student-first parent preview`

وهذا صحيح، لكنه أقل من الهدف النهائي.

### Problem B: No admin-safe parity surface for role dashboards

حتى مع وجود teacher/supervisor previews الحالية، ما زالت هناك فجوة بين:

- ما يبنيه الفرونت من admin-safe aggregates
- وما قد يراه الدور الفعلي داخل dashboard المملوك له

إذا كان الهدف الإداري هو:

- “أرني ما الذي يجب أن يراه المعلم أو المشرف أو ولي الأمر فعلًا”

فالعقد الحالي لا يوفر parity surface مخصصة للإدارة.

## Requested Backend Change

## Preferred option

إضافة أسطح `admin-only` صريحة للمعاينة والدعم:

### Parent preview

- `GET /api/v1/reporting/admin-preview/parents/{parentUserId}/dashboard`
- `GET /api/v1/reporting/admin-preview/parents/{parentUserId}/students/{studentId}/profile`
- `GET /api/v1/reporting/admin-preview/parents/{parentUserId}/students/{studentId}/reports/attendance-summary`
- `GET /api/v1/reporting/admin-preview/parents/{parentUserId}/students/{studentId}/reports/assessment-summary`
- `GET /api/v1/reporting/admin-preview/parents/{parentUserId}/students/{studentId}/reports/behavior-summary`
- `GET /api/v1/reporting/admin-preview/parents/{parentUserId}/students/{studentId}/transport/live-status`

### Teacher preview

- `GET /api/v1/reporting/admin-preview/teachers/{teacherUserId}/dashboard`

### Supervisor preview

- `GET /api/v1/reporting/admin-preview/supervisors/{supervisorUserId}/dashboard`

## Required Contract Rules

### Scope

- هذه الأسطح تكون:
  - `admin-only`
  - `read-only`
  - لا تنشئ جلسة بديلة
  - لا تنفذ impersonation

### Shape

- يفضل أن تعيد نفس shape المستعملة في role-owned surfaces الحالية قدر الإمكان.
- إذا وُجد اختلاف مقصود، يجب توثيقه صراحة.

### Error behavior

- `404 Parent not found`
  - إذا كان `parentUserId` غير موجود أو ليس role=`parent`
- `404 Teacher not found`
  - إذا كان `teacherUserId` غير موجود أو ليس role=`teacher`
- `404 Supervisor not found`
  - إذا كان `supervisorUserId` غير موجود أو ليس role=`supervisor`
- `404 Student not linked to parent`
  - إذا كان `studentId` لا يعود إلى ولي الأمر المحدد
- `403 Permission denied`
  - إذا لم يكن الاستدعاء من admin
- `200` مع empty payload صالح
  - إذا لم توجد بيانات تشغيلية بعد

### Parent dashboard minimum data

استجابة:

- `GET /reporting/admin-preview/parents/{parentUserId}/dashboard`

يجب أن تعيد على الأقل ما يكفي للفرونت كي يبني:

- بيانات ولي الأمر الأساسية
- قائمة الأبناء المرتبطين
- child selector
- empty states الصحيحة

أي أن الحد الأدنى المطلوب داخل `data` هو:

- parent summary block
- `students[]` linked to that parent

## Acceptable Alternative

إذا كان الباك لا يريد paths جديدة، فالبديل المقبول هو:

- توسيع الأسطح الحالية بنمط admin-safe صريح

مثلًا:

- نفس endpoint لكن مع path/query واضحة للدعم الإداري
- أو support endpoints تحت `/reporting/support/*`

لكن ما نحتاجه وظيفيًا يجب أن يحقق الشرطين التاليين:

1. لا يعتمد على `me`
2. صالح إداريًا وآمن صلاحيًا

## Why Frontend Should Not Solve This Locally

لا يجوز للفرونت أن يحاول حل هذا الجزء عبر:

- البحث العكسي المحلي على كل الطلاب لاكتشاف أبناء ولي الأمر
- استعمال role-owned endpoints `me` من admin runtime
- تبديل الجلسة أو impersonation
- تركيب dashboard تقريبي من بيانات مشتتة ثم تسميته “what the user sees”

لأن هذا يؤدي إلى واحد من الأخطاء التالية:

- burden غير صحيح على الواجهة
- drift بين preview والدور الحقيقي
- اختلاط في الصلاحيات
- دعم فني مبني على صورة غير موثوقة

## Expected Frontend Outcome If Implemented

إذا تم اعتماد هذا الطلب، يستطيع الفرونت أن ينجز النسخة النهائية من `Admin Preview / Monitoring` بالشكل التالي:

### Parent-first preview

1. الإداري يختار ولي الأمر
2. النظام يعرض أبناءه مباشرة
3. الإداري يختار الطالب
4. تظهر profile/reports/transport preview من نفس العقد

### Teacher parity preview

1. الإداري يختار المعلّم
2. تظهر dashboard preview مطابقة لما يجب أن يظهر للمعلّم
3. مع deep links مباشرة لشاشات الإصلاح

### Supervisor parity preview

1. الإداري يختار المشرف
2. تظهر dashboard preview مطابقة لما يجب أن يظهر للمشرف
3. مع deep links مباشرة لشاشات الإصلاح

## Priority

- **Priority: Medium**

ليست blocker على happy paths الإدارية الحالية، لأن route `/monitoring` يعمل جزئيًا بشكل صحيح الآن.

لكنها:

- أعلى gap متبقية داخل هذا الـ backlog
- وتمنع اكتمال `parent-first preview`
- وتمنع parity كاملة بين preview الإداري وdashboards الفعلية للأدوار

## Requested Documentation Updates

عند اعتماد هذا التعديل، نحتاج تحديثًا متسقًا في:

- [API_REFERENCE.md](../../API_REFERENCE.md)
- `Public-Doc/docs/openapi/ishraf-platform.openapi.json`
- `Public-Doc/docs/postman/ishraf-platform.postman_collection.json`
- [ENDPOINT_MAP.md](./ENDPOINT_MAP.md)

بحيث يثبت صراحة:

- paths النهائية المعتمدة
- role scope
- response examples
- الفرق بين:
  - `empty`
  - `not found`
  - `permission denied`
- وما إذا كانت response shapes تطابق role-owned surfaces أو تختلف عنها

## Requested Final Decision From Backend

نحتاج قرارًا موثقًا وصريحًا لأحد الخيارين:

1. **Adopted:** إضافة admin-safe preview endpoints صريحة كما وردت أعلاه
2. **Alternative:** توفير support/admin-safe parity surfaces تحقق نفس الهدف دون الاعتماد على `me`

التوصية التنفيذية من جهة الفرونت:

- اعتماد الخيار الأول

لأنه:

- أوضح
- أأمن
- أسهل في التوثيق
- ويعطي preview إداريًا مفهومًا ومستقرًا دون أي التباس مع role-owned dashboards
