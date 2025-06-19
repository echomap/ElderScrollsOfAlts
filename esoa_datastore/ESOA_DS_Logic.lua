----------------------------------------
--[[ ESOA Datastore ]]-- 
----------------------------------------
-- INTERNAL Implementation API
-- ONLY use SET methods for CURRENT server/account!
----------------------------------------


------------------------------
-- Implementation
function EchoESOADatastore.saveCurrentCharcterDataAll(loadtype)
	EchoESOADatastore.debugMsg("saveCurrentCharcterDataAll: loadtype=" , loadtype)
	--check if want to save player
	EchoESOADatastore.debugMsg("saveCurrentCharcterDataAll: savePlayer=", EchoESOADatastore.svESOADataAW.savePlayerData)
	if(EchoESOADatastore.svESOADataAW.savePlayerData) then
		EchoESOADatastore.saveCurrentPlayerDataInt()
	end
	--check if want to save equip
	EchoESOADatastore.debugMsg("saveCurrentCharcterDataAll: saveEquip=", EchoESOADatastore.svESOADataAW.saveEquipData)
	if(EchoESOADatastore.svESOADataAW.saveEquipData) then
		EchoESOADatastore.saveEquipData()
	end
	-- etc...?
end

------------------------------
-- Implementation
function EchoESOADatastore.getAccountList()
	local retval = {}
	if(EchoESOADatastore.svListDataAW.servers==nil) then
		local bar = {}
		bar.account = GetDisplayName()
		bar.server  = GetDisplayName()
		retval[account] = bar
		return retval
	end
	for dServer, dName in pairs(EchoESOADatastore.svListDataAW.servers) do
		EchoESOADatastore.outputMsg("getAccountList: Account=".. dServer .. " dName=".. dName )
		local bar = {}
		bar.account = dServer
		bar.server  = dName
		retval[dServer] = bar
	end
	return retval
end

