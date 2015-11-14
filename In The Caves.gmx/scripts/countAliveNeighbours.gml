/// countAliveNeighbours(column, row)
var column = argument0;
var row = argument1;

var count = 0;

// Check each square around the tile in question to see how many contain rocks
for (col = -1; col < 2; col++) {
    for (rw = -1; rw < 2; rw++) {
        var neighbour_c = column + col;
        var neighbour_r = row + rw;
        // If looking at the middle point...
        if ( col == 0 && rw == 0 ) {
            //...do nothing
        }
        // Check for cases where the index is off the edge of the map & count if true
        else if (neighbour_c < 0 || neighbour_r < 0 || neighbour_c >= numColumns || neighbour_r >= numRows )  {
            count = count + 1;
        }
        // Otherwise, compare neighbouring cell
        else if ( mapgrid[# neighbour_c, neighbour_r] == true ) {
            count = count + 1;
        }
    }
}

return count;
