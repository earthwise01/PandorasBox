local drawableSprite = require("structs.drawable_sprite")
local drawableRectangle = require("structs.drawable_rectangle")
local utils = require("utils")

local dreamDashController = {}

dreamDashController.name = "pandorasBox/dreamDashController"
dreamDashController.depth = 0
dreamDashController.placements = {
    {
        name = "controller",
        data = {
            allowSameDirectionDash = false,
            allowDreamDashRedirect = true,
            overrideDreamDashSpeed = false,
            neverSlowDown = false,
            useEntrySpeedAngle = false,
            bounceOnCollision = false,
            stickOnCollision = false,
            overrideColors = false,
            sameDirectionSpeedMultiplier = 1.0,
            dreamDashSpeed = 240.0,
            activeBackColor = "Black",
            disabledBackColor = "af2e2d",
            activeLineColor = "White",
            disabledLineColor = "6a8480",
            particleLayer0Colors = "ffef11,ff00d0,08a310",
            particleLayer1Colors = "5fcde4,7fb25e,e0564c",
            particleLayer2Colors = "5b6ee1,CC3B3B,7daa64",
            disabledParticleLayer0Colors = "LightGray",
            disabledParticleLayer1Colors = "LightGray",
            disabledParticleLayer2Colors = "LightGray"
        }
    },
    {
        name = "controller_area",
        data = {
            allowSameDirectionDash = false,
            allowDreamDashRedirect = true,
            overrideDreamDashSpeed = false,
            neverSlowDown = false,
            useEntrySpeedAngle = false,
            bounceOnCollision = false,
            stickOnCollision = false,
            overrideColors = false,
            sameDirectionSpeedMultiplier = 1.0,
            dreamDashSpeed = 240.0,
            activeBackColor = "Black",
            disabledBackColor = "af2e2d",
            activeLineColor = "White",
            disabledLineColor = "6a8480",
            particleLayer0Colors = "ffef11,ff00d0,08a310",
            particleLayer1Colors = "5fcde4,7fb25e,e0564c",
            particleLayer2Colors = "5b6ee1,CC3B3B,7daa64",
            disabledParticleLayer0Colors = "LightGray",
            disabledParticleLayer1Colors = "LightGray",
            disabledParticleLayer2Colors = "LightGray",
            nodes = {
                { x = 0, y = 0 },
                { x = 0, y = 0 }
            }
        }
    }
}

dreamDashController.nodeLimits = function(room, entity)
    local nodes = entity.nodes or {}
    return #nodes > 0 and { 2, 2 } or { 0, 0 }
end
dreamDashController.nodeLineRenderType = "fan"
dreamDashController.nodeVisibility = "never"

dreamDashController.fieldOrder = {
    "x", "y",
    "activeBackColor", "disabledBackColor",
    "activeLineColor", "disabledLineColor",
    "particleLayer0Colors", "disabledParticleLayer0Colors",
    "particleLayer1Colors", "disabledParticleLayer1Colors",
    "particleLayer2Colors", "disabledParticleLayer2Colors",
    "dreamDashSpeed", "sameDirectionSpeedMultiplier",
    "overrideColors", "overrideDreamDashSpeed", "allowDreamDashRedirect", "allowSameDirectionDash",
    "neverSlowDown", "useEntrySpeedAngle", "bounceOnCollision", "stickOnCollision"
}

