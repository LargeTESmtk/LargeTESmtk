within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval;
record GridErrorPar_Radial_AuxValues "Auxiliary values for grid error evaluation (radial direction)"
  extends Modelica.Icons.Record;

  parameter Integer M_Sec_r = 3 "No. of radial sections" annotation (HideResult=true);

  parameter Modelica.Units.SI.Length dr_Sec_largestNo_act[M_Sec_r](each fixed=false) "Radial size of largest node of each section (actual value)";

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
end GridErrorPar_Radial_AuxValues;
