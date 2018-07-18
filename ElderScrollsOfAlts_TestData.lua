--TEST TEST TEST TEST
function ElderScrollsOfAlts:DelTestData1()
 local pName1 = "Test1 McTesty1"
  ElderScrollsOfAlts.altData.players[pName1] = {}
  local pName = "Perpugilliam Brown"
  ElderScrollsOfAlts.altData.players[pName].bio = {}
end

function ElderScrollsOfAlts:LoadTestData1()
   local pName1 = "Test1 McTesty1"
  ElderScrollsOfAlts.altData.players[pName1] = {}
  ElderScrollsOfAlts.altData.players[pName1].bio = {}
  ElderScrollsOfAlts.altData.players[pName1].bio.gender = 0
	ElderScrollsOfAlts.altData.players[pName1].bio.level = 0
  local pName = "Perpugilliam Brown"
  ElderScrollsOfAlts.altData.players[pName].bio = {}
  ElderScrollsOfAlts.altData.players[pName].bio.gender = 0
	ElderScrollsOfAlts.altData.players[pName].bio.level = 50
  ElderScrollsOfAlts.altData.players[pName].bio.CanChampPts = true
	ElderScrollsOfAlts.altData.players[pName].bio.race = "Wood Elf"
	ElderScrollsOfAlts.altData.players[pName].bio.class = "Dragonknight"
	ElderScrollsOfAlts.altData.players[pName].bio.classId = 1
  ElderScrollsOfAlts.altData.players[pName].bio.champion = 50
	ElderScrollsOfAlts.altData.players[pName].stats = {}
  ElderScrollsOfAlts.altData.players[pName].skills= {}
  ElderScrollsOfAlts.altData.players[pName].skills.armor = {}
	ElderScrollsOfAlts.altData.players[pName].skills.armor.typelist = {}
	ElderScrollsOfAlts.altData.players[pName].skills.world = {}
	ElderScrollsOfAlts.altData.players[pName].skills.world.typelist = {}
	ElderScrollsOfAlts.altData.players[pName].skills.class = {}
	ElderScrollsOfAlts.altData.players[pName].skills.class.typelist = {}
	ElderScrollsOfAlts.altData.players[pName].skills.guild = {}
	ElderScrollsOfAlts.altData.players[pName].skills.guild.typelist = {}
	ElderScrollsOfAlts.altData.players[pName].skills.racial = {}
	ElderScrollsOfAlts.altData.players[pName].skills.racial.typelist = {}
	ElderScrollsOfAlts.altData.players[pName].skills.weapon = {}
	ElderScrollsOfAlts.altData.players[pName].skills.weapon.typelist = {}
	ElderScrollsOfAlts.altData.players[pName].skills.ava = {}
	ElderScrollsOfAlts.altData.players[pName].skills.ava.typelist = {}
	ElderScrollsOfAlts.altData.players[pName].skills.trade = {}
	ElderScrollsOfAlts.altData.players[pName].skills.trade.typelist = {}
  ElderScrollsOfAlts.altData.players[pName].skills.trade.skills   = {}
end
