include "globals.mzn";
include "chuffed.mzn";

array [0..5, 0..4, 0..63] of var 0..1: statestart; %before S-box
array [0..5, 0..4, 0..63] of var 0..1: stateend; %after S-box
array [0..64*6-1] of var {0,2,3,4}: prb;

%Modeling the substitution layer
array [1..317, 1..11] of int : DDT = array2d(1..317, 1..11, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 3, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 3, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 3, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 3, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 3, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 3, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 3, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 3, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 3, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 3, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 3, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 3, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 3, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 3, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 3, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 3, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 3, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 3, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 3, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 3, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 3, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 3, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 3, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 2, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 2, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 2, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 2, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 3, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 3, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 3, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 3, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 3, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 3, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 3, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 4, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 4, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 4, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 4, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 4, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 4, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 4, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 4, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 4, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 4, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 4, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 4, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 4, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 4, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 4, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 4, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 3, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 3, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 3, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 3, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 3, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 3, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 3, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 3, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 3, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 3, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 3, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 3, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 3, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 3, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 3, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 3, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 4, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 4, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 4, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 4, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 4, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 4, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 4, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 4, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 4, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 4, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 4, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 4, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 4, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 4, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 4, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 4, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 4, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 4, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 4, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 4, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 4, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 4, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 4, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 4, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 4, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 4, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 4, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 4, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 4, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 4, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 4, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 4, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 4, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 4, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 4, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 4, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 4, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 4, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 4, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 4, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 4, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 4, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 4, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 4, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 4, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 4, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 4, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 4, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 2, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 2, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 2, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 4, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 4, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 4, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 4, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 4, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 4, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 4, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 4, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 4, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 4, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 4, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 4, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 4, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 4, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 4, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 4, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 3, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 3, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 3, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 3, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 3, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 3, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 3, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 3, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 3, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 3, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 3, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 3, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 3, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 3, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 3, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 3, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 2, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 2, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 2, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 2, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 2, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 2, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 2, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 2, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 4, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 4, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 4, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 4, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 4, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 4, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 4, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 4, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 4, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 4, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 4, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 4, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 4, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 4, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 4, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 4, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 2, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 2, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 2, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 3, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 3, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 3, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 3, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 3, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 3, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 3, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 3, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 3, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 3, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 3, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 3, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 3, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 3, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 3, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 4, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 4, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 4, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 4, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 4, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 4, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 4, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 4, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 4, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 4, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 4, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 4, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 4, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 4, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 4, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 4, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 3, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 3, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 3, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 3, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 3, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 3, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 3, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 3, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 4, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 4, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 4, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 4, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 4, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 4, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 4, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 4, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 4, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 4, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 4, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 4, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 4, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 4, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 4, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 4, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 3, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 3, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 3, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 3, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 3, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 3, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 4, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 4, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 4, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 4, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 4, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 4, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 4, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 4, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 4, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 4, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 4, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 4, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 4, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 4, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 4, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 4, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 4, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 4, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 4, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 4, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 4, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 4, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 4, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 4, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 4, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 4, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 4, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 4, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 4, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 4, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 4, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 4, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 3, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 3, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 3, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 3, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 3, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 3, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 3, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 3, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 3, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 3, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 3, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 3, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 3, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 3, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 4, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 4, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 4, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 4, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 4, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 4, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 4, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 4, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 4, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 4, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 4, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 4, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 4, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 4, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 4, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 3, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 3, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 3]);

constraint forall (r in 0..5, i in 0..63) (
             table([statestart[r,0,i],statestart[r,1,i], statestart[r,2,i], statestart[r,3,i], statestart[r,4,i],
                    stateend[r,0,i],stateend[r,1,i], stateend[r,2,i], stateend[r,3,i], stateend[r,4,i],
              prb[64*(r)+i]], DDT)); 
 
%Modeling the linear layer
predicate Xor4(
  array[0..63] of var 0..1: a, 
  array[0..63] of var 0..1: b,
  array[0..63] of var 0..1: c, 
  array[0..63] of var 0..1: d)=
    forall(i in 0..63)(a[i]+b[i]+c[i]+d[i] in {0,2,4});

function array[0..63] of var 0..1: RRot(array[0..63] of var 0..50: X, int: val)=array1d(0..63, [X[(64+j-val) mod 64] | j in 0..63]);    
                             
