 /*
 * @author  Igor Demyanov
 * @license CC-BY-NC-4.0
 */
 
version = "11.02.2022 v0.2.1";
 
pir_radius  = 5.5;
pir_radius_inner  = 8.7/2;
pir_sensor_lenght = 6;
pir_pcb_width   = 8.4;
pir_pcb_height  = 10.5;
pir_full_length = 20;//35//14
tolerance = 0.3;
thickness = 1;
thickness_front = thickness + 1; 
holder_length = (pir_radius + thickness)*4;
holder_radius = pir_radius + (tolerance + thickness ) / 2;
holder_round_radius = (holder_length - holder_radius*2 )/2;
holder_full_deep = pir_full_length + thickness*2;

cooling_holes_width = 2; // ширина вентиляционных отверстий
cooling_holes_deep = wall_depth + back_thickness - 4;
cooling_holes_height = 10; // длина вентиляционных отверстий
cooling_holes_interval = 6;// расстояния между отверстиями

holder_mount_deep = cooling_holes_height;
holder_mount_w = cooling_holes_width;
holder_mount_h = cooling_holes_width;
holder_mount_step = cooling_holes_interval;
holder_mount_x_base = 1.0;




difference()
{
 union(){
     tmp_h = pir_full_length+thickness*2+tolerance;
     cylinder(h=tmp_h,r = holder_radius ,  $fn=50);
     translate([-holder_length/2,-holder_radius, 0]) cube(size=[holder_length,holder_radius,tmp_h]);
    translate([-holder_radius,-holder_radius,0]) cube([holder_radius*2,holder_radius,pir_full_length+thickness+tolerance]);
     color("Lime"){
         for ( holder_mount_x = [0 : holder_mount_step : holder_length] ){
            translate([-(holder_length+holder_mount_w)/2 + holder_mount_x_base + holder_mount_x+0.01,-holder_radius-holder_mount_deep, holder_full_deep+tolerance-holder_mount_h ]) {
                cube([holder_mount_w,holder_mount_deep,holder_mount_h]);
            }
        }
    }
     }
 

color("red"){
    tmp_h = pir_full_length + tolerance*2;
    translate([0,0, +thickness_front]) cylinder(h= tmp_h-thickness_front-tolerance,r = pir_radius,  $fn=50);
    translate([0,0, -tolerance]) cylinder(h= tmp_h,r = pir_radius_inner,  $fn=50);
    translate([holder_length / 2,0, -tolerance]) cylinder(h= tmp_h+thickness*2+tolerance,r = holder_round_radius,  $fn=50);
    translate([-holder_length / 2,0, -tolerance]) cylinder(h= tmp_h+thickness*2+tolerance,r = holder_round_radius,  $fn=50);
    translate([-pir_radius,-pir_radius-thickness, thickness_front]) cube(size=[pir_radius*2,pir_radius+thickness,tmp_h-thickness_front - tolerance]);
 
    translate([-(holder_length+holder_mount_w)/2 + holder_mount_x_base - 0.01,-holder_radius-holder_mount_deep - 0.01, holder_full_deep+tolerance-holder_mount_h - 0.01 ]) 
                cube([holder_mount_w+0.2,holder_mount_deep+0.2,holder_mount_h+0.2]);
            
 
    translate([-(holder_length+holder_mount_w)/2 + holder_mount_x_base+ holder_mount_step * 4 - 0.01,-holder_radius-holder_mount_deep - 0.01, holder_full_deep+tolerance-holder_mount_h - 0.01 ]) 
                cube([holder_mount_w+0.2,holder_mount_deep+0.2,holder_mount_h+0.2]);
            
}
} 