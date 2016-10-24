function scomHandler( scom, BytesAvailable, file )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    lineString = fgetl(scom);
    fprintf(file, '%s\n', lineString);
end

