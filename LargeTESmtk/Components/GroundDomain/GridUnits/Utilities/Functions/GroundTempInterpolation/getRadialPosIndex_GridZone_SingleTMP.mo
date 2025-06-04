within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getRadialPosIndex_GridZone_SingleTMP

  input Modelica.Units.SI.Radius r = 131.15 "Radial position of wanted temperature (global)";
  input Modelica.Units.SI.Radius r_SD_l[:] = {126.15, 131.15, 151.15} "Left boundaries of sections of sub-domain (global)";
  input Modelica.Units.SI.Radius r_SD_r[:] = {131.15, 151.15, 176.15} "Right boundaries of sections of sub-domain (global)";

  output Integer n_SD_r "Indices of radial sections of monitoring point positions in sub-domain";

protected
  Integer n;

algorithm

assert(r>=r_SD_l[1], "r_WantedTemperature < r_le_MeshSubDomain: Position of wanted temperature is outside of the mesh sub-domain boundary!", AssertionLevel.error);
assert(r<=r_SD_r[end], "r_WantedTemperature > r_re_MeshSubDomain: Position of wanted temperature is outside of the mesh sub-domain boundary!", AssertionLevel.error);

n := 1;

for i in 1:size(r_SD_l,1) loop
  if r==r_SD_l[n] then
    break;
  elseif r>r_SD_l[n] and r<=r_SD_r[n] then
    break;
  else
    n := n+1;
  end if;
end for;

n_SD_r := n;

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
end getRadialPosIndex_GridZone_SingleTMP;
