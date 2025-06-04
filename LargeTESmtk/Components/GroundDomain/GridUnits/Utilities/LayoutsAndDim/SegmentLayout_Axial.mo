within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
model SegmentLayout_Axial "Grid segment layout (axial direction)"
  //extends Modelica.Icons.Record;

// Dimensions and coordinates
  parameter Modelica.Units.SI.Position z_to_glo "Axial distance to top boundary (w.r.t. global coordinate system)";
  parameter Modelica.Units.SI.Position z_bo_glo "Axial distance to bottom boundary (w.r.t. global coordinate system)";

  final parameter Modelica.Units.SI.Length dz = z_bo_glo-z_to_glo "Size in axial direction";

  parameter Modelica.Units.SI.Position z_to "Axial distance to top boundary (w.r.t. local coordinate system)";
  parameter Modelica.Units.SI.Position z_bo "Axial distance to bottom boundary (w.r.t. local coordinate system)";

  final parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.NodeDim_Axial nodeDim(N_z=N_z);

// Grid parameters
  parameter Integer N_z(min=1) = 10 "Number of nodes in axial direction" annotation (HideResult=false);

  parameter Real GR_z_act "Actual growth rate in axial direction used for further calculations";

initial equation

  nodeDim.z_to[1] = 0;
  nodeDim.z_bo[N_z] = dz;

  if GR_z_act==1 then
    for n in 2:N_z loop
      nodeDim.z_to[n] = nodeDim.z_to[n-1] + dz / N_z;
      nodeDim.z_bo[n-1] = nodeDim.z_to[n];
    end for;
  else
    for n in 2:N_z loop
      nodeDim.z_to[n] = nodeDim.z_to[n-1] + dz  * (1-GR_z_act)/(1-GR_z_act^(N_z)) * GR_z_act^(n-2);
      nodeDim.z_bo[n-1] = nodeDim.z_to[n];
    end for;
  end if;

  for n in 1:N_z loop
    nodeDim.z[n] = (nodeDim.z_to[n]+nodeDim.z_bo[n])/2;
    nodeDim.dz[n] = nodeDim.z_bo[n] - nodeDim.z_to[n];

    nodeDim.z_to_glo[n] = z_to_glo + nodeDim.z_to[n];
    nodeDim.z_bo_glo[n] = z_to_glo + nodeDim.z_bo[n];
    nodeDim.z_glo[n] = z_to_glo + nodeDim.z[n];
  end for;

  annotation (defaultComponentName="gridLayout",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Grid segment layout, i.e., the reference framework of the grid segment that defines the dimensions and coordinates of the individual nodes in axial direction .
</p>

</html>", revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end SegmentLayout_Axial;
