---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Bergi.
--- DateTime: 22.02.2020 21:14
function ActivatedAllTower()
	local e--временный юнит
	local k=0
	local id=FourCC('h002')
	GroupEnumUnitsInRect(perebor,bj_mapInitialPlayableArea,nil)
	while true do
		e = FirstOfGroup(perebor)
		if e == nil then break end
		if UnitAlive(e) and GetUnitTypeId(e)==id then
			k=k+1
			StartTowerAI(e)
		end
		GroupRemoveUnit(perebor,e)
	end
	--print("Запущено башен: "..k)
end