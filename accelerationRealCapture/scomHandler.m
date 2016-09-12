function scomHandler( scom, BytesAvailable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    global bufferSize; %N
    global lindex;
    global hindex;
    global buffer;
    global windex;
    global count;

    lineString = fgetl(scom);
    if mod(qiancaiyang,40) == 0
        accel = sscanf(lineString, '$%c%ce %f,%f,%f');
        accel
        count = count + 1;
        buffer(:,windex) = accel;
        if windex > bufferSize+1
            buffer(:,windex-bufferSize-1) = accel;
        end
        if windex >= bufferSize*2
            windex = bufferSize;
        else
            windex = windex+1;
        end
        %display & filter
        if count >= bufferSize
            figure(1);
            plot(buffer(1,lindex:hindex),'r'); hold on
            plot(buffer(2,lindex:hindex),'g');
            plot(buffer(3,lindex:hindex),'b'); hold off
            grid on
            if hindex >= bufferSize*2
                lindex = 1;
                hindex = bufferSize;
            else
                lindex = lindex + 1;
                hindex = hindex + 1;
            end
            %¸ßË¹ÂË²¨
        end
    end
end
