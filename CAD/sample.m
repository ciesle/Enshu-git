model=createpde("structural","static-solid");
importGeometry(model, "sample_cad.stl");

structuralProperties(model, "YoungsModulus", 200e9, "PoissonsRatio",0.3);

structuralBC(model, "Face", 1, "Constraint", "fixed");

structuralBoundaryLoad(model, "Face", 5, "SurfaceTraction",[0;0;-1e0]);

generateMesh(model);

result=solve(model);

figure
pdeplot3D(model, "ColorMapData",result.Displacement.uy);
title("VMStress");
colormap("jet")
