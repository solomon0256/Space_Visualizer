clear; close all; clc

%% {初始化}
% [读取素材]
imgspace = imread('space.jpg');
imgsun = imread('sun.jpg');
imgearth = imread('earth.jpg');
imgmoon = imread('moon.jpg');
% [物体半径]
Rsun = 30;
Rearth = 6;
Rmoon = 1,5;
% [轨迹半径]
R1 = Rsun*2;
R2 = Rearth*1.5;
% [初始位置]
Psun = [0,0,0];
Pearth = [R1,0,0];
Pmoon = [R1+R2,0,0];

%% {绘制}
% [纹理网格]
SpaceR = (R1+R2)*1.1;
[x01,y01,z01] = meshgrid(-SpaceR:SpaceR,-SpaceR:SpaceR,-SpaceR/1.5);
[x02,y02,z02] = meshgrid(-SpaceR:SpaceR,-SpaceR,-SpaceR/1.5:SpaceR/1.5);
[x03,y03,z03] = meshgrid(-SpaceR,-SpaceR:SpaceR,-SpaceR/1.5:SpaceR/1.5);
[x,y,z] = sphere(50);
[x1,y1,z1] = getxyz(x,y,z,Rsun,Psun,0);
[x2,y2,z2] = getxyz(x,y,z,Rearth,Pearth,0);
[x3,y3,z3] = getxyz(x,y,z,Rmoon,Pmoon,0);
% [上色绘制]
figure('Position',[0,0,1600,820])
h0 = surf(squeeze(x01),squeeze(y01),squeeze(z01),'EdgeAlpha',0);
set(h0,'CData',imgspace,'FaceColor','texturemap');
hold on
h0 = surf(squeeze(x02),squeeze(y02),squeeze(z02),'EdgeAlpha',0);
set(h0,'CData',imgspace,'FaceColor','texturemap');
h0 = surf(squeeze(x03),squeeze(y03),squeeze(z03),'EdgeAlpha',0);
set(h0,'CData',imgspace,'FaceColor','texturemap');
h1 = surf(x1,y1,z1,'EdgeAlpha',0);
set(h1,'CData',imgsun,'FaceColor','texturemap');
h2 = surf(x2,y2,z2,'EdgeAlpha',0);
set(h2,'CData',imgearth,'FaceColor','texturemap');
h3 = surf(x3,y3,z3,'EdgeAlpha',0);
set(h3,'CData',imgmoon,'FaceColor','texturemap');
hold off
axis equal,axis([-1,1,-1,1,-1/1.5,1/1.5]*SpaceR), axis off
view([1,1,0.2])
set(gca,'looseInset',[0 0 0 0])
%% {运动}
% [设置角速度]
V1 = 2*pi/365.25;
V2 = 2*pi/27.32;
datpart = 24;
% [迭代]
t = 0;
while 1
    t = t+1;
    dt1 = t*V1/datpart;
    dt2 = t*V2/datpart;
    Pearth = Psun+R1*[cos(dt1),sin(dt1),0];
    Pmoon = Pearth+R2*[cos(dt2),sin(dt2),0];

    theta = t/datpart*2*pi;
    [x2,y2,z2] = getxyz(x,y,z,Rearth,Pearth,theta);
    [x3,y3,z3] = getxyz(x,y,z,Rmoon,Pmoon,theta/2);
    
    h2.XData = x2;
    h2.YData = y2;
    h2.ZData = z2;
    
    h3.XData = x3;
    h3.YData = y3;
    h3.ZData = z3;
    drawnow
end

function [xq,yq,zq] = getxyz(x,y,z,R,center,theta)

%
siz = size(x);
coor = [x(:),y(:),z(:)]';
RM = [cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1];
coor = RM*coor;
x = reshape(coor(1,:),siz);
y = reshape(coor(2,:),siz);
z = reshape(coor(3,:),siz);
%
xq = x*R+center(1);
yq = y*R+center(2);
zq = z*R+center(3);

end
