--module Define

local Define = {

    DataStorageId = "DataStorageV1",

    LeaderstartsName = "Player's Status",
    CoinName = "Lucky Gold",
    StageName = "Trial",
    DefaultPlayerData = {
        CoinsDefault = 0,
        StageDefault = 1
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
        SpringPotion = {
            JumpPower = 90;
            EffectDuration = 20
        }
    },

    PlayerCharacter = {
        DefaultJumpPower = 50
    }



}

return Define;
