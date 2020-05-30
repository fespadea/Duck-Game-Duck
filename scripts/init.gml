hurtbox_spr = sprite_get("hurtbox");
crouchbox_spr = sprite_get("crouchbox");
air_hurtbox_spr = sprite_get("airbox");
hitstun_hurtbox_spr = -1;

char_height = 32;
idle_anim_speed = 0;
crouch_anim_speed = 0;
walk_anim_speed = .1;
dash_anim_speed = .2;
pratfall_anim_speed = .25;

walk_speed = 3;
walk_accel = 0.2;
walk_turn_time = 6;
initial_dash_time = 14;
initial_dash_speed = 6;
dash_speed = initial_dash_speed;
dash_turn_time = 10;
dash_turn_accel = 2;
dash_stop_time = 4;
dash_stop_percent = .35; //the value to multiply your hsp by when going into idle from dash or dashstop
ground_friction = .6;
moonwalk_accel = 1.4;

jump_start_time = 5;
jump_speed = 12;
short_hop_speed = 8;
djump_speed = 12;
leave_ground_max = 7; //the maximum hsp you can have when you go from grounded to aerial without jumping
max_jump_hsp = 7; //the maximum hsp you can have when jumping from the ground
air_max_speed = 5; //the maximum hsp you can accelerate to when in a normal aerial state
jump_change = 3; //maximum hsp when double jumping. If already going faster, it will not slow you down
air_accel = .325;
prat_fall_accel = .85; //multiplier of air_accel while in pratfall
air_friction = .04;
max_djumps = 0;
double_jump_time = 32; //the number of frames to play the djump animation. Can't be less than 31.
walljump_hsp = 7;
walljump_vsp = 11;
walljump_time = 32;
max_fall = 10; //maximum fall speed without fastfalling
fast_fall = max_fall+1; //fast fall speed (this value just needs to be a speed duck can't reach since they can't fast fall)
gravity_speed = .5;
hitstun_grav = .5;
knockback_adj = 1.2; //the multiplier to KB dealt to you. 1 = default, >1 = lighter, <1 = heavier

land_time = 4; //normal landing frames
prat_land_time = 3;
wave_land_time = 8;
wave_land_adj = 1.35; //the multiplier to your initial hsp when wavelanding. Usually greater than 1
wave_friction = .12; //grounded deceleration when wavelanding

//crouch animation frames
crouch_startup_frames = 1;
crouch_active_frames = 1;
crouch_recovery_frames = 1;

//parry animation frames
dodge_startup_frames = 1;
dodge_active_frames = 1;
dodge_recovery_frames = 3;

//tech animation frames
tech_active_frames = 3;
tech_recovery_frames = 1;

//tech roll animation frames
techroll_startup_frames = 2
techroll_active_frames = 2;
techroll_recovery_frames = 2;
techroll_speed = 10;

//airdodge animation frames
air_dodge_startup_frames = 1;
air_dodge_active_frames = 2;
air_dodge_recovery_frames = 3;
air_dodge_speed = 7.5;

//roll animation frames
roll_forward_startup_frames = 2;
roll_forward_active_frames = 4;
roll_forward_recovery_frames = 2;
roll_back_startup_frames = 2;
roll_back_active_frames = 4;
roll_back_recovery_frames = 2;
roll_forward_max = 9; //roll speed
roll_backward_max = 9;

land_sound = asset_get("sfx_land_med");
landing_lag_sound = asset_get("sfx_land");
waveland_sound = asset_get("sfx_waveland_zet");
jump_sound = asset_get("sfx_jumpground");
djump_sound = asset_get("sfx_jumpair");
air_dodge_sound = asset_get("sfx_quick_dodge");

//visual offsets for when you're in Ranno's bubble
bubble_x = 0;
bubble_y = 8;

// duck states
DS_STAND = 0;
DS_CROUCH = 1;
// duck uses custom states
duckState = DS_STAND;

//duck sprites
idleSprite[1] = sprite_get("idle_quack");
idleSprite[0] = sprite_get("idle");
crouchSprite[1] = sprite_get("crouch_quack");
crouchSprite[0] = sprite_get("crouch");
walkSprite[1] = sprite_get("walk_quack");
walkSprite[0] = sprite_get("walk");
jumpSprite[1] = sprite_get("jump_quack");
jumpSprite[0] = sprite_get("jump");
slideSprite[1] = sprite_get("slide_quack");
slideSprite[0] = sprite_get("slide");
hurtSprite[1] = sprite_get("hurt_quack");
hurtSprite[0] = sprite_get("hurt");

//wing sprites
wingIdleSprite = sprite_get("wing_idle");
wingCrouchSprite = sprite_get("wing_crouch");
wingWalkSprite = sprite_get("wing_walk");
windJumpSprite = sprite_get("wing_jump");
wingGlideSprite = sprite_get("wing_glide");
//left wing sprites
wingLeftJumpSprite = sprite_get("wing_left_jump");
wingLeftGlideSprite = sprite_get("wing_left_glide");

//wing article
wingArticle = instance_create(x, y, "obj_article1");

//duck animation variables
duckSpriteIndex = idleSprite;
duckImageIndex = 0;

//attribute variables
//DS_STAND
standGroundFriction = ground_friction;
standAirFriction = air_friction;
standMaxFall = max_fall;
standJumpSpeed = jump_speed;
standHopSpeed = short_hop_speed;
standJumpHsp = max_jump_hsp;
standLeaveGroundHsp = leave_ground_max;
standAirHsp = air_max_speed;
//DS_CROUCH
slideGroundFriction = ground_friction/3;
slideAirFriction = air_friction/3;
slideJumpSpeed = jump_speed/2;
slideHopSpeed = short_hop_speed/2;
slideMaxFall = max_fall;

//previous speeds
prevVsp = vsp;
prevHsp = hsp;

//float variable
floatActive = false;

//variable to indicate that the left arm needs to be drawn for falling
fallingSoDrawLeft = false;