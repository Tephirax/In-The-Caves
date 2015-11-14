/// doSimulationStep(birthLimit, deathLimit)
// Run cave creation simulation one step
birthLimit = argument0;
deathLimit = argument1;

// Loop over each row & column of the map
for ( r1 = 0; r1 < numRows; r1++ ) {
    for ( c1 = 0; c1 < numColumns; c1++ ) {
        // Count how many rocks are around the square in question
        var nbs = countAliveNeighbours(c1, r1);
        // Create new value based on the simulation rules
        // If a cell is on the left, right or bottom edge of the map, make it rock
        if ( c1 == 0 || c1 == numColumns - 1 || r1 == numRows - 1 ) {
            newgrid[# c1, r1] = true;
        }
        // If a cell is rock but has too few neighbours, remove it
        else if ( mapgrid[# c1, r1] ) {
            if ( nbs < deathLimit ) {
                newgrid[# c1, r1] = false; 
//                show_debug_message("Code a: Rock removed from c, r: " + string(c1) + ", " + string(r1));           
            } else {
                newgrid[# c1, r1] = true;
//                show_debug_message("Code b: Rock remains at c, r: " + string(c1) + ", " + string(r1));
            }
        }
        // Otherwise, if the cell is empty, check if it has enough neighbours to be 'born'
        else {
            if ( nbs > birthLimit ) {
                newgrid[# c1, r1] = true;            
//                show_debug_message("Code c: Rock born at c, r: " + string(c1) + ", " + string(r1));           
            }
        }
    }
}

// Clear mapgrid
ds_grid_clear(mapgrid, false);

// Copy updated newgrid to mapgrid
ds_grid_copy(mapgrid, newgrid);