dreamDashController.fieldInformation = {
    activeBackColor = {
        fieldType = "color",
        allowXNAColors = true,
    },
    disabledBackColor = {
        fieldType = "color",
        allowXNAColors = true,
    },
    activeLineColor = {
        fieldType = "color",
        allowXNAColors = true,
    },
    disabledLineColor = {
        fieldType = "color",
        allowXNAColors = true,
    },
    particleLayer0Colors = {
        fieldType = "list",
        elementSeperator = ",",
        elementDefault = "ffffff",
        elementOptions = {
            fieldType = "color",
            allowXNAColors = true,
        }
    },
    particleLayer1Colors = {
        fieldType = "list",
        elementSeperator = ",",
        elementDefault = "ffffff",
        elementOptions = {
            fieldType = "color",
            allowXNAColors = true,
        }
    },
    particleLayer2Colors = {
        fieldType = "list",
        elementSeperator = ",",
        elementDefault = "ffffff",
        elementOptions = {
            fieldType = "color",
            allowXNAColors = true,
        }
    },
    disabledParticleLayer0Colors = {
        fieldType = "list",
        elementSeperator = ",",
        elementDefault = "ffffff",
        elementOptions = {
            fieldType = "color",
            allowXNAColors = true,
        }
    },
    disabledParticleLayer1Colors = {
        fieldType = "list",
        elementSeperator = ",",
        elementDefault = "ffffff",
        elementOptions = {
            fieldType = "color",
            allowXNAColors = true,
        }
    },
    disabledParticleLayer2Colors = {
        fieldType = "list",
        elementSeperator = ",",
        elementDefault = "ffffff",
        elementOptions = {
            fieldType = "color",
            allowXNAColors = true,
        }
    }
}

local dreamDashControllerTexture = "objects/pandorasBox/controllerIcons/dreamDashController"
local dreamDashControllerAreaCornerTexture = "objects/pandorasBox/controllerIcons/dreamDashAreaControllerCorner"
local dreamDashControllerAreaCornerColor = { 0.7, 1, 1, 0.7 }
local dreamDashControllerAreaFill = { 0, 1, 1, 0.2 }
local dreamDashControllerAreaBorder = { 0, 1, 1, 0.5 }

function dreamDashController.sprite(room, entity)
    local nodes = entity.nodes or {}
    local area = #nodes == 2
    
    local sprites = {}
    table.insert(sprites, drawableSprite.fromTexture(dreamDashControllerTexture, entity))

    if area then
        local ax, ay = nodes[1].x or 0, nodes[1].y or 0
        local bx, by = nodes[2].x or 0, nodes[2].y or 0

        local topLeftX, topLeftY = math.min(ax, bx), math.min(ay, by)
        local bottomRightX, bottomRightY = math.max(ax, bx), math.max(ay, by)
        
        local areaRectangle = drawableRectangle.fromRectangle("bordered",
                topLeftX, topLeftY, bottomRightX - topLeftX, bottomRightY - topLeftY,
                dreamDashControllerAreaFill, dreamDashControllerAreaBorder)
        table.insert(sprites, areaRectangle)

        local cornerScaleX, cornerScaleY = (bx - ax >= 0) and 1 or -1, (by - ay >= 0) and 1 or -1

        local cornerSpriteA = drawableSprite.fromTexture(dreamDashControllerAreaCornerTexture,
                { x = ax, y = ay, scaleX = cornerScaleX, scaleY = cornerScaleY, color = dreamDashControllerAreaCornerColor })
        local cornerSpriteB = drawableSprite.fromTexture(dreamDashControllerAreaCornerTexture,
                { x = bx, y = by, scaleX = -cornerScaleX, scaleY = -cornerScaleY, color = dreamDashControllerAreaCornerColor })
        table.insert(sprites, cornerSpriteA)
        table.insert(sprites, cornerSpriteB)
    end

    return sprites
end

function dreamDashController.selection(room, entity)
    local x, y = entity.x or 0, entity.y or 0
    local nodes = entity.nodes or {}
    local area = #nodes == 2
    
    local sprite = drawableSprite.fromTexture(dreamDashControllerTexture, entity)
    local width = sprite.meta.width
    local height = sprite.meta.height
    local main = utils.rectangle(x - width / 2, y - height / 2, width, height)

    local nodeRectangles = {}
    if area then
        for _, node in ipairs(nodes) do
            table.insert(nodeRectangles, utils.rectangle(node.x - 3, node.y - 3, 6, 6))
        end
    end
    
    return main, nodeRectangles
end

return dreamDashController
