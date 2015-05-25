bearing = 22.6;
woodhole = 25.5;
screw = 3;
screw_distance = 35;
wall = 1;
h = 10;
off = 1;
difference() {
    union() {
        difference() {
    translate([0,0,0]) cylinder(d=woodhole, h=h, $fn=30);
    translate([off,0,wall]) cylinder(d=bearing, h=h, $fn=30);
}
    hull() {
        
        translate([screw_distance/2,0,0]) cylinder(d=screw*2, h=wall, $fn=30);
        translate([-screw_distance/2,0,0]) cylinder(d=screw*2, h=wall, $fn=30);
        translate([0,0,0]) cylinder(d=woodhole, h=wall, $fn=30);
    }
}
    translate([screw_distance/2,0,-1]) cylinder(d=screw, h=h, $fn=30);
    translate([-screw_distance/2,0,-1]) cylinder(d=screw, h=h, $fn=30);
    translate([off,0,-1]) cylinder(d=10, h=h, $fn=30);
}
