//animation

//duck animations
fallingSoDrawLeft = false;
if(duckState == DS_STAND){
    if(free){
        hurtboxID.sprite_index = hurtbox_spr;
        hurtboxID.image_angle = 0;
        changeSprite(jumpSprite);
        if(vsp < 0){
            duckImageIndex = 0;
        } else {
            duckImageIndex = 1;
            fallingSoDrawLeft = true;
        }
    } else {
        hurtboxID.sprite_index = air_hurtbox_spr;
        hurtboxID.image_angle = 0;
        var absoluteHSP = abs(hsp);
        if(absoluteHSP > .3){
            changeSprite(walkSprite);
            duckImageIndex += absoluteHSP*(walk_anim_speed/walk_speed);
        } else {
            changeSprite(idleSprite);
        }
    }
} else if(duckState == DS_CROUCH){
    hurtboxID.sprite_index = crouchbox_spr;
    hurtboxID.image_angle = 0;
    duckImageIndex = 0;
    if(slideActive){
        changeSprite(slideSprite);
    } else {
        changeSprite(crouchSprite);
    }
} else if(duckState == DS_HURT){
    duckImageIndex = 0;
    changeSprite(hurtSprite);
    spr_angle = round(duckOrientation)-90;
    hurtboxID.sprite_index = hitstun_hurtbox_spr;
    hurtboxID.image_angle = spr_angle;
}
sprite_index = duckSpriteIndex[quackTaunt ? 1 : 0];
image_index = floor(duckImageIndex);

if(state == PS_PRATFALL || state == PS_PRATLAND){
    duckColor = c_gray;
} else if(state == PS_PARRY && window == 1){
    duckColor = c_ltgray;
} else {
    duckColor = c_white;
}

#define changeSprite(newSprite)
if(duckSpriteIndex != newSprite){
    duckSpriteIndex = newSprite;
    duckImageIndex = 0;
}