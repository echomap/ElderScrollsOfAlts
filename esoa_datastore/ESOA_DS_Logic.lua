--[[ ESOA Datastore INTERNAL ]]-- 

------------------------------
-- 

------------------------------
--INTERNAL API
ESOADatastoreLogic = {
  view = {},
}
------------------------------
------------------------------

------------------------------
-- API
function ESOADatastoreLogic.saveCurrentPlayerData()
  --check if want to save player
  if(EchoESOADatastore.svESOADataAW.savePlayerData) then
    ESOADatastoreLogic.saveCurrentPlayerDataInt()
  end
  --check if want to save equip
  if(EchoESOADatastore.svESOADataAW.saveEquipData) then
    --ESOADatastoreLogic.saveEquipData()
  end
  -- etc...
end
------------------------------
------------------------------


------------------------------
------------------------------
