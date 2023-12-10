pico-8 cartridge // http://www.pico-8.com
version 41
__lua__


function _init()
	grid.init()
	spawn(grid)


	test = {1,1,2,2}
	shifted = shift(test)[1]
	for i=1,4,1 do
		//print(shifted[i])
	end
end


function _update()
	grid.update()
end

function _draw()
	grid.draw()
end
-->8
grid = {}

grid.blamk = {
{0,0,0,0},
{0,0,0,0},
{0,0,0,0},
{0,0,0,0}
}

grid.table = {
{0,0,0,0},
{0,0,0,0},
{0,0,0,0},
{0,0,0,0}
}

grid.new = {
{0,0,0,0},
{0,0,0,0},
{0,0,0,0},
{0,0,0,0}
}


grid.speed = {
{0,0,0,0},
{0,0,0,0},
{0,0,0,0},
{0,0,0,0}
}



tile_size = 10
grid_thickness = 2
play_dimension = tile_size*4 +
 grid_thickness*5

left_edge = flr((128 - play_dimension)/2)
top_edge = flr((128 - play_dimension)/2)

grid.init = function(self)
	print("grid init")
	print(grid.table[1][1])
	print(grid.table[4][4])
	spawn(grid)
	spawn(grid)
end

grid.update = function(self)
	if btn(0) then
		print("shift left")
		debug_draw(grid.table)
		shift_left(grid)
		debug_draw(grid.table)
		
	elseif btn(1) then
		print("shift right")
		debug_draw(grid.table)
		shift_right(grid)
		debug_draw(grid.table)
		
	elseif btn(2) then
		print("shift up")
		debug_draw(grid.table)
		shift_up(grid)
		debug_draw(grid.table)
		
	elseif btn(3) then
		print("shift down")
		debug_draw(grid.table)
		shift_down(grid)
		debug_draw(grid.table)
	end
	
	if(btn(0)
		or btn(1)
		or btn(2)
		or btn(3)) then
		spawn(grid)
	end
end


function spawn(grid)
	level = 1 + flr(rnd(2))
	empty_loc = false
	while not empty_loc do
		x_loc = 1 + flr(rnd(4))
		y_loc = 1 + flr(rnd(4))
		if grid.table[y_loc][x_loc] == 0 then
			empty_loc = true
		end
	end
		
	grid.table[y_loc][x_loc] = level
end

function shift_left(grid)
	print("shift_left")
	shift_left(grid)
	
end

grid.draw = function(self)
	for y=1,4,1 do
		for x=1,4,1 do
			if grid.table[y][x] != 0 then
				col = grid.table[y][x]
				tile = grid.table[y][x]
				x_pos = left_edge +
				 (x-1) * tile_size +
				 (x-1)*grid_thickness
				y_pos = top_edge +
					(y-1) * tile_size +
					(y-1) * grid_thickness
				rectfill(
				x_pos,
				y_pos,
				x_pos+tile_size,
				y_pos+tile_size,
				col)
			end
		end
	end
end

function debug_draw(array)
	for y=1,4,1 do
		print(
			array[y][1]..
			array[y][2]..
			array[y][3]..
			array[y][4])
	end
end

function grid_copy(from, to)
	if type(from) == 'table' and type(to) == 'table' then
		for y=1,4,1 do
			for x=1,4,1 do
				to[y][x] = from[y][x]
			end
		end
	end
end
-->8
function shift_left(grid)
	grid_copy(grid.blank,grid.speed)
	for y = 1,4,1 do
	
		strip = {}
		for x = 1,4,1 do
			add(strip,grid.table[y][x])
		end
		
		res = shift(strip)
		shifted = res[1]
		speed = res[2]
		
		for x = 1,4,1 do
			//print(shifted[x])
			index = x
			grid.new[y][x] = shifted[index]
			grid.speed[y][x] = speed[index]
		end
		
	end
	//debug_draw(grid.new)
	
	grid_copy(grid.new, grid.table)
	grid_copy(grid.blank, grid.new)
end
		
function shift_right(grid)
	grid_copy(grid.blank,grid.speed)

	for y = 1,4,1 do
	
		strip = {}
		for x = 1,4,1 do
			add(strip,grid.table[y][x])
		end
		
		res = shift(strip)
		shifted = res[1]
		speed = res[2]
		
		for x = 1,4,1 do
			index = 5-x
			grid.new[y][x] = shifted[index]
			grid.speed[y][x] = speed[index]
		end
		
		
	end
	grid_copy(grid.new, grid.table)
	grid_copy(grid.blank, grid.new)
end

		
function shift_up(grid)
	grid_copy(grid.blank,grid.speed)


	for x = 1,4,1 do
	
		strip = {}
		for y = 1,4,1 do
			add(strip,grid.table[y][x])
		end
		
		res = shift(strip)
		shifted = res[1]
		speed = res[2]
		
		for y = 1,4,1 do
			index = y
			grid.new[y][x] = shifted[index]
			grid.speed[y][x] = speed[index]
		end
		
	end
	grid_copy(grid.new, grid.table)
	grid_copy(grid.blank, grid.new)
end
		

function shift_down(grid)
	grid_copy(grid.blank,grid.speed)

	for x = 1,4,1 do
	
		strip = {}
		for y = 4,1,-1 do
			add(strip,grid.table[y][x])
		end
		
		res = shift(strip)
		shifted = res[1]
		speed = res[2]
		
		for y = 4,1,-1 do
			index = 5-y
			grid.new[y][x] = shifted[index]
			grid.speed[y][x] = speed[index]
		end
		
	end
	grid_copy(grid.new, grid.table)
	grid_copy(grid.blank, grid.new)
end
		
-->8
function shift(strip)
	shifted = {}
	speed = {}
	buffer = 0
	
	for i=1,4,1 do 
		//print(strip[i])
	end
	
	
	for i=1,4,1 do
	
		val = strip[i]
		if (buffer == 0 and val != 0)
			then
			buffer = val
			//add(speed, i-count(shifted))
			
		else
			if val == 0 then
				//add(speed,0)
			elseif val == buffer then
				add(shifted, buffer+1)
				buffer = 0
				add(speed,i - 
					count(shifted)+1)
			else
				add(shifted, buffer)
				buffer = val
				add(speed, i -
					count(shifted)+1)
			end
		end
	end
	
	if buffer != 0 then
		add(shifted,buffer)
	end
	while count(shifted) < 4 do
		add(shifted,0)
	end
	
	return {shifted, speed}
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
