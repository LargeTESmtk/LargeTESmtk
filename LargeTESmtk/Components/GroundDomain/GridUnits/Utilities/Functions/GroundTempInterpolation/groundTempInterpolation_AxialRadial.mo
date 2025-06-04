within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function groundTempInterpolation_AxialRadial "First interpolation in axial direction, then in radial direction"

  input Modelica.Units.SI.Radius r "Radial position of wanted temperature";
  input Modelica.Units.SI.Distance z "Axial position of wanted temperature";

  input Modelica.Units.SI.Temperature T_t_l "Reference point - Top_Left: Temperature";
  input Modelica.Units.SI.Radius r_t_l "Reference point - Top_Left: Radial position";
  input Modelica.Units.SI.Distance z_t_l "Reference point - Top_Left: Axial position";

  input Modelica.Units.SI.Temperature T_t_r "Reference point - Top_Right: Temperature";
  input Modelica.Units.SI.Radius r_t_r "Reference point - Top_Right: Radial position";
  input Modelica.Units.SI.Distance z_t_r "Reference point - Top_Right: Axial position";

  input Modelica.Units.SI.Temperature T_b_l "Reference point - Bottom_Left: Temperature";
  input Modelica.Units.SI.Radius r_b_l "Reference point - Bottom_Left: Radial position";
  input Modelica.Units.SI.Distance z_b_l "Reference point - Bottom_Left: Axial position";

  input Modelica.Units.SI.Temperature T_b_r "Reference point - Bottom_Right: Temperature";
  input Modelica.Units.SI.Radius r_b_r "Reference point - Bottom_Right: Radial position";
  input Modelica.Units.SI.Distance z_b_r "Reference point - Bottom_Right: Axial position";

  output Modelica.Units.SI.Temperature T "Wanted temperature";

protected
  Modelica.Units.SI.Temperature T_l "Interpolated reference point - Left: Temperature";
  Modelica.Units.SI.Temperature T_r "Interpolated reference point - Right: Temperature";

algorithm

  assert(r_t_l==r_b_l, "r_t_l and r_b_l are not identical!", AssertionLevel.warning);
  assert(z_t_l==z_t_r, "z_t_l and z_t_r are not identical!", AssertionLevel.warning);
  assert(r_t_r==r_b_r, "r_t_r and r_b_r are not identical!", AssertionLevel.warning);
  assert(z_b_l==z_b_r, "z_b_l and z_b_r are not identical!", AssertionLevel.warning);

  T_l :=groundTempInterpolation_Axial(
    z,
    T_t_l,
    z_t_l,
    T_b_l,
    z_b_l);
  T_r :=groundTempInterpolation_Axial(
    z,
    T_t_r,
    z_t_r,
    T_b_r,
    z_b_r);

  T :=groundTempInterpolation_Radial(
    r,
    T_l,
    r_t_l,
    T_r,
    r_t_r);

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
end groundTempInterpolation_AxialRadial;
