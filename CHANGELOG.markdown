2.10.2
---
* Fix UTC timestamps - [#32] [ags]

2.10.1
---
* Fix Memoization - [#31] [bobbytables]

2.10.0
---
* Add Assignment type - [#30] [bobbytables]

2.9.0
---
* Added 'approve_rejected' [chrisconley]
* Add additional attributes to HIT's [seeingidog]
* Fixed constant value bug [karimn]
* Fix unescaped HTML in raw XML [seeingidog]

2.8.0
----
* Adding support for operation SearchQualificationTypes [hampei]
* Bumped to API version 2012-03-25
2.7.0
----
* Adding support for operation SearchQualificationTypes [denniskuczynski]
* Added ServiceUnavailable error type for detecting/handling HTTP
  Service Unavailable errors [denniskuczynski]
2.6.0
-----
* Adding IntegerValue attribute to AssignQualification from Ross
  Hale [rosshale]

2.5.2
-----
* Update to 2.5.2 with correct publish date. Sorry about the mixup here.

2.5.0
-----
* Updated endpoints to HTTPS. This change could break some installations behind firewalls, so
bumping with a minor release.

2.3.5
-----
* Added GetQualificationRequests API call [hamin]
* Added RequestQualificationRequests API call [hamin]
* rake spec now works correctly [hamin]

2.3.4
-----
* Added bonus_payments to Assignment and HIT for auditing [dbalatero]
