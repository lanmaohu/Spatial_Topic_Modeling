function d = kilometerDistance(lat1, lon1, lat2, lon2)

%Convert to radians

latrad1 = lat1*pi/180;
lonrad1 = lon1*pi/180;
latrad2 = lat2*pi/180;
lonrad2 = lon2*pi/180;

londif = abs(lonrad2-lonrad1);

raddis = acos(sin(latrad2)*sin(latrad1)+cos(latrad2)*cos(latrad1)*cos(londif));

nautdis = raddis * 3437.74677;
statdis = nautdis * 1.1507794;
stdiskm = nautdis * 1.852;

d = stdiskm;
% 
% fprintf('Distance in radians: = %7.4f \n', raddis);
% fprintf('Distance in nautical miles: = %7.2f \n', nautdis);
% fprintf('Distance in statute miles: = %7.2f \n', statdis);
% fprintf('Distance in kilometers: = %7.2f \n', stdiskm);