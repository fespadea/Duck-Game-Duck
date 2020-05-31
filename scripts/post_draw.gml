// post draw

// wing animations
if(wingState == WS_UNARMED){
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
    draw_sprite_ext(wingSprite, wingImage, x, y, spr_dir, 1, 0, c_white, 1);
}