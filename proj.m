close all
clear
clc
%rgb_array=zeros(480,640,799);
depth=zeros(480,640,799);
addpath('data');
for i=1:799
    filename=sprintf('images00000%03d.mat',i);
    load(filename);
    depth(:,:,i)=depth_array;
end
clear rgb_array
clear frame_date
clear frame_toc
clear depth_array
%%
med=median(depth,3); % remover isto a cada imagem
%%

%Background removal

load('CalibrationData.mat');
d=reshape(med(:,:),480*640,1);
xyz=get_xyzasus(d,[480 640],find(d(:)>0),Depth_cam.K,1,0);
 for i=1:799
    backless(:,:,i)=depth(:,:,i)-med;
    d=reshape(backless(:,:,i),480*640,1);
    store(:,:,i)=get_xyzasus(d,[480 640], find(d(:)>0),Depth_cam.K,1,0);
 end

%%
%Ransac
[normal_vec,d,no_groundpoints,ground_points]=RANSAC(xyz,3,500,0.1,0.2);

x_m=mean(ground_points(:,1));
y_m=mean(ground_points(:,2));
z_m=mean(ground_points(:,3));
ground_points(:,1)=ground_points(:,1)-x_m;
ground_points(:,2)=ground_points(:,2)-y_m;
ground_points(:,3)=ground_points(:,3)-z_m;%Translation to the origin is performed

nx=cross(normal_vec,[0 0 1]);
nx=nx/norm(nx);
theta=dot(normal_vec,[0 0 1])/(norm([0 0 1])*norm(normal_vec));
theta=acos(theta);
X=[0 -nx(3) nx(2);nx(3) 0 -nx(1);-nx(2) nx(1) 0];
R=eye(3)+sin(theta)*X+(1-cos(theta))*X^2;
rotated=R*ground_points';
%%
rotate=R*xyz';
altura=find(normal_vec*rotate<d-1.4);
rotate(:,altura)=0;
%Como fazer a divisão?

%%

