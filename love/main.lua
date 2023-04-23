function HSV(h, s, v)
	if s <= 0 then return v,v,v end
	h, s, v = h/256*6, s/255, v/255
	local c = v*s
	local x = (1-math.abs((h%2)-1))*c
	local m,r,g,b = (v-c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return (r+m)*255,(g+m)*255,(b+m)*255
end

function HSL(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h/256*6, s/255, l/255
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return (r+m)*255,(g+m)*255,(b+m)*255,a
end

function invertColor( r, g, b ) 
	return 255 - r, 255 - g, 255 - b
end

function love.load()
	
	local res = 64
	local w = 5632 / res
	local h = 2048 / res
	
	res = 8
	w = 130
	h = 80
	
	
	canvas = love.graphics.newCanvas(5632, 2048)
	
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		love.graphics.setBlendMode("alpha")
		
		local colors = { }
		
		for n = 0, ( w * h ) - 1 do
			local state = math.floor( n / 255 ) * 1
			local i = n % 4
			
			if i == 0 then
				love.graphics.setColor( love.math.colorFromBytes( HSV( n % 255, 255 - state, 255 - state ) ) )
			elseif i == 1 then
				love.graphics.setColor( love.math.colorFromBytes( HSV( (n-64) % 255, 255 - state, 255 - state ) ) )
			elseif i == 2 then
				love.graphics.setColor( love.math.colorFromBytes( HSV( (n-128) % 255, 255 - state, 255 - state ) ) )
			elseif i == 3 then
				love.graphics.setColor( love.math.colorFromBytes( HSV( (n-192) % 255, 255 - state, 255 - state ) ) )
			end 
			
			love.graphics.rectangle( "fill", ( n % w ) * res, math.floor( n / w ) * res, res, res )
		end 
		
		
		-- for n = 0, w*h do
		-- 	local i = math.floor( n / 255 ) * 5
			
		-- 	love.graphics.setColor(love.math.colorFromBytes(HSV(n%127,255,255-i)))
		-- 	-- if n % 2 == 0 then
		-- 	--     love.graphics.setColor(love.math.colorFromBytes(HSV(n%127,255,255-i)))
		-- 	-- else
		-- 	--     love.graphics.setColor(love.math.colorFromBytes(invertColor(HSV(n%127,255,255-i))))
		-- 	-- end
			
		-- 	love.graphics.rectangle("fill", ( n % w ) * res, math.floor( n / w ) * res, res, res)
		-- end
		
	love.graphics.setCanvas()
	
	-- canvas:newImageData():encode("png","filename.png")
end

function love.draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setBlendMode("alpha", "premultiplied")
	love.graphics.draw(canvas)
end