within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_SizeOfFirstNode
  input Real SF_r = 1.50 "Radial scaling factor";
  input Modelica.Units.SI.Distance dr_tot = 5 "Total radial size";
  input Integer N = 8 "No. of radial nodes";

  output Modelica.Units.SI.Distance dr_FC "Radial size of first/smallest cell";

algorithm
  dr_FC := dr_tot*(1 - SF_r)/(1-SF_r^N);

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
end get_SizeOfFirstNode;
