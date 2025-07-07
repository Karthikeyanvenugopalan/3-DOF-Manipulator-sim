clc; clear; close all;

syms theta1 theta2 theta3 L1 L2 d1

DH = [ 0     pi/2   d1   theta1;
       L1    0      0    theta2;
       L2    0      0    theta3];

T = @(a, alpha, d, theta) [cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta);
                           sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
                           0,           sin(alpha),             cos(alpha),             d;
                           0,           0,                      0,                      1];

T01 = T(DH(1,1), DH(1,2), DH(1,3), DH(1,4));
T12 = T(DH(2,1), DH(2,2), DH(2,3), DH(2,4));
T23 = T(DH(3,1), DH(3,2), DH(3,3), DH(3,4));
T03 = simplify(T01 * T12 * T23);

disp('Symbolic T01 = '); disp(T01);
disp('Symbolic T12 = '); disp(T12);
disp('Symbolic T23 = '); disp(T23);
disp('Symbolic Final Transformation Matrix (0T3) = '); disp(T03);

d1_val = 10;
L1_val = 5;
L2_val = 7;

theta1_val = deg2rad(30);
theta2_val = deg2rad(45);
theta3_val = deg2rad(60);

T01_num = subs(T01, [d1, L1, L2, theta1, theta2, theta3], [d1_val, L1_val, L2_val, theta1_val, theta2_val, theta3_val]);
T12_num = subs(T12, [d1, L1, L2, theta1, theta2, theta3], [d1_val, L1_val, L2_val, theta1_val, theta2_val, theta3_val]);
T23_num = subs(T23, [d1, L1, L2, theta1, theta2, theta3], [d1_val, L1_val, L2_val, theta1_val, theta2_val, theta3_val]);
T03_num = subs(T03, [d1, L1, L2, theta1, theta2, theta3], [d1_val, L1_val, L2_val, theta1_val, theta2_val, theta3_val]);

T01_num = double(T01_num);
T12_num = double(T12_num);
T23_num = double(T23_num);
T03_num = double(T03_num);

disp('Numerical T01 = '); disp(T01_num);
disp('Numerical T12 = '); disp(T12_num);
disp('Numerical T23 = '); disp(T23_num);
disp('Numerical Final Transformation Matrix (0T3) = '); disp(T03_num);
