// pre draw

//draw the parry outline
#macro XOFFSET 4
#macro YOFFSET 4
if(showArmor){
    draw_sprite_ext(wingSprite, wingImage, x+XOFFSET, y, spr_dir, 1, 0, c_black, 1);
    draw_sprite_ext(wingSprite, wingImage, x-XOFFSET, y, spr_dir, 1, 0, c_black, 1);
    draw_sprite_ext(wingSprite, wingImage, x, y+YOFFSET, spr_dir, 1, 0, c_black, 1);
    draw_sprite_ext(wingSprite, wingImage, x, y-YOFFSET, spr_dir, 1, 0, c_black, 1);
    draw_sprite_ext(chestplateSprite, quackTaunt ? 1 : 0, x+xOffsetChestplate*spr_dir+XOFFSET, y+yOffsetChestplate, spr_dir, 1, duckOrientation - 90, c_black, 1);
    draw_sprite_ext(chestplateSprite, quackTaunt ? 1 : 0, x+xOffsetChestplate*spr_dir-XOFFSET, y+yOffsetChestplate, spr_dir, 1, duckOrientation - 90, c_black, 1);
    draw_sprite_ext(chestplateSprite, quackTaunt ? 1 : 0, x+xOffsetChestplate*spr_dir, y+yOffsetChestplate+YOFFSET, spr_dir, 1, duckOrientation - 90, c_black, 1);
    draw_sprite_ext(chestplateSprite, quackTaunt ? 1 : 0, x+xOffsetChestplate*spr_dir, y+yOffsetChestplate-YOFFSET, spr_dir, 1, duckOrientation - 90, c_black, 1);
    draw_sprite_ext(helmetSprite, quackTaunt ? 1 : 0, x+xOffsetHelmet*spr_dir+XOFFSET, y+yOffsetHelmet, spr_dir, 1, duckOrientation - 90, c_black, 1);
    draw_sprite_ext(helmetSprite, quackTaunt ? 1 : 0, x+xOffsetHelmet*spr_dir-XOFFSET, y+yOffsetHelmet, spr_dir, 1, duckOrientation - 90, c_black, 1);
    draw_sprite_ext(helmetSprite, quackTaunt ? 1 : 0, x+xOffsetHelmet*spr_dir, y+yOffsetHelmet+YOFFSET, spr_dir, 1, duckOrientation - 90, c_black, 1);
    draw_sprite_ext(helmetSprite, quackTaunt ? 1 : 0, x+xOffsetHelmet*spr_dir, y+yOffsetHelmet-YOFFSET, spr_dir, 1, duckOrientation - 90, c_black, 1);
}

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
        draw_sprite_ext(jetpackSprite, floor((maxJetPackFuel-jetpackFuel)*jetpackSpriteFrameSpeed), x+xOffset*spr_dir, y+yOffset, spr_dir, 1, duckOrientation - 90, duckColor, 1);
        break;
    }
}


// draw the left arm when falling (floating or normal) since the sprite doesn't have the arm
shader_start();
if(duckState == DS_STAND){
    if(fallingSoDrawLeft){
        if(floatActive){
            draw_sprite_ext(wingLeftGlideSprite, floor(get_gameplay_time()/3), x, y, spr_dir, 1, 0, duckColor, 1);
        } else {
            draw_sprite_ext(wingLeftJumpSprite, image_index, x, y, spr_dir, 1, 0, duckColor, 1);
        }
    }
}

// draw the bottom half of the duck's body when hit
if(duckState == DS_HURT){
    draw_sprite_ext(hurt2Sprite, 0, x, y, spr_dir, 1, duckBottomOrientation+90, duckColor, 1);
}
shader_end();