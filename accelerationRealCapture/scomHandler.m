function scomHandler( scom, BytesAvailable, h, h2 )
% 实时采集加速度和滤波波形对比

    global bufferSize; %N
    global lindex;
    global hindex;
    global buffer;
    global windex;
    global count;
    global qiancaiyang;
    global guassFilter;

    lineString = fgetl(scom);
    qiancaiyang = qiancaiyang+1;
    
    if mod(qiancaiyang,1)==0 && strcmp(lineString(1:2), 'a3')==1
        accel = sscanf(lineString, 'a3 %f,%f,%f');
        count = count + 1;
        buffer(:,windex) = accel(1:3);
        if windex > bufferSize+1
            buffer(:,windex-bufferSize-1) = accel(1:3);
        end
        if windex >= bufferSize*2
            windex = bufferSize;
        else
            windex = windex+1;
        end
        
        if count >= bufferSize
%             改用set方法重绘
%             figure(1);
%             plot(buffer(1,lindex:hindex),'r'); hold on
%             plot(buffer(2,lindex:hindex),'g');
%             plot(buffer(3,lindex:hindex),'b'); hold off
%             axis([0 bufferSize -2 2]);
%             grid on

%             改用set图形句柄效率更高
              set(h(1), 'XData', 1:bufferSize, 'YData', buffer(1,lindex:hindex));
              set(h(2), 'XData', 1:bufferSize, 'YData', buffer(2,lindex:hindex));
              set(h(3), 'XData', 1:bufferSize, 'YData', buffer(3,lindex:hindex));
            if hindex >= bufferSize*2
                lindex = 1;
                hindex = bufferSize;
            else
                lindex = lindex + 1;
                hindex = hindex + 1;
            end
            %高斯滤波
            set(h2(1), 'XData', 1:bufferSize, 'YData', conv(buffer(1,lindex:hindex), guassFilter, 'same'));
            set(h2(2), 'XData', 1:bufferSize, 'YData', conv(buffer(2,lindex:hindex), guassFilter, 'same'));
            set(h2(3), 'XData', 1:bufferSize, 'YData', conv(buffer(3,lindex:hindex), guassFilter, 'same'));
        end
    end
end
