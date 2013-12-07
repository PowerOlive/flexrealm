-- flexrealm 0.1.5 by paramat
-- For latest stable Minetest and back to 0.4.8
-- Depends default
-- Licenses: code WTFPL, textures CC BY-SA

-- Variables

local XMIN = -33000 -- Approximate limits
local XMAX = 33000
local YMIN = -32
local YMAX = 33000
local ZMIN = -33000
local ZMAX = 33000

local GFAC = 10 --  -- Density gradient factor (noise4 multiplier). Reduce for higher hills

-- Large scale density field grad = noise4 * GFAC
local ICET = 0.05 --  -- Ice density threshold
local SANT = -0.05 --  -- Beach top density threshold
local SANR = -0.02 --  -- Beach top density threshold randomness
local ALIT = -0.05 --  -- Airlike water barrier nodes density threshold
local ROCK = -0.4 --  -- Rocky terrain density threshold
local CLLT = -1 --  -- Cloud low density threshold
local CLHT = -0.995 --  -- Cloud high density threshold

-- Terrain density field
local DEPT = 1 --  -- Realm depth density threshold
local SSLT1 = 0.20 --  -- Sandstone strata low density threshold1
local SSHT1 = 0.25 --  -- Sandstone strata high density threshold1
local SSLT2 = 0.30 --  -- Sandstone strata low density threshold2
local SSHT2 = 0.40 --  -- Sandstone strata high density threshold2
local STOT = 0.10 --  -- Stone density threshold at sea level
local DIRT = 0.05 --  -- Dirt density threshold
local TRET = 0.005 --  -- Tree growth density threshold, links tree density to soil depth
local LELT = -0.2 --  -- LEAN (Light Emitting Airlike Node) low density threshold
local LEHT = -0.16 --  -- LEAN high density threshold

-- Noise3
local FITS = 0 --  -- Fissure threshold at surface. Controls size of fissures and amount / size of fissure entrances at surface
local FEXP = 0.1 --  -- Fissure expansion rate under surface

local OCHA = 7*7*7 --  -- Ore 1/x chance per stone node

-- Noise2
local DEST = 0.4 --  -- Desert threshold
local TAIT = -0.4 --  -- Taiga threshold
local BIOR = 0.05 --  -- Biome noise randomness for blend dithering

local TCHA = 49 --  -- Tree maximum 1/x chance per grass or snowblock

local LINT = 23 --  -- LEAN abm interval
local LCHA = 16*16 --  -- LEAN abm 1/x chance

-- Noise parameters

-- 3D noise 1 for terrain

local np_terrain = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 92,
	octaves = 6,
	persist = 0.6
}

-- 3D noise 5 for terrain alt

local np_alter = {
	offset = 0,
	scale = 1,
	spread = {x=207, y=207, z=207},
	seed = -3911,
	octaves = 6,
	persist = 0.6
}

-- 3D noise 7 for smooth terrain

local np_smooth = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 800911,
	octaves = 4,
	persist = 0.3
}

-- 3D noise 8 for terrain blend

local np_terblen = {
	offset = 0,
	scale = 1,
	spread = {x=414, y=414, z=414},
	seed = -440002,
	octaves = 1,
	persist = 0.5
}

-- 3D noise 6 for faults

local np_fault = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 14440002,
	octaves = 4,
	persist = 0.5
}

-- 3D noise 2 for biomes

local np_biome = {
	offset = 0,
	scale = 1,
	spread = {x=250, y=250, z=250},
	seed = 9130,
	octaves = 3,
	persist = 0.5
}

-- 3D noise 3 for fissures

local np_fissure = {
	offset = 0,
	scale = 1,
	spread = {x=64, y=64, z=64},
	seed = 186000048881,
	octaves = 4,
	persist = 0.5
}

-- 3D noise 4 for large scale density gradient

local np_dengrad = {
	offset = 0,
	scale = 1,
	spread = {x=828, y=828, z=828},
	seed = 80000002222208,
	octaves = 3,
	persist = 0.3
}

-- Stuff

flexrealm = {}

