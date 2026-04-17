using Microsoft.Xna.Framework;
using Monocle;
using MonoMod.ModInterop;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Celeste.Mod.PandorasBox;

public static class PandorasBoxExports
{
    internal static void Initialize()
    {
        DreamDashController.SetupIgnoringTypes.Clear();
        DreamDashController.ControlledTypes.Clear();
        
        typeof(DreamDashControllerExports).ModInterop();
    }

    [ModExportName("PandorasBox.DreamDashController")]
    public static class DreamDashControllerExports
    {
        public static void AddSetupIgnoringTypes(HashSet<Type> types)
            => DreamDashController.AddSetupIgnoringTypes(types);
        public static void RemoveSetupIgnoringTypes(HashSet<Type> types)
            => DreamDashController.RemoveSetupIgnoringTypes(types);
        
        public static void AddControlledTypes(HashSet<Type> types)
            => DreamDashController.AddControlledTypes(types);
        public static void RemoveControlledTypes(HashSet<Type> types)
            => DreamDashController.RemoveControlledTypes(types);

        public static void GetGameplaySettingsFor(Entity entity,
            out bool? allowSameDirectionDash,
            out bool? allowDreamDashRedirection,
            out bool? overrideDreamDashSpeed,
            out bool? neverSlowDown,
            out bool? useEntrySpeedAngle,
            out bool? bounceOnCollision,
            out bool? collideStickToWalls,
            out float? sameDirectionSpeedMultiplier,
            out float? dreamDashSpeed)
        {
            allowSameDirectionDash = null;
            allowDreamDashRedirection = null;
            overrideDreamDashSpeed = null;
            neverSlowDown = null;
            useEntrySpeedAngle = null;
            bounceOnCollision = null;
            collideStickToWalls = null;
            sameDirectionSpeedMultiplier = null;
            dreamDashSpeed = null;
            
            if (entity.Get<DreamDashController.DreamDashControllerComponent>()?.Controller is not { } controller)
                return;
            
            allowSameDirectionDash = controller.AllowSameDirectionDash;
            allowDreamDashRedirection = controller.AllowDreamDashRedirection;
            overrideDreamDashSpeed = controller.OverrideDreamDashSpeed;
            neverSlowDown = controller.NeverSlowDown;
            useEntrySpeedAngle = controller.UseEntrySpeedAngle;
            bounceOnCollision = controller.BounceOnCollision;
            collideStickToWalls = controller.CollideStickToWalls;
            sameDirectionSpeedMultiplier = controller.SameDirectionSpeedMultiplier;
            dreamDashSpeed = controller.DreamDashSpeed;
        }
        
        public static void GetVisualSettingsFor(Entity entity,
            out Color? activeBackColor,
            out Color? disabledBackColor,
            out Color? activeLineColor,
            out Color? disabledLineColor,
            out Color[][] activeParticleLayerColors,
            out Color[][] disabledParticleLayerColors)
        {
            activeBackColor = null;
            disabledBackColor = null;
            activeLineColor = null;
            disabledLineColor = null;
            activeParticleLayerColors = null;
            disabledParticleLayerColors = null;

            if (entity.Get<DreamDashController.DreamDashControllerComponent>()?.Controller is not { OverrideColors: true } controller)
                return;

            activeBackColor = controller.ActiveBackColor;
            disabledBackColor = controller.DisabledBackColor;
            activeLineColor = controller.ActiveLineColor;
            disabledLineColor = controller.DisabledLineColor;
            activeParticleLayerColors = controller.ActiveParticleLayerColors;
            disabledParticleLayerColors = controller.DisabledParticleLayerColors;
        }
    }
}
