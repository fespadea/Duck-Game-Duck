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
if(wingState == WS_UNARMED && duckState != DS_HURT){
    wingImage = image_index;
    if(duckSpriteIndex == idleSprite){
        wingSprite = wingIdleSprite;
    } else if(duckSpriteIndex == crouchSprite){
        wingSprite = wingCrouchSprite;
    } else if(duckSpriteIndex == slideSprite){
        wingSprite = wingSlideSprite;
    } else if(duckSpriteIndex == walkSprite){
        wingSprite = wingWalkSprite;
    } else if(duckSpriteIndex == jumpSprite){
        if(floatActive){
            wingSprite = wingGlideSprite;
            wingImage = floor(get_gameplay_time()/3);
        } else {
            wingSprite = wingJumpSprite;
        }
    }
    draw_sprite_ext(wingSprite, wingImage, x, y, spr_dir, 1, 0, duckColor, 1);
}