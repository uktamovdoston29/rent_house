plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.kevin.rent_house"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

   compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
    isCoreLibraryDesugaringEnabled = true
}


    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.kevin.rent_house"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
