//update

//duckState control
if(down_hard_pressed || state == PS_CROUCH){
    duckState = DS_CROUCH;
} else if(!down_down){
    duckState = DS_STAND;
}

//friction control
if(duckState == DS_STAND){
    ground_friction = standGroundFriction;
    air_friction = standAirFriction;
} else if(duckState == DS_CROUCH){
    ground_friction = slideGroundFriction;
    air_friction = slideAirFriction;
}