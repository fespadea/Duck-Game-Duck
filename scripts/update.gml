//update

//duckState control
if(down_hard_pressed || state == PS_CROUCH){
    duckState = DS_CROUCH;
} else if(!down_down){
    duckState = DS_STAND;
}

//attribute control

floatActive = false;
if(vsp == fast_fall && fast_falling){
    vsp = prevVsp;
}
if(duckState == DS_STAND){
    ground_friction = standGroundFriction;
    air_friction = standAirFriction;
    max_jump_hsp = standJumpHsp;
    leave_ground_max = standLeaveGroundHsp;
    air_max_speed = standAirHsp;
    max_fall = standMaxFall;
    if(left_down){
        spr_dir = -1;
    } else if(right_down){
        spr_dir = 1;
    }
    slideActive = false;
    duckOrientation = 90;
} else if(duckState == DS_CROUCH){
    if(state == PS_DASH_START){
        set_state(PS_IDLE);
    }
    ground_friction = slideGroundFriction;
    air_friction = slideAirFriction;
    max_fall = slideMaxFall;
    if((hsp > 0 && hsp > prevHsp) || (hsp < 0 && hsp < prevHsp)) hsp = prevHsp;
    var absoluteHsp = abs(hsp); //avoiding negatives
    max_jump_hsp = absoluteHsp*.9;
    leave_ground_max = absoluteHsp*.9;
    air_max_speed = absoluteHsp*.9;
    // decide if sliding
    var absoluteHSP = abs(hsp);
    if(absoluteHSP > .3 && !free){
        slideActive = true;
        duckOrientation = 0;
    } else if (duckSpriteIndex != slideSprite || (state == PS_JUMPSQUAT && hsp == 0)) {
        slideActive = false;
        duckOrientation = 90;
    }
}
prevHsp = hsp;
prevVsp = vsp;

//floating mechanic
var floatable = (state_cat == SC_AIR_NEUTRAL || state == PS_WALL_JUMP) && duckState == DS_STAND;
var floatInput = jump_down || (up_down && can_tap_jump());
if(!floatInput || !floatable){
    floatActive = false;
} else if (floatable) {
    if(!jetpackFuel || !inAirButNotJumping){
        if (vsp < 0) {
            goingUp = true;
        } else {
            if (floatInput) {
                if (goingUp || djumps == max_djumps) {
                    floatActive = true;
                }
            }
            goingUp = false;
        }
    }
}
if floatActive {
    max_fall = standMaxFall/3;
    if (vsp > max_fall) {
        vsp = max_fall;
    }
}

// taunt control
move_cooldown[AT_TAUNT] = 2;
if(taunt_down){
    if(!quackTaunt){
        sound_play(quackTauntSound);
    }
    quackTaunt = true;
    quackTimer = 3;
} else if(quackTaunt){
    quackTimer--;
    if(!quackTimer){
        quackTaunt = false;
    }
}

//jetpack
var jetpackStartInput = jump_pressed || (up_hard_pressed && can_tap_jump());
var jetpackInput = jump_down || (up_down && can_tap_jump());
if(state == PS_WALL_JUMP && state_timer == 1){
    inAirButNotJumping = false;
}
if(!free){
    jetpackFuel = maxJetPackFuel;
    inAirButNotJumping = false;
    jetpackActive = false;
} else {
    if(!jetpackInput){
        inAirButNotJumping = true;
    }
    if(jetpackStartInput && inAirButNotJumping){
        jetpackActive = true;
    }
    if(jetpackActive && jetpackFuel && jetpackInput){
        jetpackFuel--;
        var horPor = cos(degtorad(duckOrientation));
        var maxHsp = maxJetpackSpeed*horPor;
        var verPor = sin(degtorad(duckOrientation));
        var maxVsp = -maxJetpackSpeed*verPor;
        if(maxHsp > hsp){
            hsp += min(maxHsp - hsp, jetpackAccel*horPor);
        }
        if(maxVsp < vsp){
            vsp -= min(abs(maxVsp - vsp), jetpackAccel*verPor);
        }
    }
}