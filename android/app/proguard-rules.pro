# Jaga agar org.slf4j.impl.StaticLoggerBinder tidak dihapus
-keep class org.slf4j.** { *; }
-keep class ch.qos.logback.** { *; }
-keep class org.slf4j.** { *; }
-dontwarn org.slf4j.**
