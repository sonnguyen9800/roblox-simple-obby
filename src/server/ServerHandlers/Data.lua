-- Module Data
local playersService = game:GetService("Players")
local dataStoreService = game:GetService("DataStoreService")

--Load the Define Module
local defineModule = require(game.ServerScriptService.Server.ServerHandlers.Define);


local store = dataStoreService:GetDataStore(defineModule.DataStorageId);

local sessionData = {}
local dataMod = {};

--Core Functions

dataMod.Load = function(player)
    local key = player.UserId
    local data = store:GetAsync(key);
    return data;
end


dataMod.SetupData = function(player)
    local key = player.UserId
    local data = dataMod.Load(player);

    sessionData[key] = dataMod.recursiveCopy(defineModule.DefaultPlayerData);

    if (data) then
        for index, value in pairs(data) do
            --dataMod.set()
            print(index, value)
            dataMod.set(player, index, value)
        end

        print("Player Name: "..player.Name.. "'s data has been loaded")
    else
        print("Player Name" ..player.Name.. " is a new player");
    end
    
end

dataMod.set = function(player, stats, value)
    local key = player.UserId
    local playerData = sessionData[key]
    playerData[stats] = value;
    --update the leaderboard
    dataMod.updateLeaderBoard(player, stats, value)
end

dataMod.increment = function(player, stats, value)
    local key = player.UserId
    local playerData = sessionData[key]
    local oldData = playerData[stats];
    playerData[stats] = oldData + value;
    dataMod.updateLeaderBoard(player, stats,  oldData + value)
end

dataMod.get = function(player, stats)
    local key = player.UserId
    local playerData = sessionData[key]
    return playerData[stats]
end

dataMod.updateLeaderBoard = function(player, stats, value)
    local leaderstartsName = defineModule.LeaderstartsName
    player[leaderstartsName][stats].value = value
end

dataMod.save = function(player)
    local key = player.UserId
    local data = dataMod.recursiveCopy(sessionData[key])
    store:SetAsync(key, data)
    print("Data of "..player.Name.." has been saved")
end

dataMod.removeSessionData = function(player)
    local key = player.UserId
    sessionData[key] = nil
end


-- Connect to PlayerServices
playersService.PlayerAdded:Connect(function(player)
    local folder = Instance.new("Folder");
    folder.Name = defineModule.LeaderstartsName
    folder.Parent = player

    local coinData = Instance.new("IntValue");
    coinData.Parent = folder
    coinData.Name = defineModule.CoinName
    coinData.Value = defineModule.DefaultPlayerData.CoinsDefault

    local stageData = Instance.new("IntValue");
    stageData.Parent = folder
    stageData.Name = defineModule.StageName
    stageData.Value = defineModule.DefaultPlayerData.StageDefault

    dataMod.SetupData(player);
end)

playersService.PlayerRemoving:Connect(function(player)
    dataMod.save(player)
    dataMod.removeSessionData(player)
end)


-- Added Funtion
dataMod.recursiveCopy = function(dataTable)
    local tableCopy = {}
    for index, value in pairs(dataTable)do
        if type(value) == "table" then
            value = dataMod.recursiveCopy(value);
        end
        tableCopy[index] = value
    end
    return tableCopy
end




return dataMod;