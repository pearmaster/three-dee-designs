
delta=.001;
cup_height=130;
cup_r=38;
cup_trans_h=20;
cup_trans_r=18;
beam_r=14;
beam_len=90*2;
post_height=30;
post_r=cup_trans_r;
end_cap_r=beam_r*1.2;
end_cap_len=5;
through_hole_r=6;
percent_off_back=.2;


difference() {
    union() {
        color("green") {
            difference() {
                cylinder(h=cup_height, r=cup_r, center=false);
                translate([0, (cup_r*-(1-percent_off_back))+(2*through_hole_r), cup_height*.9]) {
                    rotate([0, 90, 0]){
                        cylinder(h=3*cup_r, r=through_hole_r, center=true);
                    }
                }
            }
        }

        translate([0, 0, cup_height-delta]) {
            cylinder(h=cup_trans_h+delta, r1=cup_r, r2=cup_trans_r, center=false);
        }
    }
    translate([0, -cup_r, (cup_height)-delta]) {
        cube([3*cup_r, percent_off_back*2*cup_r, 2*cup_height], center=true);
    }
}

translate([0, 0, cup_height+cup_trans_h-delta]) {
    cylinder(h=post_height, r=post_r, center=false);
    translate([0, 0, post_height]) {
        scale([1, 1, (beam_r/post_r)]) {
            sphere(post_r);
        }
    }
}

translate([0, 0, cup_height+cup_trans_h+post_height]) {
    rotate([0, 90, 0]){
        color("blue") {
            translate([0,0,(beam_len/2)-delta]){
                difference() {
                    cylinder(h=end_cap_len, r=end_cap_r);
                    translate([-delta, 2*beam_r, 0]) {
                        cube(beam_r*2, center=true);
                    }
                }
            }
        }
        color("black") {
            translate([0,0,(beam_len/-2)-end_cap_len+delta]){
                difference() {
                    cylinder(h=end_cap_len, r=end_cap_r);
                    translate([-delta, 2*beam_r, 0]) {
                        cube(beam_r*2, center=true);
                    }
                }
            }
        }
        
        color("red")
        cylinder(h=beam_len, r=beam_r, center=true);
    }
}

translate([0, 0, cup_height+cup_trans_h+post_height-beam_r]) {
    difference() {
        rotate([0, 45, 0]) {
            color("pink") cube([4*beam_r, beam_r/4, 4*beam_r], center=true);
        }
        translate([0, -delta, 4*beam_r]) {
            cube([8*beam_r, (beam_r) + 2*delta, 8*beam_r], center=true);
        }
   }
}


