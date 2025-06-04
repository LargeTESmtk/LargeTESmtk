within LargeTESmtk.Components.FluidDomain.Examples.Parameters;
record PartialModelParameters_FluidDom "Partial record with common model parameters for fluid domain example models"
  extends LargeTESmtk.Utilities.TestFrameworks.PartialParRecords.PartialModelParameters;

  parameter Modelica.Units.SI.Length dz = 27  "Size in axial direction";

  parameter Modelica.Units.SI.Position z_to_glo = 0 "Axial distance to top boundary (w.r.t. global coordinate system)";

  parameter Integer N_z = 50 "Number of axial nodes";

  parameter Integer n_InOut_top = 2 "Position of top inlet/outlet fluid port (n=1: top fluid node)";
  final parameter Modelica.Units.SI.Position z_InOut_top = (n_InOut_top-0.5)*dz/N_z
    "Distance between the top inlet/outlet fluid port and the top fluid domain boundary";

  parameter Integer n_InOut_bot = N_z-1 "Position of bottom inlet/outlet fluid port (n=1: top fluid node)";
  final parameter Modelica.Units.SI.Position z_InOut_bot = (n_InOut_bot-0.5)*dz/N_z
    "Distance between the bottom inlet/outlet fluid port and the top fluid domain boundary";

  parameter Modelica.Media.Interfaces.Types.Temperature T_init_unif = 273.15+10 "Uniform initial temperature for all nodes";

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_top = 0.1
    "Overall heat transfer coefficent (HTC) at top boundary surface";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_sid = 0.3
    "Overall heat transfer coefficent (HTC) at side boundary surface";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_bot = 0.3
    "Overall heat transfer coefficent (HTC) at bottom boundary surface";

  parameter Modelica.Units.SI.Time tau_buo = 1
    "Time constant of buoyancy model (determines how fast the temperature compensation between adjacent fluid layers occurs)";

  parameter Modelica.Units.SI.Temperature T_ref = 273.15+10 "Reference temperature for internal energy calculation";

  // Placeholder parameters for future feature
  parameter Modelica.Units.SI.Time t_ReInit = 0 "[Placeholder for future feature] Reinitialization time; if t_ReInit=0 -> no reinitialization";
  parameter Modelica.Units.SI.Time t_PreDefT = 0 "[Placeholder for future feature] Duration of preheating period; if t_PreDefT=0 -> no preheating applied";
  annotation (defaultComponentName="modelPar",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="", revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end PartialModelParameters_FluidDom;
