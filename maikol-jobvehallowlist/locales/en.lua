local Translations = {
    error = {
        not_allowed = "You're not allowed to drive this vehicle!",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})