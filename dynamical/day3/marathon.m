s=tf('s');
function score = calc_score(x,y,k)
    P=2/s/(s+2);
    K=k*(s+x(1))*(s+x(2))/(s+y(1))/(s+y(2));
    S=1/(1+P*K);
    T=(P*K)/(1+P*K);
    [Gm,Pm,Wgc,Wcp]=margin(P*K);
    si=stepinfo(P*K);
    Mrs=getPeakGain(S);
    Mr=getPeakGain(T);
    Tr=si.RiseTime;
    Ts=si.SettlingTime;
    Amax=si.Overshoot;
    Kv=2*k*(-x(1))*(-x(2))/2/(-y(1))/(-y(2));
    
    sum=0;
    decs=10;
    if Wgc<2 sum=sum+(2-Wgc)/4;
    elseif Wgc <=4 sum=sum+(Wgc-2)/decs/4;
    elseif Wgc<=6 sum=sum+(6-Wgc)/decs/4;
    else sum=sum+(Wgc-6)/4;
    end

    if GM>=10 sum=sum+(GM-10)/decs/10;
    else sum=sum+(10-GM)/10;
    end

    if PM>=45 sum=sum+(PM-45)/decs/45;
    else sum=sum+(45-PM)/45;
    end

    if Kv>=15 sum=sum+(Kv-15)/decs/15;
    else sum=sum+(15-Kv)/15;
    end

    if Mrs<=6 sum=sum+(6-Mrs)/decs/6;
    else sum=sum+(Mrs-6)/6;
    end
    
    if Mr<=3.5 sum=sum+(3.5-Mr)/decs/3.5;
    else sum=sum+(Mr-3.5)/3.5;
    end

    if Tr<=0.8 sum=sum+(0.8-Tr)/decs/0.8;
    else sum=sum+(Tr-0.8)/0.8;
    end

    if Ts<=1.4 sum=sum+(1.4-Ts)/decs/1.4;
    else sum=sum+(Ts-1.4)/1.4;
    end

    if Amax<=2 sum=sum+(2-Amax)/decs/2;
    else sum=sum+(Amax-2)/2;
    end

    return sum*sum;
end

function [k,x,y] = sa()
    k=0.23;
    x(1)=1.344;
    x(2)=48.55;
    y(1)=3.8;
    y(2)=2.4;

    start_tmp=1;
    end_tmp=0;
    count=1;
    while true
        count=count+1;
        if count>100000
            break;
        end

        nk=k+random("Normal",0,1/count/);

           
        tmp=start_tmp+(end_tmp-start_tmp)*(count)/100000;
        
    end
end