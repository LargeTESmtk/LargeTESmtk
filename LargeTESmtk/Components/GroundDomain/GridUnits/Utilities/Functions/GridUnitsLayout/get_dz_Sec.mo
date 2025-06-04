within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_dz_Sec

  input Modelica.Units.SI.Position z_to_glo = 10 "Axial distance to top boundary (w.r.t. global coordinate system)";
  input Modelica.Units.SI.Position z_Sec_bo_glo[:] = {15,20,25} "Axial distance to bottom boundary of each section (w.r.t. global coordinate system)";

  output Modelica.Units.SI.Length dz_Sec[size(z_Sec_bo_glo,1)] "Size of each section in axial direction";

protected
  Integer N_Sec = size(z_Sec_bo_glo,1) "No. of axial sections of subdomain";
  Modelica.Units.SI.Position z_Sec_to_glo[N_Sec] "Axial distance to bottom boundary of each section (w.r.t. global coordinate system)";

algorithm

  z_Sec_to_glo[1] := z_to_glo;
  for n in 2:N_Sec loop
    z_Sec_to_glo[n] := z_Sec_bo_glo[n-1];
  end for;

  for n in 1:N_Sec loop
    dz_Sec[n] := z_Sec_bo_glo[n]-z_Sec_to_glo[n];
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
end get_dz_Sec;
