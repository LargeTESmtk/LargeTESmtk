within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getAxialPosIndex_GridZone_SingleTMP

  input Modelica.Units.SI.Distance z = 40.4 "Axial position of wanted temperature (global)";
  input Modelica.Units.SI.Distance z_SD_t[:] = {0.3, 1.9, 3.9, 5.9, 25.1} "Top boundaries of sections of sub-domain (global)";
  input Modelica.Units.SI.Distance z_SD_b[:] = {1.9, 3.9, 5.9, 25.1, 40.3} "Bottom boundaries of sections of sub-domain (global)";

  output Integer n_SD_z "Indices of axial sections of monitoring point positions in sub-domain";

protected
  Integer n;

algorithm

assert(z>=z_SD_t[1], "z_WantedTemperature < z_t_MeshSubDomain: Position of wanted temperature is outside of the mesh sub-domain boundary!", AssertionLevel.error);
assert(z<=z_SD_b[end], "z_WantedTemperature > z_b_MeshSubDomain: Position of wanted temperature is outside of the mesh sub-domain boundary!", AssertionLevel.error);

n := 1;

for i in 1:size(z_SD_t,1) loop
  if z==z_SD_t[n] then
    break;
  elseif z>z_SD_t[n] and z<=z_SD_b[n] then
    break;
  else
    n := n+1;
  end if;
end for;

n_SD_z := n;

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
end getAxialPosIndex_GridZone_SingleTMP;
