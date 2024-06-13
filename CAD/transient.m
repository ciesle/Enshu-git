model=createpde("structural","transient-solid");
importGeometry(model,"TuningFork.stl");
mesh=generateMesh(model, "Hmax",0.005);

E=210E9;
nu=0.3;
rho=8000;
structuralProperties(model, ...
    "YoungsModulus",E,...
    "PoissonsRatio",nu,...
    "MassDensity",rho);

figure("units","normalized","OuterPosition",[0 0 1 1]);
pdegplot(model, "FaceLabels", "on");
view(-50,15);

structuralBC(model, "Face", [21,22],"Constraint","Fixed");
T=2*pi/RF.NaturalFrequencies(7);

structuralBoundaryLoad(model,"Face",11,"Pressure",5E6,"EndTime",T/300);
structuralIC(model,"Displacement",[0;0;0],"Velocity",[0;0;0]);

ncycle=10;
samplingFrequency=10/T;
tlist=linspace(0,ncycle*T,ncycle*T*samplingFrequency);

R=solve(model,tlist);

excitedTineTipNodes=findNodes(mesh, "region","Face",12);
tipDisp=R.Displacement.uy(excitedTineTipNodes(1),:);

figure()
plot(R.SolutionTimes,tipDisp);
title("Transverse Displacement at Tine Tip");
xlim([0,0.1]);
xlabel("Time");
ylabel("Displacement");

[fTip,PTip]=tuningForkFFT(tipDisp,samplingFrequency);
figure(6)
set(gcf,"DoubleBuffer","on","Color",[1 1 1],"Position",[601 651 600*1 600]);
plot(fTip,PTip)
title({'Single-sided Amplitude Spectrum','of Tip Vibration'});
xlabel("f(Hz)");
ylabel("|P1(f)|");
xlim([0,4000]);