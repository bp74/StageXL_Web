call dart2js.bat ../web/stagexl_demos.dart --output-type=dart --minify --out=stagexl_demos.dart
call dart2js.bat ../web/stagexl_demos.dart --output-type=js --minify --out=stagexl_demos.dart.js

call dart2js.bat ../web/stagexl_runtimes.dart --output-type=dart --minify --out=stagexl_runtimes.dart
call dart2js.bat ../web/stagexl_runtimes.dart --output-type=js --minify --out=stagexl_runtimes.dart.js

call dart2js.bat ../web/stagexl_docs.dart --output-type=dart --minify --out=stagexl_docs.dart
call dart2js.bat ../web/stagexl_docs.dart --output-type=js --minify --out=stagexl_docs.dart.js

del *.dart.deps /s
del *.dart.js.deps /s
del *.dart.js.map /s