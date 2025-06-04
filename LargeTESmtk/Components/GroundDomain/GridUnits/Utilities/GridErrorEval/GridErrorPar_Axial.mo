within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval;
record GridErrorPar_Axial "Grid error parameters (axial direction)"
  extends Modelica.Icons.Record;

// Error parameters
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.ErrorMetrics dz_Sec_smallestNo[N_Sec_z]
    "Axial size of smallest node of each section";
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.ErrorMetrics GR_betwSec[N_Sec_z - 1]
    "Growth rate between largest node and smallest node of adjacent section in axial direction";

  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.ErrorMetrics z_Sec_to_glo[N_Sec_z]
    "Axial distance to top boundary of each section (w.r.t. global coordinate system)";
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.ErrorMetrics z_Sec_bo_glo[N_Sec_z]
    "Axial distance to bottom boundary of each section (w.r.t. global coordinate system)";
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.ErrorMetrics dz_Sec[N_Sec_z]
    "Size of each section in axial direction";

// Auxiliary values
  parameter Integer N_Sec_z = 3 "No. of axial sections" annotation (HideResult=true);

  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.GridErrorPar_Axial_AuxValues auxValues(N_Sec_z=N_Sec_z)
    "Auxiliary values for error metric calculations";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
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
end GridErrorPar_Axial;
