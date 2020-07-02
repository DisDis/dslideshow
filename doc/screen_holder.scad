/*
 * @author  Igor Demyanov
 * @license CC-BY-NC-4.0
 * @version 2.1
 */
/*
TODO:
[ ] Легко ломаются держатели. Может их клеить?
*/
frame_inner_width = 200;
frame_inner_hieght = 150;

display_width = 200.9;
display_hieght = 132.1;

active_area_width = 192;
active_area_hieght = 120;
active_area_offsety = 3.15;
active_area_offsetx = (display_width - active_area_width) / 2;
tolerance = 0.3;


thickness = 1.0;
display_thickness = 1.82;
mount_thickness = 3;
mount_w = 10;
mount_h = 3;

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
    // mounts
    mount_offset = 20;
    color("red"){
        mount_pos_y=[-mount_h-off_y-tolerance ,display_hieght - off_y  + tolerance ];
        for(pos_y = mount_pos_y){
            translate([mount_offset,pos_y,thickness]) cube(size=[mount_w,mount_h,mount_thickness]);
            translate([frame_inner_width-mount_offset-mount_w,pos_y,thickness]) cube(size=[mount_w,mount_h,mount_thickness]);
            translate([frame_inner_width/2-mount_w/2,pos_y,thickness]) cube(size=[mount_w,mount_h,mount_thickness]);
        }            
    }
}

3dmodel_form();
//paper_form();