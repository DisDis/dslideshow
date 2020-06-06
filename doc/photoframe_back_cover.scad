/*
 * @author  Igor Demyanov
 * @license CC-BY-NC-4.0
 */
width = 220;
height = 170;
back_thickness = 1.5;
wall_thickness = 1.5;
wall_depth = 5;
pcbDriverW = 65;
pcbDriverH = 67.5;
pcbPowerH  = 45;
pcbPowerW  = 31;
pcbRPiH    = 56;  // Alto del PCB (eje Y).
pcbRPiW    = 85;  // Ancho del PCB (eje X).
pcbRPiT    = 1.4; 

frame_thickness = 10;

M3_rad = 3.5;

cover_version = "07.06.2020 v0.2";

pcbRPi4X = 153;
pcbRPi4Y = 85;
pcbRPi4Z = back_thickness+4;
pcbPowerX = frame_thickness + 7;
pcbPowerY = height - pcbPowerH - frame_thickness - 7;
pcbPowerZ = back_thickness + 1.5 + 2;

//-----------------------------------------------------------------------------
use <./pcbDisplayDriver.scad>
use <./pcbPowerDistribution.scad>
use <./PCB/RaspberryPi4.scad>
//-----------------------------------------------------------------------------

pcbMount_ddriver_offx=1.3;
pcbMount_ddriver_offy=3.3;
pcbMounts = [
 // M_POWER
 // pcbPostion, positions[4], height_base, height_holder
 [[pcbPowerX, pcbPowerY, back_thickness], [[2,2,0],[pcbPowerW-2,2,0],[2,pcbPowerH-2,0], [pcbPowerW-2,pcbPowerH-2,0]],2, 3],
  // M_DDRIVER
 [[(width-pcbDriverW)/2,(height-pcbDriverH)/2,back_thickness],[[pcbMount_ddriver_offx,pcbMount_ddriver_offy,0],[pcbDriverW-pcbMount_ddriver_offx,pcbMount_ddriver_offy,0],[pcbMount_ddriver_offx,pcbDriverH-pcbMount_ddriver_offy,0],[pcbDriverW-pcbMount_ddriver_offx,pcbDriverH-pcbMount_ddriver_offy,0]], 10,3],
// M_RPI4
 [[pcbRPi4X, pcbRPi4Y, back_thickness],[[3.5,-3.5,0],[61.5-9,-3.5,0],[3.5,-52.5 - 9,0],[61.5-9,-52.5-9,0]],2.5,3]
];
   //[ 3.5, 61.5 ], // X
    //[ 3.5, 52.5 ]  



module regular_polygon( r= 1.0){
    order = 6;
    linear_extrude(height = 3) { 
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
  }
}

module hex_nutM3_holder(){
    regular_polygon( r= M3_rad);
}





/*
//Example use of module
standoff(
     height = 2
    ,diameter = 5
    ,holediameter = 2
    ,firstTX = 100
    ,firstTY = 10
    ,firstTZ = back_thickness
    ,pcbWidth = 25
    ,pcbLength = 50
    ,fn = 25
);*/


union(){
    //Mount blocks
    mount_z = wall_depth+back_thickness;
    color("Red")
    {
        cube([frame_thickness,frame_thickness,mount_z]);
        translate([width-frame_thickness,0,0]) cube([frame_thickness,frame_thickness,mount_z]);
        translate([0,height-frame_thickness,0]) cube([frame_thickness,frame_thickness,mount_z]);
        translate([width-frame_thickness,height-frame_thickness,0]) cube([frame_thickness,frame_thickness,mount_z]);
    }
    
    // pcb Mounts
     color("Gray") {
         for (i =[0:2])
         {
         pcbMountInfo = pcbMounts[i];
         pcbPos = pcbMountInfo[0];
         pcbMountPos = pcbMountInfo[1];
         translate(pcbPos){
             mount_h = pcbMountInfo[3];
             mount_base_h = pcbMountInfo[2];
            for (ii =[0:3]) translate(pcbMountPos[ii]) {
                // base
                translate([0,0,mount_base_h/2]) cylinder(h=mount_base_h, r= (M3_rad/2 + 1) , center= true, $fn=20);
                // holder
                translate([0,0,mount_base_h]) cylinder(h=mount_h, r=M3_rad/2, center = true, $fn=20);
            }
         }
        }
     }
    
    cube([width,height,back_thickness]);
    translate([0,0,back_thickness]){
     cube([wall_thickness,height,wall_depth]);
     cube([width,wall_thickness,wall_depth]);
     translate([width-wall_thickness,0,0]){
       cube([wall_thickness,height,wall_depth]);
     }   
     translate([0,height-wall_thickness,0]) cube([width,wall_thickness,wall_depth]);
    }
    color("Green"){
      translate([width / 2,height - 20,back_thickness]) {
        linear_extrude(height = 0.5, convexity = 10)
            {
                text(cover_version, 5);
            }
        }
    }
    
    
}




//RasPi4
translate([pcbRPi4X, pcbRPi4Y, pcbRPi4Z]) rotate(a=[0,0,-90]) raspberry4();
 
translate([(width-pcbDriverW)/2+pcbDriverW/2,(height-pcbDriverH)/2+pcbDriverH/2,back_thickness+10]) rotate(a=[180,0,-90]) translate([-pcbDriverW/2,-pcbDriverH/2,0])  pcbDisplayDriver();

translate([pcbPowerX, pcbPowerY, pcbPowerZ]) pcbPowerDistribution();
