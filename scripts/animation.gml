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
        if(absoluteHSP > .3 && state != PS_PARRY){
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
sprite_index = duckSpriteIndex[(quackTaunt && !showArmor) ? 1 : 0];
image_index = floor(duckImageIndex);

if(state == PS_PRATFALL || state == PS_PRATLAND){
    duckColor = c_gray;
} else if(state == PS_PARRY && window == 1){
    duckColor = c_ltgray;
} else {
    duckColor = c_white;
}

// wing animations
wingSprite = wingEmpty;
if(duckState != DS_HURT){
    if(wingState == WS_UNARMED){
        wingImage = image_index;
        wingXOffset = 0;
        wingYOffset = 0;
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
    } else {
        wingImage = 0;
        wingSprite = wingArmedSprite;
        if(duckSpriteIndex == idleSprite){
            wingXOffset = 0;
            wingYOffset = 0;
        } else if(duckSpriteIndex == crouchSprite){
            wingXOffset = 0;
            wingYOffset = 0;
        } else if(duckSpriteIndex == slideSprite){
            wingXOffset = 0;
            wingYOffset = 0;
        } else if(duckSpriteIndex == walkSprite){
            wingXOffset = 0;
            wingYOffset = 0;
        } else if(duckSpriteIndex == jumpSprite){
            wingXOffset = 0;
            wingYOffset = 0;
        }
    }
}

//armor offsets
if(duckSpriteIndex == idleSprite){
    xOffsetChestplate = 2;
    yOffsetChestplate = -17;
    xOffsetHelmet = 0;
    yOffsetHelmet = -39;
} else if(duckSpriteIndex == slideSprite){
    xOffsetChestplate = 7;
    yOffsetChestplate = -12;
    xOffsetHelmet = -11;
    yOffsetHelmet  = -12;
} else if(duckSpriteIndex == crouchSprite){
    xOffsetChestplate = 6;
    yOffsetChestplate = -9;
    xOffsetHelmet = 4;
    yOffsetHelmet = -29;
}

#define changeSprite(newSprite)
if(duckSpriteIndex != newSprite){
    duckSpriteIndex = newSprite;
    duckImageIndex = 0;
}