---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Bergi.
--- DateTime: 24.02.2020 13:40

function RegisterAllAmmoBoxes(hero)
	local gg_trg_RANGE = CreateTrigger()
	TriggerRegisterUnitInRangeSimple(gg_trg_RANGE, 150, hero)

	TriggerAddAction(gg_trg_RANGE, function()
		local AmmoBox=GetTriggerUnit()
		local IsResurrected=false
		local IsKill=false
		--print("any")
		if IsUnitZCollision(hero,GetUnitZ(AmmoBox)) then
			if  GetUnitTypeId(AmmoBox)==FourCC('e002') then-- простой ящик
				--print("мммм")
				HeroUpdateWeaponCharges(hero,1,-100)
				HeroUpdateWeaponCharges(hero,2,-100)
				IsResurrected=true
				IsKill=true
			elseif GetUnitTypeId(AmmoBox)==FourCC('e003') or GetUnitTypeId(AmmoBox)==FourCC('e006') then
				if Ammo[GetPlayerId(GetOwningPlayer(hero))].Available.Rocket==false then
					Ammo[GetPlayerId(GetOwningPlayer(hero))].Available.Rocket=true
				end
				HeroUpdateWeaponCharges(hero,3,-50)
				IsResurrected=false
				IsKill=true
			elseif GetUnitTypeId(AmmoBox)==FourCC('e007') then
				if Ammo[GetPlayerId(GetOwningPlayer(hero))].Available.Fire==false then
					Ammo[GetPlayerId(GetOwningPlayer(hero))].Available.Fire=true
				end
				HeroUpdateWeaponCharges(hero,4,-300)
				IsResurrected=false
				IsKill=true
			elseif GetUnitTypeId(AmmoBox)==FourCC('e008') then
				if Ammo[GetPlayerId(GetOwningPlayer(hero))].Available.Toss==false then
					Ammo[GetPlayerId(GetOwningPlayer(hero))].Available.Toss=true
				end
				HeroUpdateWeaponCharges(hero,5,-15)
				IsResurrected=false
				IsKill=true
			elseif GetUnitTypeId(AmmoBox)==FourCC('e009') then
				if Ammo[GetPlayerId(GetOwningPlayer(hero))].Available.Barrel==false then
					Ammo[GetPlayerId(GetOwningPlayer(hero))].Available.Barrel=true
				end
				HeroUpdateWeaponCharges(hero,6,-10)
				IsResurrected=false
				IsKill=true
			end

			if UnitAlive(AmmoBox) and IsKill then
				local x,y=GetUnitXY(AmmoBox)
				local p=GetOwningPlayer(AmmoBox)
				local id=GetUnitTypeId(AmmoBox)
				KillUnit(AmmoBox)
				PlaySoundAtPointBJ( gg_snd_CollectOB1, 100, Location(GetUnitXY(hero)), 0 )
				if IsResurrected then
					TimerStart(CreateTimer(), 60, false, function()
						local new=CreateUnit(p,id,x,y,0)
						SetUnitAnimation(new,"Birth")
					end)
				end
			end
		end
	end)
end