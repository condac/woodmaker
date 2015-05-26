z_mellan = 160;
z_y = 21;
z_d = 12.6;
z_hole = 15;

nema_xy = 42;
nema_screw = 31;

screw = 3;
screw_distance = 100;
wall = 3;
h = 4;
ply = 8;

difference() {
    union() {
        difference() {
            
        }
        hull() {
            translate([z_mellan/2,0,0]) cylinder(d=z_d+wall*2, h=h, $fn=30);
            translate([-z_mellan/2,0,0]) cylinder(d=z_d+wall*2, h=h, $fn=30);
            
            translate([-z_mellan/2-wall/2-z_d/2,0,0]) cube([z_mellan+wall+z_d,z_y,h]);
            
        }
        //nema platta
        translate([-nema_xy/2,-nema_xy/2,0]) cube([nema_xy, nema_xy, h]);
        //uppstickande hål
        translate([z_mellan/2,0,0]) cylinder(d=z_hole, h=h+ply, $fn=30);
        translate([-z_mellan/2,0,0]) cylinder(d=z_hole, h=h+ply, $fn=30);
    }
    translate([screw_distance/2,0,-1]) cylinder(d=screw, h=h*3, $fn=30);
    translate([-screw_distance/2,0,-1]) cylinder(d=screw, h=h*3, $fn=30);
    translate([z_mellan/2,0,h]) cylinder(d=z_d, h=h*3+ply, $fn=30);
    translate([-z_mellan/2,0,h]) cylinder(d=z_d, h=h*3+ply, $fn=30);
    
    //nema hål
    translate([-nema_screw/2,nema_screw/2,-1]) cylinder(d=screw, h=h*3, $fn=30);
    translate([-nema_screw/2,-nema_screw/2,-1]) cylinder(d=screw, h=h*3, $fn=30);
    translate([nema_screw/2,-nema_screw/2,-1]) cylinder(d=screw, h=h*3, $fn=30);
    translate([nema_screw/2,nema_screw/2,-1]) cylinder(d=screw, h=h*3, $fn=30);
    translate([0,0,-1]) cylinder(d=23, h=h*3, $fn=30);
}
