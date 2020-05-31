// pre draw

// draw the jetpack when being used
if(jetpackActive){
    
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