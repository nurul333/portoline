// Tambahkan ini paling atas atau sebelum allprojects
ext.set("flutter", mapOf(
    "compileSdkVersion" to 34,
    "minSdkVersion" to 21,
    "targetSdkVersion" to 34,
    "versionCode" to 1,
    "versionName" to "1.0",
    "ndkVersion" to "27.0.12077973"
))

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}


val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
