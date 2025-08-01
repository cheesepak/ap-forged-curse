pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

cartdata("ssj072025_the_forged_curse_vanilla")

function _init()
	frame=0
	
	stfx=split("poison,slow,confused,weak")
	initplayer()
	vx,vy=8,8
	--key items
	keys=split(
		--vanilla keys
		"112,37,,50,36,45,35,42,57,46,,,,,112,,39,,,,,00,00,00,,00,,34,,54,33,63,47,,51,67,,,112,00,00,48,,,,,,53,,,112,,112"
--"---,--,,--,--,--,--,--,--,--,,,,,---,,--,,,,,ga,gs,ws,,la,,--,,--,--,ap,--,,--,--,,,---,ia,is,--,,,,,,--,,,---,,---,map"
	)
	for ki,k in ipairs(keys) do
		if (k=="") k=49
		k=makeitem(k)
		k.id=ki
		keys[ki]=k
	end
	local eqpals={
		--armor
		--leth, iron,    gold
		"1,2,4","5,13,6","4,9,10",
		--sword
		--wood, iron,    gold
		"2,4,2","4,6,12","9,10,8",
	}
	local eqids=split("26,40,22,24,41,23")
	for pi,p in ipairs(eqpals) do
		local typ=pi\4
		local eq=makeitem(
			40+typ,
			1+typ
		)
		eq.p=split(p)
		eq.pow=2^(1+pi-typ*3)--(2+typ)^(pi-typ*3)
		local id=eqids[pi]
		eq.id=id--#keys+1
		keys[id]=eq
	end
	--record length of keys table
	keysl=#keys
	
	--forge fire entity
	fire=makeent(76,33,92)
	fire.isnpc=true
	--barrier entity
	barr=makeent(
		64,43,30,
		1,0,9999
	)
	barr.up=noup
	
	--entity data
	enttyps={
		--amanita
		{spd=.25,ap=2,rng=6,
			aspd=2,
			atk=projatk,
			fire=makespore,
			et="confused",
			ed=12,
		},
		--browncap
		{hp=4,ap=2,rng=3,
			aspd=3,
			atk=projatk,
			fire=makespore,
			et="slow",
		},
		--lionsmane
		{hp=8,ap=10,spd=.75,rng=2,
			atk=projatk,
			aspd=8,
			fire=makespore,
			et="weak",
			ed=10,
		},
		--cricket
		makenpc,
		--cat
		makenpc,
		--dog
		makenpc,
		--pig
		makenpc,--spd=.5,isnpc=true},
		--snake
		{et="poison",dmg=5},
		
		--spider
		{},
		--crab
		{hp=3,spd=2,ap=10,dp=3,aspd=4},
		--bananaslug
		{hp=7,spd=.25},
		--snail
		{hp=5,dp=3,spd=.25,ap=1},
		--axolotl
		{spd=.5,rng=7,ap=4,
			dr=draxolotl
		},
		--shimp
		{spd=3,agr=2},
		--small slime
		{hp=6,spd=.5,up=upslime},
		--slime
		{hp=12,spd=.8,up=upslime},
		
		--big slime
		{hp=24,up=upslime},
		--chest
		makechest,
		--pot
		{up=noup},
		--shadow
		{hp=12,dp=3,ap=6,spd=.8,slp=120},
		--bat
		{slp=120},
		--eyebat
		{slp=80},
		--big wiz
		makebigwiz,--{hp=50,dp=3,ap=10},
		--kobold
		makenpc,--spd=.5,isnpc=true},
		
		--kikku
		{hp=7,ap=4,
			atk=kickatk,
			dr=drkikku,
			aspd=3
		},
		--monstera
		makeleaf,
		--gnoglic mushroom
		{atk=projatk,
			fire=makespore,
			et="poison",
			aspd=3,
			ed=20
		},
		--potted hand
		makepothand,
		--ember
		{},
		--lilwiz
		{hp=5,ap=10},
		--monster kobold
		{hp=25,dp=5,spd=.5,ap=12},
		--dragon skull
		{hp=9999,
			dp=100,
			rng=10,
			aspd=6,
			mov=noup,
			atk=dsklatk,
		},
		
		--cubepig
		{hp=10,},
		--mimic
		makemimic,
		--mimic pot
		makemimpot,
	}
	
	--sight map
	sm={}
	--base entities
	be={}
	chex={}
	local ki=1
	for ri=0,63 do
		local row={}
		for ci=0,127 do
			-------------------
			row[ci]=0
			--convert tiles to ents
			local t=mget(ci,ri)
			local made=makeenttyp(t,ci,ri)
			
			if made then
				if t==97 or t==81 then
					--chests to check and kill
					--if their contents have
					--been recieved
					chex[ki]=made
					--add item to keys
					made.item=keys[ki]
					--count up key index
					ki+=1
				else--save restore data
					add(be,{e=made,
						sx=ci,sy=ri,
						ssp=made.sp
					})
					--]]
				end
				if (t!=81)	mset(ci,ri,0)
			end
		end
		sm[ri]=row
	end
	
	loot=split("49,49,49,49,49,49,49,52")
	
	---[[
	for ci,c in ipairs(chsts) do
		if not c.item then
			c.item=makeitem(49)
		end
	end
	--]]
	
	local keymap=makeitem(26)
	keymap.id=55
	dropitm(
		keymap,82,1
	)
	keys[55]=keymap
	
	local boltunlock=makeitem(122)
	boltunlock.id=56
	keys[56]=boltunlock
	
	
	--removed stuff was here
	
	
	--seen palettes
	spal={	
		split("0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"),
		split("0,0,1,2,1,5,13,2,4,9,3,13,5,4,9"),
	}
	resetvis()
	
	ticks=0
	tt=0
	ttm=4
	tott=0
	
	
	
	menusel=0
	clrt=0
	clrmsg=clrmsg or ""
	
	music()
	
	--title color table
	tcolt=split(
		"1,2,2,8,9,9,8,2,2"
	)
	--game mode
	mode="title"
	
	--debug
	test=""
	--testd=0
end--_init()



function _update()
	frame+=1
	
	
	if mode=="title" then
		if btnp(❎) or btnp(🅾️) then
			mode="gameplay"
			music(10,10000)
		end
		if btn(🅾️,1) and btn(❎,1)
		then
			clrt+=1
		else
			clrt=0
			clrmsg="hold to clear save"
		end
		if clrt>100 then
			clearsd()
			_init()
			clrmsg="save cleared"
		end
	elseif mode=="gameplay" then
		local nticks=0
		if (pc.hp>0)	nticks=pcup()
		if nticks>0 then
			--burn thru remaining ticks
			for t=1,ticks do
				upprjs()
				upents()
				upsnds()
				ticks-=1
			end
			ticks+=nticks
			tott+=nticks
			--vx,vy=pc.x,pc.y
		end
		if ticks>=1 then
			if tt<=0 then
				upprjs()
				upents()
				upsnds()
				ticks-=1
				tt=ttm
			else
				tt-=1
			end
		end
		vx,vy=pc.x,pc.y
		---[[debugd-----------------
		if pc.hp<=0 then
			if pc.dt<=0 then
				mode="gameover"
				music(0,300)
				pc.x=64
				pc.y=31
				pc.hp=100
				pc.dt=40
				for sei,se in ipairs(stfx)
				do
					pc[se.."t"]=0
				end
				--revive base ents
				for ei,e in ipairs(be) do
					local ent=e.e
					--remove existing
					local hp=ent.hp or 1
					--if hp>0 then
					del(ents,ent)
					--end
					--alias any pot
					local pot=ent.pot
					--test=e
					--remake ent
					ent=makeenttyp(
						e.ssp,e.sx,e.sy
					)
					ent.pot=pot
					--remake pot
					if pot then
						del(ents,pot)
						makethingpot(ent)
					end
					e.e=ent
				end
				resetvis()
			else
				pc.dt-=1
			end
		end
		--]]
	elseif mode=="map" then
		if btnp(🅾️) or btnp(❎) then
			mode="gameplay"
		end
	elseif mode=="gameover" then
		local nm={"gameplay","title"}
		if btnp(⬆️) or btnp(⬇️) then
		 menusel=(menusel+1)%2
		end
		if btnp(🅾️) or btnp(❎) then
			mode=nm[menusel+1]
			if (mode=="gameplay") music(10,300)
		end
	end
	
end--_update()



