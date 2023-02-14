# Instructions:

- Put the file in the Scripts folder that is in your project. (You can put it in subfolders to organize it too, for example, Scripts/Utils/ )
- In your Lua level file, you must first load the module to can use it. An easy way is add a new function that initializes all the modules, and trigger this function on level start and level load.
- To initialize the module, you must create a variable for the module and assign it with the value of action "require" and name of the module file (without the extension). 
For example: m_ElectricCleaner = require ("obj_ElectricCleaner")
- If you have put your file in a subfolder, you must indicate the folder in the file name. 
For example: m_ElectricCleaner = require ("Utils.obj_ElectricCleaner")
- Once you have prepare your module, you can use it in your other functions calling your module variable and summoning its functions with the "." operator.

# Level example code:
```lua
LevelFuncs.OnStart = function() 
    InitializeModules ()
end

LevelFuncs.OnControlPhase = function(dt)
    DeltaTime = dt
end

LevelFuncs.OnEnd = function() 
end

LevelFuncs.OnLoad = function() 
    InitializeModules ()
end

LevelFuncs.OnSave = function() 
end

function InitializeModules ()
    m_ElectricCleaner = require ("Utils.obj_ElectricCleaner")
    m_Guide = require ("Utils.obj_Guide")
end

---------- My Level functions ----------

LevelFuncs.SetCleanerSpeedDouble = function (Triggerer, objectName)
    local moveable = GetMoveableByName (objectName)
    m_ElectricCleaner.SetMovementSpeed(moveable, 128)
end

LevelFuncs.SetCleanerSpeedDefault = function (Triggerer, objectName)
    local moveable = GetMoveableByName (objectName)
    m_ElectricCleaner.SetMovementSpeed(moveable, 64)
end

LevelFuncs.GuideToNextNode = function (Triggerer, objectName)
    local moveable = GetMoveableByName (objectName)
    m_Guide.GoNextNode (moveable)
end
```
