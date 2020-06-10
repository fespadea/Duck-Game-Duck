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

var drawBeforeArmor = wingSprite == wingIdleSprite || wingSprite == wingCrouchSprite;
if(drawBeforeArmor){
    // wing animations
    shader_start();
    draw_sprite_ext(wingSprite, wingImage, x, y, spr_dir, 1, 0, duckColor, 1);
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
    draw_sprite_ext(wingSprite, wingImage, x, y, spr_dir, 1, 0, duckColor, 1);
    shader_end();
}