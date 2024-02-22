function SoDA:GetRaids()
    local raids = {}
    local numSavedInstances = GetNumSavedInstances()
    if numSavedInstances > 0 then
        for i=1, numSavedInstances do
            local name, _, reset, _, _, _, _, _, _, _, numEncounters, encounterProgress, _, instanceId = GetSavedInstanceInfo(i)
            if instanceId == 48 then -- Blackfathom Deeps
                local bfd = {}
                bfd.resetAt = time() + reset
                bfd.encounterProgress = encounterProgress
                bfd.numEncounters = numEncounters
                bfd.name = name
                raids.bfd = bfd
            end
            if instanceId == 90 then -- Gnomeregan
                local gnomeregan = {}
                gnomeregan.resetAt = time() + reset
                gnomeregan.encounterProgress = encounterProgress
                gnomeregan.numEncounters = numEncounters
                gnomeregan.name = name
                raids.gnomeregan = gnomeregan
            end
        end
    end
    return raids    
end

function SoDA:GetRaidsGui(character)
    local group = self.aceGui:Create("SimpleGroup")

    local raids = character.raids or {}

    -- Header
    local currencyHeader = self.aceGui:Create("Label")
    currencyHeader:SetText("Raids")
    group:AddChild(currencyHeader)

    -- Blackfathom Deeps
    local bfd = raids.bfd or {
        ["encounterProgress"] = nil,
        ["numEncounters"] = 7,
        ["name"] = "Blackfathom Deeps",
        ["resetAt"] = 0,
    }
    local bfdLock = SoDA:RaidLock(bfd)
    group:AddChild(bfdLock)

    -- Gnomeregan
    local gnomeregan = raids.gnomeregan or {
        ["encounterProgress"] = nil,
        ["numEncounters"] = 6,
        ["name"] = "Gnomeregan",
        ["resetAt"] = 0,
    }
    local gnomereganLock = SoDA:RaidLock(gnomeregan)
    group:AddChild(gnomereganLock)

    return group
end

function SoDA:RaidLock(raid)
    local raidLock = self.aceGui:Create("Label")
    if time() > raid.resetAt then
        raid.encounterProgress = nil
    end
    if raid.encounterProgress == raid.numEncounters and time() < raid.resetAt then
        raidLock:SetColor(0, 1, 0)
    end
    local name = raid.name
    if string.len(name) > 13 then
        name = string.sub(name, 1, 13) .. "..."
    end
    raidLock:SetText(name)
    if raid.encounterProgress ~= nil then
        raidLock:SetText(name .. " " .. raid.encounterProgress .. "/" .. raid.numEncounters)
    end
    return raidLock
end
