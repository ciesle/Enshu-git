model=createpde("structural","modal-solid");
importGeometry(model,"TuningFork.stl");
figure
pdegplot(model, "FaceLabels","on");

E=210E9;
nu=0.3;
rho=8000;
structuralProperties(model, ...
    "YoungsModulus",E,...
    "PoissonsRatio",nu,...
    "MassDensity",rho);

generateMesh(model, "Hmax",0.002);

RF=solve(model, "FrequencyRange",[-1,4000]*2*pi);
modelD=1:numel(RF.NaturalFrequencies);

%tmodalResults=table(modelD.',RF.NaturalFrequencies/2/pi);
%tmodalResults.Properties.VariableNames={'Mode','Frequency[Hz]'};
%disp(tmodalResults);

frames=animateSixTuningForkModes(RF);
movie (figure('unites','normalized','outerposition', [0 0 1 1]), frames, 5,30);