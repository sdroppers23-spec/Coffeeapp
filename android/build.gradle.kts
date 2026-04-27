allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val projectDrive = project.projectDir.absolutePath.substringBefore(":")
    val rootDrive = rootProject.projectDir.absolutePath.substringBefore(":")

    if (projectDrive.equals(rootDrive, ignoreCase = true)) {
        // Якщо на тому ж диску (D:), використовуємо спільну папку build на D:
        val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
        project.layout.buildDirectory.set(newSubprojectBuildDir)
    } else {
        // Якщо на іншому диску (C:), використовуємо локальну папку build в самому плагіні на C:
        // Це запобігає помилці "this and base files have different roots"
        project.layout.buildDirectory.set(project.layout.projectDirectory.dir("build"))
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Очищення папки build при запуску clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
