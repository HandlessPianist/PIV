function [bestParameter1,bestParameter2,bestInNum,plane_points] = ransac(data,num,iter,threshDist,inlierRatio)
 % data: a 2xn dataset with #n data points
 % num: the minimum number of points. 3 for a plane
 % iter: the number of iterations
 % threshDist: the threshold of the distances between points and the
 % fitting plane
 % inlierRatio: the threshold of the number of inliers 
 
 %%
number=size(data,1); %total nb of points
bestInNum=0;% Best fitting line with largest number of inliers
bestParameter1=0;bestParameter2=0;% parameters for best fitting linep
 plane_points=[];

 for i=1:iter
 
     idx = randperm(number,num); sample = data(idx,:);   
     v1=sample(1,:)-sample(3,:);
     v2=sample(2,:)-sample(3,:);
     n0=cross(v1,v2)/norm(cross(v1,v2));
     d0=dot(-sample(3,:),cross(sample(1,:),sample(2,:)))/norm(cross(v1,v2));
     
     data1=[data ones(length(data),1)];
     distance=[n0(1) n0(2) n0(3) d0]*data1';
 
     inlierIdx=find(abs(distance)<=threshDist);
     inlierNum = length(inlierIdx);

   
     if inlierNum>=round(inlierRatio*number) && inlierNum>bestInNum
         bestInNum = inlierNum;
         bestParameter1=n0; bestParameter2=d0;
         plane_points=data(inlierIdx,:);
     end
 end
 