#!/usr/bin/lua
-- generate tiles for brushes and xml
function replaceterr (str, replacearr)
	for k, v in pairs(replacearr) do
		str = replace(str,'%s*('.. (k -1)..')%s*',v);
	end
	return str;
end

function replace (str, patt, new)
	return string.gsub(str,patt,new)
end

function table_find(tabl,needed)
	for k,v in pairs(tabl) do
		for k2, v2 in pairs(tabl[k]) do
			if (v2 == needed) then
				return k, k2;
			end
		end
	end
end

function getNextFreeSpace(tabl, height, width)
	for col =1, width do
		if (tabl[col])then
			for row=1, height do
				if (not tabl[col][row])then
					return col, row, 0;
				end
			end
		else
			tabl[col]={};
			return col, 1, 0;
		end
	end
	return 1, height+1, 1;--last one adds a row to terrains
end

function get(a,b,c,d, e, tabl)
	if(not(a==e))then a='' end
	if(not(b==e))then b='' end
	if(not(c==e))then c='' end
	if(not(d==e))then d='' end
	--print(tabl)
	return table_find(tabl,a..','..b..','..c..','..d);
end

--sf=string.format
--local answer
--io.write("What\'s your name?=>")
--answer = io.read()
--print(sf("OK, your name is %s.",answer))

local firstFile = true;
local tilewidth = 0;
local tileheight = 0;
local tiles = {};
local terrain = {};
local terrainbyname = {};
local height = 0;
local width = 0;

--read all sources

