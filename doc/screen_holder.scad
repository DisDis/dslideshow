/*
 * @author  Igor Demyanov
 * @license CC-BY-NC-4.0
 * @version 2.3
 */
/*
TODO:
[ ] Легко ломаются держатели. Может их клеить?
*/
text_version = "v2.3.0";
frame_inner_width = 200;
frame_inner_hieght = 150;

human_sensor_width = 35;
human_sensor_hieght = 7;
human_sensor_thickness = 5;
human_sensor_offsetx = 0;
human_sensor_offsety = -1.5;
human_sensor_mount_wht = 1;
human_sensor_mount_t = 3;
human_sensor_tolerance = 0.5;

display_width = 200.9;
display_hieght = 132.1;

active_area_width = 192;
active_area_hieght = 120;
active_area_offsety = 3.15;
active_area_offsetx = (display_width - active_area_width) / 2;
tolerance = 0.3;


thickness = 1.0;
display_thickness = 1.82;//толщина дисплея
mount_thickness = 3;//
mount_w = 30;
mount_h = 5;

//Paper
module paper_form(){
projection(cut=true) 
//translate([0,0,-4.5])
//intersection()
{
    difference()
    {
        cube(size=[frame_inner_width,frame_inner_hieght,thickness], center = true);
        color("green") cube(size=[active_area_width,active_area_hieght,thickness+0.1], center = true);
    }
}
}

module stiffener(sr_start = [0,0,0],sr_end = [0,0,10], sr_points=[[0,0,0], [0,10,0], [0,0,10]], sr_faces = [[0,1,2]]){
 //polyhedron(points= sr_points, faces=sr_faces);
    hull() {
    translate(sr_start) polyhedron(points= sr_points, faces=sr_faces);
    translate(sr_end)   polyhedron(points= sr_points, faces=sr_faces);
 }
}


module 3dmodel_form(){
    //translate([0,0,thickness+display_thickness])
    {
        difference()
        {
            cube(size=[frame_inner_width,frame_inner_hieght,thickness]);
            color("pink") translate([(frame_inner_width - active_area_width) / 2, (frame_inner_hieght -   active_area_hieght) / 2,-0.1]) cube(size=[active_area_width,active_area_hieght,thickness+1]);
        } 
    }
    active_area_x = (display_width - active_area_width)/2;
    active_area_y = (display_hieght - active_area_offsety - active_area_hieght);
    off_x = active_area_x - ((frame_inner_width - active_area_width) / 2);
    off_y = active_area_y - ((frame_inner_hieght -   active_area_hieght) / 2);
    if ($preview) {
        color("green") translate([-off_x,-off_y,thickness ]) cube(size=[display_width,display_hieght,display_thickness]);
        color("blue") translate([-off_x + active_area_x,-off_y + active_area_y,thickness - 0.1 ]) cube(size=[active_area_width,active_area_hieght,display_thickness+0.3]);
    }
    
    hsensor_x = (frame_inner_width - (human_sensor_width + 2 *human_sensor_tolerance))/2 + human_sensor_offsetx;
    hsensor_y = frame_inner_hieght - (human_sensor_hieght+ 2 *human_sensor_tolerance) + human_sensor_offsety;
    
    difference(){
    // mounts
    union(){
    mount_offset = 20;
    // display mount
    color("red"){
        mount_pos_y=[-mount_h-off_y-tolerance ,display_hieght - off_y  + tolerance ];
        for(pos_y = mount_pos_y){
            translate([mount_offset,pos_y,thickness]) cube(size=[mount_w,mount_h,mount_thickness]);
            translate([frame_inner_width-mount_offset-mount_w,pos_y,thickness]) cube(size=[mount_w,mount_h,mount_thickness]);
            translate([frame_inner_width/2-mount_w/2,pos_y,thickness]) cube(size=[mount_w,mount_h,mount_thickness]);
        }            
    }
    //Sensor mount 
    translate([ hsensor_x ,hsensor_y,thickness]) {
        color("red"){
            translate([-human_sensor_mount_wht/2,-human_sensor_mount_wht/2,0])
            cube(size=[human_sensor_width+ 2 *human_sensor_tolerance + human_sensor_mount_wht,human_sensor_hieght+ 2 *human_sensor_tolerance+human_sensor_mount_wht,human_sensor_mount_t]);
            }
        }
    }
    
    
    // human_sensor
    translate([ hsensor_x ,hsensor_y,thickness]) {
        //Sensor
        color("pink"){
          cube(size=[human_sensor_width+ 2 *human_sensor_tolerance,human_sensor_hieght+ 2 *human_sensor_tolerance,human_sensor_thickness]);
            }
    }
        }
    color("Black"){
          translate([55,0.5,thickness]) {
            linear_extrude(height = 0.4, convexity = 20)
                {
                    text(text_version, 5);
                }
            }
        }
}

3dmodel_form();
//paper_form();