function _draw()
 cls()
 
 local tcol=tcolt[1+(frame\4)%9]
 if mode=="title" then
 	print("the",58,24,tcol)
 	print("\^w\^tforged curse",
 		16,32,tcol
 	)
 	if clrt<=0 then
	 	print("press 🅾️",48,96,
	 		spal[2][tcol]
	 	)
	 else
	 	print(clrmsg,
	 		64-#clrmsg*2,96,
	 		mid(2,9,tcol)
	 	)
	 end
	 	
 elseif mode=="gameplay" then
	 
	 local drx,dry=vx-8,vy-8
	 
	 for ri=0,16 do
	 	local cy=dry+ri
	 	for ci=0,16 do
	 		local t=1
	 		local cx=drx+ci
	 		local seen=sm[cy] or {}
	 		seen=seen[cx] or 0
	 		local vis=pc.vis[ri][ci]
	 		pal(spal[seen+vis*2+1])
	 		
	 		t=mgoob(cx,cy)
	 		
	 		if (t==0) t=4
	 		spr(t,ci*8-4,ri*8-4)
	 		
	 	end
	 end
	 pal()
	 
	 drpkups()
	 pcdr()
	 drents()
	 drprjs()
	 drftxts()
	 drgotitm()
	 drawhud()
	 
	elseif mode=="gameover" then
		print("g a m e   o v e r",
			30,32,tcol
		)
		spr(10,59,59)
		local mo={
			"continue","exit to title"
		}
		for mii, mi in ipairs(mo) do
			local txt=mi
			if mii==menusel+1 then
			 txt="-> "..txt
			end
			print(txt,64-#txt*2,64+mii*8,8)
		end
	elseif mode=="map" then
		for ri=0,63 do
			for ci=0,127 do
				local seen=sm[ri][ci]
				local t=mget(ci,ri)
				local pv=1
				if fget(t,1) then
				 pv=13
				elseif fget(t,0) then
					pv=4
				end
				pset(ci,ri+32,pv*seen)
			end
		end
		for ci,c in ipairs(chsts)
		do
			local seen=sm[c.y][c.x]
			pset(c.x,c.y+32,9*seen)
		end
		if frame%20>8 then
			pset(pc.x,pc.y+32,11)
		end
	end
	
 _debug()
end--_draw()



function _debug()
end--_debug()
-->8
--utils

--keep pal swaps after run
--poke(0x5f2e,1)

function rint(mxin)
	return flr(rnd(mxin))
end--rint()

function norp()
	return rint(2)*2-1
end--norp()

--override sgn() to return 0
function sgn(vin)
	if (vin==0) return 0
	return vin/abs(vin)
end

--returns status of single bit
--from decimal representation
--of binary number
function bit(decin,bitin)
 return flr(decin/(2^bitin))%2==1
end

function dist(e1in,e2in)
 local dx=e1in.x-e2in.x
	local dy=e1in.y-e2in.y
	return sqrt(dx*dx+dy*dy),dx,dy
end

dirt={--direction table
	{y=-1},--⬆️
	{x=1}, --➡️
	{y=1}, --⬇️
	{x=-1}	--⬅️
}	
--dirt helpers: nesw to x,y
function dirtx(din)
	return dirt[(din%4)+1].x or 0
end
function dirty(din)
	return dirt[(din%4)+1].y or 0
end
function dirts(din)
	return dirtx(din),dirty(din)
end

function oob(xin,yin)
	return xin<0 or xin>127 or yin<0 or yin>63
end

--mget+oob check
function mgoob(xin,yin)
	local ret=1
	if not oob(xin,yin) then
		ret=mget(xin,yin)
	end
	return ret
end

function getdrx(xin)
	return 60+(xin-vx)*8
end

function getdry(yin)
	return 60+(yin-vy)*8
end

--area of effect tileswap
function aoe(
swapin,
xin,yin,
rin
)
	local rad=rin or 1
	local x=xin or pc.x
	local y=yin or pc.y
	local	placed=0
	for ri=0-rad,rad do
		for ci=0-rad,rad do
			local t=mget(x+ci,y+ri)
			for fti=1,#swapin,2	do
				local ft=swapin[fti]
				if t==ft then
					mset(
						x+ci,
						y+ri,
						swapin[fti+1] or t
					)
					placed+=1
				end
			end
		end
	end
	--return count of tiles found
	return placed
end--aoe()

--[[
function stats()
	print("cpu:" .. flr(stat(1)*100) .. "%",1,120,11)
	print("mem:" .. flr(stat(0)) .. "kib",40,120,11)
	print("fps:" .. stat(7),88,120,11)
end
--]]
-->8
--player

function resetvis()
	local vis={}
	--reset all to -1
	for ri=-1,17 do
		local row={}
		for ci=-1,17 do
			row[ci]=-1
		end
		vis[ri]=row
	end
	--set player position to seen
	vis[8][8]=1
	--for each line of sight
	for li,l in ipairs(los) do
		--test=li
		--alias target tile coords
		local btx=l[1].x
		local bty=l[1].y
		
		
		for dx=-1,1,2 do	for dy=-1,1,2 do	for flop=0,1 do
			local tx=btx*dx
			local ty=bty*dy
			if (flop==1) tx,ty=ty,tx
			--alias tile vis value
			local tv=vis[ty+8][tx+8]
			--find map coords
			local mx=pc.x+tx
			local my=pc.y+ty
			--alias map tile
			local t=mgoob(mx,my)
			local opaque=fget(t,1)
			--if not marked or opaque
			if tv==-1 or opaque then
				if tv==-1 then
					--mark tile as visible
					vis[ty+8][tx+8]=1
					--mark as seen
					if my>=0 and my<=#sm
					and mx>=0 and my<=#sm[1]
					then
						sm[my][mx]=1
					end
				end
				--if opaque
				if fget(t,1) then
					--vis[ty+8][tx+8]=2
					--mark subsequent
					-- as not visible
					for ci=2,#l do
						local c=l[ci]
						local cx=c.x*dx
						local cy=c.y*dy
						if (flop==1) cx,cy=cy,cx
						vis[cy+8][cx+8]=0
					end
				else--see-thru
					for di=0,3 do
						local nx=tx+dirtx(di)
						local ny=ty+dirty(di)
						local nmx=pc.x+nx
						local nmy=pc.y+ny
						local nt=mget(nmx,nmy)
						if vis[ny+8][nx+8]==0 
						and fget(nt,1) then
							vis[ny+8][nx+8]=1.5
							if nmy>=0 and nmy<=#sm
							and nmx>=0 and nmy<=#sm[1]
							then
								sm[nmy][nmx]=1
							end
						end
					end
				end
			end--if not marked
		end end end--dx,dy,flop
	end--for each line of sight
	
	pc.vis=vis
end--resetvis()

function initplayer()
	local clock=makeitem(43)
	local noarm=makeitem(44,1,{9})
	noarm.pow=0
	local nowep=makeitem(44,2,{8})
	nowep.pow=0
	local ihp=100
	pc={
		x=64,
		y=31,
		dx=0,
		dy=0,
		dt=40,
		up=pcup,
		dr=pcdr,
		hp=ihp,
		mhp=ihp,
		mt=0,
		mtm=4,
		ap=3,
		dp=0,
		spd=1,
		iselx=0,
		isely=0,
		iselt=0,
		gotitm=0,
		g=0,
		--key items received
		keys={
			--[94]=makeitem(42),
			--[95]=makeitem(51),
			--[96]=makeitem(50),
			--[97]=makeitem(46),
			--[98]=makeitem(53),
			--[99]=makeitem(48),
			[0]=clock,--clock
			--[101]=makeitem(26),--map
			--none armor
			[102]=noarm,
			--none weapon
			[103]=nowep,
		},
		--actual inventory
		inv={},
		iopen=false,
		--current inventory selects
		ci={clock,noarm,nowep},
		--waiting on direction pick
		pickdir=false,
		boatready=false,
		hsshot=false,
		gotbolts=false,
		--cricket cooldown
		cricketcd=0,
		bolts=0,
		food=1,
		rest=0,
		full=0,
		hpdrip=0,
		--vision table
		vis={},
		--status effects + timers
		--poison=0,--poisoned
		--poisont=0,
		--slow=0,--slowed
		--slowt=0,
		--confused=0,
		--confusedt=0,--confused
		--wkn=0,--weakness
		--wknt=0,
	}
	for sei,se in ipairs(stfx) do
		pc[se]=0
		pc[se.."t"]=0
	end
	pcsetinv()
	
	--build line of sight lookup
	los=split(
		"011202121303132414041424251505152536261606162636372717071727374838281808182838485949392919091929394959;112112223242233343536324344454647484943545556575859536465666768696475767778797485868788898495969798999;020314041415051516061617071728180818282919091929;1213231424342535452636465627374757672838485868293949596979;2233433444544555657556667686576777879768788898798999;030405160616170717180818190919;13142415251626362737283848293949;23243435453646564757674858687859697989;33445445556556667667778797788898798999;04050607180818190919;141516261727182838192939;24253536463747384858495969;34354546565767586878697989;4455655666766777877888988999;05060708190919;1516172718281929;252636273738483949;353646475748585969;45465657676878697989;5566766777877888988999;06070809;161718281929;262737283839;363747484959;46475758686979;566768787989;667788988999;070809;17181929;27282939;37384849;4748585969;5758686979;67787989;778899",
		";",false
	)
	for li,l in ipairs(los) do
		local ld=split(l,1)
		l={}
		flop=false
		for pi=1,#ld,2 do
			local i=add(l,{
				x=ld[pi],
				y=ld[pi+1]
			})
			flop=flop or i.x==0
			if flop and i.x>0 then
				add(l,{
					x=i.x*-1,
					y=i.y
				})
			end
		end
		los[li]=l
	end
	
	
end

--condense received (sorted)
-- items for selection
function pcsetinv()
	pc.inv={{},{},{}}
	for ki=0,110 do
		local i=pc.keys[ki]
		if i then
			add(pc.inv[i.typ+1],i)
		end
	end
	if pc.food>0 then
		add(pc.inv[1],makeitem(52))
	end
	for iti,it in ipairs(pc.inv)
	do
		it.h=(#it+4)\5
	end
end--pcsetinv()

function isvis(xin,yin)
	local visx=xin-pc.x+8
	local visy=yin-pc.y+8
	local iv=pc.vis[visy] or {}
	return iv[visx] or 0
end

function pcdr()
	local os=(frame\16)%2
	local drx,dry=59,59
	local sp=16*os
	local hss=pc.hsshot
	if hss then
		local ssp=113+hss.d%2
		local hsx=getdrx(hss.x)
		local hsy=getdry(hss.y)
		line(
			drx+3,dry+3,hsx+3,hsy+3,
			9
		)		
		spr(ssp,
			hsx,hsy,
			1,1,
			hss.d>2,hss.d>2
		)
	end
	if (pc.gotitm!=0) sp,os=32,0
	if (pc.hp<=0) sp,os=10,0
	spr(
		sp,
		59+os*3,--pc.x*8-vx,
		59--pc.y*8-vy-4
	)
	if pc.inboat then
		spr(53,60,61)
	end
end--pcdr()

--draw got item
function drgotitm()
	local gi=pc.gotitm
	if gi!=0 and pc.hp>0 then
		circfill(63.5,54.5,4,0)
	 dritem(gi,59,51)
	end
end--drgotitm()

function giveitem(iin)--,nosave)
	if (iin.sp==-1 and rint(10)>3)
	or iin.sp==49 then
		local prz=rint(#loot)
		prz=loot[prz+1] 
		if prz==123 then
			if pc.bolts<20 then
				pc.bolts=max(
					pc.bolts+1+rint(3),
					20
				)
			else
				prz=49
			end
		end
			--]]
		iin.sp=prz
		if prz==49 then
			pc.g+=1+rint(3)--(rint(8)+rint(8))
		elseif prz==52 then
			pc.food+=1
			pcsetinv()
		end
	elseif iin.id then
		if iin.sp==112 then
			pc.mhp+=10
			pc.hp=pc.mhp
		elseif iin.sp==122 then
			pc.gotbolts=true
			add(loot,123)
			pc.bolts=20
		else
			pc.keys[iin.id]=iin
			pcsetinv()
		end
		--keys[iin.id].got=true
	end
	--save data
	--if iin.id then
		--local id=iin.id-1
		--keys[id+1]=nil
		--if not nosave then
			--local byte=dget(id\8)
			--byte+=2^(id%8)
			--dset(id\8,byte)
		--end
	--end
	--test=iin.sp--debug
	--set gotitem
	if (iin.sp>0)	pc.gotitm=iin
end


