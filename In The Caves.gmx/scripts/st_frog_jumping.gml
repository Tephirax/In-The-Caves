var t; // time
t = argument1;
switch(argument0)
{
    case 0: // Action to be performed upon state initialisation
        show_debug_message("obj_frog changes state to st_frog_jumping");
        // Reset variables
        pdir = 0;
        pdist = 0;
        x_axis_value = 0;
        y_axis_value = 0;
        jumpPower = 0;
        jumpDir = 0;
        
        keyJumpPressed = -1;
        keyJump = false;
        stickJumpPressed = false;
        stickJump = false;
        buttonJumpPressed = -1;
        buttonJump = false;
        
        // Change sprite
        if ( jump_direction != 270 ) {
            sprite_index = spr_frogjump;
            if ( jump_direction < 90 || jump_direction > 270 ) {
                image_xscale = 1;    
            } else {
                image_xscale = -1;
            }
        }
        
        // Apply physics force
        physics_apply_local_impulse(x, y - 8, lengthdir_x(jump_energy, jump_direction), lengthdir_y(jump_energy, jump_direction));
        
        // Play sound
        audio_play_sound(snd_Jump, 0, false);
        break;
    case 1: // Action to be performed before state is replaced
        break;
    case 2: // Action 0 to be performed in Step event        
        // Check if frog has returned to ground
        if ( t > 30 && jump_test == true ) {
            show_debug_message("Frog has touched down");
            sprite_index = spr_frog;
            statechange(st_frog_idle);
        }
        
        if ( t == 40 ) {
            sprite_index = spr_frog;
        }
        break;
}
