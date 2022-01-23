#!/usr/bin/env raku
use gpython-id;
use Test;

grammar G does Python3ID {
    rule TOP { <NAME> }
}

ok so G.parse("HELL9x");
ok so G.parse("goodbye");
nok so G.parse("0goodbye");
ok so G.parse("goodbye_py");
ok so G.parse("goodbye_p.y",              rule => "dotted_name");
ok so G.parse("goodbye_p.y.y.d.d.d.eeee", rule => "dotted_name");
ok so G.parse("goodbye_p.y.y.n18.d.d.eeee", rule => "dotted_name");
