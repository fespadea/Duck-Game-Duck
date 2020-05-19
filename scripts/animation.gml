//animation

if(duckState == DS_STAND){
    if(free){
        changeSprite(jumpSprite);
        if(vsp < 0){
            duckImageIndex = 0;
        } else {
            duckImageIndex = 1;
        }
    } else {
        var absoluteHSP = abs(hsp)
        if(absoluteHSP > .3){
            changeSprite(walkSprite);
            duckImageIndex += absoluteHSP*(walk_anim_speed/walk_speed);
        } else {
            changeSprite(idleSprite);
        }
    }
}
sprite_index = duckSpriteIndex;
image_index = floor(duckImageIndex);

#define changeSprite(newSprite)
if(duckSpriteIndex != newSprite){
    duckSpriteIndex = newSprite;
    duckImageIndex = 0;
}