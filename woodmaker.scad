// Woodmaker

include <MCAD/stepper.scad>;
include <MCAD/bearing.scad>;

cdist = 18; // distance between 6mm rods on ultimaker
r608 = 22;
h608 = 7;

pulley_r = 16/2;
pulley_h = 17;

xr  = 8/2;
yh = 337;
yr  = 8/2;
xh = 348;
rodsides = 16;
module x_rod() {
    // X rods

color("cyan") translate([0,0,0]) rotate([-90,0,0]) cylinder(r=xr, h=xh , $fn=rodsides);
//translate([0,0,0]) rotate([-90,0,0]) cylinder(r=xr, h=xh );
}

module pulley() {
    color("red") translate([0,0,0]) rotate([-90,0,0]) cylinder(r=pulley_r, h=pulley_h, $fn=rodsides );
}
module y_rod() {
// Y rods

color("cyan") translate([0,0,0]) rotate([0,90,0]) cylinder(r=yr, h=yh, $fn=rodsides );
//translate([0,0,0]) rotate([0,90,0]) cylinder(r=yr, h=yh );
}

// cross rods
cr  = 6/2;
ch = 268;
translate([-ch/2,40,347]) rotate([0,90,0]) cylinder(r=cr, h=ch, $fn=rodsides);
translate([10,-ch/2-10,347+cdist]) rotate([-90,0,0]) cylinder(r=cr, h=ch, $fn=rodsides);

// Z rods
zr  = 12/2;
zh = 339;
translate([0,0,-400]) rotate([0,0,0]) cylinder(r=zr, h=zh, $fn=rodsides);
translate([0,0,-400]) rotate([0,0,0]) cylinder(r=zr, h=zh, $fn=rodsides);

// 608 bearing




pulley();


//translate([100,0,-50]) rotate([-90,0,0]) motor(Nema17);
//translate([-100,0,0]) rotate([90,0,0]) bearing(model=608);

// Wood walls
wall = 7;


uscale = 10;
//color("gray") scale([uscale,uscale,uscale]) rotate([90,0,0]) import("Ultimaker.stl", convexity=10);
translate([-142,-200,300])cube([284,10,10]);

// mina träplattor
ux = 325;
uy = 338;
uz = 390+0;

module wallmount() {
    
    skruv_distance = wall+3;
    
    translate([8*1.5-4,0,wall-2])rotate([0,90,0]) wallmount_printed_part();
    color("cyan") translate([-wall-2,0,wall-2])rotate([0,90,0]) cylinder(r=5/2,h=2, $fn=6);
    color("cyan") translate([-wall-2,0,wall-2-skruv_distance])rotate([0,90,0]) cylinder(r=5/2,h=2, $fn=6);
    
    color("cyan") translate([-wall-2,0,wall-2])rotate([0,90,0]) cylinder(r=3/2,h=25, $fn=16);
    color("cyan") translate([-wall-2,0,wall-2-skruv_distance])rotate([0,90,0]) cylinder(r=3/2,h=25, $fn=16);
    
}
module wallmount_printed_part() {
    radie = (3+5)/2; // skruv och mutters radie
    skruv_distance = wall+3;
    tjock = 6;
    mutter_m3 = (5 + 0.2)/2;
    mutter_z = 2;
    skruv_m3 = (3+0.2)/2;
    
    color([1,0.2,0]) difference() {
        hull() {
            translate([skruv_distance,0,0]) cylinder(r=radie,h=tjock, $fn=16);
            cylinder(r=radie,h=tjock, $fn=16);
        }
        //mutter
        translate([0,0,tjock-mutter_z]) cylinder(r=mutter_m3,h=mutter_z*1.5, $fn=6);
        translate([skruv_distance,0,tjock-mutter_z]) cylinder(r=mutter_m3,h=mutter_z*1.5, $fn=6);
        //skruvhålet
        translate([0,0,tjock-tjock*2]) cylinder(r=skruv_m3,h=tjock*2*1.5, $fn=20);
        translate([skruv_distance,0,tjock-tjock*2]) cylinder(r=skruv_m3,h=tjock*2*1.5, $fn=20);
    }
    
}
translate([-ux/2,0,378+wall/2]) wallmount();
module fras(x=10, y=10, r=4) {
    hull() {
        translate([x,y,0]) cylinder(r=r,h=10, $fn=16);
        cylinder(r=r,h=10);
    }
}
fras(x=0,y=30);

