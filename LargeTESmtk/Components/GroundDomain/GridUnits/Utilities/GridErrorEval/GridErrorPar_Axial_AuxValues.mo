within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval;
record GridErrorPar_Axial_AuxValues "Auxiliary values for grid error evaluation (axial direction)"
  extends Modelica.Icons.Record;

  parameter Integer N_Sec_z = 3 "No. of axial sections" annotation (HideResult=true);

  parameter Modelica.Units.SI.Length dz_Sec_largestNo_act[N_Sec_z](each fixed=false) "Axial size of largest node of each section (actual value)";

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
end GridErrorPar_Axial_AuxValues;
