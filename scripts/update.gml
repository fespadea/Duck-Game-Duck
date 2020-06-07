//update

//duckState control
if(down_hard_pressed || state == PS_CROUCH){
    changeDuckState(DS_CROUCH);
} else if(state_cat == SC_HITSTUN || state == PS_TUMBLE){
    changeDuckState(DS_HURT);
} else if(!down_down){
    changeDuckState(DS_STAND);
}

//attribute control
floatActive = false;
if(vsp == fast_fall && fast_falling){
    vsp = prevVsp;
    fast_falling = false;
}
if(duckState == DS_STAND){
    if(!duckStateTimer){
        ground_friction = standGroundFriction;
        air_friction = standAirFriction;
        air_accel = standAirAccel;
        slideActive = false;
        duckOrientation = 90;
    }
    max_fall = standMaxFall;
    if(left_down){
        spr_dir = -1;
    } else if(right_down){
        spr_dir = 1;
    }
} else if(duckState == DS_CROUCH){
    if(state == PS_DASH_START){
        set_state(PS_IDLE);
    }
    if(!duckStateTimer){
        ground_friction = slideGroundFriction;
        air_friction = slideAirFriction;
        max_fall = slideMaxFall;
        air_accel = slideAirAccel;
    }
    // decide if sliding
    if(abs(hsp) > .3 && !free){
        slideActive = true;
        duckOrientation = 90 + 90*spr_dir;
    } else if (duckSpriteIndex != slideSprite || (state == PS_JUMPSQUAT && hsp == 0 && !jetpackActive)) {
        slideActive = false;
        duckOrientation = 90;
    }
} else if(duckState == DS_HURT){
    if(!duckStateTimer){
        ground_friction = standGroundFriction;
        air_friction = standAirFriction;
        max_fall = standMaxFall;
        air_accel = standAirAccel;
        slideActive = false;
        duckOrientation = 90;
        duckBottomOrientation = -duckOrientation;
        if(duckSpriteIndex == slideSprite){
            y -= 25;
        } else if(duckSpriteIndex != slideSprite){
            y -= 18;
        }
        if(hsp < 0)
            spr_dir = -1;
        else if(hsp > 0)
            spr_dir = 1;
    }
    if(free){
        if(hsp == 0){
            if(vsp > 0)
                launchAngle = 270;
            else if(vsp < 0)
                launchAngle = 90;
        } else
            launchAngle = darctan2(-vsp, hsp);
        print_debug(string(launchAngle));
        if(launchAngle < 0)
            launchAngle += 360;
        var angleOffset = maximumBendAngle - 45/exp(sqrt(sqr(hsp)+sqr(vsp))/5);
        duckOrientation = launchAngle + (-angleOffset-90)*spr_dir;
        duckBottomOrientation = launchAngle - (-angleOffset-90)*spr_dir;
    }
}
duckStateTimer++;
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

//walljumps
if(slideActive && has_walljump){
    storingWallJump = true;
    has_walljump = false;
} else if(storingWallJump){
    has_walljump = true;
    storingWallJump = false;
}

//jetpack
var jetpackStartInput = jump_pressed || (up_hard_pressed && can_tap_jump());
var jetpackInput = jump_down || (up_down && can_tap_jump());
if(state == PS_WALL_JUMP && state_timer == 1){
    inAirButNotJumping = false;
}
if(!free && !(slideActive && jetpackActive)){
    jetpackFuel = maxJetPackFuel;
    inAirButNotJumping = false;
    jetpackActive = false;
    if(jetpackSfxIndexToStop){
        sound_stop(jetpackSfxIndexToStop);
        jetpackSfxIndexToStop = 0;
    }
} else{
    if(state == PS_JUMPSQUAT){
        set_state(PS_IDLE);
    } else if(state == PS_WALL_JUMP && state_timer == 1){
        inAirButNotJumping = false;
        jetpackActive = false;
    }
    if(!jetpackInput){
        inAirButNotJumping = true;
    }
    if(jetpackStartInput && inAirButNotJumping){
        jetpackActive = true;
    }
    if(jetpackActive && jetpackFuel && jetpackInput && state != PS_PRATFALL && state != PS_ATTACK_AIR && state_cat != SC_HITSTUN){
        if(!jetpackSfxIndexToStop){
            jetpackSfxIndexToStop = sound_play(jetpackSfx);
        }
        jetpackFuel--;
        if(!(jetpackFuel % 3)){
            spawn_hit_fx(x+random_func(0, 21, true)-10, y+random_func(1, 21, true)-10, jetpackSmokeEffect);
        }
        var horPor = dcos(duckOrientation);
        var maxHsp = maxJetpackSpeed*horPor;
        var verPor = dsin(duckOrientation);
        var maxVsp = -maxJetpackSpeed*verPor;
        if(vsp > 0){ // you went no where if you use the jetpack while falling
            verPor *= 1.5;
        }
        if(maxHsp > 0 && maxHsp > hsp){
            hsp += min(maxHsp - hsp, jetpackAccel*horPor);
        } else if (maxHsp < 0 && maxHsp < hsp){
            hsp += max(maxHsp - hsp, jetpackAccel*horPor);
        }
        if(maxVsp < 0 && maxVsp < vsp){
            vsp += max(maxVsp - vsp, -jetpackAccel*verPor);
        } else if(maxVsp > 0 && maxVsp > vsp){
            vsp += min(maxVsp - vsp, -jetpackAccel*verPor);
        }
    } else {
        if(jetpackSfxIndexToStop){
            sound_stop(jetpackSfxIndexToStop);
            jetpackSfxIndexToStop = 0;
        }
    }
}


#define changeDuckState(newDuckState)
if(duckState != newDuckState){
    duckState = newDuckState;
    duckStateTimer = 0;
}