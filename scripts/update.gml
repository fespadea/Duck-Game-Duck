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
    jump_speed = standJumpSpeed;
    short_hop_speed = standHopSpeed;
    max_jump_hsp = standJumpHsp;
    leave_ground_max = standLeaveGroundHsp;
    air_max_speed = standAirHsp;
    max_fall = standMaxFall;
} else if(duckState == DS_CROUCH){
    if(state == PS_DASH_START){
        set_state(PS_IDLE);
    }
    ground_friction = slideGroundFriction;
    air_friction = slideAirFriction;
    jump_speed = slideJumpSpeed;
    short_hop_speed = slideHopSpeed;
    max_fall = slideMaxFall;
    if((hsp > 0 && hsp > prevHsp) || (hsp < 0 && hsp < prevHsp)) hsp = prevHsp;
    var absoluteHsp = abs(hsp); //avoiding negatives
    max_jump_hsp = absoluteHsp*.8;
    leave_ground_max = absoluteHsp*.8;
    air_max_speed = absoluteHsp*.8;
}
prevHsp = hsp;
prevVsp = vsp;

//floating mechanic
var floatable = (state_cat == SC_AIR_NEUTRAL || state == PS_WALL_JUMP) && duckState == DS_STAND;
var floatInput = jump_down || (up_down && can_tap_jump());
if(!floatInput || !floatable){
    floatActive = false;
} else if (floatable) {
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
if floatActive {
    max_fall = standMaxFall/3;
    if (vsp > max_fall) {
        vsp = max_fall;
    }
}