/*
 * @author  Igor Demyanov
 * @license CC-BY-NC-4.0
 * @version 2.0.0
 */

cover_version = "04.02.2022 v2.0.0";

width = 220; // Ширина рамки
height = 170; // Высота рамки
back_thickness = 1.5; //толщина задней панели
wall_thickness = 1.5; // толщина стеноки
wall_depth = 5; // высота стенки
// China
//pcbDriverW = 65;
//pcbDriverH = 67.5;
// Toshiba
pcbDriverW = 70.10; // ширина драйвера
pcbDriverH = 40.15; // высота драйвера

pcbDriverRotate = [0,0,90];//[180,0,-90];
pcbPowerH  = 45;
pcbPowerW  = 30.5;
pcbRPiH    = 56;  // Alto del PCB (eje Y).
pcbRPiW    = 85;  // Ancho del PCB (eje X).
pcbRPiT    = 1.4; 
pcbRPi4Rotate = [0,0,-90];

hasKeyHoles = false;
hasRPiPortOut = false; // Порты выходят наружу


frame_thickness = 10; // толщина стенок фоторамки

M3_rad = 3.3;


pcbRPi4X = width - 67;
pcbRPi4Y = hasRPiPortOut? 87.9 : 100;
pcbRPi4Z = back_thickness+4;
pcbPowerX = (height+pcbPowerW)/2;
pcbPowerY = height - pcbPowerH - frame_thickness - 7;
pcbPowerZ = back_thickness + 1.5 + 2;
pcbDriverX = pcbDriverW+frame_thickness + 5;//(width+pcbDriverW)/2-10;
pcbDriverY = frame_thickness + 45;
//pcbDriverZ = ;

cooling_holes_width = 2; // ширина вентиляционных отверстий
cooling_holes_deep = wall_depth + back_thickness - 4;
cooling_holes_height = hasRPiPortOut? 8 : 10; // длина вентиляционных отверстий
cooling_holes_interval = 6;// расстояния между отверстиями
cooling_holes_startx = frame_thickness + cooling_holes_width;
cooling_holes_endx = width - frame_thickness - cooling_holes_width;

/*TODO:
1. [+]Дыхательные прорези :)
2. [+]Углубления для саморезов на которые будет крепиться крышка
3. [ ]Вырез для разьёма питания
4. [+]Вырез для Pi4
5. [+]Дырки для крепления плат
6. [+]Монтаж на стену или ножка 
7. [ ]Высокие поддержки требуют ребёр жёсткости
8. [+]Укрепить углы вентиляции
9. [+]Поддержка краёв Pi4 + убрать выямку под usb
10.[+]Зазоры между usb и ent заполнить 
11.[+]Увеличить до 2мм back pi panel
12.[ ]Переделать eth держатель
*/
//-----------------------------------------------------------------------------
//use <./pcbDisplayDriver.scad>
use <./pcbDisplayDriver_Toshiba.scad>
use <./pcbPowerDistribution.scad>
use <./PCB/RaspberryPi4.scad>
use <./keyhole_hanger.scad>
//-----------------------------------------------------------------------------

pcbPowerHoles = getPcbPowerDistributionHoles();
pcbDisplayHoles = getPcbDisplayDriverHoles();
pcbRaspberry4Holes = getRaspberry4Holes();

