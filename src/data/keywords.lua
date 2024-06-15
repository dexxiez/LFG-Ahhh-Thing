LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

-- English only because it's the correct language and the only one that matters
LFGAT.keywords = {
    trade = {
        "wts",
        "wtb",
        "wtt",
        "w2s",
        "w2b",
        "w2t",
    },
    lfg = {
        "lfg",
    },
    lfm = {
        "lfm",
        "lf*m" -- TODO: Add support for wildcard characters
    },
    zones = {
        BH = { "bh", "bh10", "bh25" },
        TBOT = { "bot", "bot10", "bot25" },
        COCK = { "coc", "crucible" }
    },
    misc = {
        RECRUITMENT = { "looking for", "recruiting", "exceptional" }
    }
}
