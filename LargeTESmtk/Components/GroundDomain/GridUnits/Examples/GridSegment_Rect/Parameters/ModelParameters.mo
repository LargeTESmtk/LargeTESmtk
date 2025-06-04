within LargeTESmtk.Components.GroundDomain.GridUnits.Examples.GridSegment_Rect.Parameters;
record ModelParameters "Record with common model parameters for example models"
  extends LargeTESmtk.Utilities.TestFrameworks.PartialParRecords.PartialModelParameters;

  parameter Modelica.Units.SI.Radius r_le = 20 "Radial distance to left boundary (inner radius)";
  parameter Modelica.Units.SI.Radius r_ri = 45 "Radial distance to right boundary (outer radius)";

  parameter Modelica.Units.SI.Position z_to_glo = 0 "Axial distance to top boundary (w.r.t. global coordinate system)";
  parameter Modelica.Units.SI.Position z_bo_glo = 25 "Axial distance to bottom boundary (w.r.t. global coordinate system)";

  parameter Integer M_Sec_r = 1 "No. of radial sections in grid zone";
  parameter Modelica.Units.SI.Length dr_Sec_input[:] = {5,5}
    "Radial size of each section except the last section, which results from the size of the entire grid zone";
  parameter Modelica.Units.SI.Length dr_smallestNo = 0.10 "Radial size of smallest node of entire grid zone";
  parameter Integer M_r = 16 "Number of nodes in radial direction";
  parameter Real GR_r = 1.3 "Growth rate between adjacent nodes in radial direction (1: equidistant)";
  parameter Boolean reversedDir_GR_r = false
    "Growth rate direction, = false(default): node size increases from left to right, = true: node size increases from right to left";

  parameter Integer N_Sec_z = 1 "No. of axial sections in grid zone";
  parameter Modelica.Units.SI.Position z_Sec_bo_glo_input[:] = {5,10}
      "Axial distance to bottom boundary of each section (w.r.t. global coordinate system) except the last section, which is equivalent to the axial distance of the entire grid zone";
  parameter Boolean useEquidistantGrid_z=false
    "= false(default): increasing node size according to defined growth rate, = true: uniform node size in entire grid zone (i.e., equidistant grid spacing)";
  parameter Modelica.Units.SI.Length dz_smallestNo=0.10 "Axial size of smallest node of entire grid zone";
  parameter Integer N_z = 16 "Number of nodes in axial direction";
  parameter Real GR_z = 1.3 "Growth rate between adjacent nodes in axial direction (1: equidistant)";
  parameter Boolean reversedDir_GR_z = false
    "Growth rate direction, = false(default): node size increases from top to bottom, = true: node size increases from bottom to top";

  parameter Boolean useUnifThermProp = true
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment";
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.Ground.GenericGround thermalProp_unif
    "Thermophysical properties of the solid material (uniform for all nodes)";

  parameter Modelica.Units.SI.Temperature T_init_unif = 273.15 + 10 "Uniform initial temperature for all nodes";

  parameter Modelica.Units.SI.Radius r_TMP[:] = {30}
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)";
  parameter Modelica.Units.SI.Distance z_TMP[:] = {20}
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This record can be used to globally define the corresponding parameters for all example models. Alternatively, the parameters can also be defined individually in each model. 
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
end ModelParameters;
