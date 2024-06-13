model=createpde("structural","static-solid");
importGeometry(model, "kadai2-3_1_0.1.stl");

structuralProperties(model, "YoungsModulus",200e9, "MassDensity",100,"PoissonsRatio",0.3);
structuralBC(model, "Face", 3,"Constraint","fixed");

%structuralBoundaryLoad(model,"Face",6,"SurfaceTraction",[0;0;-1e2;]);
structuralBodyLoad(model,"GravitationalAcceleration",[0;0;-9.8]);

generateMesh(model);

result=solve(model);
figure
pdeplot3D(model,"ColorMapData",result.VonMisesStress);
title("VMstress");
colormap("jet")