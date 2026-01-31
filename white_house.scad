// White House Approximation in OpenSCAD
// This script creates a simplified 3D model of the White House
// including the main residence, porticos, and wings

// Main parameters (all dimensions in arbitrary units, approximately meters)
main_building_width = 52;  // Width of main building
main_building_depth = 26;  // Depth of main building
main_building_height = 21; // Height of main building

wing_width = 20;   // Width of each wing
wing_depth = 15;   // Depth of each wing
wing_height = 15;  // Height of each wing

column_radius = 0.8;  // Radius of columns
column_height = 12;   // Height of columns

// Color definitions
building_color = [0.95, 0.95, 0.90]; // Off-white
roof_color = [0.3, 0.3, 0.3]; // Dark gray
column_color = [1, 1, 1]; // White

// Main module to create the entire White House
module white_house() {
    // Main central building
    main_building();
    
    // North Portico (front entrance)
    translate([0, -main_building_depth/2 - 3, 0])
        north_portico();
    
    // South Portico (back entrance)
    translate([0, main_building_depth/2 + 3, 0])
        south_portico();
    
    // East Wing
    translate([main_building_width/2 + wing_width/2 + 2, 0, 0])
        wing();
    
    // West Wing
    translate([-main_building_width/2 - wing_width/2 - 2, 0, 0])
        wing();
}

// Main building (center block)
module main_building() {
    color(building_color) {
        // Main structure
        translate([0, 0, main_building_height/2])
            cube([main_building_width, main_building_depth, main_building_height], center=true);
        
        // Roof
        color(roof_color)
            translate([0, 0, main_building_height])
                roof(main_building_width, main_building_depth, 4);
    }
}

// North Portico with columns
module north_portico() {
    portico_width = 20;
    portico_depth = 8;
    portico_height = 3;
    
    // Portico base platform
    color(building_color)
        translate([0, 0, portico_height/2])
            cube([portico_width, portico_depth, portico_height], center=true);
    
    // Columns (6 columns across the front)
    num_columns = 6;
    column_spacing = portico_width / (num_columns + 1);
    
    for (i = [1:num_columns]) {
        translate([
            -portico_width/2 + i * column_spacing,
            0,
            portico_height
        ])
            column();
    }
    
    // Portico roof
    color(building_color)
        translate([0, 0, portico_height + column_height])
            cube([portico_width, portico_depth, 2], center=true);
    
    // Triangular pediment
    color(building_color)
        translate([0, -portico_depth/2, portico_height + column_height + 1])
            rotate([90, 0, 0])
                linear_extrude(height=0.5)
                    polygon([
                        [-portico_width/2, 0],
                        [portico_width/2, 0],
                        [0, 4]
                    ]);
}

// South Portico (similar but semi-circular)
module south_portico() {
    portico_width = 18;
    portico_depth = 8;
    portico_height = 3;
    
    // Portico base platform with curved front
    color(building_color) {
        translate([0, 0, portico_height/2])
            cube([portico_width, portico_depth, portico_height], center=true);
        
        // Curved extension
        translate([0, portico_depth/2, portico_height/2])
            cylinder(h=portico_height, r=portico_width/2, center=true, $fn=50);
    }
    
    // Columns in a semi-circle
    num_columns = 8;
    for (i = [0:num_columns-1]) {
        angle = 180 * i / (num_columns - 1) - 90;
        translate([
            (portico_width/2) * cos(angle),
            portico_depth/2 + (portico_width/2) * sin(angle),
            portico_height
        ])
            column();
    }
    
    // Portico roof (circular)
    color(building_color)
        translate([0, portico_depth/2, portico_height + column_height])
            cylinder(h=2, r=portico_width/2, center=true, $fn=50);
}

// Wing buildings
module wing() {
    color(building_color) {
        // Wing structure
        translate([0, 0, wing_height/2])
            cube([wing_width, wing_depth, wing_height], center=true);
        
        // Wing roof
        color(roof_color)
            translate([0, 0, wing_height])
                roof(wing_width, wing_depth, 3);
    }
}

// Column module
module column() {
    color(column_color) {
        // Column base
        translate([0, 0, 0.5])
            cylinder(h=1, r1=column_radius*1.3, r2=column_radius, center=true, $fn=30);
        
        // Column shaft
        translate([0, 0, column_height/2 + 1])
            cylinder(h=column_height-2, r=column_radius, center=true, $fn=30);
        
        // Column capital
        translate([0, 0, column_height - 0.5])
            cylinder(h=1, r1=column_radius, r2=column_radius*1.3, center=true, $fn=30);
    }
}

// Roof module (simple hip roof)
module roof(width, depth, height) {
    // Use hull to create a proper hip roof
    hull() {
        // Base
        translate([0, 0, 0])
            cube([width, depth, 0.1], center=true);
        // Top (smaller)
        translate([0, 0, height])
            cube([width - 6, depth - 6, 0.1], center=true);
    }
}

// Render the complete White House
white_house();
