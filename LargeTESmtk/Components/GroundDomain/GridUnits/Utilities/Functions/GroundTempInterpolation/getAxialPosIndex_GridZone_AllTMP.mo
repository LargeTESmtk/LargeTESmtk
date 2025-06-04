within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getAxialPosIndex_GridZone_AllTMP

  input Modelica.Units.SI.Distance z[:] = {1.3, 1.3, 19.3} "Axial positions of wanted temperatures (global)";
  input Modelica.Units.SI.Distance z_SD_t[:] = {0.3, 1.9, 3.9, 5.9, 25.1} "Top boundaries of sections of sub-domain (global)";
  input Modelica.Units.SI.Distance z_SD_b[:] = {1.9, 3.9, 5.9, 25.1, 40.3} "Bottom boundaries of sections of sub-domain (global)";

  output Integer n_SD_z[size(z,1)] "Indices of axial sections of monitoring point positions in sub-domain";

algorithm

  for i in 1:size(z,1) loop
    n_SD_z[i] :=LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation.getAxialPosIndex_GridZone_SingleTMP(
      z[i],
      z_SD_t,
      z_SD_b);
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
end getAxialPosIndex_GridZone_AllTMP;