dofile(minetest.get_modpath("flexrealm").."/nodes.lua")
dofile(minetest.get_modpath("flexrealm").."/functions.lua")

-- Abm

minetest.register_abm({
	nodenames = {"flexrealm:leanoff"},
	interval = LINT,
	chance = LCHA,
	action = function(pos, node)
		minetest.add_node(pos,{name="flexrealm:lean"})
	end,
})

-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.x < XMIN or maxp.x > XMAX
	or minp.y < YMIN or maxp.y > YMAX
	or minp.z < ZMIN or maxp.z > ZMAX then
		return
	end
	
	local t1 = os.clock()
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	print ("[flexrealm] chunk minp ("..x0.." "..y0.." "..z0..")")
	local sidelen = x1 - x0 + 1 -- chunk side length
	local vplanarea = sidelen ^ 2 -- vertical plane area, used if calculating noise index from x y z
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minpos = {x=x0, y=y0, z=z0}
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	
	local c_air = minetest.get_content_id("air")
	local c_meseblock = minetest.get_content_id("default:mese_block")
	local c_stodiam = minetest.get_content_id("default:stone_with_diamond")
	local c_stogold = minetest.get_content_id("default:stone_with_gold")
	local c_stocopp = minetest.get_content_id("default:stone_with_copper")
	local c_stoiron = minetest.get_content_id("default:stone_with_iron")
	local c_stocoal = minetest.get_content_id("default:stone_with_coal")
	local c_cactus = minetest.get_content_id("default:cactus")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_watsource = minetest.get_content_id("default:water_source")
	local c_apple = minetest.get_content_id("default:apple")
	local c_leaves = minetest.get_content_id("default:leaves")
	local c_tree = minetest.get_content_id("default:tree")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	local c_ice = minetest.get_content_id("default:ice")
	local c_sastone = minetest.get_content_id("default:sandstone")
	local c_needles = minetest.get_content_id("default:needles")
	
	local c_flrairlike = minetest.get_content_id("flexrealm:airlike")
	local c_flrgrass = minetest.get_content_id("flexrealm:grass")
	local c_flrsand = minetest.get_content_id("flexrealm:sand")
	local c_flrdesand = minetest.get_content_id("flexrealm:desand")
	local c_flrstone = minetest.get_content_id("flexrealm:stone")
	local c_flrdestone = minetest.get_content_id("flexrealm:destone")
	local c_flrleanoff = minetest.get_content_id("flexrealm:leanoff")
	local c_flrcloud = minetest.get_content_id("flexrealm:cloud")
	local c_flrneedles = minetest.get_content_id("flexrealm:needles")
	
	local nvals1 = minetest.get_perlin_map(np_terrain, chulens):get3dMap_flat(minpos)
	local nvals2 = minetest.get_perlin_map(np_biome, chulens):get3dMap_flat(minpos)
	local nvals3 = minetest.get_perlin_map(np_fissure, chulens):get3dMap_flat(minpos)
	local nvals4 = minetest.get_perlin_map(np_dengrad, chulens):get3dMap_flat(minpos)
	local nvals5 = minetest.get_perlin_map(np_alter, chulens):get3dMap_flat(minpos)
	local nvals6 = minetest.get_perlin_map(np_fault, chulens):get3dMap_flat(minpos)
	local nvals7 = minetest.get_perlin_map(np_smooth, chulens):get3dMap_flat(minpos)
	local nvals8 = minetest.get_perlin_map(np_terblen, chulens):get3dMap_flat(minpos)
	
	local ni = 1
	for z = z0, z1 do
	for y = y0, y1 do
	for x = x0, x1 do -- for each node do
		local vi = area:index(x, y, z) -- LVM index for node
		local nodid = data[vi] -- node
		local nofis = false
		local desert = false
		local forest = false
		local taiga = false
		
		local noise2 = nvals2[ni]
		if noise2 > DEST + (math.random() - 0.5) * BIOR then
			desert = true
		elseif noise2 < TAIT + (math.random() - 0.5) * BIOR then
			taiga = true
		else
			forest = true
		end
		
		local terno -- terrain noise
		local noise6 = nvals6[ni] -- faults
		local terblen = math.min(math.abs(nvals8[ni]) * 2, 1) -- terrain blend with smooth
		if noise6 > 0 then
			terno = (nvals1[ni] + nvals5[ni]) / 2 * (1 - terblen) + nvals7[ni] * terblen
		else
			terno = (nvals1[ni] - nvals5[ni]) / 2 * (1 - terblen) - nvals7[ni] * terblen
		end
		local noise4 = nvals4[ni]
		local grad = noise4 * GFAC -- large scale density field
		--local grad = (208 - y) / 96 -- flat realm for testing, normally disable this line
		local density = terno + grad -- terrain density field
		
		if math.abs(nvals3[ni]) > FITS + density ^ 0.5 * FEXP then -- if no fissure then
			nofis = true
		end
		
		local stot = STOT * (1 - grad / ROCK)
		
		if density >= stot and density <= DEPT and nofis then -- stone cut by fissures
			if (density >= SSLT1 and density <= SSHT1)
			or (density >= SSLT2 and density <= SSHT2) then
				data[vi] = c_sastone
			elseif desert then
				data[vi] = c_flrdestone
			elseif math.random(OCHA) == 2 then
				local osel = math.random(34)
				if osel == 34 then
					data[vi] = c_meseblock -- revenge!
				elseif osel >= 31 then
					data[vi] = c_stodiam
				elseif osel >= 28 then
					data[vi] = c_stogold
				elseif osel >= 19 then
					data[vi] = c_stocopp
				elseif osel >= 10 then
					data[vi] = c_stoiron
				else
					data[vi] = c_stocoal
				end
			else
				data[vi] = c_flrstone
			end
		elseif density > 0 and density < stot then -- fine materials not cut by fissures
			if grad >= SANT + (math.random() - 0.5) * SANR then
				if taiga and density < DIRT and grad <= 0 then -- snowy beach
					data[vi] = c_snowblock
				else
					data[vi] = c_flrsand
				end
			elseif nofis then -- fine materials cut by fissures
				if desert then
					data[vi] = c_flrdesand
				else
					if density >= DIRT then
						data[vi] = c_dirt
					else
						local tree = false
						if math.random(TCHA) == 2 then
							if density <= TRET -- surface node, links trees to soil depth
							-- and noise2 >= -0.8 and noise2 <= 0
							and x-x0 >= 1 and x1 - x >= 1
							and y-y0 >= 1 and y1 - y >= 1
							and z-z0 >= 1 and z1 - z >= 1 then
								tree = true
							end
						end
						if taiga then
							if tree then
								flexrealm_pinetree(x, y, z, ni, nvals4, area, data, c_tree, c_flrneedles, c_snowblock)
							else
								data[vi] = c_snowblock
							end
						else
							if tree then
								flexrealm_appletree(x, y, z, ni, nvals4, area, data, c_tree, c_leaves, c_apple)
							else
								data[vi] = c_flrgrass
							end
						end
					end
				end
			end
		elseif taiga and grad > 0 and grad <= ICET and density < 0 then
			if nodid == c_air then
				data[vi] = c_ice
			end
		elseif grad > 0 and density < 0 then
			if nodid == c_air then
				data[vi] = c_watsource
			end
		elseif grad >= ALIT and grad <= 0 and density < 0 then
			if nodid == c_air then
				data[vi] = c_flrairlike
			end
		elseif not nofis and grad >= ALIT and density > 0 and density < DEPT and math.abs(noise6) < 0.05 then
			data[vi] = c_flrsand -- sand blocking fissures in cliffs below water level
		elseif density >= LELT and density <= LEHT then
			if nodid == c_air then
				data[vi] = c_flrleanoff
			end
		elseif grad >= CLLT and grad <= CLHT and ((density >= -1.1 and density <= -1.05) or (density >= -0.95 and density <= -0.9)) then
			if nodid == c_air then
				data[vi] = c_flrcloud
			end
		end
		ni = ni + 1
	end
	end
	end
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[flexrealm] "..chugent.." ms")
end)