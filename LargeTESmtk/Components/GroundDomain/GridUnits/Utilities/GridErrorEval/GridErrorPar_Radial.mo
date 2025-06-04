within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval;
record GridErrorPar_Radial "Grid error parameters (radial direction)"
  extends Modelica.Icons.Record;

  // Error parameters
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.ErrorMetrics dr_Sec_smallestNo[M_Sec_r]
    "Radial size of smallest node of each section";
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.ErrorMetrics GR_betwSec[M_Sec_r - 1]
    "Growth rate between largest node and smallest node of adjacent sections in radial direction";

  // Auxiliary values
  parameter Integer M_Sec_r = 3 "No. of radial sections" annotation (HideResult=true);

  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.GridErrorPar_Radial_AuxValues auxValues(M_Sec_r=M_Sec_r)
    "Auxiliary values for error metric calculations";

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
end GridErrorPar_Radial;
