clc;
clear;
addpath("mesh","mr")

BASE_X = 0.085;
BASE_Y =0;
BASE_Z =0.0765;

LINK_01 = 0.1007;
LINK_12 = 0.0540;
LINK_23 = 0.1458;
LINK_34 = 0.1542;
LINK_45 = 0.1458;
LINK_56 = 0.1542;

w =[ 0     0     1;...
     0     0     0;...
     0     0     0;...  
     0     0     1;...
     0     1     0;...
     0     0     1;...
     -1     0     0;...
     0     0     1;...
     0     1     0];
p =[     0         0    0;...
         0         0    0;...
         0         0    0;...
         BASE_X         BASE_Y    BASE_Z+LINK_01;...
         BASE_X         BASE_Y    BASE_Z+LINK_01+LINK_12;...
         BASE_X         BASE_Y    BASE_Z+LINK_01+LINK_12+LINK_23;...
         BASE_X         BASE_Y    BASE_Z+LINK_01+LINK_12+LINK_23+LINK_34;...
         BASE_X         BASE_Y    BASE_Z+LINK_01+LINK_12+LINK_23+LINK_34+LINK_45;...
         BASE_X         BASE_Y    BASE_Z+LINK_01+LINK_12+LINK_23+LINK_34+LINK_45+LINK_56];
     
     
M01 = [1 0 0 0;...
       0 1 0 0;...
       0 0 1 0;...
       0 0 0 1];
M12 = [1 0 0 0;...
       0 1 0 0;...
       0 0 1 0;...
       0 0 0 1];
M23 = [1 0 0 0;...
       0 1 0 0;...
       0 0 1 0;...
       0 0 0 1];
   
   
M34 = [0 -1 0 BASE_X;...
       1 0 0 BASE_Y;...
       0 0 1 BASE_Z+LINK_01;...
       0 0 0 1];
M45 = [1 0 0 0;...
       0 1 0 0;...
       0 0 1 LINK_12;...
       0 0 0 1];
M56 = [1 0 0 0;...
       0 1 0 0;...
       0 0 1 LINK_23;...
       0 0 0 1];
M67 = [1 0 0 0;...
       0 1 0 0;...
       0 0 1 LINK_34;...
       0 0 0 1];
M78 = [1 0 0 0;...
       0 1 0 0;...
       0 0 1 LINK_45;...
       0 0 0 1];
M89 = [1 0 0 0;...
       0 1 0 0;...
       0 0 1 LINK_56;...
       0 0 0 1];

Mlist={M01,M12,M23,M34,M45,M56,M67,M78,M89};
Slist = w_p_to_Slist(w,p);
Slist(4,2)=1;
Slist(5,3)=1;

thetalist =[0;0;0;0;0;0;0;0;0];
M = eye(4);
for j=1:1:length(Mlist)
    M = M*Mlist{j};
end
fv{1} = stlread("mesh/body_change.stl");
fv{2} = stlread("mesh/body_change.stl");
fv{3} = stlread("mesh/body_change.stl");
fv{4} = stlread("mesh/SPA_Link_01.stl");
fv{5} = stlread("mesh/SPA_Link_02.stl");
fv{6} = stlread("mesh/SPA_Link_03.stl");
fv{7} = stlread("mesh/SPA_Link_04.stl");
fv{8} = stlread("mesh/SPA_Link_05.stl");
fv{9} = stlread("mesh/SPA_Link_06.stl");

T = FKinSpace(M,Slist,thetalist);
for k = 1:1:5
thetalist =[0;0;0;0;0;0;0;0;0];

for i =linspace(0,pi/2,100)
    thetalist =[i;i/2;i/2;i;i;i;i;i;i];
    drawFK_mm(Slist,Mlist,thetalist,1,fv)
end
end