/* [DIMENSIONS] */
DEPTH = 10;
BOTTOM_PLATE_THICKNESS = 4;
BOTTOM_PLATE_LENGTH = 70;

ROUTER_THICKNESS = 26;
HOLDER_WALL = 4;
HOLDER_THICKNESS = ROUTER_THICKNESS + 2*HOLDER_WALL;

STABLIZER_HEIGHT = 50;
STABILIZER_VERTEX_RADIUS = 1;
HOLDER_HEIGHT = 55;

DEBUG = false;

/* [HIDDEN] */
$fn = 128;


rotate([90,0,0])
render();

module render(){
    base();
    translate([0,0,BOTTOM_PLATE_THICKNESS])
    holder();
}



module base(){
    color("blue")
    translate([0,0,BOTTOM_PLATE_THICKNESS/2])
    cube([BOTTOM_PLATE_LENGTH, DEPTH, BOTTOM_PLATE_THICKNESS], true);    
    
}

module holder(){
    difference(){
        union(){
            translate([0,0,HOLDER_HEIGHT/2])            
            cube([HOLDER_THICKNESS, DEPTH, HOLDER_HEIGHT], true);        
            stabilizer();
        }
        color("red")
        translate([0,0,HOLDER_HEIGHT*1.1/2])        
        cube([ROUTER_THICKNESS, DEPTH*2, HOLDER_HEIGHT*1.1], true);      
    }
    
    if(DEBUG){
        color("green")
        stablizer_points(20);
    }
}

module stabilizer(){
    hull(){
        stablizer_points(DEPTH);
    }    
}

module stablizer_points(depth){
    offset_x = BOTTOM_PLATE_LENGTH/2- STABILIZER_VERTEX_RADIUS;
    
//    translate([0,0,STABILIZER_VERTEX_RADIUS])
    union(){
        translate([offset_x,0,0])
        base_cylinder(depth);
        
        translate([0,0,STABLIZER_HEIGHT])
        base_cylinder(depth);
        
        translate([-offset_x,0,0])
        base_cylinder(depth);    
    }
}

module base_cylinder(depth){
    rotate([90,0,0])
    cylinder(depth, STABILIZER_VERTEX_RADIUS, STABILIZER_VERTEX_RADIUS, true);
}