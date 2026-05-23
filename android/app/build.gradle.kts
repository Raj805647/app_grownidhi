plugins {
    id("com.android.application")

    // Firebase
    id("com.google.gms.google-services")

    id("kotlin-android")

    // Flutter Plugin
    id("dev.flutter.flutter-gradle-plugin")
}

android {

    namespace = "com.technowxa.app_grownidhi"

    compileSdk = 36

    defaultConfig {
        applicationId = "com.technowxa.app_grownidhi"

        minSdk = flutter.minSdkVersion
        targetSdk = 36

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}
flutter {
    source = "../.."
}

dependencies {

    // REQUIRED FOR flutter_local_notifications
    coreLibraryDesugaring(
        "com.android.tools:desugar_jdk_libs:2.1.2"
    )
}
