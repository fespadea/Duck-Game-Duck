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

// draw the jetpack when being used
repeat 1{ // this is here so that I can use a break statement
    if(showArmor){
        var xOffset = 0;
        var yOffset = 0;
        if(duckSpriteIndex == idleSprite){
            xOffset = -3;
            yOffset = -24;
        } else if(duckSpriteIndex == slideSprite){
            xOffset = 3;
            yOffset  = -7;
        } else if(duckSpriteIndex == crouchSprite){
            xOffset = -1;
            yOffset = -15;
        } else {
            break;
        }
        draw_sprite_ext(helmetSprite, quackTaunt ? 1 : 0, x+xOffset*spr_dir, y+yOffset, spr_dir, 1, duckOrientation - 90, duckColor, 1);
        break;
    }
}

// wing animations
shader_start();
draw_sprite_ext(wingSprite, wingImage, x, y, spr_dir, 1, 0, duckColor, 1);
shader_end();