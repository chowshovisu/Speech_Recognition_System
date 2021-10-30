clc; clear all; close all;
recObj = audiorecorder
samp=5;
l = samp*8000;
input=50;
s=8;
y=zeros(l,s);
for i=1:s
    disp('Start speaking.')
    recordblocking(recObj, samp);
    disp('End of Recording.');
    play(recObj);
    y(:,i) = getaudiodata(recObj);
    pause(); 
end
in=zeros(input,s);
for i=1:s
    W=abs(fft(y(:,i)));
    in(:,i)=sortW(W,l,input);
end
o = [1 0 0 1 1 0 1 0];

net = feedforwardnet(20);  
net.trainParam.epochs=1000;
net.trainparam.goal=1e-10;
net = train(net,in,o);
pause()

% W = abs(fft)
function[f]=sortW(W,l,in)

    w=[1:l]';
    temp=0;
    for i=1:l
        for j=1:l-1
            if W(j+1) > W(j)
                temp=W(j+1);
                W(j+1)=W(j);
                W(j) =temp;
                temp=w(j+1);
                w(j+1)=w(j);
                w(j) =temp;
            end
        end
    end
f=zeros(in,1);    
for i=1:2:in*2-1
    f((i/2)+0.5)=w(i);
end
end

                
