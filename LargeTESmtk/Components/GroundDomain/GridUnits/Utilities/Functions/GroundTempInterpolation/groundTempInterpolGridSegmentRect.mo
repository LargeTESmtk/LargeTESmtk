within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function groundTempInterpolGridSegmentRect

  input Modelica.Units.SI.Radius r "Radial position of wanted temperature";
  input Modelica.Units.SI.Distance z "Axial position of wanted temperature";

  input Modelica.Units.SI.Radius r_vec[:] "Given radial grid";
  input Modelica.Units.SI.Radius r_l "Left boundary of mesh domain";
  input Modelica.Units.SI.Radius r_r "Right boundary of mesh domain";

  input Modelica.Units.SI.Distance z_vec[:] "Given axial grid";
  input Modelica.Units.SI.Distance z_t "Top boundary of mesh domain";
  input Modelica.Units.SI.Distance z_b "Bottom boundary of mesh domain";

  output Integer n_RP_r[4] "Indices of radial reference points for interpolation {RP top-left, RP top-right, RP bottom-left, RP bottom-right}; n=0: left boundary, n=-1: right boundary";
  output Integer n_RP_z[4] "Indices of axial reference points for interpolation {RP top-left, RP top-right, RP bottom-left, RP bottom-right}; n=0: top boundary, n=-1: bottom boundary";
  output Modelica.Units.SI.Radius r_RP[4] "Radial positions of reference points for interpolation {RP top-left, RP top-right, RP bottom-left, RP bottom-right}";
  output Modelica.Units.SI.Distance z_RP[4] "Axial positions of reference points for interpolation {RP top-left, RP top-right, RP bottom-left, RP bottom-right}";

algorithm
  n_RP_r :=getRadialPositionsIndex(
    r,
    r_vec,
    r_l,
    r_r)                                               "Vector with indices of radial positions";
  r_RP :=getRadialPositions(
    n_RP_r,
    r_vec,
    r_l,
    r_r)                                             "Positions of radial reference points {tl,tr,bl,br}";

  n_RP_z :=getAxialPositionsIndex(
    z,
    z_vec,
    z_t,
    z_b)                                              "Vector with indices of axial positions";
  z_RP :=getAxialPositions(
    n_RP_z,
    z_vec,
    z_t,
    z_b)                                            "Positions of axial reference points {tl,tr,bl,br}";

  TinCornerWarnings(
    r,
    z,
    r_vec,
    r_l,
    r_r,
    z_vec,
    z_t,
    z_b);

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
end groundTempInterpolGridSegmentRect;
