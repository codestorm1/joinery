$fn = 100;
peg_height = 2;
peg_diameter = 4;
peg_round_height = 1;
peg_padding = 2;
peg_with_padding = peg_diameter + peg_padding * 2;
num_pegs = 5;
peg_gap = .02;

module make_peg(height, diameter, round_height) {
  union() {
    translate([0, 0, height - round_height]) {
      resize([diameter, diameter, height]) {
        minkowski() {
          cylinder(round_height, d = diameter, true);
          sphere(r = 1);
        }
      }
    }
    cylinder(height - round_height, d = diameter, true);
  }
}

cube([peg_with_padding * (num_pegs), peg_with_padding, 2]);

for (idx = [0 : peg_with_padding : peg_with_padding * (num_pegs - 1)]) {
  translate([peg_diameter + idx, peg_diameter, 2])  {
    make_peg(peg_height, peg_diameter, peg_round_height);
  }
}

translate([0, peg_with_padding + 2, 0]) {
  difference() {
    cube([peg_with_padding * (num_pegs), peg_with_padding, peg_height + 3]);
    for (idx = [0 : peg_with_padding : peg_with_padding * (num_pegs - 1)]) {
      translate([peg_diameter + idx, peg_with_padding / 2, peg_height])  {
        cylinder(h = peg_height + 3, d = peg_diameter + peg_gap);
      }
    }
  }
}
