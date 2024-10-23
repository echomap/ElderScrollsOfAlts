--TEST TEST TEST TEST
function ElderScrollsOfAlts:DelTestData1()
  local pName = "Test1 McTesty1"
  if(ElderScrollsOfAlts.altData.players[pName] ~= nil) then
    ElderScrollsOfAlts.altData.players[pName] = {}
  end
  pName = "Perpugilliam Brown"
  if(ElderScrollsOfAlts.altData.players[pName] ~= nil) then
    ElderScrollsOfAlts.altData.players[pName] = {}
  end
  pName = "Very very long named character"
  if(ElderScrollsOfAlts.altData.players[pName] ~= nil) then
    ElderScrollsOfAlts.altData.players[pName] = {}
  end
end

function ElderScrollsOfAlts:LoadTestData1()
  local newPlayer = ElderScrollsOfAlts:deepcopy(ElderScrollsOfAlts.altData.players[1])
  newPlayer.name = "Very very long named character"
  table.insert( ElderScrollsOfAlts.altData.players, newPlayer)
end

 
function ElderScrollsOfAlts:ChangeESOAFontGame()
	local ef1 = ESOAFontGame --.font
	
    ElderScrollsOfAlts.debugMsg("ef1='"..tostring(ef1).."'")
    ElderScrollsOfAlts.debugMsg("ef1='"..tostring(ef1.font).."'")
    ElderScrollsOfAlts.debugMsg("ef1='"..tostring(ef1[0]).."'")
	ElderScrollsOfAlts.debugMsg("ef1='"..tostring(ef1[1]).."'")
	ElderScrollsOfAlts.debugMsg("ef1='"..tostring(ef1[2]).."'")
	
	--$(MEDIUM_FONT)|$(KB_18)|soft-shadow-thin
	--local font = {value:GetFontInfo()}
	--ESOA_RowTemplate_Label
	for dHL = 1, #ESOA_GUI2_Body_ListHolder.dataHolderLines do
		local dataHolderLine = ESOA_GUI2_Body_ListHolder.dataHolderLines[dHL] --ESOA_RowTemplate
--[[
		if(dataLine.displayedEntries~=nil)then
			for k, dLine in pairs(dataLine.displayedEntries) do
				if(dLine~=nil) then
					ElderScrollsOfAlts.debugMsg("LoadDataEntriesForSetView: Hid item=",dLine.entry)
					dLine:SetHidden(true)
				end
			end  
		end
--]]
	end
end

  
--TEST TEST TEST TEST