slot_l = 20;
wallplus = wall + 2;
module top() {
    
    slot_w = 8;
    window_x = 250;
    window_y = 250;
    
    
    difference() {
        union() {
            translate([0,0,0]) cube([ux,uy,wall]);
            //sidoutstickare
            translate([-wallplus,uy*1/4-slot_l/2-uy/8,0]) cube([wallplus,slot_l,wall]); 
            translate([-wallplus,uy*2/4-slot_l/2-uy/8,0]) cube([wallplus,slot_l,wall]); 
            translate([-wallplus,uy*3/4-slot_l/2-uy/8,0]) cube([wallplus,slot_l,wall]); 
            translate([-wallplus,uy*4/4-slot_l/2-uy/8,0]) cube([wallplus,slot_l,wall]); 
        }
        
        
        
        //slots
        translate([slot_w*1.5,uy/2-slot_l/2,-1]) fras(x=0,y=slot_l);//cube([slot_w,slot_l,wall*2]);   // 2/4 mitten
        translate([slot_w*1.5,uy/4-slot_l/2,-1]) fras(x=0,y=slot_l);   // 1/4
        translate([slot_w*1.5,uy*3/4-slot_l/2,-1]) fras(x=0,y=slot_l); // 3/4
        
        //window
        translate([(ux-window_x)/2,(uy-window_y)/2,-1]) cube([window_x,window_y,wall*2]);
    }
}

module sida() {
    color([0.8,0.8,0.1]) difference() {
        cube([wall,uy,uz]);
        //translate([-1,-wall-2+(uy+(wall+2)*2)/5,378+4]) rotate([0,90,0]) fras(x=0,y=(uy+(wall+2)*2)/5);
        translate([-1,uy*1/4-slot_l/2-uy/8,378+4]) rotate([0,90,0]) fras(x=0, y=slot_l); 
        translate([-1,uy*2/4-slot_l/2-uy/8,378+4]) rotate([0,90,0]) fras(x=0, y=slot_l);  
        translate([-1,uy*3/4-slot_l/2-uy/8,378+4]) rotate([0,90,0]) fras(x=0, y=slot_l); 
        translate([-1,uy*4/4-slot_l/2-uy/8,378+4]) rotate([0,90,0]) fras(x=0, y=slot_l); 
        
        //skruvhål
        translate([-1,uy*1/4,378-1.5]) rotate([0,90,0]) fras(x=0, y=0, r=3/2); 
        translate([-1,uy*2/4,378-1.5]) rotate([0,90,0]) fras(x=0, y=0, r=3/2); 
        translate([-1,uy*3/4,378-1.5]) rotate([0,90,0]) fras(x=0, y=0, r=3/2); 
        //övre skruvhål
        translate([-1,uy*1/4,378+1.5+wall]) rotate([0,90,0]) fras(x=0, y=0, r=3/2); 
        translate([-1,uy*2/4,378+1.5+wall]) rotate([0,90,0]) fras(x=0, y=0, r=3/2); 
        translate([-1,uy*3/4,378+1.5+wall]) rotate([0,90,0]) fras(x=0, y=0, r=3/2); 
        
    }
}
//top
translate([-ux/2,-uy/2,378]) top();
//höger
translate([-ux/2-wall,-uy/2,0]) sida();
//vänster
translate([ux/2,-uy/2,0]) sida();
//bak
translate([-ux/2,uy/2,0])cube([ux,wall,uz]);
//fram
translate([-ux/2,-uy/2-wall,0])cube([ux,wall,uz]);
//botten
//translate([-ux/2,-uy/2,0])cube([ux,uy,wall]);

// Rods
translate([ch/2+xr*2,-uy/2,347]) x_rod();
translate([-ch/2-xr*2,-uy/2,347]) x_rod();

translate([-ux/2,ch/2+xr*2,347+cdist+20]) y_rod();
translate([-ux/2,-ch/2-xr*2,347+cdist]) y_rod();
