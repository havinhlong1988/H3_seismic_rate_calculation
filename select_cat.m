function select_cat(clat,clong,radius,inxls,tab)
% Select catalog from xls file based on center location latitude, longitude
% and radius from center piont (in Km). And write out file name "out_cat.mat"
data = xlsread(inxls,tab);
y = data(:,1); m = data(:,2); d = data(:,3);
h = data(:,4); mi = data(:,5); s = data(:,6);
lat = data(:,7); long = data(:,8); dep = data(:,9); mag = data(:,10);
lat = lat(~isnan(lat)); long = long(~isnan(long)); 
dep = dep(~isnan(dep)); mag = mag(~isnan(mag));
lat0=clat; long0=clong;
%
cat = [];
for i=1:length(mag)
    % Calculate distance using haversin formula
    d(i) = haversin(lat0,long0,lat(i),long(i));
    if (d(i) <= radius) % Select event < 50 km from center point
        cat = [cat ;lat(i) long(i) dep(i) mag(i) y(i) m(i) d(i) h(i) mi(i) s(i)];
    end
end
save('out_cat.mat','cat','-ascii')
end