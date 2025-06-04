within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function groundTempInterpolation_Axial

  input Modelica.Units.SI.Distance z "Position of wanted temperature";

  input Modelica.Units.SI.Temperature T_t "Reference point - Top: Temperature";
  input Modelica.Units.SI.Distance z_t "Reference point - Top: Position";

  input Modelica.Units.SI.Temperature T_b "Reference point - Bottom: Temperature";
  input Modelica.Units.SI.Distance z_b "Reference point - Bottom: Position";

  output Modelica.Units.SI.Temperature T "Wanted temperature";

algorithm

  T := T_t-(z-z_t)/(z_b-z_t)*(T_t-T_b);

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
end groundTempInterpolation_Axial;
