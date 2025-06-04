within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function groundTempInterpolation_Radial

  input Modelica.Units.SI.Radius r "Position of wanted temperature";

  input Modelica.Units.SI.Temperature T_l "Reference point - Left: Temperature";
  input Modelica.Units.SI.Radius r_l "Reference point - Left: Position";

  input Modelica.Units.SI.Temperature T_r "Reference point - Right: Temperature";
  input Modelica.Units.SI.Radius r_r "Reference point - Right: Position";

  output Modelica.Units.SI.Temperature T "Wanted temperature";

algorithm

  T := T_l-log(r/r_l)/log(r_r/r_l)*(T_l-T_r);

  annotation (Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end groundTempInterpolation_Radial;
