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

cover_version = "07.06.2020 v0.5";

pcbRPi4X = 153;
pcbRPi4Y = 87;
pcbRPi4Z = back_thickness+4;
pcbPowerX = frame_thickness + 7;
pcbPowerY = height - pcbPowerH - frame_thickness - 7;
pcbPowerZ = back_thickness + 1.5 + 2;

cooling_holes_width = 1.5;
cooling_holes_deep = wall_depth + back_thickness - 2;
cooling_holes_height = 15;
cooling_holes_interval = 5;
cooling_holes_startx = frame_thickness + cooling_holes_width;
cooling_holes_endx = width - frame_thickness - cooling_holes_width;

/*TODO:
1. [+]Дыхательные прорези :)
2. [+]Углубления для саморезов на которые будет крепиться крышка
3. Вырез для разьёма питания
4. [+]Вырез для Pi4
5. [+]Дырки для крепления плат
*/
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

module cover_mount_holes(r = 1.3){
  color("Blue"){
      mount_z = wall_depth+back_thickness;
      base_z = 3;
      translate([frame_thickness/2,frame_thickness/2,0]){
            translate([0,0,base_z/2-0.01]) cube([5,5,base_z],center = true);
            cylinder(h = mount_z+0.01, r = r, $fn = 20);
          }
  }
}

// Вырез под разъёмы RaPi4
module raPi4_back_holes(){
    union(){
        
        /**
    [ [ 15.9 + tolerance, 21.20 + tolerance, 13.5 + tolerance ], "Violet",        [ 76.50, 10.25,  0.0 ],     90 ], // 4 Ethernet
    [ [ 13.1 + tolerance, 17.30 + tolerance, 16.8 + tolerance ], "Silver",        [ 78.45, 47.00,  0.0 ],     90 ], // 8 USB 1
    [ [ 13.1 + tolerance, 17.30 + tolerance, 16.8 + tolerance ], "Silver",        [ 78.45, 29.00,  0.0 ],     90 ], // 9 USB 2
        */
        rpi4_ethernet_w = 15.9;
        rpi4_ethernet_x = 10.25;
        rpi4_ethernet_d = 13.5+0.1;
        rpi4_usb1_w = 13.1;
        rpi4_usb1_x = 47.0;
        rpi4_usb1_d = 16.8+0.1;
        rpi4_usb2_w = 13.1;
        rpi4_usb2_x = 29.0;
        rpi4_usb2_d = 16.8+0.1;
        //Ethernet
        translate([pcbRPi4X/*X*/+ rpi4_ethernet_x - rpi4_ethernet_w/2,-0.1, pcbRPi4Z]){
           color("Lime") cube([rpi4_ethernet_w,wall_thickness+0.2,rpi4_ethernet_d]);
        }
        //USB 1
        translate([pcbRPi4X/*X*/+rpi4_usb1_x - rpi4_usb1_w/2,-0.1, pcbRPi4Z]){
            color("Lime") cube([rpi4_usb1_w,wall_thickness+0.2,rpi4_usb1_d]);
        }
        //USB 2
        translate([pcbRPi4X/*X*/+rpi4_usb2_x - rpi4_usb2_w/2,-0.1, pcbRPi4Z]){
           color("Lime") cube([rpi4_usb2_w,wall_thickness+0.2,rpi4_usb2_d]);
        }
  
 }
}

/*
cooling_holes_width
cooling_holes_deep
cooling_holes_height
cooling_holes_interval
cooling_holes_startx
cooling_holes_endx
*/
module cooling_holes(){
    // UP
    for ( cooling_x = [cooling_holes_startx : cooling_holes_interval : cooling_holes_endx] ){
        translate([cooling_x+0.01,height-cooling_holes_height + 0.01, -0.01 ]) {
            color("Lime"){
                cube([cooling_holes_width,cooling_holes_height,cooling_holes_deep]);
            }
        }
    }
    //Down
    for ( cooling_x = [cooling_holes_startx : cooling_holes_interval : cooling_holes_endx] ){
        translate([cooling_x+0.01,-0.01, -0.01 ]) {
            color("Lime"){
                cube([cooling_holes_width,cooling_holes_height,cooling_holes_deep]);
            }
        }
    }
}

module frameMountBlocks(){
        mount_z = wall_depth+back_thickness;
        color("Red")
        {
            cube([frame_thickness,frame_thickness,mount_z]);
            translate([width-frame_thickness,0,0]) cube([frame_thickness,frame_thickness,mount_z]);
            translate([0,height-frame_thickness,0]) cube([frame_thickness,frame_thickness,mount_z]);
            translate([width-frame_thickness,height-frame_thickness,0]) cube([frame_thickness,frame_thickness,mount_z]);
        }
}

module buildFrame(){
        cube([width,height,back_thickness]);
        translate([0,0,back_thickness]){
         cube([wall_thickness,height,wall_depth]);
         cube([width,wall_thickness,wall_depth]);
         translate([width-wall_thickness,0,0]){
           cube([wall_thickness,height,wall_depth]);
         }   
         translate([0,height-wall_thickness,0]) cube([width,wall_thickness,wall_depth]);
        }
        color("Black"){
          translate([20,20,back_thickness]) {
            linear_extrude(height = 0.5, convexity = 10)
                {
                    text(cover_version, 5);
                }
            }
        }
  }
  
// Frame mount holes
module frameMountHoles(){
    translate([0,0,0]) cover_mount_holes();
    translate([width-frame_thickness,0,0]) cover_mount_holes();
    translate([width-frame_thickness,height-frame_thickness,0]) cover_mount_holes();
    translate([0,height-frame_thickness,0]) cover_mount_holes();
}    
   
module pcbsMounts(){
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
                    difference(){
                    union(){
                    // base
                    translate([0,0,mount_base_h/2]) cylinder(h=mount_base_h, r= (M3_rad/2 + 1) , center= true, $fn=20);
                    // holder
                    translate([0,0,mount_base_h])
                        cylinder(h=mount_h, r=M3_rad/2, center = true, $fn=20);
                    }
                
                    translate([0,0,mount_base_h]) translate([0,0,-2.5]) {cylinder(h=mount_h+1.01, r=M3_rad/2-1,  $fn=20);}
                    }
                }
             }
            }
         }
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

difference(){
    union(){
        //Frame mount blocks
        frameMountBlocks();
        // pcb Mounts
        pcbsMounts();
        //frame
        buildFrame();
    }
    // Frame mount holes
    frameMountHoles();
    // cooling holes
    cooling_holes();
    raPi4_back_holes();
}
    



//RasPi4
translate([pcbRPi4X, pcbRPi4Y, pcbRPi4Z]) rotate(a=[0,0,-90]) raspberry4();

//Display Driver 
translate([(width-pcbDriverW)/2+pcbDriverW/2,(height-pcbDriverH)/2+pcbDriverH/2,back_thickness+10]) rotate(a=[180,0,-90]) translate([-pcbDriverW/2,-pcbDriverH/2,0])  pcbDisplayDriver();

//PoweDistib
translate([pcbPowerX, pcbPowerY, pcbPowerZ]) pcbPowerDistribution();
