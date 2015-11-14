var t; // time
t = argument1;
switch(argument0)
{
    case 0: // Action to be performed upon state initialisation
        show_debug_message("obj_frog changes state to st_frog_jumpright");
        // Apply physics force
        physics_apply_force(x, y, 120, -120);
        break;
    case 1: // Action to be performed before state is replaced
        phy_rotation = 0;
        break;
    case 2: // Action 0 to be performed in Step event
        // Check if frog has returned to ground
        if ( t > 30 && physics_test_overlap(x, y + 1, 0, obj_collision) ) {
            show_debug_message("Frog has touched down");
            statechange(st_frog_idle);
        }
        break;
}