if(#arg >1 ) then
	os.execute("cp "..arg[2]..".png "..arg[1]..".png ");
	for k, v in pairs (arg) do
		if (k > 1) then
			--print(v)
			local terrainreplace = {};
			local name;
			local thiswidth = 0;
			local thisheight = 0;
			--local vertical = (height>width);--muss zeile fuer zeile gemacht werden *mhm*
			if not (k == 2) then
				--print("convert "..arg[1]..".png "..arg[k]..".png +append "..arg[1]..".png");
				os.execute("convert "..arg[1]..".png "..arg[k]..".png +append "..arg[1]..".png");
			end
			for line in io.lines(v..".tsx") do
				if (string.find(line,"<tileset ")) then
					--print(string.match(line,'%s*tilewidth="(%d+)%s*'))
					--print(string.match(line,'%s*tileheight="(%d+)%s*'))
					if(firstFile)then
						tilewidth = string.match(line,'%s*tilewidth="(%d+)%s*');
						tileheight = string.match(line,'%s*tileheight="(%d+)%s*');
						firstFile = false;
					else
						if not (tilewidth == string.match(line,'%s*tilewidth="(%d+)%s*') and tileheight == string.match(line,'%s*tileheight="(%d+)%s*')) then
							print("Error: all tilesets shuld have tiles of the same size");
						end
					end
				end
				if (string.find(line,"<tile ")) then
					--print(string.match(line,'%s*terrain="(%S*),(%S*),(%S*),(%S*)"%s*'))
					--print("col-shift: "..(width/tilewidth))
					local id = string.match(line,'%s*id="(%d+)%s*')
					local col = id%(thiswidth/tilewidth)
					local row = ( id - col ) / (thiswidth/tilewidth)
					--print("col: "..col.."  row: "..row)
					if not tiles[(width/tilewidth) + col+1] then tiles[(width/tilewidth) + col+1] = {} end
					tiles[(width/tilewidth) + col+1][row+1] = replaceterr(string.match(line,'%s*terrain="(%S*)"%s*'),terrainreplace);--id..'('..v..')'..' - '..
					--print(replaceterr(string.match(line,'%s*terrain="(%S*)"%s*'),terrainreplace))

				end
				if (string.find(line,"<image ")) then
					--print()
					--print()
					thiswidth = string.match(line,'%s*width="(%d+)%s*');
					thisheight = string.match(line,'%s*height="(%d+)%s*');
				end
				if (string.find(line,"<terrain ")) then
					--print(line)
					local name = string.match(line,'%s*name="(%S*)"%s*');
					local replaceid = #terrain;
					if(terrainbyname[name])then
						replaceid = terrainbyname[name];
					end
					terrainreplace[#terrainreplace +1] = replaceid;
					local tile = string.match(line,'%s*tile="(%d*)"%s*')
					--print(string.find(line,'%s*tile="(%d+)%s*'));
					local col = tile%(thiswidth/tilewidth)
					local row = ( tile - col ) / (thiswidth/tilewidth)
					--print("col: "..col.."  row: "..row)
					--print(replace(line,'%s*tile="(%d*)"%s*','tile="'..col..','..row..'"'))
					if(not terrainbyname[name])then
						terrainbyname[name] = #terrain +1;
						--table.insert(terrainbyname,name, #terrain);
						terrain[#terrain +1] = {(width/tilewidth) + (col+1),(row+1)};--replace(line,'%s*tile="(%d*)"%s*','tile="'..(col+1)..','..(row+1)..'"');
						--table.insert(terrain,#terrain +1,replace(line,'%s*tile="(%d*)"%s*','tile="'..col..','..row..'"'));
					end
					if not tiles[(height/tileheight) + col+1] then tiles[(height/tileheight) + col+1] = {} end
					tiles[(height/tileheight) + col+1][row+1] = replaceid..','..replaceid..','..','..replaceid..','..','..replaceid..','
				end
			end
			--print(thisheight)
			--print(height)
			if (tonumber(thisheight) > tonumber(height)) then
				height = thisheight;
			end
			width = width + thiswidth;
		end
	end


--check and generate tiles

	for k, v in pairs(terrain) do
		for k2, v2 in pairs(terrain) do
			for k3, v3 in pairs(terrain) do
				for k4, v4 in pairs(terrain) do
					if(not table_find(tiles, (k-1)..","..(k2-1)..","..(k3-1)..","..(k4-1))) then
						local done = {};
						local base = math.min(k,k2,k3,k4) -1;
						done[base] = true;
						local base_col = terrain[base+1][1];
						local base_row = terrain[base+1][2];
						if base_col then
							os.execute('convert '..arg[1]..'.png -crop '..tileheight..'x'..tilewidth..'+'..((base_col-1)*tilewidth)..'+'..((base_row-1)*tileheight)..' '..arg[1]..'_tmp.png')
						end
						local checkthis = {k-1,k2-1,k3-1,k4-1}
						table.sort(checkthis);
						for chk,chv in pairs(checkthis) do
							if(not done[chv])then
								base_col, base_row = get((k-1),(k2-1),(k3-1),(k4-1),chv,tiles);
								if ( not base_col and not base_row) then
									base_col, base_row = get('','',(k3-1),(k4-1),chv,tiles);
									if (base_col and base_row) then
										os.execute('convert '..arg[1]..'.png -crop '..tileheight..'x'..tilewidth..'+'..((base_col-1)*tilewidth)..'+'..((base_row-1)*tileheight)..' '..arg[1]..'_tmp2.png')
										os.execute('composite -geometry +0+0 '..arg[1]..'_tmp2.png '..arg[1]..'_tmp.png '..arg[1]..'_tmp.png')
									else
										print("Error tile " .. (k-1)..","..(k2-1)..","..(k3-1)..","..(k4-1) .. " with "..chv.."-filter can't be generated'")
									end
									base_col, base_row = get((k-1),(k2-1),'','',chv,tiles);
								end
								if (base_col and base_row) then
									os.execute('convert '..arg[1]..'.png -crop '..tileheight..'x'..tilewidth..'+'..((base_col-1)*tilewidth)..'+'..((base_row-1)*tileheight)..' '..arg[1]..'_tmp2.png')
									os.execute('composite -geometry +0+0 '..arg[1]..'_tmp2.png '..arg[1]..'_tmp.png '..arg[1]..'_tmp.png')
									done[v] = true;
								else
									print("Error tile " .. (k-1)..","..(k2-1)..","..(k3-1)..","..(k4-1) .. " with "..chv.."-filter can't be generated'")
								end
							end
						end
						newcol, newrow, extend = getNextFreeSpace(tiles, height/tileheight, width/tilewidth)
						if extend==1 then
							height = height + extend*tileheight;
							os.execute('convert -size '..width..'x'..tileheight..' canvas:none  '..arg[1]..'_empty.png')
							os.execute("convert "..arg[1]..".png "..arg[1].."_empty.png -append "..arg[1]..".png");
						end
						tiles[newcol][newrow]=(k-1)..","..(k2-1)..","..(k3-1)..","..(k4-1);
						newcol = newcol-1;
						newrow = newrow-1;
						os.execute('composite -geometry +'..(newcol*tilewidth)..'+'..(newrow*tileheight)..' '..arg[1]..'_tmp.png '..arg[1]..'.png '..arg[1]..'.png')
					end
				end
			end
		end
	end

--output

	print(' <tileset firstgid="1" name="terrains" tilewidth="'..tilewidth..'" tileheight="'..tileheight..'">');
	print('  <image source="./'..arg[1]..'.png" width="'..width..'" height="'..height..'"/>');
	print('  <terraintypes>');
	for i = 1, #terrain do
		for k,v in pairs(terrainbyname) do
			if v==i then
				print('   <terrain name="'..k..'" tile="'..((terrain[v][2]-1)*(width/tilewidth) + (terrain[v][1]-1))..'"/>');
			end
		end
	end
	print('  </terraintypes>');
	for k, v in pairs (tiles) do
		for k2, v2 in pairs (tiles[k]) do
			print('  <tile id="'..((k2-1)*(width/tilewidth) + k-1)..'" terrain="'..v2..'"/>');
		end
	end
	print(' </tileset>');
	os.execute('rm '..arg[1]..'_tmp.png '..arg[1]..'_tmp2.png  '..arg[1]..'_empty.png');
else
	print ("lol.lua targetfile sourcefile sourcefile …");
end
