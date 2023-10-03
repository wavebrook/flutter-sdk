package io.monedata.flutter.extensions

import io.monedata.consent.models.ConsentData

internal fun ConsentData.toMap() = mapOf(
    "date"      to date?.time,
    "granted"   to granted,
    "iabString" to iabString,
    "source"    to source?.name
)