%row 0
constraint forall (r in 0..4) (
let {
    array [0..63] of var 0..1:tmp=RRot(array1d(0..63,[stateend[r,0,j] | j in 0..63]),19),
    array [0..63] of var 0..1:tmpb=RRot(array1d(0..63,[stateend[r,0,j] | j in 0..63]),28),
    array [0..63] of var 0..1:tmpc=array1d(0..63,[stateend[r,0,j] | j in 0..63]), 
    array [0..63] of var 0..1:tmpd=array1d(0..63,[statestart[r+1,0,j] | j in 0..63])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);

%row 1
constraint forall (r in 0..4) (
let {
    array [0..63] of var 0..1:tmp=RRot(array1d(0..63,[stateend[r,1,j] | j in 0..63]),61),
    array [0..63] of var 0..1:tmpb=RRot(array1d(0..63,[stateend[r,1,j] | j in 0..63]),39), 
    array [0..63] of var 0..1:tmpc=array1d(0..63,[stateend[r,1,j] | j in 0..63]), 
    array [0..63] of var 0..1:tmpd=array1d(0..63,[statestart[r+1,1,j] | j in 0..63])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);

%row 2
constraint forall (r in 0..4) (
let {
    array [0..63] of var 0..1:tmp=RRot(array1d(0..63,[stateend[r,2,j] | j in 0..63]),1),
    array [0..63] of var 0..1:tmpb=RRot(array1d(0..63,[stateend[r,2,j] | j in 0..63]),6),
    array [0..63] of var 0..1:tmpc=array1d(0..63,[stateend[r,2,j] | j in 0..63]),
    array [0..63] of var 0..1:tmpd=array1d(0..63,[statestart[r+1,2,j] | j in 0..63])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);
%row 3
constraint forall (r in 0..4) (
let {
    array [0..63] of var 0..1:tmp=RRot(array1d(0..63,[stateend[r,3,j] | j in 0..63]),10),
    array [0..63] of var 0..1:tmpb=RRot(array1d(0..63,[stateend[r,3,j] | j in 0..63]),17),
    array [0..63] of var 0..1:tmpc=array1d(0..63,[stateend[r,3,j] | j in 0..63]),
    array [0..63] of var 0..1:tmpd=array1d(0..63,[statestart[r+1,3,j] | j in 0..63])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);
%row 4
constraint forall (r in 0..4) (
let {
    array [0..63] of var 0..1:tmp=RRot(array1d(0..63,[stateend[r,4,j] | j in 0..63]),7),
    array [0..63] of var 0..1:tmpb=RRot(array1d(0..63,[stateend[r,4,j] | j in 0..63]),41),
    array [0..63] of var 0..1:tmpc=array1d(0..63,[stateend[r,4,j] | j in 0..63]),
    array [0..63] of var 0..1:tmpd=array1d(0..63,[statestart[r+1,4,j] | j in 0..63])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);

%checking activeness of each Sbox
array [0..5, 0..63] of var bool: sboxes;
constraint forall(k in 0..5, j in 0..63) (sboxes[k,j] = checkActive([statestart[k,i,j] | i in 0..4]));
predicate checkActive(array[int] of var 0..1: a) = 
            let { int: len = length(a) }
          in
            sum(i in 1..len) (a[i]) > 0;
            
array[0..5] of var int: Sboxes;
constraint forall (k in 0..5)(
  Sboxes[k] = sum(j in 0..63)(bool2int(checkActive([statestart[k,i,j] | i in 0..4])))
);

%objective function
var int: obj;
constraint obj = sum(i in 0..64*6-1)(prb[i]);
         
ann: search_ann;
search_ann = seq_search([
    int_search(row(sboxes,1), random_order, indomain_min, complete),
    int_search(row(sboxes,4), random_order, indomain_min, complete),
    int_search(row(sboxes,0), random_order, indomain_min, complete),
    int_search(array1d(prb), occurrence, indomain_min, complete)]);

solve :: restart_constant(10000)
:: search_ann minimize obj;

%starting point (modifiable)
constraint stateend[2,3,37] == 1;
constraint stateend[2,3,47] == 1;
constraint stateend[2,3,54] == 1;
constraint sum(i in 0..4, j in 0..63)(stateend[2,i,j]) == 3;

constraint statestart[3,3,7] == 1;
constraint statestart[3,3,37] == 1;
constraint statestart[3,3,57] == 1;
constraint sum(i in 0..4, j in 0..63)(statestart[3,i,j]) == 3;

%Output
output ["beforeSB : \n"] ++ [show([statestart[0,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;
        
output ["afterSB : \n"] ++ [show([stateend[0,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;
        
output ["beforeSB : \n"] ++ [show([statestart[1,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;
        
output ["afterSB : \n"] ++ [show([stateend[1,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;

output ["beforeSB : \n"] ++ [show([statestart[2,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;
        
output ["afterSB : \n"] ++ [show([stateend[2,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;

output ["beforeSB : \n"] ++ [show([statestart[3,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;
        
output ["afterSB : \n"] ++ [show([stateend[3,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;

output ["beforeSB : \n"] ++ [show([statestart[4,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;
        
output ["afterSB : \n"] ++ [show([stateend[4,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;

output ["beforeSB : \n"] ++ [show([statestart[5,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;
        
output ["afterSB : \n"] ++ [show([stateend[5,i,j] | j in 0..63]) ++ " \n" | i in 0..4] ;
        
        
output [show([Sboxes[i] | i in 0..5]) ++ " " ++ show(obj) ++ "\n"] ++ [show([prb[i] | i in 64*k..64*(k+1)-1]) ++ " " ++ show(sum([prb[i] | i in 64*k..64*(k+1)-1])) ++ "\n" | k in 0..5 ];