within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getRadialPosIndex_GridZone_AllTMP

  input Modelica.Units.SI.Radius r[:] = {126.15+1, 126.15+5, 126.15+1} "Radial positions of wanted temperatures (global)";
  input Modelica.Units.SI.Radius r_SD_l[:] = {126.15, 131.15, 151.15} "Left boundaries of sections of sub-domain (global)";
  input Modelica.Units.SI.Radius r_SD_r[:] = {131.15, 151.15, 176.15} "Right boundaries of sections of sub-domain (global)";

  output Integer n_SD_r[size(r,1)] "Indices of radial sections of monitoring point positions in sub-domain";

algorithm

  for i in 1:size(r,1) loop
    n_SD_r[i] :=LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation.getRadialPosIndex_GridZone_SingleTMP(
      r[i],
      r_SD_l,
      r_SD_r);
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
end getRadialPosIndex_GridZone_AllTMP;
