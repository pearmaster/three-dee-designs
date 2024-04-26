
box_z = 30;
box_x = 100;
box_y = 100;
thick = 2;
corner_r = 5;
d = 0.002; // slight adjustments for differences
screw_r = 3;

module rounded_box (x,y,z,r) {
    hull() {
        translate([r, r, 0])
            cylinder(h=z, r=r, center=false);
        translate([x-r, r, 0])
            cylinder(h=z, r=r, center=false);
        translate([x-r, y-r, 0])
            cylinder(h=z, r=r, center=false);
        translate([r, y-r, 0])
            cylinder(h=z, r=r, center=false);
    }
}


module hollow_box(x, y, z, r, t) {
    difference() {
        rounded_box(x, y, z, r);
        translate([t,t,t+d])
            rounded_box(x-t-t, y-t-t, z-t, r);
    }
}

module hollow_box_for_lid(x, y, z, r, t, screw_r) {
    difference() {
        rounded_box(x, y, z, r);
        translate([2*t, 2*t, t])
            rounded_box(x-(4*t), y-(4*t), z-t, r);
        translate([t, t, z-t+d])
            rounded_box(x-(2*t), y-(2*t), z-t, r);
    }
    color("red") {
        translate([x-(t+t+t+screw_r), t+t+t+screw_r, 0]) {
            difference() {
                cylinder(h=z-t, r=screw_r+t+t, center=false);
                translate([0,0,d]) cylinder(h=z-t, r=screw_r, center=false);
            }
        }
        translate([x-(t+t+t+screw_r), y-(t+t+t+screw_r), 0]) {
            difference() {
                cylinder(h=z-t, r=screw_r+t+t, center=false);
                translate([0,0,d]) cylinder(h=z-t, r=screw_r, center=false);
            }
        }
        translate([t+t+t+screw_r, y-(t+t+t+screw_r), 0]) {
            difference() {
                cylinder(h=z-t, r=screw_r+t+t, center=false);
                translate([0,0,d]) cylinder(h=z-t, r=screw_r, center=false);
            }
        }
        translate([t+t+t+screw_r, t+t+t+screw_r, 0]) {
            difference() {
                cylinder(h=z-t, r=screw_r+t+t, center=false);
                translate([0,0,d]) cylinder(h=z-t, r=screw_r, center=false);
            }
        }
    }
}

module lid_for_hollow_box(x, y, r, t, screw_r) {
    difference() {
        lid_x = x-(2*t);
        lid_y = y-(2*t);
        rounded_box(lid_x, lid_y, t, r);
        color("red") {
            x_off = (2*t) + screw_r;
            y_off = (2*t) + screw_r;
            translate([x_off, y_off, -1*d]) {
                cylinder(h=t+d+d, r=screw_r, center=false);
            }
            translate([lid_x-x_off, y_off, -1*d]) {
                cylinder(h=t+d+d, r=screw_r, center=false);
            }
            translate([x_off, lid_y-y_off, -1*d]) {
                cylinder(h=t+d+d, r=screw_r, center=false);
            }
            translate([lid_x-x_off, lid_y-y_off, -1*d]) {
                cylinder(h=t+d+d, r=screw_r, center=false);
            }
        }
    }
}

hollow_box_for_lid(box_x, box_y, box_z, corner_r, thick, screw_r);

translate([10+box_x, thick, 0]) {
    lid_for_hollow_box(box_x, box_y, corner_r, thick, screw_r);
}