within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
record ZoneLayout_Axial_Parameters "Grid zone layout parameters (axial direction)"
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.Position z_to_glo = 10 "Axial distance to top boundary (w.r.t. global coordinate system)" annotation(Dialog(group="Dimensions"));
  parameter Modelica.Units.SI.Position z_bo_glo = 40 "Axial distance to bottom boundary (w.r.t. global coordinate system)" annotation(Dialog(group="Dimensions"));

  parameter Integer N_Sec_z = 3 "No. of axial sections in grid zone" annotation(Dialog(group="Dimensions"));
  parameter Modelica.Units.SI.Position z_Sec_bo_glo_input[:] = {20,30}
    "Axial distance to bottom boundary of each section (w.r.t. global coordinate system) except the last section, which is equivalent to the axial distance of the entire grid zone" annotation(Dialog(group="Dimensions"));

  parameter Boolean useEquidistantGrid_z = false
    "= false(default): increasing node size according to defined growth rate, = true: uniform node size in entire grid zone (i.e., equidistant grid spacing)" annotation(Dialog(group="Grid parameters"));

  parameter Modelica.Units.SI.Length dz_smallestNo = 0.10
    "Axial size of smallest node of entire grid zone" annotation(Dialog(enable=not useEquidistantGrid_z,group="Grid parameters"),HideResult=useEquidistantGrid_z);
  parameter Real GR_z(min=1) =  1.1
    "Growth rate between adjacent nodes in axial direction (1: equidistant)" annotation(Dialog(enable=not useEquidistantGrid_z,group="Grid parameters"),HideResult=useEquidistantGrid_z);
  parameter Boolean reversedDir_GR_z = false
    "Growth rate direction, = false(default): node size increases from top to bottom, = true: node size increases from bottom to top" annotation(Dialog(enable=not useEquidistantGrid_z,group="Grid parameters"),HideResult=useEquidistantGrid_z);

  parameter Integer N_Nodes_z(min=1) = 10
    "Number of nodes in axial direction" annotation(Dialog(enable=useEquidistantGrid_z,group="Grid parameters"),HideResult=not useEquidistantGrid_z);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Parameters of grid zone layout, i.e., the reference framework of the grid zone that defines the dimensions and coordinates of the individual grid segments in axial direction.
</p>

</html>",
        revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end ZoneLayout_Axial_Parameters;
