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

// wing animations
shader_start();
draw_sprite_ext(wingSprite, wingImage, x, y, spr_dir, 1, 0, duckColor, 1);
shader_end();