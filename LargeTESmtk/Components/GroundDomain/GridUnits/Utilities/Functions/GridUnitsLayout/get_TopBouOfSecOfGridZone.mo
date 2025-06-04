within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_TopBouOfSecOfGridZone
  input Modelica.Units.SI.Distance dz_SD[:] = {1.6, 2, 2, 19.2, 15.2} "Axial size of sections";
  input Modelica.Units.SI.Distance  z_SD_t_tot = 0.3 "Top boundary of total sub-domain (global)";

  output Modelica.Units.SI.Distance z_SD_t[size(dz_SD,1)] "Top boundaries of sections of sub-domain (global)";
protected
  Modelica.Units.SI.Radius z_SD_b[size(dz_SD,1)] "Bottom boundaries of sections of sub-domain (global)";

algorithm

  z_SD_t[1] := z_SD_t_tot;
  z_SD_b[1] := z_SD_t[1] + dz_SD[1];

  for i in 2:size(dz_SD,1) loop
    z_SD_t[i] := z_SD_t[i - 1] + dz_SD[i - 1];
    z_SD_b[i] := z_SD_t[i] + dz_SD[i];
  end for;

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
end get_TopBouOfSecOfGridZone;
