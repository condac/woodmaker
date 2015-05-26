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
//translate([-ch/2,40,347]) rotate([0,90,0]) cylinder(r=cr, h=ch, $fn=rodsides);
//translate([10,-ch/2-10,347+cdist]) rotate([-90,0,0]) cylinder(r=cr, h=ch, $fn=rodsides);

// Z rods
zr  = 12/2;
zh = 339;
//translate([0,0,-400]) rotate([0,0,0]) cylinder(r=zr, h=zh, $fn=rodsides);
//translate([0,0,-400]) rotate([0,0,0]) cylinder(r=zr, h=zh, $fn=rodsides);

// 608 bearing




//pulley();


//translate([100,0,-50]) rotate([-90,0,0]) motor(Nema17);
//translate([-100,0,0]) rotate([90,0,0]) bearing(model=608);

// Wood walls
wall = 8;


uscale = 10;
//color("gray") scale([uscale,uscale,uscale]) rotate([90,0,0]) import("Ultimaker.stl", convexity=10);
//translate([-142,-200,300])cube([284,10,10]);

// mina träplattor
ux = 326;  //330
uy = 337.5  ;  //341
uz = 390+0;

minz = 440;

module wallmount() {
    
    skruv_distance = 20;
    
    translate([8*1.5-4,0,wall-2])rotate([0,90,0]) wallmount_printed_part();
    color("cyan") translate([-wall-2,0,wall-2])rotate([0,90,0]) cylinder(r=5/2,h=2, $fn=6);
    color("cyan") translate([-wall-2,0,wall-2-skruv_distance])rotate([0,90,0]) cylinder(r=5/2,h=2, $fn=6);
    
    color("cyan") translate([-wall-2,0,wall-2])rotate([0,90,0]) cylinder(r=3/2,h=9, $fn=16);
    color("cyan") translate([-wall-2,0,wall-2-skruv_distance])rotate([0,90,0]) cylinder(r=3/2,h=30, $fn=16);
    
}
module wallmount_printed_part() {
    radie = (3+5)/2; // skruv och mutters radie
    skruv_distance = 20;
    tjock = 6;
    mutter_m3 = (6 + 0.2)/2;
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
//translate([-ux/2,0,378+wall/2]) wallmount();

module fras(x=10, y=10, r=4) {
    hull() {
        translate([x,y,0]) cylinder(r=r,h=10, $fn=16);
        cylinder(r=r,h=10);
    }
}
//fras(x=0,y=30);

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
        cube([wall,uy,minz]);
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
//translate([-ux/2,-uy/2,378]) top();
//höger
//translate([-ux/2-wall,-uy/2,0]) sida();
//vänster
//translate([ux/2,-uy/2,0]) sida();
//bak
//translate([-ux/2,uy/2,0])cube([ux,wall,uz]);
//fram
//translate([-ux/2,-uy/2-wall,0])cube([ux,wall,uz]);
//botten
//translate([-ux/2,-uy/2,0])cube([ux,uy,wall]);

// Rods
//translate([ch/2+xr*2,-uy/2,347]) x_rod();
//translate([-ch/2-xr*2,-uy/2,347]) x_rod();

//translate([-ux/2,ch/2+xr*2,347+cdist+20]) y_rod();
//translate([-ux/2,-ch/2-xr*2,347+cdist]) y_rod();

//z rods
// 16cm mellan dom
// 21mm från bakvägg

module printable_corner(left= 20, right=20, invert=1,top=20) {
    // left and right is the space from wall to center of left and right rod
    // set invert to -1 to invert what rod is on top
    cdist_l=18*invert;
    cdist_r=-18*(invert-1);
    
    //top_space = top; // space from top of box to center of highest rod
    rod = 8.3;
    h = top+cdist + rod;
    wall = 3;
    cylinder_res = 50;
    
    color([1,0.2,0]) difference() {
        union() {
            hull() {
                translate([0,0,-1]) cube([left+rod,wall,1]);
                translate([left,0,-cdist_l-top]) rotate([-90,0,0]) cylinder(d=rod*2, h=wall, $fn=cylinder_res);
            }
            hull() {
                translate([0,0,-1]) cube([wall,right+rod,1]);
                translate([0,right,-cdist_r-top]) rotate([0,90,0]) cylinder(d=rod*2, h=wall, $fn=cylinder_res);
            }
            hull() {
                translate([0,0,-wall]) cube([left,wall,wall]);
                translate([0,0,-wall]) cube([wall,right,wall]);
            }
        }
        translate([left,0,-cdist_l-top]) rotate([-90,0,0]) cylinder(d=rod, h=100, $fn=cylinder_res);
        translate([0,right,-cdist_r-top]) rotate([0,90,0]) cylinder(d=rod, h=100, $fn=cylinder_res);
    }
}

//bak vänster hörn
//translate([-ux/2,uy/2,378]) rotate([180,0,-90]) printable_corner(left=37.5,right=21.2,invert=0,top=13);

//bak höger
//translate([ux/2,uy/2,378]) rotate([180,0,180]) printable_corner(left=21.2,right=37.5,invert=1,top=13);

//fram vänster
//translate([-ux/2,-uy/2,378]) rotate([180,0,0]) printable_corner(left=21.2,right=16.5,invert=1,top=13);

//fram höger
//translate([ux/2,-uy/2,378]) rotate([180,0,90]) printable_corner(left=16.5,right=21.2,invert=0,top=13);


















