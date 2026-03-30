# توثيق Endpoints لوحة التحكم

هذا المجلد يوثق جميع الـ endpoints المستخدمة فعليًا داخل `admin-dashboard/src` فقط، دون إدخال أي endpoints غير مستخدمة في لوحة الإدارة.

## منهجية البناء

تم بناء هذا التوثيق بالترتيب التالي فقط، دون استخدام أي مصدر خارج هذه القائمة:
1. استخدامات الفرونت الفعلية داخل `admin-dashboard/src`.
2. `Public-Doc/docs/frontend-execution/admin-dashboard/ENDPOINT_MAP.md`.
3. `Public-Doc/docs/openapi/ishraf-platform.openapi.json`.
4. `Public-Doc/docs/postman/ishraf-platform.postman_collection.json`.

إذا كانت schema أو response example غير كافية لتحديد required/optional أو data shape بشكل دقيق، لم يتم تخمينها؛ بل تم توضيح ذلك داخل ملف `VERIFICATION_GAPS.md` وداخل قسم `Required vs Optional Fields` للـ endpoint نفسها.

## معنى used in admin dashboard

- يشمل أي endpoint تُستدعى مباشرة من صفحة أو component داخل `admin-dashboard/src`.
- ويشمل أيضًا الاستدعاءات التي تمر عبر shared hooks أو helpers مثل `useListQuery`, `student-workflows`, وطبقة `api/client`.
- لا يشمل endpoints الموجودة في الباك أو Postman ولكن غير مستخدمة فعليًا في لوحة الإدارة.

## معنى required / optional

- `required` يعني أن OpenAPI صرّحت به صراحة عبر `required: true` أو ضمن `required[]` في schema.
- إذا كانت OpenAPI تستخدم schema مفتوحة (`GenericObject` أو `additionalProperties: true`) وتم الاعتماد على example فقط، فسيتم التنبيه أن required/optional غير محسوم بالكامل.

## الملفات

| الملف | المحتوى |
| --- | --- |
| [DISCOVERY_MATRIX.md](./DISCOVERY_MATRIX.md) | سجل التغطية الكامل: endpoint, method, consumers, hook/helper, والمراجع المطابقة |
| [VERIFICATION_GAPS.md](./VERIFICATION_GAPS.md) | أي gaps أو مناطق لا يمكن توثيقها بالكامل دون تخمين |
| [AUTH.md](./AUTH.md) | endpoints دومين Auth المستخدمة فعليًا |
| [USERS.md](./USERS.md) | endpoints دومين Users المستخدمة فعليًا |
| [ACADEMIC_STRUCTURE.md](./ACADEMIC_STRUCTURE.md) | endpoints دومين Academic Structure المستخدمة فعليًا |
| [STUDENTS.md](./STUDENTS.md) | endpoints دومين Students المستخدمة فعليًا |
| [ATTENDANCE.md](./ATTENDANCE.md) | endpoints دومين Attendance المستخدمة فعليًا |
| [ASSESSMENTS.md](./ASSESSMENTS.md) | endpoints دومين Assessments المستخدمة فعليًا |
| [BEHAVIOR.md](./BEHAVIOR.md) | endpoints دومين Behavior المستخدمة فعليًا |
| [HOMEWORK.md](./HOMEWORK.md) | endpoints دومين Homework المستخدمة فعليًا |
| [TRANSPORT.md](./TRANSPORT.md) | endpoints دومين Transport المستخدمة فعليًا |
| [COMMUNICATION.md](./COMMUNICATION.md) | endpoints دومين Communication المستخدمة فعليًا |
| [REPORTING.md](./REPORTING.md) | endpoints دومين Reporting المستخدمة فعليًا |

## عدد الـ endpoints المستخدمة

- الإجمالي: **106** endpoint مستخدمة فعليًا داخل لوحة الإدارة.
- Auth: **7**
- Users: **5**
- Academic Structure: **20**
- Students: **8**
- Attendance: **5**
- Assessments: **8**
- Behavior: **7**
- Homework: **5**
- Transport: **24**
- Communication: **11**
- Reporting: **6**

## ملاحظات مهمة

- `DISCOVERY_MATRIX.md` هو مرجع الاكتمال؛ إذا لم يظهر endpoint هناك فهي خارج نطاق الاستخدام الفعلي الحالي.
- truth contract يؤخذ من `OpenAPI` و`Postman`، بينما `ENDPOINT_MAP` يربط العقد بالسياق التنفيذي داخل لوحة الإدارة.
- عند وجود mismatch بين المصدرين، تم تثبيته صراحة بدل ترجيح صامت.
