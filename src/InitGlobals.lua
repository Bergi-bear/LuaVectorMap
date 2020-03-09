TIMER_PERIOD = 0.03125
HERO={}

do
	local InitGlobalsOrigin = InitGlobals -- записываем InitGlobals в переменную
	function InitGlobals()
		InitGlobalsOrigin() -- вызываем оригинальную InitGlobals из переменной

		local hero=CreateUnit(Player(0), FourCC('H000'), GetPlayerStartLocationX(Player(0)), GetPlayerStartLocationY(Player(0)), 0)
		TimerStart(CreateTimer(), 3, true, function()
			UnitAddVectorForce(hero,180,5,GetRandomInt(200,600))
		end)
	end
end

function MovingSystem(hero)
	local data=HERO[GetHandleId(hero)]
	local Vector3 = wGeometry.Vector3

	TimerStart(CreateTimer(), TIMER_PERIOD, true, function()
		local k=data.ForcesCount
		local paladin = Vector3:copyFromUnit(hero)
		local newPos=paladin--+paladin:yawPitchOffset( 5.0, GetUnitFacing(hero) * ( math.pi / 180 ), 0.0 )
		if GetTerrainZ(GetUnitXY(hero))<=-80 then newPos=newPos+Vector3:new(0, 10, 0) end
		local f=0
		for i=1,k do
			if data.ForceRemain[i]>0 then
				f=f+1
				newPos=newPos+newPos:yawPitchOffset( data.ForceSpeed[i], data.ForceAngle[i] * ( math.pi / 180 ), 0.0 )
				data.ForceRemain[i]=data.ForceRemain[i]-data.ForceSpeed[i]
			else
				if data.IsForce[i] then
					data.IsForce[i]=false
				end
			end
		end
		if f==0 then
			data.ForcesCount=0
		end

		SetUnitX( hero, newPos.x )
		SetUnitY( hero, newPos.y )
	end)
end

function UnitAddVectorForce(hero,Angle,Speed,Distance)
	local data=nil
	local k=0
	if not HERO[GetHandleId(hero)] then
		--print("первый толчек")
		HERO[GetHandleId(hero)]={
			ForcesCount=0,
			ForceRemain={},
			ForceAngle={},
			ForceSpeed={},
			IsForce={}
		}
		data=HERO[GetHandleId(hero)]
		MovingSystem(hero)
	end
	data=HERO[GetHandleId(hero)]
	data.ForcesCount=data.ForcesCount+1
	k=data.ForcesCount
	data.ForceRemain[k]=Distance
	data.ForceSpeed[k]=Speed
	data.ForceAngle[k]=Angle
	data.IsForce[k]=true
end