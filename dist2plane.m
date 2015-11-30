function [ distances ] = dist2plane( points,plane )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
points(:,4)=1;
distances=zeros(length(points),1);
for i=1:length(points)
    distances(i)=plane'*points(i,:)';
end


end

