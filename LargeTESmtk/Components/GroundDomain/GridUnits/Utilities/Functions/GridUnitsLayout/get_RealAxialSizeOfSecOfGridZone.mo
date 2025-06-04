within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_RealAxialSizeOfSecOfGridZone
  input Integer N_SD_z_real[:] = {4, 5, 5, 48, 38} "Real no. of nodes of axial sections";
  input Modelica.Units.SI.Distance dz_F_SC = 0.4 "Axial size of single cell";

  output Modelica.Units.SI.Distance dz_SD_real[size(N_SD_z_real,1)] "Real axial size of sections";

algorithm

  for i in 1:size(N_SD_z_real,1) loop
    dz_SD_real[i] :=N_SD_z_real[i]*dz_F_SC;
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
end get_RealAxialSizeOfSecOfGridZone;
