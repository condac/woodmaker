// Woodmaker

include <MCAD/stepper.scad>;
include <MCAD/bearing.scad>;

cdist = 18; // distance between 6mm rods on ultimaker
r608 = 22;
h608 = 7;

pulley_r = 16/2;
pulley_h = 17;



module x_rod() {
    // X rods
xr  = 8/2;
xh = 337;
color("cyan") translate([0,0,0]) rotate([-90,0,0]) cylinder(r=xr, h=xh );
//translate([0,0,0]) rotate([-90,0,0]) cylinder(r=xr, h=xh );
}

module pulley() {
    color("red") translate([0,0,0]) rotate([-90,0,0]) cylinder(r=pulley_r, h=pulley_h );
}
module y_rod() {
// Y rods
yr  = 8/2;
yh = 348;
color("cyan") translate([0,0,0]) rotate([0,90,0]) cylinder(r=yr, h=yh );
//translate([0,0,0]) rotate([0,90,0]) cylinder(r=yr, h=yh );
}

// cross rods
cr  = 6/2;
ch = 268;
translate([-ch/2,40,347]) rotate([0,90,0]) cylinder(r=cr, h=ch, $fn=16 );
translate([10,-ch/2-10,347+cdist]) rotate([-90,0,0]) cylinder(r=cr, h=ch, $fn=16  );

// Z rods
zr  = 12/2;
zh = 339;
translate([0,0,-400]) rotate([0,0,0]) cylinder(r=zr, h=zh );
translate([0,0,-400]) rotate([0,0,0]) cylinder(r=zr, h=zh );

// 608 bearing


translate([0,0,0]) x_rod();
translate([300,0,0]) x_rod();

translate([0,0,cdist]) y_rod();
translate([0,300,cdist]) y_rod();

pulley();


translate([100,0,-50]) rotate([-90,0,0]) motor(Nema17);
translate([-100,0,0]) rotate([90,0,0]) bearing(model=608);

// Wood walls
wall = 6;
translate([00,-wall,-100])cube([100,wall,100]);
translate([-wall,0,-100])cube([wall,100,100]);

uscale = 10;
color("gray") scale([uscale,uscale,uscale]) rotate([90,0,0]) import("Ultimaker.stl", convexity=10);
translate([-142,-200,300])cube([284,10,10]);

// mina träplattor
ux = 325;
uy = 338;
uz = 390;


//top
//translate([-ux/2,-uy/2,378])cube([ux,uy,6]);
//höger
translate([-ux/2-wall,-uy/2,0])cube([wall,uy,uz]);
//vänster
translate([ux/2,-uy/2,0])cube([wall,uy,uz]);
//bak
translate([-ux/2,uy/2,0])cube([ux,wall,uz]);
//fram
translate([-ux/2,-uy/2-wall,0])cube([ux,wall,uz]);
//botten
//translate([-ux/2,-uy/2,0])cube([ux,uy,wall]);
