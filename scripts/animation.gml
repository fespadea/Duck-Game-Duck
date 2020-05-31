//animation

//duck animations
fallingSoDrawLeft = false;
if(duckState == DS_STAND){
    if(free){
        pHurtBox.sprite_index = hurtbox_spr;
        changeSprite(jumpSprite);
        if(vsp < 0){
            duckImageIndex = 0;
        } else {
            duckImageIndex = 1;
            fallingSoDrawLeft = true;
        }
    } else {
        pHurtBox.sprite_index = air_hurtbox_spr;
        var absoluteHSP = abs(hsp)
        if(absoluteHSP > .3){
            changeSprite(walkSprite);
            duckImageIndex += absoluteHSP*(walk_anim_speed/walk_speed);
        } else {
            changeSprite(idleSprite);
        }
    }
} else if(duckState == DS_CROUCH){
    pHurtBox.sprite_index = crouchbox_spr;
    var absoluteHSP = abs(hsp)
    if(absoluteHSP > .3 && !free){
        changeSprite(slideSprite);
        duckImageIndex = 0;
    } else if (duckSpriteIndex != slideSprite) {
        changeSprite(crouchSprite);
    }
}
sprite_index = duckSpriteIndex[quackTaunt ? 1 : 0];
image_index = floor(duckImageIndex);

#define changeSprite(newSprite)
if(duckSpriteIndex != newSprite){
    duckSpriteIndex = newSprite;
    duckImageIndex = 0;
}