plugins {
    val kotlinVersion = System.getenv("KOTLIN_VERSION") ?: "1.9.21"
    kotlin("multiplatform") version kotlinVersion
}

repositories {
    mavenCentral()
}

kotlin {
    linuxX64()
    linuxArm64()
}
