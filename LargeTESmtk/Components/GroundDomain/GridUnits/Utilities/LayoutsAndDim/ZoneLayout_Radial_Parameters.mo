within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
record ZoneLayout_Radial_Parameters "Grid zone layout parameters (radial direction)"
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.Radius r_le = 10 "Radial distance to left boundary (inner radius)" annotation(Dialog(group="Dimensions"));
  parameter Modelica.Units.SI.Radius r_ri = 40 "Radial distance to right boundary (outer radius)" annotation(Dialog(group="Dimensions"));

  parameter Integer M_Sec_r = 3 "No. of radial sections in grid zone" annotation(Dialog(group="Dimensions"));
  parameter Modelica.Units.SI.Length dr_Sec_input[:] = {10,10}
    "Radial size of each section except the last section, which results from the size of the entire grid zone" annotation(Dialog(group="Dimensions"));

  parameter Modelica.Units.SI.Length dr_smallestNo = 0.10 "Radial size of smallest node of entire grid zone" annotation(Dialog(group="Grid parameters"));
  parameter Real GR_r(min=1) =  1.1 "Growth rate between adjacent nodes in radial direction (1: equidistant)" annotation(Dialog(group="Grid parameters"));
  parameter Boolean reversedDir_GR_r = false
    "Growth rate direction, = false(default): node size increases from left to right, = true: node size increases from right to left" annotation(Dialog(group="Grid parameters"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Parameters of grid zone layout, i.e., the reference framework of the grid zone that defines the dimensions and coordinates of the individual grid segments in radial direction.
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
end ZoneLayout_Radial_Parameters;
