within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function TinCornerWarnings

  input Modelica.Units.SI.Radius r = 5.5 "Radial position of wanted temperature";
  input Modelica.Units.SI.Distance z = 5.5 "Axial position of wanted temperature";

  input Modelica.Units.SI.Radius r_vec[:] = {1,2,3,5} "Given radial grid";
  input Modelica.Units.SI.Radius r_l = 0 "Left boundary of mesh domain";
  input Modelica.Units.SI.Radius r_r = 6 "Right boundary of mesh domain";

  input Modelica.Units.SI.Distance z_vec[:] = {1,2,3,5} "Given axial grid";
  input Modelica.Units.SI.Distance z_t = 0 "Top boundary of mesh domain";
  input Modelica.Units.SI.Distance z_b = 6 "Bottom boundary of mesh domain";

  output Boolean TinCornerWarning;

protected
  Boolean InTopLeftCorner;
  Boolean InTopRightCorner;
  Boolean InBotLeftCorner;
  Boolean InBotRightCorner;

  String AddInfoLocation;

algorithm

AddInfoLocation :=  " (Detected for temperature location: r_glo=" + String(r) + ", z_glo=" + String(z) + ")";

assert(r>=r_l, "r_WantedTemperature < r_l_MeshDomain: Position of wanted temperature is outside of the mesh domain boundary!" + AddInfoLocation, AssertionLevel.error);
assert(r<=r_r, "r_WantedTemperature > r_r_MeshDomain: Position of wanted temperature is outside of the mesh domain boundary!" + AddInfoLocation, AssertionLevel.error);

assert(z>=z_t, "z_WantedTemperature < z_t_MeshDomain: Position of wanted temperature is outside of the mesh domain boundary!" + AddInfoLocation, AssertionLevel.error);
assert(z<=z_b, "z_WantedTemperature > z_b_MeshDomain: Position of wanted temperature is outside of the mesh domain boundary!" + AddInfoLocation, AssertionLevel.error);

InTopLeftCorner := r<r_vec[1] and z<z_vec[1];
assert(not InTopLeftCorner, "The position of the desired temperature is in the top left corner of the mesh domain. 
Interpolation might be imprecise!" + AddInfoLocation, AssertionLevel.warning);

InTopRightCorner := r>r_vec[end] and z<z_vec[1];
assert(not InTopRightCorner, "The position of the desired temperature is in the top right corner of the mesh domain. 
Interpolation might be imprecise!" + AddInfoLocation, AssertionLevel.warning);

InBotLeftCorner := r<r_vec[1] and z>z_vec[end];
assert(not InBotLeftCorner, "The position of the desired temperature is in the bottom left corner of the mesh domain. 
Interpolation might be imprecise!" + AddInfoLocation, AssertionLevel.warning);

InBotRightCorner := r>r_vec[end] and z>z_vec[end];
assert(not InBotRightCorner, "The position of the desired temperature is in the bottom right corner of the mesh domain. 
Interpolation might be imprecise!" + AddInfoLocation, AssertionLevel.warning);

TinCornerWarning := InTopLeftCorner or InTopRightCorner or InBotLeftCorner or InBotRightCorner;

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
end TinCornerWarnings;
