// pre draw

// draw the jetpack when being used
repeat 1{ // this is here so that I can use a break statement
    if(jetpackActive){
        var xOffset = 0;
        var yOffset = 0;
        if(duckSpriteIndex == jumpSprite){
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
        draw_sprite_ext(jetpackSprite, floor((maxJetPackFuel-jetpackFuel)*jetpackSpriteFrameSpeed), x+xOffset*spr_dir, y+yOffset, spr_dir, 1, duckOrientation - 90, c_white, 1);
        break;
    }
}


// draw the left arm when falling (floating or normal) since the sprite doesn't have the arm
if(duckState == DS_STAND){
    if(fallingSoDrawLeft){
        if(floatActive){
            draw_sprite_ext(wingLeftGlideSprite, floor(get_gameplay_time()/3), x, y, spr_dir, 1, 0, c_white, 1);
        } else {
            draw_sprite_ext(wingLeftJumpSprite, image_index, x, y, spr_dir, 1, 0, c_white, 1);
        }
    }
}

// draw the bottom half of the duck's body when hit
if(duckState == DS_HURT){
    draw_sprite_ext(hurt2Sprite, 0, x, y, spr_dir, 1, duckBottomOrientation+90, c_white, 1);
}