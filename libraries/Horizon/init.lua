--[[
		             _                                  
	              (`  ).                   _           
	             (     ).              .:(`  )`.       
	)           _(       '`.          :(   .    )      
	        .=(`(      .   )     .--  `.  (    ) )      
	       ((    (..__.:'-'   .+(   )   ` _`  ) )                 
	`.     `(       ) )       (   .  )     (   )  ._   
	  )      ` __.:'   )     (   (   ))     `-'.-(`  ) 
	)  )  ( )       --'       `- __.'         :(      )) 
	.-'  (_.'          .')                    `(    )  ))
	                  (_  )                     ` __.:'          
	                                        
	--..,___.--,--'`,---..-.--+--.,,-,,..._.--..-._.-a:f--.

	Horizön
	3DS <-> PC Löve Bridge
--]]

Horizon =
{
	_VERSION = "1.0.1",
	RUNNING = (love.system.getOS() ~= "Horizon")
}

--SYSTEM CHECK
if not Horizon.RUNNING then
	return
end

Horizon.RUNNING = true

local path = ...

Enum = require(path .. ".enum")
CONFIG = require(path .. ".config")

require(path .. ".input")
require(path .. ".render")
require(path .. ".system")

love.window.setMode(400, 480, {vsync = true})
love.window.setTitle("NINTENDO 3DS :: " .. love.filesystem.getIdentity():upper())

if CONFIG.BOOT then
	require(path .. ".boot")
end

require(path .. ".objects")