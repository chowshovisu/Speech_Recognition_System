% Validation
clc;
disp('Start speaking.')
recordblocking(recObj, samp);
disp('End of Recording.');
play(recObj);
q = getaudiodata(recObj);
W=abs(fft(q));
pause();
f=sortW(W,40000,50);
x=net(f);

if x<0.5
    x=0;
else
    x=1;
end

fprintf('I hope you said %d\n',x);

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
