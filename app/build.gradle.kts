plugins {
    id("com.android.application")
}

android {
    namespace = "com.sicos.watchface"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.sicos.watchface"
        minSdk = 33      // Wear OS 4 is API 33, Wear OS 5 is API 34
        targetSdk = 34   // Target Wear OS 5 / Pixel Watch 3
        versionCode = 1
        versionName = "1.0.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            applicationIdSuffix = ".debug"
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

dependencies {
    // Pure WFF watch faces do not require custom runtime code dependencies.
}
