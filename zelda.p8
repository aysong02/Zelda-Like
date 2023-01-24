pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
-->8
-- special functions
  -- code modified from class rain.p8
  function _init() 
    player = {
      --player coordinates
      x = 10,
      y = 10,
      --offset for sprite from top left
      ox=0, 
      oy=0,
      --sprite dimensions
      w = 15,
      h = 15,
      orientation = 0
    -- orientation is 0,2,4,6 for
    -- left, right, up, down
    }

    -- initailize spikes and gems
    spikes = {}
    spikeCount = 0
    plantSpikes(70,70)
    plantSpikes(90,90)
    gems = {}
    gemCount = 0
    plantGem(30,30)
    plantGem(50,50)

    -- variables for movement
    speed = 40 -- pixels/sec
    dx, dy = 0, 0
    dt = 0
    lastframe = t()
  end

  function _draw()
    cls()
    map()
    spr(player.orientation, player.x, player.y, 2, 2)
    drawSpikes()
    drawGem()
    print("for debugging", 0, 120, 12)
  end

  function _update60()
    dt = t() - lastframe
    lastframe = t()
  
    input() 
    updateSpikes()
  end





-->8
--code for player movement
  function input()
    local dx, dy = 0,0
    if(btn(0)) then --left
      dx = -speed * dt
      player.orientation = 0
    elseif (btn(1)) then --right
      dx = speed * dt
      player.orientation = 2
    elseif (btn(2)) then --up
      dy = -speed * dt
      player.orientation = 4
    elseif (btn(3)) then --down
      dy= speed * dt
      player.orientation = 6
    end

    if hit(player.x+dx,player.y,player.w,player.h) then
      dx = 0
    end
    if hit(player.x,player.y+dy,player.w,player.h) then
      dy = 0
    end

    player.x += dx
    player.y += dy
  end
  --code for wall collisions
  --Checks for collisions on all sides of the sprite
  function hit(x,y,w,h)
    collide=false
    for i=x,x+w do
      --Check both the top and the bottom 
      if (fget(mget(i/8,y/8))>0) or
          (fget(mget(i/8,(y+h)/8))>0) then
            collide=true
      end
    end
    
    for i=y,y+h do
      --Check both the left and the right 
      if (fget(mget(x/8,i/8))>0) or
          (fget(mget((x+w)/8,i/8))>0) then
            collide=true
      end
    end
    
    return collide
  end
-->8
--code for gems
  function drawGem()
  for i=1,#gems do
    spr(20, gems[i].x, gems[i].y)
  end
  end

  function plantGem(x,y)
    local seed = {
      x=x,
      y=x,
      frame=0
    }
    gemCount += 1
    gems[gemCount] = seed
  end

  function updateGem()
  -- TODO
  --  for i=1,#gems do
  --   local stage = flr(t() % 4)
  --    spikes[i].frame = stage
  --  end
  end
-->8
--code for spikes
  function drawSpikes()
  for i=1,#spikes do
    spr(spikes[i].frame, spikes[i].x, spikes[i].y)
  end
  end

  function plantSpikes(x,y)
    local seed = {
      x=x,
      y=x,
      frame=0
    }
    spikeCount += 1
    spikes[spikeCount] = seed
  end

  function updateSpikes()
  for i=1,#spikes do
    local stage = flr(t() % 4)
    spikes[i].frame = stage
  end
  end

__gfx__
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
777777777777777788888888888888889999999999999999aaaaaaaaaaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
555555553333333333333b3300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666656663333333333b3b33300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66665666333333333b33333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555333333333333b33300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6656666633333333333b33b300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
665666663333333333b33b3300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4040404040404040404040404141414141414141414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414241414141414141404141414041414141414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141424141414141404140414141414141414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041424142414142414141404141414141414041414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414040404040404141404141414141414141414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414241414142404141414140414141414141404141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4042414141424141404141414141414140414141414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041414141414141404140414141414141414140414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4040404040404040404041414141404141414141414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4141414141414141414140414141414141414141414141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
