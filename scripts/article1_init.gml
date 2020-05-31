// arm init (uses the article template for the most part)

//wing sprites
wingIdleSprite = sprite_get("wing_idle");
wingCrouchSprite = sprite_get("wing_crouch");
wingWalkSprite = sprite_get("wing_walk");
windJumpSprite = sprite_get("wing_jump");
wingGlideSprite = sprite_get("wing_glide");

// sprite and direction
sprite_index = wingIdleSprite;
image_index = 0;
spr_dir = player_id.spr_dir;
depth = player_id.depth - 1;
uses_shader = true;

//State
wingState = 0;
wingStateTimer = 0;
hitstop = 0;
hsp = 0;
vsp = 0;
exist_timer = 0;
