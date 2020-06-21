function keyhole_size(big_r, small_r)=big_r * 2 + small_r;

module create_keyhole_hanger(big_r = 4.5, small_r = 2, h=1){
    cylinder(h=h, r=big_r, $fn=50);

    hull() { 
        cylinder(h=h, r=small_r, $fn=50);
        translate([0,keyhole_size(big_r, small_r),0]) cylinder(h=h, r=small_r, $fn=50);
    }
}

module create_keyhole_hanger_hangar(big_r = 4.5, small_r = 2, hole_h = 1.5, wall_thickness = 2.5, top_thickness = 2.5, free_h = 2){
    gap = 0.4;
    cube_free_w = big_r * 2 + gap;
    cube_free_h = 2 * big_r + keyhole_size(big_r, small_r) + gap;
    cube_w = cube_free_w + wall_thickness * 2;
    cube_h = cube_free_h + wall_thickness * 2;
            
    difference(){
        translate([0,0,+0.01])union(){
            translate([-cube_w/2,-big_r - wall_thickness ,0]) cube(size = [cube_w,cube_h, hole_h + top_thickness + free_h]);
        }
     color("red")create_keyhole_hanger(big_r = big_r, small_r = small_r, h= hole_h);
     color("green") translate([-cube_free_w/2,-big_r - gap , hole_h - 0.01]) cube(size = [cube_free_w,cube_free_h, free_h]);
    }
    
}

create_keyhole_hanger_hangar();