package com.example.flutter_ces

import android.os.Bundle
import io.qameta.allure.android.AllureAndroidLifecycle
import io.qameta.allure.android.listeners.ExternalStoragePermissionsListener
import io.qameta.allure.android.writer.TestStorageResultsWriter
import io.qameta.allure.kotlin.Allure
import io.qameta.allure.kotlin.junit4.AllureJunit4
import io.qameta.allure.kotlin.util.PropertiesUtils
import pl.leancode.patrol.PatrolJUnitRunner

class AllurePatrolJUnitRunner : PatrolJUnitRunner() {

    override fun onCreate(arguments: Bundle) {
        Allure.lifecycle = createAllureAndroidLifecycle()

        // Registra el listener de Allure (y, si se usa TestStorage, el listener
        // que concede el permiso de almacenamiento) junto a los ya presentes.
        val listenerArg = listOfNotNull(
            arguments.getCharSequence("listener"),
            AllureJunit4::class.java.name,
            ExternalStoragePermissionsListener::class.java.name.takeIf { useTestStorage }
        ).joinToString(separator = ",")
        arguments.putCharSequence("listener", listenerArg)

        super.onCreate(arguments)
    }

    private fun createAllureAndroidLifecycle(): AllureAndroidLifecycle {
        // Con TestStorage los resultados se guardan en
        // /sdcard/googletest/test_outputfiles/allure-results y sobreviven a la
        // desinstalacion de la app y al clearPackageData del orchestrator.
        return if (useTestStorage) {
            AllureAndroidLifecycle(TestStorageResultsWriter())
        } else {
            AllureAndroidLifecycle()
        }
    }

    private val useTestStorage: Boolean
        get() = PropertiesUtils.loadAllureProperties()
            .getProperty("allure.results.useTestStorage", "true")
            .toBoolean()
}
