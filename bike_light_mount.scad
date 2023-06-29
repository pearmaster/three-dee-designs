
delta=.001;
cup_height=122;
cup_r=36;
cup_trans_h=20;
cup_trans_r=17.6;
beam_r=14.1;
beam_len=90*2;
post_height=30;
post_r=cup_trans_r;
end_cap_r=beam_r*1.18;
end_cap_len=5;
through_hole_r=6;
percent_off_back=.18;
nub_size=7;
nub_ext=4;

difference() {
    union() {
        color("green") {
            cylinder(h=cup_height, r=cup_r, center=false);
        }

        translate([0, 0, cup_height-delta]) {
            cylinder(h=cup_trans_h+delta, r1=cup_r, r2=cup_trans_r, center=false);
        }
    }
    translate([0, -cup_r, (cup_height)-delta]) {
        cube([3*cup_r, percent_off_back*2*cup_r, 2*cup_height], center=true);
    }
}

difference() {
    union() {
        translate([0, 0, cup_height+cup_trans_h-delta]) {
            //post
            cylinder(h=post_height, r=post_r, center=false);
            
            //post cap
            translate([0, 0, post_height]) {
                scale([1, 1, (beam_r/post_r)]) {
                    sphere(post_r);
                }
            }
        }

        translate([0, 0, cup_height+cup_trans_h+post_height]) {
            rotate([-7.9, 90, 0]){
                // right end cap
                color("black") {
                    translate([0,0,(beam_len/-2)-end_cap_len+delta]){
                        cylinder(h=end_cap_len, r=end_cap_r);
                    }
                    
                    translate([0, -beam_r-nub_ext+delta, (beam_len/-2)+nub_size]) {
                        cube([nub_size, nub_size, nub_size]);
                    }
                }
                
                // beam
                color("red") {
                    translate([0, 0, beam_len/-4]) cylinder(h=beam_len/2, r=beam_r, center=true);
                }
            }
        }

        translate([0, 0, cup_height+cup_trans_h+post_height]) {
            rotate([7.9, 90, 0]){
                // left end cap
                color("blue") {
                    translate([0,0,(beam_len/2)-delta]){
                        cylinder(h=end_cap_len, r=end_cap_r);
                    }
                    
                    translate([0, -beam_r-nub_ext+delta, (beam_len/2)-nub_size-end_cap_len]) {
                        cube([nub_size, nub_size, nub_size]);
                    }
                }
                
                // beam
                color("red") {
                    translate([0, 0, beam_len/4])  cylinder(h=beam_len/2, r=beam_r, center=true);
                }
            }
        }
        
        translate([0, -.1*cup_r, cup_height+cup_trans_h+post_height-(.9*beam_r)]) {
            difference() {
                rotate([0, 45, 0]) {
                    color("pink") cube([4*beam_r, beam_r/3, 4*beam_r], center=true);
                }
                translate([0, -delta, 4*beam_r]) {
                    cube([8*beam_r, (beam_r) + 2*delta, 8*beam_r], center=true);
                }
           }
        }
    }
    translate([0, (-post_r/2)-8, cup_height+cup_trans_h+post_height+10])
        rotate([0, 90, 0])
            rotate_extrude(convexity = 10, $fn = 100)
                translate([10, 0, 0])
                    circle(r = 4, $fn = 100);
}