------------------------------
-- Implementation
function EchoESOADatastore.getCharacterList(accountname)
	local retval = {}
	if( accountname==nil ) then
		for dServer, dName in pairs(EchoESOADatastore.svListDataAW.servers) do
			EchoESOADatastore.outputMsg("getCharList: Account=".. dServer .. " dName=".. dName )
			for id, cname in pairs(EchoESOADatastore.svListDataAW[dServer].playerlist) do
				EchoESOADatastore.outputMsg("getCharList: character1=[" , id , "] cname=".. cname )
				local bar = {}
				bar.id = id
				bar.name = cname
				bar.account = dServer
				bar.server = dName
				table.insert(retval, bar)
			end
		end
	else
		if(EchoESOADatastore.svListDataAW[accountname]==nil) then
			EchoESOADatastore.outputMsg("-No data for Account[",tostring(accountname),"]")
		else
			EchoESOADatastore.outputMsg("  for Account["..accountname.."]")
			for id, cname in pairs(EchoESOADatastore.svListDataAW[accountname].playerlist) do	
				EchoESOADatastore.outputMsg("getCharList: character2=[" , id , "] cname=".. cname )
				local bar = {}
				bar.id = id
				bar.name = cname
				bar.account = accountname
				bar.server = id
				table.insert(retval, bar)
			end
		end
	end
	EchoESOADatastore.outputMsg("getCharList: retval#=" , #retval )
	return retval
end

------------------------------
-- Implementation
function EchoESOADatastore.getCharactersBasicData(accountname)
	local retval = {}
	if( accountname==nil ) then
		for dServer, dName in pairs(EchoESOADatastore.svListDataAW.servers) do
			EchoESOADatastore.outputMsg("getBasicCharList: Account=".. dServer .. " dName=".. dName )
			for id, bar in pairs(EchoESOADatastore.svListDataAW[dServer].players) do
				table.insert(retval, bar)
			end
		end
	else
		if(EchoESOADatastore.svListDataAW[accountname]==nil) then
			EchoESOADatastore.outputMsg("  No data for Account[",tostring(accountname),"]")
		else
			EchoESOADatastore.outputMsg("  for Account["..accountname.."]")
			for id, bar in pairs(EchoESOADatastore.svListDataAW[accountname].players) do	
				table.insert(retval, bar)
			end
		end
	end
	return retval
end

------------------------------
-- UI/Console
function EchoESOADatastore.PrintPlayerNote(accountname)
	EchoESOADatastore.outputMsg("Playerlist->")
	local reval = EchoESOADatastore.getCharacterList(accountname)
	if(reval~=nil) then
		for index, tvalue in pairs(reval) do
			--EchoESOADatastore.outputMsg("index=".. tostring(index) .. " tvalue=".. tostring(tvalue) )
			EchoESOADatastore.outputMsg("name=".. tostring(tvalue.name) .. " id=".. tostring(tvalue.id) .. " account=".. tostring(tvalue.account ) )
		end
	else
		EchoESOADatastore.outputMsg("No players listed in datastsore")
	end
	EchoESOADatastore.outputMsg("<--Playerlist")
end

------------------------------
-- Implementation
function EchoESOADatastore.getDataForCharacters(account)
	local retval1 = {}
	local reval = EchoESOADatastore.getCharacterList(account)
	if(reval~=nil) then
		for index, tvalue in pairs(reval) do
			--EchoESOADatastore.debugMsg("index=".. tostring(index) .. " tvalue=".. tostring(tvalue) )
			EchoESOADatastore.outputMsg("getCharData2: name=" , tostring(tvalue.name) , " id=".. tostring(tvalue.id) , " account=" , tostring(tvalue.account), " index=", index )
			local val = EchoESOADatastore.getDataForCharacterById(tvalue.id, account)
			retval1[tvalue.id] = val
		end
	else
		EchoESOADatastore.outputMsg("No players listed in datastsore for account["..account.."]")
	end
	return retval1
end

------------------------------
-- Implementation
-- I think this isnt right
function EchoESOADatastore.getFlatDataForCharacters(account)
	local retval1 = {}
	local reval = EchoESOADatastore.getCharacterList(account)
	if(reval~=nil) then
		for index, tvalue in pairs(reval) do
			--EchoESOADatastore.debugMsg("index=".. tostring(index) .. " tvalue=".. tostring(tvalue) )
			EchoESOADatastore.debugMsg("name=".. tostring(tvalue.name) .. " id=".. tostring(tvalue.id ) .. " account=".. tostring(tvalue.account ) )
			local val = EchoESOADatastore.getFlatDataForCharacterById(tvalue.id, account)
			table.insert(retval, val)
		end
	else
		EchoESOADatastore.outputMsg("No players listed in datastsore for account["..account.."]")
	end
	return retval1
end

------------------------------
-- Implementation
function EchoESOADatastore.getDataForCharacterById(characterID,account)
	EchoESOADatastore.outputMsg("GetCharDataByID: for id: ", characterID, " account=" , account )
	if(account==nil) then
		account = EchoESOADatastore.GetAccountForCharacterByID(characterID)
	end
	if(account==nil) then
		EchoESOADatastore.outputMsg("-Error with account for character")
	end
	if(EchoESOADatastore.svListDataAW[account]==nil) then
		EchoESOADatastore.outputMsg("-No data for Account[",account,"]")
		return
	end
	if(EchoESOADatastore.svListDataAW[account].playerlist[characterID]==nil ) then
		EchoESOADatastore.outputMsg("-No data for Character["..characterID.."]")
		return
	end
	local retval = {}
	EchoESOADatastore.outputMsg("GetCharDataByID: characterID=["..characterID.. "] for account["..account.."]" )
	--
	retval["bio"] 			= EchoESOADatastore.svCharDataAW.sections.bio[characterID]
	retval["stats"] 		= EchoESOADatastore.svCharDataAW.sections.stats[characterID]
	retval["skills"]		= EchoESOADatastore.svCharDataAW.sections.skills[characterID]
	retval["tradeskills"] 	= EchoESOADatastore.svCharDataAW.sections.tradeskills[characterID]
	retval["xp"] 	 		= EchoESOADatastore.svCharDataAW.sections.xp[characterID]
	retval["power"]  		= EchoESOADatastore.svCharDataAW.sections.power[characterID]
	retval["riding"] 		= EchoESOADatastore.svCharDataAW.sections.riding[characterID]
	retval["bags"] 	 		= EchoESOADatastore.svCharDataAW.sections.bags[characterID]
	retval["skillpoints"] 	= EchoESOADatastore.svCharDataAW.sections.skillpoints[characterID]
	retval["achieve"]  		= EchoESOADatastore.svCharDataAW.sections.achieve[characterID]
	retval["currency"] 		= EchoESOADatastore.svCharDataAW.sections.currency[characterID]
	retval["ava"] 			= EchoESOADatastore.svCharDataAW.sections.ava[characterID]
	retval["pvp"] 			= EchoESOADatastore.svCharDataAW.sections.pvp[characterID]
	retval["infamy"] 		= EchoESOADatastore.svCharDataAW.sections.infamy[characterID]
	retval["location"]		= EchoESOADatastore.svCharDataAW.sections.location[characterID]
	retval["research"] 		= EchoESOADatastore.svCharDataAW.sections.research[characterID]
	retval["buffs"] 		= EchoESOADatastore.svCharDataAW.sections.buffs[characterID]
	retval["researchtraits"]= EchoESOADatastore.svCharDataAW.sections.researchtraits[characterID]
	retval["companions"] 	= EchoESOADatastore.svCharDataAW.sections.companions[characterID]
	-- Defaults
	if( EchoESOADatastore.svCharDataAW.custom ~= nil ) then
		retval["custom"]	= EchoESOADatastore.svCharDataAW.custom[characterID]
	end
	if( retval["custom"] == nil ) then
		retval["custom"] 	= {}
	end
	if( retval["custom"].category == nil ) then
		retval["custom"].category = "A"
	end
	if( retval["custom"].playersorder == nil ) then
		retval["custom"].playersorder = -1		
	end
	-- needed? retval["custom"].note = nil
	EchoESOADatastore.outputMsg("GetCharDataByID: for id: ", characterID, " category=" , retval["custom"].category )	
	--
	-- TODO: CP, Equipment section(s)
	--
	table.insert(retval, EchoESOADatastore.svCharDataAW.sections.special[characterID]  )
	--
	return retval
end

------------------------------
-- Implementation
function EchoESOADatastore.getCharacterByName(characterName,account)
	--TODO
end

------------------------------
-- Implementation
function EchoESOADatastore.getCharacterByID(characterID,account)
	--TODO
end

------------------------------
-- Implementation
function EchoESOADatastore.getBasicDataForCharacters()
	--TODO
end

------------------------------
-- Implementation
function EchoESOADatastore.getBasicDataForCharacter(characterName)
	--TODO
end

---------------------
-- Implementation
function EchoESOADatastore.GetNote(characterLineKey)
	local keyName = "note"
	return EchoESOADatastore.svCharDataAW.custom[characterLineKey][keyName]
end

---------------------
-- Implementation
function EchoESOADatastore.GetCustomData(characterLineKey,keyName)
	if(keyname~=nil) then
		return EchoESOADatastore.svCharDataAW.custom[characterLineKey][keyName]
	else
		return EchoESOADatastore.svCharDataAW.custom[characterLineKey]
	end
end

------------------------------
-- Implementation
function EchoESOADatastore.deleteCharacterByID(characterID,account)
	--TODO
	if(EchoESOADatastore.svListDataAW[accountname]==nil) then
		EchoESOADatastore.outputMsg("No data for Account["..account.."]")
		return
	end
	local playerKey = characterID
	if(account==nil) then
		--find account for character
	end
	EchoESOADatastore.debugMsg("deleteCharacterByID: characterID=["..characterID.. "] for account["..account.."]" )
	EchoESOADatastore.svListDataAW[account].playerlist[characterID]   = nil
	EchoESOADatastore.svListDataAW[account].players[characterID] = nil
	--
	EchoESOADatastore.svCharDataAW.sections.bio[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.stats[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.skills[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.tradeskills[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.xp[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.power[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.riding[characterID] = nil	 
	EchoESOADatastore.svCharDataAW.sections.bags[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.skillpoints[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.achieve[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.currency[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.bio[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.stats[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.skills[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.tradeskills[characterID] = nil

	EchoESOADatastore.svCharDataAW.sections.ava[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.pvp[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.infamy[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.location[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.research[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.buffs[characterID] = nil
	EchoESOADatastore.svCharDataAW.sections.researchtraits[characterID] = nil
	----Section: Equipment section
	--EchoESOADatastore:SavaDataPlayerEquipment(playerKey)
	--
	EchoESOADatastore.svCharDataAW.sections.special[characterID] = nil
	--
end

------------------------------
------------------------------

------------------------------
-- UTIL/
function EchoESOADatastore.GetAccountForCharacterByID(characterID)
	EchoESOADatastore.debugMsg("getAccountForChar: characterID=",characterID )
	local retval1 = nil
	local reval = EchoESOADatastore.getCharacterList()
	if(reval~=nil) then
		for index, tvalue in pairs(reval) do
			EchoESOADatastore.debugMsg("GetCharAccount: name=".. tostring(tvalue.name) .. " id=".. tostring(tvalue.id) .. " account=".. tostring(tvalue.account) )
			if( tvalue.id == characterID) then
				retval1 = tvalue.account
			end
		end
	else
		EchoESOADatastore.outputMsg("No players listed in datastsore")
	end
	return retval1
end

------------------------------
-- UTIL
function EchoESOADatastore:matchStringList(str,itemlist)
  if(itemlist==nil) then
	return false
  end
  for _, v in ipairs(itemlist) do
      if v == str then
          return true
      end
  end
  return false;
end

function EchoESOADatastore:flatten( item, result )
    local result = result or {}  --  create empty table, if none given during initialization
    if type( item ) == 'table' then
        for k, v in pairs( item ) do
            flatten( v, result )
        end
    else
        result[ #result +1 ] = item
    end
    return result
end


----------------------------------------
----------------------------------------