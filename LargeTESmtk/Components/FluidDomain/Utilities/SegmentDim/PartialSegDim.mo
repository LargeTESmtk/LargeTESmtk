within LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim;
record PartialSegDim "Partial record with volume segment dimensions"
  extends Modelica.Icons.Record;

  final parameter Modelica.Units.SI.Distance z_to = z_bo-dz "Axial distance to top boundary (w.r.t. local coordinate system)";
  final parameter Modelica.Units.SI.Distance z_bo = z_bo_glo-z_to_glo_TopNode "Axial distance to bottom boundary (w.r.t. local coordinate system)";
  final parameter Modelica.Units.SI.Distance z = (z_to+z_bo)/2 "Axial distance to center (w.r.t. local coordinate system)";

  parameter Modelica.Units.SI.Length dz(fixed=false) "Size in axial direction (i.e., height/depth of fluid domain)";

  parameter Modelica.Units.SI.Position z_to_glo_TopNode "Axial distance to top boundary of top node of fluid domain (w.r.t. global coordinate system)" annotation (HideResult=true);

  parameter Modelica.Units.SI.Position z_to_glo(fixed=false) "Axial distance to top boundary (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Position z_bo_glo = z_to_glo+dz "Axial distance to bottom boundary (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Position z_glo = (z_to_glo+z_bo_glo)/2 "Axial distance to center (w.r.t. global coordinate system)";

  parameter Modelica.Units.SI.Area A_r = 2*r*Modelica.Constants.pi*dz "Lateral boundary surface";
  parameter Modelica.Units.SI.Area A_z_to = r^2*Modelica.Constants.pi "Top boundary surface perpendicular to axial direction";
  parameter Modelica.Units.SI.Area A_z_bo = A_z_to "Bottom boundary surface perpendicular to axial direction";
  parameter Modelica.Units.SI.Area A = A_z_to+A_z_bo+A_r "Total surface area";

  parameter Modelica.Units.SI.Volume V = A_z_to*dz "Volume";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end PartialSegDim;
