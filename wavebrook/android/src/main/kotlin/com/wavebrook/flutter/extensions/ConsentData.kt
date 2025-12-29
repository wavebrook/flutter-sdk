package com.wavebrook.flutter.extensions

import com.wavebrook.consent.models.ConsentData

internal fun ConsentData.toMap() = mapOf(
    "date"      to date?.time,
    "granted"   to granted,
    "iabString" to iabString,
    "source"    to source?.name
)