function pcup()
	local acted=0
	--debugd---------------
	--pc.hp=1000
	
	--handle some statfx
	local speed=pc.spd
	if pc.slowt>0 then
	 speed=pc.spd+pc.slow
	end
	local inp=split("0,1,2,3,4,5")
	if pc.confusedt>0 then
	---[[
		for i=1,pc.confused do
			local a=rint(6)+1
			local b=rint(6)+1
			inp[a],inp[b]=inp[b],inp[a]
		end
		--]]
	end
	
	
	local dx,dy=0,0
	
	if pc.mt<=0 then
		if (btn(inp[1])) dx-=1--⬅️
		if (btn(inp[2])) dx+=1--➡️
		if (btn(inp[3])) dy-=1--⬆️
		if (btn(inp[4])) dy+=1--⬇️
		if dx!=0 or dy!=0 then
		 pc.gotitm=0
		 pc.mt=pc.mtm
		 pc.rest=0
		end
	else
		pc.mt-=1
	end
	
	
	if btnp(inp[6]) then --❎
		pc.pickdir=false
		pc.iopen=not pc.iopen
	end
	
	if pc.hsshot then
		--handle hookshot
		hss=pc.hsshot
		if pc.x==hss.tx 
		and pc.y==hss.ty then
			pc.hsshot=false
		elseif hss.x==hss.tx
		and hss.y==hss.ty then
			pc.x+=hss.dx
			pc.y+=hss.dy
		else
			hss.x+=hss.dx
			hss.y+=hss.dy
		end
		acted=.2
		resetvis()
		
		
	elseif pc.iopen then
		--handle inventory
		--apply delta to selection y
		pc.isely=pc.isely+dy
		--get inv type
		local it=pc.inv[pc.iselt+1]
		--if oob of type
		if pc.isely>=it.h
		or pc.isely<0	then
			--apply delta to type
			--and keep in bounds
			pc.iselt=(pc.iselt+dy)%3
			--get updated inv type
			it=pc.inv[pc.iselt+1]
			--keep sel y in bounds
			pc.isely%=it.h
		end
		--determine line width
		local lw=5
		if pc.isely==it.h-1 then
		 lw=#it-5*((#it-1)\5)
		end
		--apply delta to sel x
		-- and keep in line bounds
		pc.iselx=(pc.iselx+dx)%lw
		if btnp(inp[5]) then--🅾️
			local ii=pc.iselx+pc.isely*5
			local i=it[ii+1]
			local typ=i.typ
			pc.ci[typ+1]=i
			if typ>0 then
			 acted=speed
			 pc.iopen=false
			end
		end
		
	elseif pc.pickdir then
		--handle pick direction
		-- for directional items
		local onx=dx!=0 and dy==0
		local ony=dx==0 and dy!=0
		if onx or ony then
			pc.pickdir=false
			local i=pc.ci[1]
			local isp=i.sp
			local tx=pc.x+dx
			local ty=pc.y+dy
			local dir=2-dx
			if (ony) dir=dy+1
			if isp==42 then
			--crossbow
				if pc.gotbolts
				and pc.bolts>0 then
					local b=makeproj(
						pc.x,pc.y,
						2,dx,dy,5,
						122+dir%2,12,
						bolteff
					)
					pc.bolts-=1
				end
			elseif isp==54 then
			--bellows
				makegust(dx,dy)
			elseif isp==46 then
			--blink rod
				tx+=dx
				ty+=dy
				local tt=mget(tx,ty)
				if not fget(tt,0) 
				and tt!=81 then
					pc.x,pc.y=tx,ty
					resetvis()
					sfx(52)
				else
					pc.hp-=50
					makeftxt("-50")
					sm[ty][tx]=1
				 sfx(48)
				end
			elseif isp==47 then
			--push rod
				local tt=mget(tx,ty)
				if fget(tt,3) then
					local dtx=tx+dx
					local dty=ty+dy
					if mget(dtx,dty)==0 then
						mset(dtx,dty,tt)
						mset(tx,ty,0)
					end
					sfx(53)
				else sfx(48)
				end
			elseif isp==57 then
			--grapple
				local hit,grab=false,false
				local nx,ny=pc.x-dx,pc.y-dy
				local tt,lt=0,0
				local step=0
				repeat
					step+=1
					nx+=dx
					ny+=dy
					lt=mgoob(nx,ny)
					--get the next tile over
					tt=mgoob(nx+dx,ny+dy)
					hit=fget(tt,0) and not fget(tt,4)
					grab=fget(tt,2) and not fget(lt,0)
				until hit or grab 
				or step>=12
				if grab then
					pc.hsshot={
						d=dir,
						dx=dx,dy=dy,
						x=pc.x,y=pc.y,
						tx=nx,ty=ny
					}
				else sfx(48)
				end
				
			end
			acted=speed
		elseif btnp(inp[5]) then--🅾️
			pc.pickdir=false
		end
		
	else
	--move
		local nx=pc.x+sgn(dx+pc.dx)
		local ny=pc.y+sgn(dy+pc.dy)
		--grab pickups
		for pi=#pkups,1,-1 do
			local p=pkups[pi]
			if p.x==nx and p.y==ny
			then
				if p.id then
					ap_sendloc(p.id)
				else
					giveitem(p)
				end
			 deli(pkups,pi)
			end
		end
		
		--do map collisions
		---[[debugd-------------------
		local nt=mgoob(nx,pc.y)
		if fget(nt,0) and
		not (fget(nt,4) and pc.inboat)
		then
			nx=pc.x
		end
		nt=mgoob(nx,ny)
		if fget(nt,0) and
		not (fget(nt,4) and pc.inboat)
		then
			ny=pc.y
		end
		--]]
		--if actually moved
		if nx!=pc.x or ny!=pc.y then
			
			
			--do entity collisions
			local hitent=false
			local atked=false
			for ei,e in ipairs(ents) do
				if e.x==nx and e.y==ny then
					if e.isnpc then
						local quips={
							{"meow","mya"},
							{"bark","wruf"},
							{"snort"},
							[20]={
								"hi!",
								"hello",
								"whoa!",
								"hey",
								"watch out"
							}
						}
						quips=quips[e.sp-67]
						local qi=rint(#quips)+1
						makeftxt(quips[qi],
							10,e.x,e.y
						)
					elseif not pc.inboat
					and not atked
					then--fight!
						--roll atk mult: 0=X0,9=X2
						local crit=(rint(10)+7)\8
						local wap=pc.ci[3].pow
						local weak=0
						if (pc.weakt>0) weak=pc.weak
						--attack!
						atked=true
						local atk=max(0,
							(pc.ap+wap)*crit-e.dp-weak
						)
						local txt="miss"
						if (crit>0) txt="-"..atk
						e.hp-=atk
						if e.sp!=81 then
							makeftxt(txt,10,e.x,e.y)
						end
						--wake up ent if asleep
						e.slp=min(e.slp,1)
						e.stun=0
						if e.hp<=0 then
							local ei=e.item 
								or makeitem(-1)
							if ei then
								if ei.id then
									ap_sendloc(ei.id)
									pc.gotitm=makeitem(63)
								else
									giveitem(ei)
								end
								--dont drop pickup
								e.item=nil
							end
						end--if ded
					end--if npc
					hitent=true
				end
			end
			--if didn't hit ent
			if not hitent then
				--actually move
				pc.x,pc.y=nx,ny
				pc.inboat=pc.inboat 
					and fget(nt,4)
				makesnd()
			else
				pc.dx,pc.dy=0,0
			end
		else
			pc.dx,pc.dy=0,0	
		end
		if dx!=0 or dy!=0 then
			acted=speed
			--determine vision
			resetvis()
		end--if moved
		
		if btnp(inp[5]) then--🅾️
			pc.gotitm=0
			local i=pc.ci[1]
			local isp=i.sp
			if fget(isp,6) then
				pc.pickdir=true
			else
				--rest
				if isp==43 then
					pc.rest=min(pc.rest+1,10)
				end
				if isp==48 then
					if pc.g>10 then
						makebomb()
						pc.g-=10
					else sfx(48)
					end
				--handle color keys
				elseif isp>=33
				and isp<=37 then
					aoe({isp-16,22})
--				elseif isp==34 then
--					aoe({18,22})
--				elseif isp==35 then
--					aoe({19,22})
--				elseif isp==36 then
--					aoe({20,22})
--				elseif isp==37 then
--					aoe({21,22})
				elseif isp==45 then
					aoe({29,22,22,29})
				elseif isp==39 then
					aoe({23,24})
				elseif isp==53 then
					pc.inboat=true
				elseif isp==26 then
					mode="map"
				elseif isp==52 then
					pc.food-=1
					pc.full=217
					pc.hp=min(pc.hp+20,pc.mhp)
					makeftxt("+20",11)
					pc.ci[1]=pc.inv[1][1]
					pcsetinv()
				elseif isp==51 then
					--place anvil
					if aoe({31})>0 then
						mset(74,34,51)
						del(pc.inv[1],i)
						del(pc.keys,i)
						pc.ci[1]=pc.inv[1][1]
					else sfx(48)
					end
				elseif isp==50 then
					if aoe({51})>0
					and fire.sp==108 then
						makering(8,8,1,74,34)
						ap_sendloc(55)
						if pc.gotbolts then
							local made=min(
								20,pc.g
							)
							pc.bolts=made
							pc.g-=made
							sfx(51)
							--pc.gotitm={sp=123}
						end
					else sfx(48)
					end
				elseif isp==67 then
					if pc.cricketcd<=0 then
						for i=0,20,10 do
							makering(17+i,7,0-i)
						end
						--stun enemies
						for ei,e in ipairs(ents)
						do
							local d=dist(pc,e)
							if d<=9 then
							 e.stun=10
							 e.slp=min(e.slp,1)
							 if e.sp==94 then
							 	ents[ei]=makeenttyp(
							 		87,e.x,e.y
							 	)
							 end
							end
						end
						sfx(49)
						pc.cricketcd=100
					else
						makering(
							10-pc.cricketcd\10,
							15,0
						)
					end
					--[[--reveal tiles
					for ri=-9,9 do
						local ty=pc.y+ri
						for ci=-9,9 do
							local tx=pc.x+ci
							if not oob(tx,ty) then
								sm[ty][tx]=1
							end
						end
					end
					--]]
				elseif i.eff then
					i.eff()
				end			
				acted=speed
			end
			resetvis()
		end
		pc.act=acted
		
		if pc.hpdrip>1 then
			pc.hp=min(pc.hp+1,pc.mhp)
			pc.hpdrip-=1
			makeftxt("+1",11)
		end
		
		
	end--if inv open/pickdir/etc
	
	if acted>0 then
		if (pc.full>0 or pc.rest>0)
		and pc.hp<pc.mhp then
			local dhp=(pc.mhp-pc.hp+pc.full/2)/(200)
			pc.hpdrip+=dhp/(11-pc.rest)
		end
		pc.full=max(pc.full-1,0)
		
		if pc.poisont>0 then
			pc.hp-=pc.poison
			makeftxt("-"..pc.poison,2)
		end
		
		for sei,se in ipairs(stfx)
		do
			local sen=se.."t"
			pc[sen]=max(0,
				pc[sen]-max(pc.rest,1)
			)
		end
		pc.cricketcd=max(
			pc.cricketcd-1,0
		)
		--spikes
		if mget(pc.x,pc.y)==9
		and not pc.hsshot then
			pc.hp-=20
			makeftxt("-20")
		end
		
	end--if acted
	
	ap_getitems()
	
	return acted
end--pcup()

function drawhud()
	local icols={12,9,8}
	if pc.iopen then
		---[[
		local ity=0
		for iti=0,#pc.inv-1	do
			local it=pc.inv[iti+1]
			for ii=0,#it-1 do
				local i=it[
					1+ii%#it
				]
				--test=i
				local icol=icols[i.typ+1]
				local ix=ii%5
				local iy=(ii\5)+ity
				if pc.ci[i.typ+1]==i then
					rect(
						78+ix*10,iy*10,
						87+ix*10,9+iy*10,
						icol
					)
				end
				dritem(i,
					79+ix*10,
					1+iy*10
				)
			end
			--draw selection box
			if iti==pc.iselt then
				if frame%18>12 then
					local ix=pc.iselx*10
					local iy=(pc.isely+ity)*10
					rect(
						78+ix,iy,
						87+ix,9+iy,
						7
					)
				end
			end
			ity+=it.h or 0
		end
		--]]
	else--if inv not open
		for ii,i in ipairs(pc.ci) do
			if i.sp!=44 then
				dritem(
					i,119,ii*10-9
				)
			end
		end
	end
	print("♥:"..max(pc.hp,0),1,1,8)
	print("⧗:"..flr(tott),1,7,12)
	local hy=13
	if pc.gotbolts then
		print(">▶:"..pc.bolts,1,hy,7)
		hy+=6
	end
	if pc.iopen then
		print("◆:"..pc.g,1,hy+6,6)
		print("●:"..pc.food,1,hy,9)
		hy+=12
	end
	for sei,se in ipairs(stfx) do
		local t=pc[se.."t"]
		local e=pc[se]
		if t>0 then
			print(se,--..":"..t..","..e,
				1,hy,13
			)
			hy+=6
		end
	end
	if pc.pickdir then
		local dirs=split("  ⬆️,⬅️  ➡️,  ⬇️")
		for di,d in ipairs(dirs) do
			print(d,52,44+di*8,8)
		end
	end
end--drawhud()
-->8
--entities

ents={}
function makeent(
xin,yin,
spin,hpin,
apin,dpin,--atk/def power
spdin,--speed
slpin,--sleep
upfin,--update function
npcin--is npc?
)
	local e={
		x=xin,
		y=yin,
		--f=0,
		sp=spin,--or 99
		mhp=hpin or 3,
		hp=hpin or 3,
		ap=apin or 2,
		dp=dpin or 0,
		spd=spdin or 1,
		slp=slpin or 0,
		mslp=slpin or 0,
		agr=7,
		aspd=1,--
		atkdt=0,--
		rng=0,
		at=0,
		mt=0,
		dr=drent,
		up=upfin or upent,
		mov=movent,
		stun=0,
		atk=entatk,
	}
	
	
	return add(ents,e)
end--makeent()

function makenpc(xin,yin,spin)
	local npc={
		x=xin,
		y=yin,
		hp=1,
		stun=0,
		sp=spin,
		up=upnpc,
		dr=drent,
		isnpc=true,
		hx=xin,
		hy=yin,
		tx=xin,
		ty=yin,
		ntt=0,
	}
	return add(ents,npc)
end--makenpc()

--make ent by type
function makeenttyp(
spin,
xin,yin
)
	if spin>=64 and spin<=98 then
		local edat=enttyps[spin-63]
		local e=nil
		if type(edat)=="table" then
			---[[
			e=makeent(xin,yin,spin)
			for statname,val 
			in pairs(edat) do
				e[statname]=val
				if statname=="slp" then
					e.mslp=val
				end
			end
			--[[
			if edat.isnpc then
				makenpc(e)
			end
			--]]
		else
			e=edat(xin,yin,spin)
		end
		return e
	end
end--makeenttyp()

function drent(ein,xin,yin)
	local drx=xin or ein.x
	local dry=yin or ein.y
--	local visx=drx-pc.x+8
	--local visy=dry-pc.y+8
	--local iv=pc.vis[visy] or {}
	--iv=iv[visx] or 0
	local iv=isvis(drx,dry)
	local lsp=ein.lsp
	local fl=(frame\16)%2==1 and fget(ein.sp,7)
	if (ein.f) fl=ein.f>1
	if iv>0 then
		local xo=0
		if (ein.stun>0) xo=(frame%4)\2
		spr(ein.sp,
			getdrx(drx)+xo,
			getdry(dry),
			1,1,
			fl			
		)
		ein.lsp={x=drx,y=dry}
	elseif lsp then
		local liv=pc.vis[lsp.y-pc.y+8] or {}
		liv=liv[lsp.x-pc.x+8] or 0
		if liv <=0 then
			pal(spal[2])
			spr(ein.sp,
				getdrx(lsp.x),
				getdry(lsp.y)
			)
			pal()
		else
			ein.lsp=nil
		end
	end
	
	return iv
end--drent()

function draxolotl(axin)
	drent(axin)
	if axin.atkdt>0 then
		for i=0,1 do
			line(
				getdrx(axin.x)+2,
				getdry(axin.y)+3,
				63+i,63+i,
				12-i*5
			)
		end
		axin.atkdt-=1
	end
end--draxolotl()

function drkikku(kin)
	if kin.atkdt>0 then
		kin.sp=104
		kin.atkdt-=1
	end
	local d,dx=dist(pc,kin)
	kin.f=dx
	drent(kin)
	kin.sp=88
end--drkikku()

function entatk(ein)
	--if nxin==pc.x and nyin==pc.y 
	--and ein.hp>0 then
		local crit=(rint(10)+7)\8
		local atk=max(0,
			ein.ap*crit-(pc.dp+pc.ci[2].pow)
		)
		local eff=ein.et
		if crit>1 and eff then
			stateff(ein)
		end
		test=test..ein.sp..","
		pc.hp-=atk
		local txt="miss"
		if (crit>0) txt="-"..atk
		makeftxt(txt)
		--hitent=true
		--return true
	--end
end--entatk()

function projatk(ein,dxin,dyin)
	ein:fire(
		ein.x+sgn(dxin),
		ein.y+sgn(dyin)
	)
	--ein.at=ein.aspd or 3
end--mushatk()

--dragonskull attack
function dsklatk(dsin)
	makeproj(
		--x,y,spd,dx,dy,
		dsin.x,dsin.y,2,1,0,
		--dmg,spr,life
		25,125,100
	)
end--dsklatk()

function kickatk(ein,dxin,dyin)
	pc.dx=dxin
	pc.dy=dyin
	entatk(ein)
end--kickatk()

function movent(ein,
din,dxin,dyin
)
	local step=0
	local loshit=0
	local sx,sy=ein.x,ein.y
	repeat
		sx+=dxin/din
		sy+=dyin/din
		local t=mget(
			flr(sx),flr(sy)
		)
		loshit+=tonum(fget(t,1))
		step+=1
	until loshit>1 or step>=din
	--if out of range
	if din>ein.agr 
	or loshit>1 then
		--wait
		dxin,dyin=0,0
		--or move randomly
		if rint(3)<=0 then
			dxin=rint(3)-1
			dyin=rint(3)-1
		end
	--if pc too close
	--for ranged attack
	elseif din<ein.rng then
		--reverse course
		dxin*=-1
		dyin*=-1
	end--if in agro range
	dxin,dyin=sgn(dxin),sgn(dyin)
	--move horizontally
	local nt=mget(
		ein.x+dxin,ein.y
	)
	if fget(nt,0) then
		dxin=0
	end
	--move vertically
	nt=mget(ein.x+dxin,ein.y+dyin)
	if fget(nt,0) then
		dyin=0
	end
	--collide with ents
	if dxin!=0 or dyin!=0 then
		local nx=ein.x+dxin
		local ny=ein.y+dyin
		local hitent=nx==pc.x
			and ny==pc.y--ein:atk(nx,ny)--false
		if not hitent then--else
			for ei,e in ipairs(ents)
			do
				if e!=ein then
					hitent=hitent or
					 nx==e.x and ny==e.y
				end
			end
		end
		if not hitent then
			ein.x,ein.y=nx,ny
		end
	end
	
	return loshit<1
end--movent()

function upent(ein)----------
	--get distance to player
	local d,dx,dy=dist(pc,ein)
	--handle stun
	if ein.stun>0 then
		ein.stun-=1
	--otherwise handle awake func
	elseif ein.slp<=0 then
		--alias range
		local rng=ein.rng or 0
		local haslos=false
		if d<20 then
			ein.mt+=ein.spd
			while ein.mt>=1 do
				
				haslos=ein:mov(d,dx,dy)
				
				--recalc dist to player
			 d,dx,dy=dist(pc,ein)
			 ein.at=max(ein.at-1,0)
			 if d<rng+1.99 
			 and ein.at<=0 
			 and haslos then
			 	ein:atk(dx,dy)
			 	--for axolotl
			 	ein.atkdt=2
					ein.at=ein.aspd
			 end
			 
				ein.mt-=1	
			end--while mt
		end
	else--sleepin
		local heard=false
		for si,s in ipairs(snds) do
			---[[
			local dx=ein.x-s.x
			local dy=ein.y-s.y
			--]]
			--local d=dist(s,ein)
			local vol=max(0,
				s.int-(abs(dx)+abs(dy))
			)
			ein.slp-=vol
			heard=heard or vol>0
		end
		if not heard then
		 ein.slp=min(ein.mslp,
		 	ein.slp+(ein.mslp-ein.slp)/20
		 )
		end
		--if awakened
		if ein.slp<=0 then
			--change sprite
			ein.sp+=16
		end
	end--if sleepy
end--upent()

function upbomb(bin)
	bin.hp-=1
end--upbomb()

bombs={}
function makebomb()
	local b=makeent(
		pc.x,pc.y,
		48,6
	)
	b.up=upbomb
	add(bombs,b)
end--makebomb()

function explode(bin)
	local toaoe={}
	--recursive fill function
	local function fill(
	ftin,
	xin,yin,
	powin
	)
		if powin>0 then
			local ps=xin..","..yin
			local t=mget(xin,yin)
			if not ftin[ps] then
				--add to tiles to destroy
				add(toaoe,{xin,yin})
				if not fget(t,1) then
					--create projectile
					local p=makeproj(xin,yin,
						1,0,0,30,28,1
					)
				end
				--mark it placed
				ftin[ps]=true
			end
			--expand explosion
			for di=0,3 do
				fill(ftin,
					xin+dirtx(di),
					yin+dirty(di),
					powin-1
				)
			end
		end
	end
	fill({},bin.x,bin.y,4)
	
	--destroy the tiles
	for pi,p in ipairs(toaoe) do
		aoe({3,60,23,24,60,0},
			p[1],p[2],0
		)
	end
	
	makesnd(30,bin.x,bin.y)
end--explode()

function drents()
	for ei,e in ipairs(ents) do
		e:dr()
	end
end--drents()

function upents()
	for ei,e in ipairs(ents) do
		e:up()
	end
	--check for exploding bombs
	local bombd=false
	local boom=false
	repeat
		bombd=false
		for bi=#bombs,1,-1 do
			local b=bombs[bi]
			if b.hp<=0 then
				explode(b)
				deli(bombs,bi)
				bombd=true
				boom=true
			end
		end
	until not bombd
	if (boom) sfx(50)
	--remove any dead things
	for ei=#ents,1,-1 do
		local e=ents[ei]
		if e.hp<=0 then
			deli(ents,ei)
			--drop item as pickup
			local i=e.item
			if i then
				dropitm(i,e.x,e.y)
			end
		end
	end
end--upents()

chsts={}
function makechest(
xin,yin--,itmin
)

	local c=makeent(
		xin,yin,
		81,1
	)
	
	c.up=chestup
	return add(chsts,c)
end--makechest()

function chestup(ein)
	ein.stun=0
	if ein.hp<=0 then
		del(chsts,ein)
		mset(ein.x,ein.y,25)
	end
end--breakup()

function makemimic(
xin,yin,
spin
)
	local c=makeent(
		xin,yin,
		81,100,
		2,0,
		.5,100
	)
	
	c.up=upmimic
	
	return add(chsts,c)
end--makemimic()

function upmimic(mimin)
	upent(mimin)
	chestup(mimin)
end--upmimic()

function makemimpot(
xin,yin
)
	local mp=makeent(
		xin,yin,
		82,100,
		2,0,
		.5,2000
	)
	return mp
end--makemimpot()

--dont do anything
function noup(ein)
	--ein.stun=max(ein.stun-2,0)
	if ein.stun>0 then
		ein.stun-=2
	end
	return true
end

--make pot for things in pots
function makethingpot(
ein,spin
)

	local pot,ssp=ein.pot,spin
	local sx,sy=ein.x,ein.y+1
	if pot then
	 ssp=pot.ssp
	 sx,sy=pot.sx,pot.sy
	end
	ein.bx=sx
	ein.by=sy-1
	
	pot=makeenttyp(ssp,sx,sy)
	if pot then
		mset(sx,sy,0)
	else
		pot={hp=999,x=sx,y=sy}
	end
	pot.sx,pot.sy=pot.x,pot.y
	pot.ssp=ssp
	
	ein.pot=pot
end--makethingpot()

function makepothand(
xin,yin
)

	local ph=makeent(
		xin,yin,
		91,100,
		20,2,
		1,0
	)
	
	ph.rad=5
	ph.f=0
	ph.dr=drhand
	ph.up=uphand
	makethingpot(ph,
		mget(xin,yin+1)
	)

	return ph
end--makepothand()

function uphand(phin)
	local pot=phin.pot
	if pot.hp<=0 then
		makeftxt("-"..phin.hp,8,phin.x,phin.y)
	 phin.hp=0
	end
	if phin.hp>0 
	and phin.stun<=0 then
		if phin.x==phin.bx
		and phin.y==phin.by then
			local d=dist(phin,pc)
			if d<=phin.rad+1 then
				--move and attack
				local step=0
				local hit=0
				local bhit=0
				local safe=20
				local d,dx,dy=0,0,0
				repeat
					d,dx,dy=dist(pc,phin)
					dx=sgn(dx)
					dy=sgn(dy)
					--local dx=sgn(pc.x-phin.x)
					--local dy=sgn(pc.y-phin.y)
					local nx=phin.x+dx
					local ny=phin.y+dy
					--base hit value
					-- 2 if diagonal, 1 if not
					bhit=abs(dx)+abs(dy)
					hit=bhit
					local nt=mget(nx,phin.y)
					if not fget(nt,0)
					or fget(nt,4) then
						phin.x=nx
						step+=abs(dx)
						hit-=1
					end
					nt=mget(phin.x,ny)
					if not fget(nt,0)
					or fget(nt,4) then
						phin.y=ny
						step+=abs(dy)
						hit-=1
					end
					safe-=1
				until (phin.x==pc.x-dx
				and phin.y==pc.y-dy)
				or step>=phin.rad 
				or hit>=bhit
				or safe<=0
				--attack
				if phin.x+dx==pc.x
				and phin.y+dy==pc.y then
					phin:atk()
				end
			end--if pc in range
		else--if not at base, recoil
			phin.x+=sgn(phin.bx-phin.x)
			phin.y+=sgn(phin.by-phin.y)
		end
		phin.f=2*tonum(phin.x-phin.bx)
	elseif phin.stun>0 then
		phin.stun-=1
	end
end--uphand()

function drhand(phin)
	phin.sp=107
	--update base position 
	--on draw so that it 
	--always looks right
	phin.bx=phin.pot.x
	phin.by=phin.pot.y-1
	if phin.x==phin.bx
	and phin.y==phin.by then
		phin.sp=91
	end
	local iv=drent(phin)
	--local dx=phin.x-phin.bx
	--local dy=phin.y-phin.by
	if iv>0 and phin.sp==107 then
		--draw arm
		for bi=0,1 do
			line(
				3+bi+getdrx(phin.bx),
				8+getdry(phin.by),
				4+getdrx(phin.x),
				getdry(phin.y),
				9
			)
		end
	end
end--drhand()

function makeleaf(
xin,yin
)
	local l=makeent(
		xin,yin,
		89,20,
		5,0,
		1,9999
	)
	l.dr=drleaf
	
	makethingpot(l,
		mget(xin,yin+1)
	)
	--move off map
	l.x,l.y=-999,-999
	
	return l
end--makeleaf()

function drleaf(lin)
	local pot=lin.pot
	local drx=lin.bx
	local dry=lin.by
	if pot.hp<=0 then
		if not lin.woke then
			lin.x,lin.y=lin.bx,lin.by
			lin.woke=true
			lin.slp=1
		end
		drx,dry=lin.x,lin.y
	else
		lin.bx=pot.x
		lin.by=pot.y-1
	end
	drent(lin,drx,dry)
end--drleaf()

function upnpc(ein)
	--ein.stun=0
	--update target
	if ein.ntt<=0 then
		ein.ntt=5+rint(5)
		local home={
			x=ein.hx,y=ein.hy
		}
		local d=dist(ein,home)
		if d<10 then
			ein.tx=ein.x+rint(9)-4
			ein.ty=ein.y+rint(9)-4
		else
			ein.tx=ein.hx+rint(7)-3
			ein.ty=ein.hy+rint(7)-3
		end
	else
		ein.ntt-=1
	end
	--
	local ex,ey=ein.x,ein.y
	local dx=sgn(ein.tx-ex)
	local dy=sgn(ein.ty-ey)
	ein.f=0
	if (dx>0) ein.f=2
	local nx,ny=ex+dx,ey+dy
	local nt=mget(nx,ey)
	if fget(nt,0) then
		nx=ex
	end
	nt=mget(nx,ny)
	if fget(nt,0) then
		ny=ey
	end
	if nx!=ex or ny!=ey then
		local hitent=false
		for ei,e in ipairs(ents) do
			hitent=hitent
				or (e.x==nx and e.y==ny)
		end
	end
	if not hitent then
		ein.x,ein.y=nx,ny
	end
end--upnpc()

function makebigwiz()
	local bw=makeent(
		73,44,86,--x,y,sp
		50,--hp
		20,20--atk/def power
		--1,--speed
	)
	
	bw.item=makeitem(112)
	bw.tpt=0
	bw.aspd=3
	bw.dr=drbigwiz
	bw.up=upbigwiz
	return bw
end--makebigwiz()

function upslime(slin)
	upent(slin)
	local sc=slin.sp-78
	if slin.hp<=0 
	and sc>0 then
		for i=1,4,sc do
			makeenttyp(slin.sp-1,
				slin.x+dirtx(i),
				slin.y+dirty(i)
			)
		end
	end
end--upslime()

function upbigwiz(bw)
	bw.stun=0
	if bw.tpt<=0 then
		bw.x=72+rint(9)
		bw.y=40+rint(9)
		bw.tpt=10+bw.hp\5
	else
		bw.tpt-=1
	end
	local cx,cy=bw.x,bw.y
	upent(bw)
	bw.x,bw.y=cx,cy
	--clear path to grave
	if bw.hp<=0 then
		aoe({30,0},69,44,3)
	end
end--upbigwiz()

function drbigwiz(bw)
	if isvis(bw.x,bw.y)>0 then
		local drx=getdrx(bw.x)
		local dry=getdry(bw.y)
		spr(86,drx,dry-8,1,2)
		
		local t=mget(bw.x,bw.y)
		if t==5 then
			spr(53,drx,dry+1)
		end
	end
end--drbigwiz()
-->8
--items & projectiles

--items={}
pkups={}--pickups
function makeitem(
spin,--sprite
typin,--type
palin--,--palette
--nin,--name
--bonin,--bonus
--effin--effect
)
	
	local i={
		sp=spin or 49,
		typ=typin or 0,
		p=palin or {},
		--n=nin or "",
		--eff=effin or function() end
	}
	
	return i
end--makeitem()

function dropitm(iin,xin,yin)
	iin.x=xin
	iin.y=yin
	add(pkups,iin)
end--dropitm()

function dritem(iin,xin,yin)
	pal(iin.p)
	spr(iin.sp,xin,yin)
	pal()
end--dritem()

function drpkups()
	for pi,p in ipairs(pkups) do
		dritem(p,
			60+(p.x-vx)*8,
			60+(p.y-vy)*8
		)
		--[[
		if (p.pal) pal(p.pal)
		spr(p.sp,
			60+(p.x-vx)*8,
			60+(p.y-vy)*8
		)
		pal()
		--]]
	end
end--drpkups()

--make projectile
prjs={}
function makeproj(
xin,yin,
spdin,--dirin,
dxin,dyin,
dmgin,
spin,
lspin,--lifespan
effin
)	

	local p={
		x=xin or pc.x,
		y=yin or pc.y,
		spd=spdin or 1,
		dx=dxin,--idx,
		dy=dyin,--idy,
		dmg=dmgin or 1,
		eff=effin or dmgprj,
		lsp=lspin or 1,
		sp=spin or 125,--isp,
		up=upprj,
	}

	return add(prjs,p)
end--makeproj()

--damage projectile effect
function dmgprj(pin,ein)
	if not ein.isnpc then
		local dmg=max(0,
			pin.dmg-ein.dp
		)
		ein.hp-=dmg
		makeftxt("-"..dmg,8,
			ein.x,ein.y
		)
		pin.lsp=0
	end
end--dmgprj()

function drprjs()
	for pi,p in ipairs(prjs) do
		local flp=fget(p.sp,7)	and (frame%6)>3
		spr(p.sp,--[1],
			getdrx(p.x),
			getdry(p.y),
			1,1,
			p.dx<0 or flp,
			p.dy>0 or flp
		)
	end
end--drprjs()

function upprj(pin)
	for si=1,pin.spd do
		if pin.lsp>0 then
			--if dir>=0 then
				local nx=pin.x+pin.dx
				local ny=pin.y+pin.dy
				local nt=mget(nx,ny)
				if not fget(nt,1) then
					pin.x,pin.y=nx,ny
				else
					pin.lsp=0
				end
			--end
			--collide with ents
			for ei,e in ipairs(ents) do
				if pin.x==e.x 
				and pin.y==e.y then
					pin:eff(e)
				end
			end
			if pin.x==pc.x
			and pin.y==pc.y then
				pin:eff(pc)
			end
		end--if not done
	end--for each step
	pin.lsp-=1
end--upprj()

function gusteff(pin,ein)
	if ein==fire then 
		ein.sp=108
	elseif ein.sp==92 then
		ein.ap+=3
	else
		local nx=ein.x+pin.dx
		local ny=ein.y+pin.dy
		local nt=mgoob(nx,ny)
		if not fget(nt,0) then
			ein.x,ein.y=nx,ny
		end
	end
	ein.slp=min(1,ein.slp)
end--gusteff()

function makegust(dxin,dyin)
	local g=makeproj(
		pc.x,pc.y,
		1,dxin,dyin,
		0,119,
		5,--lifespan
		gusteff
	)
end--makegust()

--[[
function makebubble(
ein,
dxin,dyin
)
	local b=makeproj(
		ein.x,ein.y,
		2,dxin,dyin,
		0,121,
		12--lifespan
	)
	b.up=upbub
end--makebubble()

function upbub(bin)
	upprj(bin)
	--bin.spd-=1
end--upbub()
--]]

function bolteff(pin,ein)
	if ein.stun>0 
	and not ein.isnpc then
		makeftxt("-"..ein.hp,8,
			ein.x,ein.y
		)
		ein.hp=0
	else
		dmgprj(pin,ein)
	end
end--bolteff()

--spores={}
function makespore(
ein,xin,yin
)

	local sp=makeproj(
		xin,yin,
		1,0,0,
		ein.ap or 1,--epowin or 1,
		124,
		10,--lifespan
		stateff
	)	
	
	--et=etin or 1
	sp.et=ein.et--stfx[et]
	sp.ed=ein.ed or 10--edin or 10
	--add(spores,sp)
end--makespore()

--status effect
function stateff(pin,ein)
	local e=ein or pc
	if e==pc then
		e[pin.et]=pin.dmg --or pin.ap
		e[pin.et.."t"]=pin.ed or 10
		makeftxt(pin.et,13)
		pin.lsp=0
	end
end--stateff()

function upprjs()
	for pi=#prjs,1,-1 do
		local p=prjs[pi]
		p:up()
		if p.lsp<=0 then
			deli(prjs,pi)
		end
	end
end--upprjs()

snds={}
function makesnd(
intin,
xin,yin
)
	local s={
		x=xin or pc.x,
		y=yin or pc.y,
		int=intin or 10
	}
	
	return add(snds,s)
end--makesound()

function upsnds()
	for si=#snds,1,-1 do
		local s=snds[si]
		s.int-=1
		if s.int<=0 then
			deli(snds,si)
		end
	end
end--upsnds()

--floating text
ftxts={}
function makeftxt(
txtin,
colin,
xin,yin
)
	local ft={
		t=txtin,
		x=xin or pc.x,
		y=yin or pc.y,
		col=colin or 8,
		at=20,
		dr=ftxtdr,
	}
	
	return add(ftxts,ft)
end--makeftxt()

function ftxtdr(ftin)
	local col=ftin.col
	if (ftin.at<10) col=spal[2][col]
	if (ftin.at>=19) col=7
	print(ftin.t,
		getdrx(ftin.x)+4-(#ftin.t*2),--64-(#ftin.t*2)+(ftin.x-vx)*8,
		getdry(ftin.y)-20+ftin.at,--40+(ftin.at)+(ftin.y-vy)*8,
		col
	)
	pal()
end--ftxtdr()

function drftxts()
	for fti=#ftxts,1,-1 do
		local ft=ftxts[fti]
		ft:dr()
		ft.at-=1
		if (ft.at<=0) deli(ftxts,fti)
	end
end--drftxts()

function makering(
lspin,colin,
radin,
xin,yin
)
	local r={
		x=xin or pc.x,
		y=yin or pc.y,
		rad=radin or 1,
		col=colin or 7,
		at=lspin or 10,
		dr=drring,
	}
	
	return add(ftxts,r)
end--makering()

function drring(rin)
	rin.rad+=4
	circ(
		getdrx(rin.x),
		getdry(rin.y),
		max(rin.rad,0),
		rin.col
	)
end--drring()
-->8
--apmw/gpio/save/load

gpio=0x5f80

--load saved data
function ap_getitems()
	for ki=0,60 do
		local k=keys[ki+1] 
			or {got=true}
		if not k.got then
			local byte=peek(gpio+10+ki\8)--dget(id\8)
			local ibit=ki%8
			if bit(byte,ibit) then
				--test=test..ki..","
				--idk why this is broken
				--but heres a quick fix
				if ki==54	then
					pc.gotbolts=true
					loot[9]=122
					pc.bolts=20
				end
				giveitem(k)--,true)
				k.got=true
				--local ch=chex[ki+1]
				--if ch then
					--ch.item=nil
					--ch.hp=0
				--end
			end
		end--if k
	end--for ki
	
end--loadsd()

function ap_sendloc(locin)
	local id=locin-1
	if id==31 then
		pc.gotitm=makeitem(rint(128))
	end
	local adr=gpio+id\8
	poke(adr,
		peek(adr)|2^(id%8)
 )
end--ap_sendloc()


__gfx__
0099990015555511055555100551151011111010cccccccc36666ddd07777760ddddd0d000060006000000000000000054444445155d155d4cccccc405676550
0019910051111151511111515111115110000000cc7ccccc6160031576666676d000000060656065000000000000000040400404111111119494949402424240
0049940015555511155555111515151110000000c7c7cccc3030030367777766d0000000505050500066660000000000424224245d155d154242424256676655
9944449051111151511111515111115110000000cccccccc5737737576666676d000000000000000066666500600060040400404111111114242424242499242
9984489051555551515555515151155100000000cccccc7c7c7cc7c7767777760000000006000600065655507777777740400404155d155d4242424242494242
0088880051111111511111115111111110000000ccccc7c7ccc7cccc76666666d000000065606560066666500600060042422424111111114242424256676655
0022222015555551155555511551115100000000cccccccccc7c7ccc67777776000000005050505006666650777777774040040455d155d12222222202422220
0044044011111111011111100111511000000000cccccccccccccccc066666600000000000000000111515110600060054444445111111114cccccc405676550
09999000114424111144241111442411114424111144241111000011110000111100001104499440f9fffff936366ddd809009081144241111776711066666d0
019910001248842112499421124bb421124cc42112477421100000011000000110000001042222409dfffdff60300d05088aa880124424211677676106dddd50
04994000428888244299992442bbbb2442cccc244277772420000000020044440000000004222240fffddddf60d00d0398a99a89424424247766667766666ddd
944449904248842442499424424bb424424cc4244247742420000000444400200000000002444420fffffff960d006030a9779a04244242476777767d5555555
98448990424424a4424424a4424424a4424424a4424424a4290000000200444400000000041111409ddddddfd0d006030a9779a0424424a4767887676666666d
08888000424424a4424424a4424424a4424424a4424424a42000000044440020000000000444444009dfdff93060060398a99a89424424a47677776700000000
222220004244242442442424424424244244242442442424200000000200444400000000042222409fdfdfd9d0600505088aa880424424247766667700000000
44044000424424244244242442442424424424244244242420000000444400200000000004244240ff999f9f5565335580900908424424247677676700000000
99199199a0a00000a0a00000a0a00000a0a00000a0a00000ccc7cccc000000000000000072000000040044449999444000111100606000007c00000078000000
994994990a0a00000a0a00000a0a00000a0a00000a0a0000cc7c7ccc05500000072007302720000042440070600000600100001006d60000cc90000088900000
0844448000a0000000a0000000a0000000a0000000a00000cccccccc508800003211112202720000042407000600060010100001006000000940000009400000
00844800000a0000000a0000000a0000000a0000000a00007c7cc7c7500880000073320000272010044270000060600010010001000606000004000000040000
008888000000aaa00000aaa00000aaa00000aaa00000aaa057377375560088000032220000021100400724000067600010001001000066600000400000004000
008888000000a88a0000a99a0000abba0000acca0000a77a303003036000055000222200000011004070424006777600100001010006608d0000040000000400
022222200000a88a0000a99a0000abba0000acca0000a77a616003150000006607022020000100104700042067777760010000100000d00d0000004000000040
0440044000000aa000000aa000000aa000000aa000000aa036666ddd00000000320000220000000340000000994444400011110000000dd00000000400000004
00009900000000000005000000000000094400000000000090000000600000000078860076660000000000000000000000000000000000000000000000000000
000090000000000004515000000000000a944400000000000940000056000600060000d075000000030030000000000000000000070300300000000000078000
0011110000760000055515000005555509a944400000000004d44000056060400dccccd070609490000300000005150000000000797030000065050007a887b0
01dd1110006507605155100055155555009a944400900000004d544400560006077666606006004900030000005551500000050007003070066656500aa11bb0
01d1111000000650551140000551555009aaa944444944440045d5d0000000600dddddd000494004000000300515511000001110030007970655555007c007e0
011111100076000005500400005111000aa9a9449994949900045d0000000600067666600904090900300300551155110000000000300370066566500cc79ee0
0111111000650000000000400001100000aaa944044449400004d00000000054067666d004004004000303035511111100000000303030000666615001199110
00111100000000000000000405555550000aa940000000000004000000000022006ddd0000949490030303030115111001000000303030301115151100011000
0000000000044000099f9f0000000000000000000505000500000000000000005050050000000090070700000000000080000080009988900000000000000000
0088700000444000f9f9f990070070000909000905550050000000000000000050500505000000090a0a0000000000008eee0800088898890000000000000000
08888800004444009f9f9ff07007066009990090075700500e0e000000bb000005055055090009090a0a00000000444007e7800e088898890000000000000000
8788878800444400f9f9fd007007655607970090555550500eee00e00bb7bb0000555500907079090aaa0000707499948eeee88e8878000800000000000ccc00
88878887045d440090ddd600087867700999909005555500ee7eee0080bbbb0055555555909049997aaa00006069444900ee000e788000980000000000c111c0
7888d0004556d54400666600077677700999990005555500eeeeee00000bbb0000858500099994900aaa5000666949490eeeeeee88000090000000000c7171c0
880d600000066000006666000507575709999900050050500eeeeee000bbb00b55080850099949000aaaaa5066d94994e00e0ee0800009890000c0000c1111c0
0060060000600600006000600507575709009090050050500e0e00e000bbbbbb5000000590909040009959990ddd944000e0000e08000989000c1c0000cccc00
0000000000000000007777000000000000060600000020000222000000600600000000000000000000ee00000999990000000000000222220000000077777700
000ccc00000000000006600000000000000ddd00000220002022200000bbb000000000000bbbb0000e0e20009900099000000000002222000603630077600777
0ccc1cc0000000000077770000000000000dd6000022250000222200007b700000777700bb3b0b000ee0e0009990009900000800277227726bb633bb67600770
cc1111cc00444400077777700000000000dd6d0000225200022222000bbbb00007777770b3bb00b0e0a2e0009909000900000000008448008bb833bb56777600
c171171c0444444007878780000000000ddd6d000222522022222220003b3b0007577570b3bb00b0e2312200990000090008000000999900bbbb333b55607766
c111111c0229922008787870055550000dd6dd0002252220042222220b33300b00777760b3b000b0a00b0ae0909000990000000092277290bbb0333006000707
cc1111cc042222400077770050000500dd666dd00052250000844800003333b00060006030000b00000c00200900999000088000022722007070333b00670070
0cccccc00424424000700700555555500d606dd0005005000079970000b0b00007700770000bb00000c0300a000990000089980000222220000b00b000066667
08888882004994400007770000550000000000002000000200777700000000000000000000000bb00000000099009990000090000777d7770000077777777700
eeeeeee20707272400006770050050000d00000d220000220027722200000000700077000bb0b003000000000099999980098000766d76770000767777600777
eeeeeee2088802220787760050005000dd0000dd25050222022272220000000077075770bb3bbb03000000000900999900897808675677570006775767677770
7eee7ee2808888220080877058085000dd606ddd25555222022222200000000077077770bb37bb03000000009009999908979980765765650057600556700707
22222ee2007878740000008050005000d7676ddd2865522002222200000000000760757073bbb3030000000090990099089799807657756d0057700005688989
eeee2ee2044444400808087050000500d6666d0d08855200022222000000000000067760b3bb3003000000000090009089977988765767d70057670706000898
2e2e2ee2042222400878770005000050066660000055000002222200000000000000060003b00030000000000090090089777988677577650005776500670070
eeeeeee0042442400070070005555555006060000000000022222220000000000000770003000303000000000000000008979990066655500000555000066667
07000000000700000000000000555500000000000000000000777700006666000000000000000000000700000000000000000000000000000000000000000000
777e0e80006750000000060005800050000000000505020000277200060000600000000000cccc00006750000000000007000000000000000000000000000000
0788e2280606050000070060500000500d606d00255552200222720060066006000000000c7700c0000600000880006000000700008888000000000000000000
0eeee888000600000059667705080050d7676dd0286552200222220060600606000000000c700dc0000600000066667700000000089999800800000000000000
0e88e228007950000005005005000050d6666ddd288552220222220060606606000000000c000dc0000600000880005000700007899977788980000080000000
0088e280000500000000050050055500d6666ddd225500220222220060600006000000000c0dd0c0008680000000000000000000997777789998000098000000
0008e800000000000000000005050000d060600d2000000202222200600666600000000000cccc00008080000000000007000000089977808880000080000000
0000e000000000000000000005555500000000000000000022222220060000000000000000000000000000000000000000000700008888000000000000000000
20002000200020152000710020c020000020201600000000955050500000202000a5202020000000000000000420000000000000000000000000000020002000
000020002000c32000c300d0d0d0200000a35050505050505050505050505050505050505050a39520f00050505000f020200000000000000050505050505050
20002000710020002000207120000000202020202000c30000505050a30020202020200045000020002000202020002000202020202020202020000000000000
0000000000000071000000b100d020b40000009550505050505050505050505050505050500000000000a300505050202020f00000c300f000000000c3000062
200020f0202020002000200420002020200000952020000000005050500000202000000000000000c3450000200400000020840000000000842000c320002000
000020002000b320000000d0d0d020202020000000a300c450505050505050505050505000000020202020202020202020202020202020202020202020200020
200000000020000071002020200020201500a000c3310000000050505000002171000000150000000000000000000000002000200000c3200020b30000000000
0000000000b3b320f000f1d0d0d02020605050505050505050505050202020a3000000000020a320550000f00050505000000000040000200000000055200020
20f0202000202000200071062000202020d300002020000000a3505050c3002020000000000000000000c3002000000000200000000000000020202020200000
c300002020202020202020202020202020002020202020202020202020202020002000000000a32020000020000050502020202020200020f400b3c30000b300
20202071717120c02020202020c32000202020202000000000505050a30020202020200000000020002000202020002000000000002000000020202020202020
0020202070a30000157070707070707070007070707070707070707070707070302020000020002000001400000050500000f0f0202000202020c32020200020
20f0857100000000000000c37100c30000202015000000000050505000002020a5002020200000000000000004200400c3200000000000000020008420707080
808070707000a0a370707080808070707000000000957000700070000000707030202000000000200015000000555050000000f02000b30000000020f4202020
2020202020202020202020202020202000002020000000a350500000002020000000000020204120202020202020202020200020000000200000001520708080
8080807070d300707080800000008080707000260025702500257025000000b130200000002000202000002000005050000000002020002020202020c3205520
7070707070707070707070707070702020712020200000000000c395202020000000c300000000000020000000000000002000c3000000000020000020709580
808095707000707080505050500000008070700070000000700000957000167020200000000000200000550000505050200000002000002000c300b300000020
709000f0909090909090707090907070204120c320202000000020202000200020202000000000c3002000000020000000202020b320b1b12020202020702580
8080257070e1708050505050008080800080707070b170250026002500000070200400000020002020202020205020202020000020000020b300b300b300b320
70900000909000f09090909090909070200020b1202020202020202020b1200020062095000600009520000000150000002020a5b30000000000002020707080
8080707070e1705050005000800000008000707070b1707070707070707070702020000000000000a300009550505000002020002000b3000000b3c3b3b30020
7090909090900000909090900015007020c30000002020000000000000002000200020250000c300252000002020200000200000200024c30020000020707070
807070e1e1e1705000800080000080008000807080808070707070707070707020202000000000200020a35050505000d4f020002000c320b300b305b300b320
707090907070909090909090c3000070200020000000000620002020200020002000202020202020202000000020000000200000000000000000000020708570
517000e1f0e1e150008065800080000080008051803580800000000000000070202000000000000000a350505000c400002020412020202000b3c3b3b3b30020
70709090707090909090909090909070202020200020200000000000200020000000c30000000000002000a50020000600200020202020202020200020700070
0000007070707050008000800000800080008070808080707070707070700070200000002020000000a350500000002020205050502020200000c320b300c320
70909090909090909090f000909090702015063000a500002020000000002000002000002000a5200020000000200000c320002020150045152020c320700070
007000707070705050005000800000008000707070b17070707070707070007020a300202020200095505050c3f020205050a300c35050202020b30020000020
7090f00090909090909000009090707020b12020002020000000000020c30000000095000000c300002000000020000000200020450000000000200020700000
007000701570708050505050008080800080707070b170e500009090007000702000000020200000505050000020205000000000000000502020000020550020
709000c390909090909090909000c37020002000000000062000202020002095002006002000002000710000002000c30071002000c300240045200020707070
707000700070707080505050500000008070700000000000000090900070007020200000000000005050d40000205000000000f000000000502000c320200020
70909090909000009090909070f000702000000000202000000000000000202500000000c3000000007100060020000000200000000000000000000020700095
00700070007000707080800000008080707000e50000009090009090005100702020200000a300a3505000002020500000f0000000f000005020200000200020
709090909090f0009090909000000070202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020700025
00700070009500257070708080807070703500000000c39090009090007000703030202000000050505000002050c3000000000000000000a350200000200020
70909090909090909090909090909070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070700026
152600260025002600707070707070707070000000000090900000e5007070702030742000000050500000a32050000000000000000000000050200000205520
70c300909090909000f00090909000f000e6f500000000000000e6f500000000e6f500000000e6f500000000e6f500000000e6f5000000000000000070250025
26250025252500260070d57070700000007070000000009090009090007070702020000000c3a350509500a32050a30000b50000000000c300502000c3200020
70001570709090900000c390909000000000000000e6f5000000007000007000007000007000007000c370000070000070000070000000707000700070250000
000000009500002500700000007000700070707070517070707070707070157020a30000202000505050000020205000c326000000850000502020002020c320
7000f070707090909090909090707070707070707070707070000070000070000070000070000070000070008570000070000070000070707000700070259500
26259525250095260070857000000070007021707031707011707041707051702020002020f000a35050c40050205000000000f0c30000005020000020550020
7000007070909090909090909070707000950000000000d6f500000000e6f5000000000070000070000070000070000070000070007070700000700070262500
0025262500002525007000707070007000700000d5c3000000000000000000702020000015200000505050505020205000000000000000502020000020000020
7090909090900000909090909090907000250025002600707070707070707070707070d6f5000000000070000070000070c3007000d6f5000095700000002600
0000950000002600957000700000007000b1950000000000d50000000000c37020a300a30000000050505050505020205050a300005050202000c30020000020
70909090909000f0909070709090907000000000000000210000000000000000000000707070707070d6f50000c300e6f50000000000000000267070b5002695
952525259595260025700070007070700070250000808080808080707000007020a30020c3000000a35050505050502020205050502020200400002020200020
70909090709090909090707090909070c300000500c3007000009500009500009500c37000007000007070707070707070707070000000000000707025002525
2525002625252500257000000070157085510000008000000000000070000070202020202020202000a350505050505050202050202020202020000020550020
70909070707090909090909090909070000000000000007000002500002500002500007000000000007000000000000000007070707070707070707025950095
009595950000959525700070007000707070700000700000000000008095007070205020202020200000000050505050202050505000d4a31520000000000020
7090909070909090909090909000c3110000000000950070000000c300950000000000700070e5700071007000e5000070007000000000000000007025252525
2525252525252525257000700000007015707000007070808080808080d500507020000000c3002020002000c400002020f0005050500000f020202071202020
70f0009090900000909090909000f07000250025002500700000d50000250000d500007000000000007000000000700070007000707000007070007070707070
70707070707070707070007070707070007070000000000000d50000c300b5505100c395009500303000c30000f0002020a30050505050505020200000002020
700000909090f00090909090909090700000000000000070000000000000000000c30031000070000070000014000000700041000000000000d500d500d50000
0000000000850000000000000000000085707000000000000000000000002550702015251525152020200000202000c42020a300500000d35050200015002020
70707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070
707070707070707070707070707070707070707070707070707070707070707070202020202020202020202020202020202020f062a3a0006262202020202020
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
888888888888888888888888888888888888888888888888888888888888888888888888888888888882282288882288228882228228888888ff888888228888
888882888888888ff8ff8ff88888888888888888888888888888888888888888888888888888888888228882288822222288822282288888ff8f888888222888
88888288828888888888888888888888888888888888888888888888888888888888888888888888882288822888282282888222888888ff888f888888288888
888882888282888ff8ff8ff888888888888888888888888888888888888888888888888888888888882288822888222222888888222888ff888f888822288888
8888828282828888888888888888888888888888888888888888888888888888888888888888888888228882288882222888822822288888ff8f888222288888
888882828282888ff8ff8ff8888888888888888888888888888888888888888888888888888888888882282288888288288882282228888888ff888222888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555550000000000005555555555555555555555555555550000000000005500000000000055555555555
555555e555566656665555e555555555555566566656655550666060000005555555555556555566556656665550666066600005506660666000055555555555
55555ee555565555565555ee55555555555655565656565550606060000005555555555556555656565656565550606060600005506060606000055555555555
5555eee555566655665555eee5555555555666566656565550606066600005555555555556555656565656665550606060600005506060606000055555555555
55555ee555555655565555ee55555555555556565556565550606060600005555555555556555656565656555550606060600005506060606000055555555555
555555e555566656665555e555555555555665565556665550666066600005555555555556665665566556555550666066600005506660666000055555555555
55555555555555555555555555555555555555555555555550000000000005555555555555555555555555555550000000000005500000000000055555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
5555555555555555556666657777756666656666655555666666665666666665666666665bbbbbbbb56666666656666666656666666656666666655555555555
5555566556656665556556657555756555656565655555666776665666667665666666775bb77777b56666777656676666656676667656667766655555dd5555
5555656565555655556656657775756665656565655555667667665666776765666677675bb7bbb7b5666676765676766665767676765667777665555d55d555
5555656565555655556656657555756655656555655555676666765677666765667766675bb7bbb7b5666676765766676765777777775677667765555d55d555
5555656565555655556656657577756665656665655555766666675766666675776666675777bbb7757777767757666776756767676757766667755555dd5555
5555665556655655556555657555756555656665655555666666665666666665666666665bbbbbbbb56666666656666666656766666756666666655555555555
55555555555555555566666577777566666566666555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555005005005005005dd500566555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555565655665655555005005005005005dd56656655555dddddddd5777777775dddddddd5dddddddd5dddddddd5dddddddd5dddddddd5dddddddd55555555555
5555656565656555550050050050050057756656655555dddddddd5755777775dd5dd5dd5ddd55ddd5ddddd5dd5dd5ddddd5dddddddd5dddddddd55555555555
5555656565656555550050050050056657756656655555dddddddd5755577775d55d55dd5dddddddd5dddd55dd5dd55dddd55d5d5d5d5d55dd55d55555555555
5555666565656555550050050056656657756656655555ddd55ddd5777755575dd55d55d5d5d55d5d5ddd555dd5dd555ddd55d5d5d5d5d55dd55d55555555555
5555565566556665550050056656656657756656655555dddddddd5777775575dd5dd5dd5d5d55d5d5dd5555dd5dd5555dd5dddddddd5dddddddd55555555555
5555555555555555550056656656656657756656655555dddddddd5777777775dddddddd5dddddddd5dddddddd5dddddddd5dddddddd5dddddddd55555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500770000066600eee00ccc0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
5550700000000060000e00c000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
555070000000666000ee00ccc0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
5550707000006000000e0000c0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600eee00ccc000d000550010001000100001000010000100055001000100010000100001000010005500100010001000010000100001000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500100010001000010000100001000550010001000100001000010000100055001000100010000100001000010005500100010001000010000100001000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55501111111111111111111111aaaaa0550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55501771111166611eee11ccc1aaaaa0550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
5550711111111161111e11c111aaaaa0550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
555071111111166111ee11ccc1aaaaa0550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
5550711111111161111e1111c1aaaaa0550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55501771111166611eee11ccc1aadaa0550010001000100001000010000100055001000100010000100001000010005500100010001000010000100001000555
55501111111111111111111111aaaaa0550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600eee00ccc0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
5550700000000060000e00c000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
555077000000666000ee00ccc0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
5550700000006000000e0000c0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600eee00ccc000d000550010001000100001000010000100055001000100010000100001000010005500100010001000010000100001000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500100010001000010000100001000550010001000100001000010000100055001000100010000100001000010005500100010001000010000100001000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500770000066600e0000c0c0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507000000000600e0000c0c0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507000000066600eee00ccc0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507070000060000e0e0000c0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600eee0000c000d000550010001000100001000010000100055001000100010000100001000010005500100010001000010000100001000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500770000066600e0000ccc0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507000000000600e0000c000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507000000066600eee00ccc0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507070000060000e0e0000c0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600eee00ccc000d000550010001000100001000010000100055001000100010000100001000010005500100010001000010000100001000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600e0000c000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507070000000600e0000c000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507700000066600eee00ccc0000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507070000060000e0e00c0c0000100550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600eee00ccc0001710550010001000100001000010000100055001000100010000100001000010005500100010001000010000100001000555
55500000000000000000000000001771550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000001777150000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55555555555555555555555555551777715555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555551771155555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555117155555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
5555dd555dd5ddd5ddd555555ddd5d5d5ddd5ddd555555dd55ddd5ddd5d5d5dd55ddd5555ddd5ddd5d5d5ddd5ddd5ddd5555dd55ddd5ddd5ddd5ddd5dd555555
5555d5d5d5d55d5555d555555d5d5d5d555d555d555555d5d5d5555d55d5d5d5d5d555555d5d5d555d5d5d555d5d5d5d5555d5d5d5d5ddd5d5d5d555d5d55555
5555d5d5d5d55d555d5555555dd55d5d55d555d5555555d5d5dd555d55d5d5d5d5dd55555dd55dd55d5d5dd55dd55dd55555d5d5ddd5d5d5ddd5dd55d5d55555
5555d5d5d5d55d55d55555555d5d5d5d5d555d55555555d5d5d5555d55d5d5d5d5d555555d5d5d555ddd5d555d5d5d5d5555d5d5d5d5d5d5d555d555d5d55555
5555d5d5dd55ddd5ddd555555ddd55dd5ddd5ddd555555ddd5ddd55d555dd5d5d5ddd5555d5d5ddd55d55ddd5d5d5ddd5555ddd5d5d5d5d5d555ddd5d5d55555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55551111111111111115555551111111111111115555551111111111111111111111155551111111111111111111111155551111111111111111111111155555
555511111111eeeeee15555551dddddd111111115555551dddddd111111111111111155551dddddd111111111111111155551dddddd111111111111111155555
555511111111eeeeee15555551dddddd111111115555551dddddd111111111111111155551dddddd111111111111111155551dddddd111111111111111155555
555511111111eeeeee15555551dddddd111111115555551dddddd111111111111111155551dddddd111111111111111155551dddddd111111111111111155555
55551111111111111115555551111111111111115555551111111111111111111111155551111111111111111111111155551111111111111111111111155555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
000303030011010300000105050300070007070707070005000d000100070300000000000000010000004000000040400000000100004000004000090000090080808000000000008000000000808080800400000000000000000000800000000000000000000000000000008003010000000000800000800000000080000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020d020202020d0202020d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d020202020202020202020202020202060606020202020202020202020206060602020202020202020202
02000002030200003c0202023d5905050000005900003a003c0000005902020000004800003c02020254003b00000000000000000202004802023a3a0d0000440003003a0003004400000d005700000d0c0c0c0c0c0d0202000000020202020000000202020202050505053a3c000a003c000a000e0e0e000a0200000a000202
025102020000090900000002023a05003c510000000000005900003a020200003b00000000000000020000004800000202000000000000020200003d0d570000000d3d00460d510057000d570000000d3d0000003c0d02000049003c0002004900000002020202020205050505003a000a00003a0505053a00000a0000533e03
0202025300000009000000530202055900003d0000000000003d00020200003c0002020202510000003b00000000000002024800020202020000003a0d000000000d46003a0d000000000d000000000d3a005700001700000000000000000000000000020200003c0202000505050a00003a0a0d0d1b0d0d0a00003a0a0d3a02
020200000009000900090000000205053a000000593c02023b020202000002000048020002020000000202020200000000020202023a000000023a000d0d160d0c0d0b0b0b0d0d1d0d0c0d0d1d0d0c0d000000000017003c0200000049000000003b0002000000003c00000000050500003c000d0051000d0d1b0d1b0d0d5102
02020000090000090000090000020202020202020202023a0000020300020202000002020200000002023c3b00000000000000003c0000003a0202003a3a003a3a3d3a003a3a3d003a3a3a3a003a3a3d00005700000d0202020200000000003c0000000000000002020202003c0505000d0d1b0d0000000000000000000d0d02
023c000900000009003c00090000020505050505050505000a0002030002020200000000000048020200000000020200020200000002003a02020000003c000000000000000000000000000000000000003c0000000d02050505050505050059000000003c00020200480200000505000d00000000000d000d000d000d000d0d
020000090000095309000009000017000502020202020200003d020200480002020248003c0202020000000202020202020202020000000202003a000000000000005700003a3a3a003a3a3d3a3c3a3a000000003a05050505050505050505050505000000000002023c02023b0e0e001300000d00000000000000005700000d
020000090000000000000009003c02000502020202020202020202020200000000020202020200003c02020202543c0200000202020202023a00020200003a0000000000450d0c0d1d0d0d0c0d160d0d3a0000000505050505053a0005050505050505050000000002030200000505000d00000000000d000d000d000d000d0d
0202000009003c000000090909020200050500000f0202020202540002023c00000000005402000002020200000000003b00003c540202020202020202020202003d000d0d0d000000000d000000000d0d000005050505000000004a0000003a05050505053a0000003b00003a0505000d0d1b0d0000000000000000000d0d02
02020000000909090909090909020200000505000f02020000000002020202020000020000000002023c00000000003c00003b0000000002020200540202020202000017510d004400570d000057000d3d003a05050500004900000000000000000005050505050049000000050500000f0f000d0051000d0d1b1d1b0d0d0202
02020253000009090900005302020251000505001b1b470002020000471713000000000002000202000000020202020202020000000000003c00000000000202023d000d0d0d000000000d000000000d0d44050505000000000000490002000000003a050505050500000005050000000000000d0d1b0d0d0d0000000d020202
02020202000000000000000202020200000505020202020002000002020202020202020000000202003b020241003b0040020202020202020200000002003c0202003a003d0d0d0d0c0d0d0d0d0c0d0d3a0005053a00000000020000000000003b00000000050505050505050000003c003a050505053a0f0d005e000d000202
02090902020200003c020202090902050505020200000202020000000202020202020200000202003c00030000005a000000004251000202000000020200000202000000003a3a3d003a00003d00003a0005050500000000000000000000000000000000000005050505053a3c00000000050505053a00000d0d1b0d0d000202
020051000902020002020900510002020202020000000002000002020200020002001b510202540000020200020000005a0000000202020000410002003b0002023d3a00000000000000000000000000000505000049003b0000003a0000003a000000000000003a05050505050505050505050500000000000d000d00000002
0200000000020900090200000000020500003c004700000000000000023c00000000020202003b0000024200005a00003b000202023c3b000000020200003c0202140d0b0b0b0b0b0b0b0b0b021702020205050000003a0505050505050505053a0000000049000000050505050505050505050000000000003c00003c000202
020505000002090009020000050502003b020202020202020202000202000002000002023c0000000002003b000002004102020000000202020202000000020202000d460000003c3b3a003d02000202020505053a0505050505050505050505050000000000000000000000003a000002000200020002000200020002020202
020505050502093c090205050505020000000000000000000000003c00000000003c0202003b0200000202004000000002020000000202000000003c02020202023a0000003d00000000463a020902024c00050505050505050505050505050505053a0000000000000000000000000000000000003c00000002020202020202
020000050502021102020505003c0200020202020202020202021702020000000000020200000200005402020202020202000000000200003b0000020254000002023b003a0045573d463a00020902023a0000050505050505050505050505000505050000000000000000000002020202020202020202020202020202020202
020200000000000000000000000202000002000000003c0000000047020000020000020200000202003c00003b0000000000000002023b000002020200000000020202513c02020202020202020902514b0000050505050505050505053b00000005050505000002000200020002000200000f000000090909090909093c0002
02020c02000000003c0000020c02000000020002020202020202170202000000000002023b00000200000000003b3b00003c000202003c000054000000000200003c0202020202020202020202090202000000050505050505050505053a00000005050505050000000000000000001700000000090909090909090000000002
02513c020202000000020202000000003c02000200000000000000000000000000000202003c00020200003b00000202020202020000003b0000003c0002020200000202023c0000003b000202090202020000053a000505004e000505053a50000505050505050000020002000200020000090909090909090000000f000002
020200000002000000020002000303030017001700020202020217020200000200000202000041000202020202020200003b00000002000202020000000202000002020200000202020002020209020200003a050049050500000000050505050505050505050505000000003a02020202020202020202020202020202020002
0202003c003b00000009000000030f0300020002003c00000047000002000000000002020200000000003c540202000000000000020200000002023c00003b003c00000000000000005851020000024b000000053a050500004b00003a0505050505050505020205050500000000000f02025102510251025102550000003c02
020200603b3b3c000009000f0003030300020002020202020202020002420200024202000202003b0000000202003c3b000000000000003c000002020000000202020200020202000202020200000202000000050505054e00000000000000500005050505020202050505000002000f020242025a0240024102000047020002
023c003c003b0000000900003c00000000020000000000000000000002020200020202000002020000003b020000000002020202020200000000540200000202020202020200020202000000000f020000003b05050505004f4e000000000000003a050505050202020505050000003a02020002000200020002000200000002
020f02020202023c02020202020202020202020202023c3c3b02020002020200020202020202021717170202000000020200000000020200003b00020002020251020202000000000000024a00020200000000050505053a003b0000505100004e00000505050502020505050502000002020002000200020000000000000002
02580260170002000200000000000200000000000000003b3b3b000000000200000000000000000000000200000000025400003c0000020000000002000202000000020200020202020202020202000000000005050505050000000000000000004e000505050505050505050505053a0202000200020000003c020202020002
02170202020017000200020f02000200020002003c0202020202020200000200020000000200000002000200513b0002003b000000410000000002020002020203020202000251000000480202024b0000003a050505050500004e000000004a004f000505050505050505050502050502020002003c00020002020047020202
020017000200020202000247020002000047000002020200000002020200020000000000000000000000020000480002000200020000020000020202000202020302020212020202170202020202020000000505050202055900004a00004b003a003a0505050505050505050505000002020505000200000002000000000202
023c0200020017000000021702000200020000020200003a000000000202020002000000020000000200020200000202510000020200000002023c00000000003c0000000000000000000000000000000000050502020205053a3a00004e000000050505050505050505050505023a000202000505050500003b000002005102
02000200020002020202020017000200000002020000000005050000000202000000005a0202110202020202020202020202020202020202020200000000000000000000000000020202020202020202000005050202050505050505050505050505050505050505050505050500000002023c00000005050505020202020202
__sfx__
0f0f800004b2404b1402b0404b043ea043ea633ca633aa533aa533aa4338a3336a3334a2332a1330a032c22620125101740a154081440612404114001043e0733e0633c0533a0533804338043380333603336033
001000010912000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
001000010b12000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
001000010c12000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
001000010e12000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
001000011012000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
001000011112015100151001510015100151001510015100151001510015100151001510015100151001510015100151001510015100151001510015100151001510015100151001510015100151001510015100
001000010712018100181001810018100181001810018100181001810018100181001810018100181001810018100181001810018100181001810018100181001810018100181001810018100181001810018100
001000010a1201c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c1001c10000100
000800000c0730c0000015300000246153c400000000c0000c07300000001530c0000c01300100001000c0000c073000000015300000246150c0000c000000000c0730c00000153000000c013001000c01300000
001000000c0730c0000015300000246153c40000153001530c07300000001530c0000c01300100001000c0000c073000000015300000246150c00000153000000c0730c00000153000000c013001000c01300000
0008000018120181201812018100181201812018120181001812018120181201810018100181001810018100181201812018120181001c1201c1201c1201c1221c1221c1221c1221810021120211202112018100
000800001d1201d1201d1201d1221d1221d1221d122001001a1001a1001a100001001a1201a1201a120001001a1201a1201a120001001d1201d1201d120001002312023120231200010000100001000010000100
00080000231202312023120001001f1201f1201f1201f1221f1221f1221f12200100001000010000100001001a1201a1201a120001001a1201a1201a12000100001000010000100001001b1201b1201b12000100
000800001812018120181201812218122181221812200100131201312013120001001312013120131200010014120141201412014122141220010216120161201612016122161220010014120141201412000100
000800000010000100001000010018120181201812000100181201812018120001001c1201c1201c120001001c1201c1201c12000100181201812018120181221812218122181220010000100001000010000100
000c00101874300500116550000011635000000000000000116250000018773000001166500000116350000000000187530000000000116550000000000000000000018753000000000011655000000000000000
001800100207002060000000505005060030700306000000050500706005070070600505000000030700000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00002d82000800008002483000800278402d820008002b820008002d8200080027830008002d8200080000800008002d8200080024840008002b820008002d81000800278302b82000800248400080000800
0008000017120171201712017122171221712217122001001c1201c1201c120001001c1201c1201c12000100001000010000100001001f1201f1201f120001002312023120231202312223122231222312200100
0008000022120221202212022122221222212222122001001d1201d1201d1201d1221d122001000010000100221202212022120001001f1201f1201f120001001d1201d1201d120001001a1201a1201a12000100
010800001812018120181201812218122181221812200100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
0108000018120181201812000100181201812018120001001812018120181200010000100001000010000100181201812018120001001c1201c1201c120001002112021120211200010018120181201812000100
010800001a1201a1201a1201a1221a1221a1221a12200100001000010000100001001d1201d1201d120001001d1201d1201d12000100201202012020120001001f1201f1201f120001001d1201d1201d12000100
010800001a1201a1201a120001001c1201c1201c1201c1221c1221c1221c122001001d1201d1201d12000100001000010000100001001a1201a1201a120001001812018120181200010015120151201512000100
010800001312013120131200010010120101201012000100131201312013120001001812018120181200010018120181201812018122181221812218122001001612016120161200010000100001000010000100
010800000010000100001000010018120181201812000100181201812018120001001c1201c1201c120001001c1201c1201c12000100181201812018120181221812218122181220010000100001000010000100
0108000022120221202212022122221222212222122001001d1201d1201d1201d1221d122001000010000100221202212022120001001f1201f1201f120001001a1201a1201a1200010015120151201512000100
010800001c1201c1201c120001001c1201c1201c120001001c1201c1201c1200010000100001000010000100211202112021120001001c1201c1201c12000100181201812018120001001a1201a1201a12000100
010800001d1201d1201d1201d1221d1221d1221d12200100001000010000100001001a1201a1201a120001001a1201a1201a120001001d1201d1201d120001002212022120221200010000100001000010000100
01080000221202212022120001001f1201f1201f1201f1221f1221f1221f12200100001000010000100001001a1201a1201a120001001a1201a1201a12000100001000010000100001001b1201b1201b12000100
010800001c1201c1201c1201c1221c1221c1221c12200100181201812018120001001812018120181200010000100001000010000100131201312013120001001412014120141200010015120151201512000100
010800000010000100001000010015120151201512000100181201812018120001001c1201c1201c120001001c1201c1201c12000100181201812018120181221812218122181220010000100001000010000100
010800001812018120181201812218122181221812200100131201312013120001001312013120131200010014120141201412014122141220010016120161201612016122161220010019120191201912000100
010800001a1201a1201a12000100001000010000100001001a1201a1201a1201a1221a1221a1221a122001000010000100001000010000100001000010000100001000010000100001001a1201a1201a12000100
0108000016120161201612000100001000010000100001001d1201d1201d1201d1221d1221d1221d1220010000100001000010000100001000010000100001001d1201d1201d1200010000100001000010000100
010800001d1201d1201d120001001f1201f1201f120001002112021120211202112221122211222112200100001000010000100001001f1201f1201f120001001a1201a1201a1200010015120151201512000100
010800001312013120131200010010120101201012000100131201312013120001000010000100001000010018120181201812000100001000010000100001000010000100001000010016120161201612000100
01080000171201712017120001000010000100001000010017120171201712017122171221712217122001000010000100001000010000100001000010000100001000010000100001001a1201a1201a12000100
010800001c1201c1201c120001001c1201c1201c12000100211202112021120001000010000100001000010024120241202412000100001000010000100001000010000100001000010000100001000010000100
0108000023120231202312000100211202112021120001001c1201c1201c1200010018120181201812000100211202112021120001001f1201f1201f120001001a1201a1201a1200010015120151201512000100
00080000211202112021120001001d1201d1201d120001001a1201a1201a12000100161201612016120001001f1201f1201f120001001a1201a1201a120001001612016120161200010013120131201312000100
080800000c073000000000000000246050000000000000000c0630000000000000000c0330000000000000000c073000000000000000246050000000000000000c0630000000000000000c073000000c02300000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01040000003500043000300003500043000300003000030000300003000030000300003000030000300003000d300093000030004300043000030000300003000000000000000000000000000000000000000000
0003000014376173761c3762037625366273662c3662f35614356173561c3562035625346273462c3462f33614336173361c3362033625326273262c3262f31614326173261c3262032625316273162c3162f306
020300003f6733d66338653346532f633286332062311613316632d65326643186330d623036131c6331162300613126030960300603096030960300003000030000300003000030000300003000030000300003
000500003707037041370213701137001370113700137011370010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001
000800000b36018341313212430027300313003d30000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
02060000183201c3101f3301f6401f650236602833128310006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e2000001885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 10515244
01 10114344
00 10114344
00 12424344
00 10111244
00 10111244
00 11124344
02 11424344
00 41424344
00 41424344
01 0b01032a
00 0c02042a
00 0d07082a
00 0e03052a
00 0f01032a
00 1302042a
00 1407082a
00 1503052a
00 16010309
00 17020409
00 18040709
00 19030509
00 0f010309
00 13020409
00 1b040709
00 15070809
00 1c01030a
00 1d04070a
00 1e07080a
00 1f03050a
00 2001030a
00 1302040a
00 1407082a
00 2103050a
00 2202042a
00 2307082a
00 2404072a
00 2503052a
00 2602042a
00 2701032a
00 2804072a
02 2907082a

