call dart2js.bat ../web/stagexl_demos.dart --trust-type-annotations --output-type=dart --minify --out=stagexl_demos.dart
call dart2js.bat ../web/stagexl_demos.dart --trust-type-annotations --output-type=js --minify --out=stagexl_demos.dart.js

call dart2js.bat ../web/stagexl_runtimes.dart --trust-type-annotations --output-type=dart --minify --out=stagexl_runtimes.dart
call dart2js.bat ../web/stagexl_runtimes.dart --trust-type-annotations --output-type=js --minify --out=stagexl_runtimes.dart.js

call dart2js.bat ../web/stagexl_docs.dart --trust-type-annotations --output-type=dart --minify --out=stagexl_docs.dart
call dart2js.bat ../web/stagexl_docs.dart --trust-type-annotations --output-type=js --minify --out=stagexl_docs.dart.js

del *.dart.deps /s
del *.dart.js.deps /s
del *.dart.js.map /s
del *.precompiled.js /s



