/// chkControls(currentState, t)
currentState = argument0;
t = argument1;

// If the menu isn't open
if ( !GameState.isMenu ) {

    // Gamepad controls
    if ( (argument0 == st_frog_idle && jump_test == true) || (argument0 == st_frog_jumping && wall_test == true) ) {
        var h_point = gamepad_axis_value(0, gp_axislh);
        var v_point = gamepad_axis_value(0, gp_axislv);
        if ((h_point != 0) || (v_point != 0))
        {
            if ( t mod 4 == 0 ) {
                pdir = point_direction(0, 0, h_point, v_point);
                pdist = point_distance(0, 0, h_point, v_point);
                x_axis_value = h_point;
                y_axis_value = v_point;
                if ( pdist > 0.2 ) {
                    stickJumpPressed = true;
                    jumpDir = pdir;
                    if ( pdist > jumpPower ) {
                        jumpPower = pdist;
                    }
                }
                //show_debug_message("jumpDir = " + string(jumpDir) + ", jumpPower = " + string(jumpPower));
            }
        }
        else if ( buttonJumpPressed == -1 ) {
            // Specific jump angles on shoulder triggers/buttons
            if ( gamepad_button_value(0, gp_shoulderl) ) {
                jumpDir = 290;
                jumpPower = 0.8; 
                buttonJumpPressed = 0;
                //show_debug_message("Left shoulder button pressed.");
            }
            else if ( gamepad_button_value(0, gp_shoulderr) ) {
                jumpDir = 250;
                jumpPower = 0.8; 
                buttonJumpPressed = 1;
                //show_debug_message("Right shoulder button pressed.");
            }
            else if ( gamepad_button_value(0, gp_shoulderlb) > 0.8 ) {
                jumpDir = 330;
                jumpPower = 0.6; 
                buttonJumpPressed = 2;
                //show_debug_message("Left trigger pressed.");
            }
            else if ( gamepad_button_value(0, gp_shoulderrb) > 0.8 ) {
                jumpDir = 210;
                jumpPower = 0.6; 
                buttonJumpPressed = 3;
                //show_debug_message("Right trigger pressed.");
            }
        }
        
        if ( (buttonJumpPressed == 0 && !gamepad_button_value(0, gp_shoulderl))
           ||(buttonJumpPressed == 1 && !gamepad_button_value(0, gp_shoulderr))
           ||(buttonJumpPressed == 2 && gamepad_button_value(0, gp_shoulderlb) < 0.2)
           ||(buttonJumpPressed == 3 && gamepad_button_value(0, gp_shoulderrb) < 0.2) ) {
            buttonJumpPressed = -1;
            buttonJump = true;
        }
        else if ( stickJumpPressed && abs(h_point) < 0.1 && abs (v_point) < 0.1 ) {
            stickJumpPressed = false;
            stickJump = true;
        }
                
        // If absolute value of either x/y_axis_value was > 0.4 (pressed in a direction), and both are now < 0.1 (centred), jump...
        //if ( ((abs(x_axis_value) > 0.4 || abs(y_axis_value) > 0.4) && (abs(h_point) < 0.1 && abs(v_point) < 0.1)) || buttonJump ) {
        if ( stickJump || buttonJump ) {
            jump_direction = jumpDir;
            show_debug_message("Jumping in direction " + string(jump_direction));
            jump_energy = jumpPower * jump_force;
            show_debug_message("Jump energy = " + string(jump_energy));
            
            // Call jumping state
            statechange(st_frog_jumping);
        }
    }


    // Enable Up to regenerate level even mid-jump
    if ( (keyboard_check(vk_up) || gamepad_button_value(0, gp_face4)) ) {
        keyboard_clear(vk_up);
        if ( instance_exists(obj_door) ) {
            //var dist = point_distance(x, y, obj_door.x, obj_door.y);
            //if ( dist < 64 ) {
                GameState.doorActive = true;
                show_debug_message("Door activated");
            //}
        }
    }
    // If frog is in the idle state
    else if ( argument0 == st_frog_idle ) {
        if ( keyboard_check(vk_left) ) {
            statechange(st_frog_jumpleft);
        }
        else if ( keyboard_check(vk_right) ) {
            statechange(st_frog_jumpright);
        }
    }
}
