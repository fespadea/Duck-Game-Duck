// CSS draw

var num_alts = 6;
var alt_cur = get_player_color(player);

//hat selection
#macro NUM_HATS 6
#macro HAT_SWITCH_FRAME_LIMIT 12
if("hatSpriteIndex" in self){
    if(hatTimer < HAT_SWITCH_FRAME_LIMIT){
        hatTimer++;
        if((altPrev < alt_cur && !(altPrev == 0 && alt_cur == num_alts-1)) || (altPrev == num_alts - 1 && alt_cur == 0)){
            hatSpriteIndex++;
            if(hatSpriteIndex == NUM_HATS){
                hatSpriteIndex = 0;
            }
        } else if(altPrev > alt_cur || (altPrev == 0 && alt_cur == num_alts-1)){
            hatSpriteIndex--;
            if(hatSpriteIndex < 0){
                hatSpriteIndex = NUM_HATS - 1;
            }
        }
    }
    if(altPrev != alt_cur){
        hatTimer = 0;
        altPrev = alt_cur;
    }
} else {
    hatSpriteIndex = get_color_profile_slot_r(0, 8);
    altPrev = alt_cur;
    hatTimer = 0;
}
set_color_profile_slot(0, 8, hatSpriteIndex, 0, 0);


//Fancy CSS template by Muno

var temp_x = x + 8;
var temp_y = y + 9;

patch_ver = "1.0";
patch_day = "10";
patch_month = "JUN";



//Alt name init. var doesn't work with arrays lol

alt_name[0]  = "White Duck";
alt_name[1]  = "Grey Duck";
alt_name[2]  = "Yellow Duck";
alt_name[3]  = "Orange Duck";
alt_name[4]  = "Vincent Duck";
alt_name[5]  = "News Duck";
alt_name[6]  = "woag";
alt_name[7]  = "woag";
alt_name[8]  = "woag";
alt_name[9]  = "woag";
alt_name[10] = "woag";
alt_name[11] = "woag";
alt_name[12] = "woag";
alt_name[13] = "woag";
alt_name[14] = "woag";
alt_name[15] = "woag";

hatName[0] = "No Hat";
hatName[1] = "Uglies Hat";
hatName[2] = "Super Hat";
hatName[3] = "Divers Hat";
hatName[4] = "Burgers Hat";
hatName[5] = "Sombrero Hat";

//setting the offsets of the hat sprites because load is slow
sprite_change_offset("hat_uglies", 32, 32);
sprite_change_offset("hat_super", 32, 32);
sprite_change_offset("hat_divers", 32, 32);
sprite_change_offset("hat_burgers", 32, 32);
sprite_change_offset("hat_sombrero", 32, 32);

//hat sprites
hatSprites[0] = asset_get("empty_sprite");
hatSprites[1] = sprite_get("hat_uglies");
hatSprites[2] = sprite_get("hat_super");
hatSprites[3] = sprite_get("hat_divers");
hatSprites[4] = sprite_get("hat_burgers");
hatSprites[5] = sprite_get("hat_sombrero");

//draw the hat on the CSS
draw_sprite_ext(hatSprites[hatSpriteIndex], 0, temp_x+36+64, temp_y-17+64, 2, 2, 0, -1, 1);

//Patch

draw_set_halign(fa_left);

textDraw(temp_x + 2, temp_y + 30, "medFont", c_white, 0, 1000, 1, true, 1, "VER. " + patch_ver);

textDraw(temp_x + 2, temp_y + 50, "fName", c_white, 0, 1000, 1, true, 1, patch_day + " " + patch_month);



//Alt

rectDraw(temp_x, temp_y + 135, temp_x + 201, temp_y + 142, c_black);

for(i = 0; i < num_alts; i++){
	var draw_color = (i == alt_cur) ? c_white : c_gray;
	var draw_x = temp_x + 2 + 10 * i;
	rectDraw(draw_x, temp_y + 137, draw_x + 7, temp_y + 140, draw_color);
}

draw_set_halign(fa_left);

//include hat name
textDraw(temp_x + 2, temp_y + 106, "fName", c_white, 0, 1000, 1, true, 1, "Hat " + (hatSpriteIndex < 9 ? "0" : "") + string(hatSpriteIndex + 1) + ": " + hatName[hatSpriteIndex]);

//include alt. name
textDraw(temp_x + 2, temp_y + 124, "fName", c_white, 0, 1000, 1, true, 1, "Alt. " + (alt_cur < 9 ? "0" : "") + string(alt_cur + 1) + ": " + alt_name[alt_cur]);

//exclude alt. name
//textDraw(temp_x + 2, temp_y + 124, "fName", c_white, 0, 1000, 1, true, 1, "Alt. " + (alt_cur < 9 ? "0" : "") + string(alt_cur + 1));



#define textDraw(x, y, font, color, lineb, linew, scale, outline, alpha, string)

draw_set_font(asset_get(argument[2]));

if argument[7]{ //outline. doesn't work lol
    for (i = -1; i < 2; i++){
        for (j = -1; j < 2; j++){
            draw_text_ext_transformed_color(argument[0] + i * 2, argument[1] + j * 2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, c_black, c_black, c_black, c_black, 1);
        }
    }
}

draw_text_ext_transformed_color(argument[0], argument[1], argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[3], argument[3], argument[3], argument[3], argument[8]);

return string_width_ext(argument[9], argument[4], argument[5]);



#define rectDraw(x1, y1, x2, y2, color)

draw_rectangle_color(argument[0], argument[1], argument[2], argument[3], argument[4], argument[4], argument[4], argument[4], false);