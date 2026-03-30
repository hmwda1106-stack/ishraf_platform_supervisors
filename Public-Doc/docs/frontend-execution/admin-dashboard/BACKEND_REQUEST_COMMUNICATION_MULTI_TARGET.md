# Backend Request: Communication Multi-Target Contracts

## Status

- **Requested:** 2026-03-30
- **Current frontend state:** `Communication Phase 1` implemented and live-verified
- **Current backend gap:** no multi-recipient / multi-role delivery contracts yet
- **Requested scope:** backend contracts only for `multi-target delivery`
- **Out of scope for this request:** group threads, impersonation, person-targeted announcements

## Executive Summary

تم إغلاق `Communication Phase 1` بالكامل داخل حدود العقود الحالية.

الحالة الحالية المثبتة:
- [COMMUNICATION_PHASE1_COMPLETION_REVIEW.md](./COMMUNICATION_PHASE1_COMPLETION_REVIEW.md): `implemented + live verified`
- [LIVE_ACCEPTANCE_AUDIT.md](./LIVE_ACCEPTANCE_AUDIT.md): `pass`
- [READ_ROUTE_STABILITY_AUDIT.md](./READ_ROUTE_STABILITY_AUDIT.md): `42 pass / 0 fail / 0 skipped`
- [OPERATIONAL_ACCEPTANCE_AUDIT.md](./OPERATIONAL_ACCEPTANCE_AUDIT.md): `12 pass / 0 fail / 0 skipped`

النتيجة:
- `Communication` يعمل الآن مؤسسيًا ضمن العقود الحالية
- composer أصبح موحدًا
- دليل المستلمين أصبح contract-driven
- الإطلاقات السياقية أصبحت تعمل من:
  - `user detail`
  - `student detail`
  - `monitoring`
  - `reporting`

المتبقي الوحيد في هذا الدومين هو تمكين **multi-target communication** من جهة الباك بشكل رسمي وواضح.

## Scope and Source of Truth

هذا الطلب مبني فقط على:
- [API_REFERENCE.md](../../API_REFERENCE.md)
- `Public-Doc/docs/openapi/ishraf-platform.openapi.json`
- `Public-Doc/docs/postman/ishraf-platform.postman_collection.json`
- [ENDPOINT_MAP.md](./ENDPOINT_MAP.md)
- [COMMUNICATION_PHASE1_COMPLETION_REVIEW.md](./COMMUNICATION_PHASE1_COMPLETION_REVIEW.md)
- [RESIDUAL_BACKEND_DEPENDENCIES_BACKLOG.md](./RESIDUAL_BACKEND_DEPENDENCIES_BACKLOG.md)
- التنفيذ الحالي داخل:
  - `admin-dashboard/src/features/communication`

مهم:
- هذا الطلب لا يفترض أي behavior غير موثق حاليًا
- ولا يطلب من الفرونت التحايل على غياب العقد عبر loops محلية في المتصفح
- المطلوب هنا هو **توسعة backend contract** فقط

## Confirmed Current Backend Behavior

العقود الحالية المؤكدة هي:

### Direct messages

- `POST /api/v1/communication/messages`
- target الحالي:
  - `receiverUserId` واحد فقط

### Manual notifications

- `POST /api/v1/communication/notifications`
- target الحالي:
  - `userId` واحد فقط

### Announcements

- `POST /api/v1/communication/announcements`
- audience الحالية:
  - `targetRole` واحد
  - أو `all users`

### Recipient directory

- `GET /api/v1/communication/recipients`
- query params الحالية:
  - `search`
  - `role`
  - `page`
  - `limit`

الفرونت الحالي يعتمد الآن على هذه العقود فقط، ولا يقوم بأي:
- multi-send loop محلي
- bulk fallback من المتصفح
- group-thread approximation

## Current Frontend Decision

هذه القرارات مقفلة من جهة الفرونت ولن تتغير إلا بعقد باك رسمي:

### Direct messages multi-target

إذا تم اعتمادها مستقبلًا، فهي تعني:
- **individual one-to-one copies**
- وليس:
  - `group thread`
  - ولا shared conversation room

### Announcements

الإعلانات تبقى:
- `roles / all only`
- ولا تتحول إلى:
  - `userIds[]`
  - أو person-targeted broadcast