pcbMounts = [
 // M_POWER
 // pcbPostion, positions[4], height_base, height_holder, rotate, radius, hole?, innerMount?
 [[pcbPowerX, pcbPowerY, back_thickness], pcbPowerHoles,2, 5, [0,0,0], M3_rad/2  - 0.1, false, true],
  // M_DDRIVER
 [ [pcbDriverX, pcbDriverY, back_thickness] , pcbDisplayHoles, 8.5, 5 , [0,0,pcbDriverRotate[2]], M3_rad/2 - 0.1, false, true],
// M_RPI4
 [[pcbRPi4X, pcbRPi4Y, back_thickness], pcbRaspberry4Holes, 2.5, 5 , pcbRPi4Rotate, M3_rad/2 - 0.5, false, true],
 
 [[pcbRPi4X, pcbRPi4Y, back_thickness], [[pcbRPiW, pcbRaspberry4Holes[0][1]],[pcbRPiW, pcbRaspberry4Holes[3][1]]], 2.5, 4.2 , pcbRPi4Rotate, M3_rad/2 - 0.5, false, false],
 // Wires mount
 //[[pcbPowerX, pcbPowerY - 30, back_thickness], [[ pcbPowerW / 2-5, 0, 0],[ pcbPowerW / 2+5, 0, 0]], 2.5, 4.2 , [0,0,0], M3_rad/2 - 0.5, true, true]
];

keyholes_hanger_pos = [
 //[width / 2, height * 0.79, -0.01 ],
 [width / 2 - 50, height * 0.79, -0.01 ],
 [width / 2 + 50, height * 0.79, -0.01 ]
];

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
            translate([0,0,base_z/2+0.15/*-0.01*/]) cube([5,5,base_z],center = true);
            translate([0,0,base_z+0.1])cylinder(h = mount_z+0.01, r = r, $fn = 20);
          }
  }
}


 /**        
    [ [ 15.9 + tolerance, 21.20 + tolerance, 13.5 + tolerance ], "Violet",        [ 76.50, 45.75,  0.0 ],     90 ], // 4 Ethernet
    [ [ 13.1 + tolerance, 17.30 + tolerance, 16.8 + tolerance ], "Silver",        [ 78.45, 27.00,  0.0 ],     90 ], // 8 USB 3
    [ [ 13.1 + tolerance, 17.30 + tolerance, 16.8 + tolerance ], "Silver",        [ 78.45,  9.00,  0.0 ],     90 ], // 9 USB 2
        */
        rpi4_usb_gap = 1;
        rpi4_ethernet_w = 15.9+0.2*2;
        rpi4_ethernet_x = 45.75;
        rpi4_ethernet_d = 13.5+0.2*2;
        rpi4_usb1_w = 13.1 + 0.1*2;
        rpi4_usb1_x = 27.0;
        rpi4_usb1_d = 16.8 + 0.1 - rpi4_usb_gap;
        rpi4_usb2_w = rpi4_usb1_w;
        rpi4_usb2_x =  9.0;
        rpi4_usb2_d = rpi4_usb1_d;

// Задняя панель на RaPi4
module raPi4_back_panel(){
    max_z = 16.8 - 1.0; 
    inc_w = 2;
    back_panel_w = pcbRPiH + inc_w;
   translate([pcbRPi4X - inc_w/*X*/ ,0, 0]){
           color("red") cube([back_panel_w,wall_thickness + 1.0,max_z + pcbRPi4Z]);
   }
}
// Вырез под разъёмы RaPi4
module raPi4_back_holes(){
    union(){ 
     
