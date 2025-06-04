within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
model SegmentLayout_Radial "Grid segment layout (radial direction)"
  //extends Modelica.Icons.Record;

// Dimensions and coordinates
  parameter Modelica.Units.SI.Radius r_le "Radial distance to left boundary (inner radius)";
  final parameter Modelica.Units.SI.Radius r_le_act = if r_le==0 then Modelica.Constants.eps else r_le  "Radial distance to left boundary (inner radius) (actual value)" annotation(HideResult=true);
  parameter Modelica.Units.SI.Radius r_ri "Radial distance to right boundary (outer radius)";

  final parameter Modelica.Units.SI.Length dr = r_ri-r_le_act "Size in radial direction";

  final parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.NodeDim_Radial nodeDim(M_r=M_r);

// Grid parameters
  parameter Integer M_r(min=1) = 10 "Number of nodes in radial direction" annotation (HideResult=true);

  parameter Real GR_r_act "Actual growth rate in radial direction used for further calculations";

initial equation

  nodeDim.r_le[1] = r_le_act;
  nodeDim.r_ri[M_r] = r_ri;

  if GR_r_act==1 then
    for m in 2:M_r loop
      nodeDim.r_le[m] = nodeDim.r_le[m-1] + dr / M_r;
      nodeDim.r_ri[m-1] = nodeDim.r_le[m];
    end for;
  else
    for m in 2:M_r loop
      nodeDim.r_le[m] = nodeDim.r_le[m-1] + dr * (1-GR_r_act)/(1-GR_r_act^(M_r)) * GR_r_act^(m-2);
      nodeDim.r_ri[m-1] = nodeDim.r_le[m];
    end for;
  end if;

  for m in 1:M_r loop
    nodeDim.r[m] = (nodeDim.r_le[m]+nodeDim.r_ri[m]) / 2;
    nodeDim.dr[m] = nodeDim.r_ri[m] - nodeDim.r_le[m];
    nodeDim.A_z[m] = Modelica.Constants.pi * (nodeDim.r_ri[m]^2 - nodeDim.r_le[m]^2);
  end for;

  annotation (defaultComponentName="gridLayout",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Grid segment layout, i.e., the reference framework of the grid segment that defines the dimensions and coordinates of the individual nodes in radial direction.
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
end SegmentLayout_Radial;