### Notifications

يمكن أن تدعم مستقبلًا:
- `userIds[]`
- و/أو `targetRoles[]`

لكن فقط عبر contract backend صريح، وليس عبر تكرار local requests من الفرونت.

## Problem Statement

من منظور المستخدم الإداري، النظام أصبح جيدًا الآن في:
- إرسال رسالة لشخص واحد
- إرسال إشعار لشخص واحد
- نشر إعلان لدور واحد أو للجميع

لكن ما يزال هناك burden تشغيلي واضح عندما يحتاج الإداري إلى:
- اختيار أكثر من شخص
- أو أكثر من دور
- أو الجمع بين عدة أدوار في broadcast واحد

اليوم لا يوجد contract خلفي يسمح بذلك.

ولذلك:
- الـ UI المتعدد ما زال مقفولًا عمدًا
- ولا يوجد fallback محلي من الفرونت
- حتى لا نخلق behavior غير موثق أو نتائج إرسال غير منضبطة

## Requested Backend Change

## Preferred Option

اعتماد ثلاث توسعات واضحة:

### 1. Bulk Direct Messages

`POST /api/v1/communication/messages/bulk`

body proposal:

```json
{
  "receiverUserIds": ["12", "44"],
  "targetRoles": ["teacher", "supervisor"],
  "messageBody": "..."
}
```

required semantics:
- `receiverUserIds[]` و`targetRoles[]` كلاهما اختياريان، لكن يجب أن ينتجا audience فعليًا
- الباك يقوم بـ `dedupe by userId`
- الباك لا ينشئ `group conversation`
- الباك ينشئ **individual direct-message copies** فقط
- لا يتم توسيع route المحادثة الحالية إلى group semantics

### 2. Bulk Notifications

`POST /api/v1/communication/notifications/bulk`

body proposal:

```json
{
  "userIds": ["12", "44"],
  "targetRoles": ["parent"],
  "title": "...",
  "message": "...",
  "notificationType": "payment_due",
  "referenceType": "student",
  "referenceId": "7"
}
```

required semantics:
- يدعم `userIds[]` و/أو `targetRoles[]`
- `notificationType` يبقى free-form كما هو الآن
- الباك يقوم بـ `dedupe by userId`
- `referenceType/referenceId` تبقيان اختياريتين

### 3. Multi-Role Announcements

توسيع:

`POST /api/v1/communication/announcements`

ليدعم:

```json
{
  "title": "...",
  "content": "...",
  "targetRoles": ["teacher", "supervisor"],
  "expiresAt": "2026-04-01T12:00:00.000Z"
}
```

مع الحفاظ على التوافق الخلفي مع:

```json
{
  "targetRole": "teacher"
}
```

required semantics:
- `targetRole` الحالي يبقى صالحًا
- `targetRoles[]` تصبح الصيغة الجديدة متعددة الأدوار
- `all users` يبقى مدعومًا بصيغة صريحة وموثقة
- الإعلان لا يدعم `userIds[]`

## Required Response Behavior

### Preferred success envelope for bulk endpoints

يفضل أن تعيد endpoints الجديدة:

```json
{
  "success": true,
  "message": "Bulk delivery completed",
  "data": {
    "resolvedRecipients": 24,
    "duplicatesRemoved": 3,
    "successCount": 24,
    "failedCount": 0,
    "failedTargets": []
  }
}
```

### If partial success is supported

نحتاج shape موثقًا صراحة مثل:

```json
{
  "success": true,
  "message": "Bulk delivery completed with partial failures",
  "data": {
    "resolvedRecipients": 24,
    "duplicatesRemoved": 3,
    "successCount": 21,
    "failedCount": 3,
    "failedTargets": [
      {
        "userId": "44",
        "role": "teacher",
        "code": "RECIPIENT_NOT_FOUND",
        "message": "Recipient not found"
      }
    ]
  }
}
```

### If all-or-nothing is preferred

هذا مقبول أيضًا، لكن يجب توثيقه صراحة في:
- `API_REFERENCE`
- `OpenAPI`
- `Postman`

حتى يعرف الفرونت كيف يبني:
- review step
- result panel
- failure handling

## Required Validation Behavior

نحتاج behavior واضحًا وصريحًا في الحالات التالية:

### Audience validation