        back_panel_deep = wall_thickness + 0.2 + 5;
        //Ethernet
        translate([pcbRPi4X/*X*/+ rpi4_ethernet_x - rpi4_ethernet_w/2,-0.1, pcbRPi4Z]){
           color("Lime") cube([rpi4_ethernet_w, back_panel_deep, rpi4_ethernet_d]);
        }
        //USB 1
        translate([pcbRPi4X/*X*/+rpi4_usb1_x - rpi4_usb1_w/2,-0.1, pcbRPi4Z + rpi4_usb_gap]){
            color("Lime") cube([rpi4_usb1_w, back_panel_deep, rpi4_usb1_d]);
        }
        //USB 2
        translate([pcbRPi4X/*X*/+rpi4_usb2_x - rpi4_usb2_w/2,-0.1, pcbRPi4Z + rpi4_usb_gap]){
           color("Lime") cube([rpi4_usb2_w, back_panel_deep, rpi4_usb2_d]);
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
//Отверстия охлаждения
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

//Блоки крепления крышки к рамке
module frameMountBlocks(){
        mount_z = wall_depth+back_thickness;
        color("Red")
        {
            cube([frame_thickness,frame_thickness,mount_z]);
            translate([width-frame_thickness,0,0]) cube([frame_thickness,frame_thickness,mount_z]);
            translate([0,height-frame_thickness,0]) cube([frame_thickness,frame_thickness,mount_z]);
            translate([width-frame_thickness,height-frame_thickness,0]) cube([frame_thickness,frame_thickness,mount_z]);
            //translate([(width-frame_thickness-30)/2,0,0]) cube([frame_thickness,frame_thickness,mount_z]);
            //translate([(width-frame_thickness-30)/2,height-frame_thickness,0]) cube([frame_thickness,frame_thickness,mount_z]);
        }
}

module stiffening_rib(sr_start = [0,0,0],sr_end = [0,0,10], sr_points=[[0,0,0], [0,10,0], [0,0,10]], sr_faces = [[0,1,2]]){
 hull() {
    translate(sr_start) polyhedron(points= sr_points, faces=sr_faces);
    translate(sr_end)   polyhedron(points= sr_points, faces=sr_faces);
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
        
    color("#6dc7ff"){
        tri_h = 3;
        tri_l = 4;
       stiffening_rib(
        sr_start = [frame_thickness,wall_thickness,back_thickness],
        sr_end = [width - frame_thickness,wall_thickness,back_thickness], sr_points=[[0,0,0], [0,tri_l,0], [0,0,tri_h]]);
       stiffening_rib(
        sr_start = [frame_thickness,height - wall_thickness,back_thickness],
        sr_end= [width - frame_thickness,height - wall_thickness,back_thickness], sr_points=[[0,0,0], [0,-tri_l,0], [0,0,tri_h]]);
       
        stiffening_rib(
        sr_start = [wall_thickness,frame_thickness,back_thickness],
        sr_end= [wall_thickness,height - wall_thickness,back_thickness], sr_points=[[0,0,0], [tri_l,0,0], [0,0,tri_h]]);
        stiffening_rib(
        sr_start = [width - wall_thickness,frame_thickness,back_thickness],
        sr_end= [width - wall_thickness,height - wall_thickness,back_thickness], sr_points=[[0,0,0], [-tri_l,0,0], [0,0,tri_h]]);
        
        
        }
        
        color("Black"){
          translate([20,20,back_thickness]) {
            linear_extrude(height = 0.4, convexity = 20)
                {
                    text(cover_version, 8);
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
    //translate([(width-frame_thickness-30)/2,0,0]) cover_mount_holes();
    //translate([(width-frame_thickness-30)/2,height-frame_thickness,0]) cover_mount_holes();
}    
   
module pcbsMounts(){
  color("Gray") {
             for (pcbMountInfo = pcbMounts)
             {
             pcbPos = pcbMountInfo[0];
             pcbMountPos = pcbMountInfo[1];
             pcbRot = pcbMountInfo[4];
             holeRadius = pcbMountInfo[5];
             isCreateHole = pcbMountInfo[6];
             innerMount = pcbMountInfo[7];
             translate(pcbPos){
                 mount_h = pcbMountInfo[3];
                 mount_base_h = pcbMountInfo[2];
                 rotate(a = pcbRot){
                for (ii = pcbMountPos) translate(ii) {
                    //difference()
                    {
                    union(){
                    // base
                    translate([0,0,mount_base_h/2]) 
                        cube(size=[(M3_rad + 1),(M3_rad + 1),mount_base_h], center= true);
                        //cylinder(h=mount_base_h, r= (M3_rad/2 + 1) , center= true, $fn=20);
                    // holder
                    if (innerMount)translate([0,0,mount_base_h])
                        cylinder(h=mount_h, r=holeRadius, center = true, $fn=20);
                    }
                    // inner hole
                    if (isCreateHole)translate([0,0,mount_base_h]) translate([0,0,-2.5]) {cylinder(h=mount_h+1.01, r=M3_rad/2-1,  $fn=20);}
                    }
                }
            }
             }
            }
         }
}

module buildKeyHolesHangar(){
    for (ii = keyholes_hanger_pos){
            translate(ii) create_keyhole_hanger_hangar(hole_h = back_thickness, wall_thickness = 3, free_h = 2.5);
    }
}

//projection(cut=true) 
//translate([0,0,-10.5])
//intersection() // Пересечение
{
difference()
    {
    union(){
        //Frame mount blocks
        frameMountBlocks();
        // pcb Mounts
        pcbsMounts();
        //frame
        buildFrame();
        //keyholes hanger hangar
        if (hasKeyHoles) buildKeyHolesHangar();
        //RaPi4 back panel
        if (hasRPiPortOut){
         raPi4_back_panel();
        }
    }
    // Frame mount holes
    frameMountHoles();
    // cooling holes
    cooling_holes();
    if (hasRPiPortOut){
        raPi4_back_holes();
    }
    //keyholes hanger
    color("pink") {
        for (ii = keyholes_hanger_pos){
            if (hasKeyHoles) translate(ii) create_keyhole_hanger(h = back_thickness + 0.5);
        }
    }
}

// Часть
/*color("red") union(){
    translate([pcbDriverX-pcbDriverW/2-5,pcbDriverY+pcbDriverH-7,-1])cube(size=[10,pcbDriverH+20,20]); //L
}*/

 //Power + Driver
/*color("red") union(){
    //translate([pcbPowerX,pcbPowerY,0])      cube(size=[60,48,20]);//Power
    // Display Driver
    translate([pcbDriverX-pcbDriverW-5,pcbDriverY-5,-1])cube(size=[pcbDriverW+10,15,15]);//B
    translate([pcbDriverX-pcbDriverW-5,pcbDriverY,-1])cube(size=[10,pcbDriverH,20]); //L
    translate([pcbDriverX-5,pcbDriverY,-1])cube(size=[10,pcbDriverH,20]); //R
    translate([pcbDriverX-pcbDriverW-5,pcbDriverY+pcbDriverH-10,-1])cube(size=[pcbDriverW+10,15,15]); //T
}*/
// RaPi4
/*color("red") union(){
    translate([pcbRPi4X-5,-5,0])      cube(size=[80,18,20]);
    translate([pcbRPi4X,-5,0])      cube(size=[10,93,20]);
    translate([pcbRPi4X+48,-5,0])      cube(size=[10,93,20]);
    translate([pcbRPi4X,80,0])      cube(size=[55,6,20]);
  }*/
//RaPi4 front
/*color("red") union(){
    translate([pcbRPi4X-5,-5,0])      cube(size=[60,10,20]);
    translate([pcbRPi4X,-5,0])      cube(size=[10,35,20]);
    translate([pcbRPi4X+48,-5,0])      cube(size=[10,35,20]);
  }*/
//raPi4_panel
/*color("red") union(){
    translate([pcbRPi4X-5,-5,0])      cube(size=[81,15,25]);
 }*/
}
//raPi4_panel mount cube
//mount_z = wall_depth+back_thickness;
//translate([pcbRPi4X-frame_thickness,0,0]) cube([frame_thickness,frame_thickness,mount_z]);


if ($preview) {
//RasPi4
translate([pcbRPi4X, pcbRPi4Y, pcbRPi4Z]) rotate(a= pcbRPi4Rotate) raspberry4();

//Display Driver 
translate([pcbDriverX,pcbDriverY,back_thickness+10]) rotate(a=pcbDriverRotate)  pcbDisplayDriver();

//PoweDistib
translate([pcbPowerX, pcbPowerY, pcbPowerZ]) pcbPowerDistribution();
}
