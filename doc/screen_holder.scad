/*
 * @author  Igor Demyanov
 * @license CC-BY-NC-4.0
 * @version 1.0
 */
frame_inner_width = 200;
frame_inner_hieght = 150;

display_width = 192;
display_hieght = 120;

thickness = 0.2;

projection(cut=true) 
//translate([0,0,-4.5])
//intersection()
{
difference()
{
    cube(size=[frame_inner_width,frame_inner_hieght,thickness], center = true);
    color("green") cube(size=[display_width,display_hieght,thickness+0.1], center = true);
}
}