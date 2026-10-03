--- project.janet.orig	2026-10-01 20:55:18 UTC
+++ project.janet
@@ -14,19 +14,13 @@
 # Scripts
 
 (declare-binscript
-  :main "bin/janet-format"
-  :hardcode-syspath true
-  :is-janet true)
+  :main "bin/janet-format")
 
 (declare-binscript
-  :main "bin/janet-netrepl"
-  :hardcode-syspath :dynamic
-  :is-janet true)
+  :main "bin/janet-netrepl")
 
 (declare-binscript
-  :main "bin/janet-pm"
-  :hardcode-syspath :dynamic # allow for JANET_PATH=new_module_tree
-  :is-janet true)
+  :main "bin/janet-pm")
 
 # Manual pages
 
