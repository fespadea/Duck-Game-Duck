// post draw

//wall jump boots
if(state == PS_WALL_JUMP){
    var bootSprite = asset_get("empty_sprite");
    if(duckState == DS_STAND){
        bootSprite = wallJumpBootsStandSprite;
    } else if(duckState == DS_CROUCH){
        bootSprite = wallJumpBootsCrouchSprite;
    }
    draw_sprite_ext(bootSprite, image_index, x, y, spr_dir, 1, 0, duckColor, 1);
}

// draw hat
if(!showArmor){
    var xOffsetHat = 0;
    var yOffsetHat = 0;
    if(duckSpriteIndex == idleSprite){
        xOffsetHat = -2;
        yOffsetHat = -44;
    } else if(duckSpriteIndex == jumpSprite){
        xOffsetHat = -2;
        if(image_index % 2 = 0)
            yOffsetHat = -44;
        else
            yOffsetHat = -46;
    } else if(duckSpriteIndex == crouchSprite){
        xOffsetHat = 0;
        yOffsetHat = -34;
    } else if(duckSpriteIndex == walkSprite){
        xOffsetHat = -2;
        switch(image_index % 6){
            case 0:
            case 1:
            case 3:
            case 4:
                yOffsetHat = -46;
                break;
            case 2:
            case 5:
                yOffsetHat = -44;
                break;
        }
    } else if(duckSpriteIndex == slideSprite){
        xOffsetHat = -16;
        yOffsetHat = -8;
    } else if(duckSpriteIndex == hurtSprite){
        xOffsetHat = (-2*dsin(duckOrientation) + 26*dcos(duckOrientation))*spr_dir;
        yOffsetHat = -26*dsin(duckOrientation) - 2*dcos(duckOrientation);
    }
    shader_start();
    draw_sprite_ext(hatSprites[hatSpriteIndex], quackTaunt ? 1 : 0, x+xOffsetHat*spr_dir, y+yOffsetHat, spr_dir, 1, duckOrientation - 90, duckColor, 1);
    shader_end();
}

var drawBeforeArmor = wingSprite == wingIdleSprite || wingSprite == wingCrouchSprite;
if(drawBeforeArmor){
    // wing animations
    shader_start();
    draw_sprite_ext(wingSprite, wingImage, x+wingXOffset*spr_dir, y+wingYOffset, spr_dir, 1, 0, duckColor, 1);
    shader_end();
}

// draw the jetpack when being used
if(showArmor){
    draw_sprite_ext(chestplateSprite, quackTaunt ? 1 : 0, x+xOffsetChestplate*spr_dir, y+yOffsetChestplate, spr_dir, 1, duckOrientation - 90, duckColor, 1);
    draw_sprite_ext(helmetSprite, quackTaunt ? 1 : 0, x+xOffsetHelmet*spr_dir, y+yOffsetHelmet, spr_dir, 1, duckOrientation - 90, duckColor, 1);
}

if(!drawBeforeArmor){
    // wing animations
    shader_start();
    draw_sprite_ext(wingSprite, wingImage, x+wingXOffset*spr_dir, y+wingYOffset, spr_dir, 1, 0, duckColor, 1);
    shader_end();
}