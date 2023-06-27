
delta=.001;
cup_height=100;
cup_r=40;
cup_trans_h=20;
cup_trans_r=22;
beam_r=20;
beam_len=400;
post_height=30;
post_r=cup_trans_r;
end_cap_r=beam_r*1.2;
end_cap_len=5;

cylinder(h=cup_height, r=cup_r, center=false);
translate([0, 0, cup_height-delta]) {
    cylinder(h=cup_trans_h+delta, r1=cup_r, r2=cup_trans_r, center=false);
}

translate([0, 0, cup_height+cup_trans_h-delta]) {
    cylinder(h=post_height, r=post_r, center=false);
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



