--module Define

local Define = {

    DataStorageId = "DataStorageV1",

    LeaderstartsName = "Player's Status",
    CoinName = "Lucky Gold",
    StageName = "Trial",
    DefaultPlayerData = {
        CoinName = 0,
        StageName = 1
    },

    Time = {
        AUTOSAVE_INTERVAL = 120
    },

    Annoucement = {
        Shutdown = "Shutting Down game. All Data will be saved"
    },

    FolderTags = {
        Coin = "CoinTags"
    },

    Items = {
        ["SpringPotion"] = {
            Name = "Spring Potion",
            CoinPrice =  5,
            JumpPower = 90;
            EffectDuration = 20
        }
    },

    PlayerCharacter = {
        DefaultJumpPower = 50
    }



}

return Define;