- رفض الطلب إذا كان audience الفعلي = صفر
- رفض `targetRoles[]` غير الصالحة
- رفض `userIds[]` غير الصالحة

### Delivery validation

- تنفيذ `dedupe by userId`
- منع self-targeting إذا كانت السياسة الخلفية تعتبره غير مسموح
- إذا أصبحت audience فارغة بعد الـ resolution أو الـ dedupe:
  - يرجع الباك validation error موثقًا بوضوح

### Expected errors

نحتاج توثيق أخطاء مثل:
- `RECIPIENT_NOT_FOUND`
- `INVALID_TARGET_ROLE`
- `AUDIENCE_EMPTY`
- `SELF_TARGETING_NOT_ALLOWED`

أو ما يعادلها إذا كان لديكم naming مختلف، بشرط أن تكون موثقة بوضوح.

## What Must Not Change

هذا الطلب لا يطلب:
- `group threads`
- `conversation route` متعددة المشاركين
- person-targeted announcements
- fallback frontend loops
- تغييرًا في مسارات `Phase 1` الحالية

المطلوب فقط:
- فتح contract backend رسمي للتواصل متعدد الجمهور

## Frontend Outcome If This Is Implemented

إذا تم اعتماد هذا الطلب، سيفتح الفرونت `Phase 2` بالشكل التالي:

### Direct messages

- اختيار عدة أشخاص
- و/أو عدة أدوار
- ثم review step
- ثم إرسال **individual copies**

### Notifications

- اختيار عدة أشخاص
- و/أو عدة أدوار
- ثم review step
- ثم إرسال notification delivery متعدد

### Announcements

- اختيار:
  - `all users`
  - أو عدة أدوار
- ثم publish announcement واحد

### Preflight UI behavior

الفرونت سيضيف:
- dedupe preview
- estimated audience count
- zero-audience blocking
- delivery result summary

لكن **لن يفتح هذا الـ UI** قبل اعتماد العقود رسميًا.

## Priority

- **Priority: Medium**

ليست blocker على التشغيل الحالي، لأن `Communication Phase 1` مغلق ويعمل حيًا.

لكنها:
- أعلى توسعة طبيعية تالية في هذا الدومين
- وتقلل burden إداريًا بشكل مباشر
- وتفتح use cases broadcast مؤسسية حقيقية

## Required Documentation Updates

قبل أن يفتح الفرونت `Phase 2`، يجب تحديث:
- [API_REFERENCE.md](../../API_REFERENCE.md)
- `Public-Doc/docs/openapi/ishraf-platform.openapi.json`
- `Public-Doc/docs/postman/ishraf-platform.postman_collection.json`
- [ENDPOINT_MAP.md](./ENDPOINT_MAP.md)

ويجب أن تثبت المراجع:
- paths النهائية المعتمدة
- request bodies
- success envelopes
- partial-success behavior أو all-or-nothing
- validation failures
- الفرق بين:
  - `targetRole`
  - `targetRoles[]`
  - `receiverUserIds[]`
  - `userIds[]`

## Frontend Unlock Condition

الفرونت لن يفتح `multi-target UI` قبل تحقق الشروط التالية:

1. اعتماد العقود رسميًا من الباك
2. تحديث `API_REFERENCE / OpenAPI / Postman`
3. عدم وجود drift بين المراجع
4. توثيق السلوك النهائي صراحة:
   - `individual copies`
   - لا `group thread`
   - لا person-targeted announcements

## Requested Final Decision From Backend

نحتاج ردًا نهائيًا موثقًا وصريحًا لأحد السيناريوهين:

1. **Adopted:**  
   - `POST /communication/messages/bulk`
   - `POST /communication/notifications/bulk`
   - وتوسيع `POST /communication/announcements` إلى `targetRoles[]`

2. **Alternative:**  
   - أي تصميم backend آخر يحقق نفس semantic contract بوضوح
   - بشرط أن يبقى:
     - direct multi-target = `individual copies`
     - announcements = `roles/all only`
     - no group-thread semantics

التوصية التنفيذية من جهة الفرونت:
- اعتماد الخيار الأول

لأنه:
- أوضح
- أسهل في التوثيق
- متسق مع الفصل الحالي بين:
  - direct messages
  - notifications
  - announcements

