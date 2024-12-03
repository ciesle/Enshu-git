function [txPos]=calcTextPosInScatterPlot(dtPos)

x=dtPos(:,1);y=dtPos(:,2);
dtPos=[x,y];

figure
scatter(x,y);
tmpAx=axis;tmpScl=tmpAx*[[-1;1;0;0] [0;0;-1;1]];
txPos=1.00*[x y];
txPosOld=txPos;
close(gcf)

for n1=1:1000
    for n2=1:size(txPos,1)
        for n3=1:size(dtPos,1)
            dv=(dtPos(n3,:)-txPos(n2,:))./tmpScl;
            if norm(dv)>0.01
                txPos(n2,:)=txPos(n2,:)-3e-7*dv.*tmpScl/norm(dv)^2;
            end
        end
        for n3=1:size(txPos,1)
            if n2~=n3
                dv=(txPos(n3,:)-txPos(n2,:))./tmpScl;
                txPos(n2,:)=txPos(n2,:)-2e-7*dv.*tmpScl/norm(dv)^2;
            end
        end
    end
    if    norm((txPosOld-txPos)./tmpScl)<1e-4
        break;
    end
    txPosOld=txPos;
    
end
end