within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_LeftBouOfSecOfGridZone
  input Modelica.Units.SI.Distance dr_SD[:] = {5,20,25} "Radial size of sections";
  input Modelica.Units.SI.Radius  r_SD_l_tot = 126.15 "Left boundary of total sub-domain (global)";

  output Modelica.Units.SI.Radius r_SD_l[size(dr_SD,1)] "Left boundaries of sections of sub-domain (global)";
protected
  Modelica.Units.SI.Radius r_SD_r[size(dr_SD,1)] "Left boundaries of sections of sub-domain (global)";

algorithm

  r_SD_l[1] := r_SD_l_tot;
  r_SD_r[1] := r_SD_l[1] + dr_SD[1];

  for i in 2:size(dr_SD,1) loop
    r_SD_l[i] := r_SD_l[i - 1] + dr_SD[i - 1];
    r_SD_r[i] := r_SD_l[i] + dr_SD[i];
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
end get_LeftBouOfSecOfGridZone;
