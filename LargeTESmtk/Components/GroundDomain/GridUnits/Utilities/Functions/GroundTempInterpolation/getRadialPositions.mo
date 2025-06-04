within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getRadialPositions

  input Integer n_r_RP[4] "Indices of radial positions of reference points";
  input Modelica.Units.SI.Radius r_vec[:] "Given radial grid";
  input Modelica.Units.SI.Radius r_l "Left boundary of mesh domain";
  input Modelica.Units.SI.Radius r_r "Right boundary of mesh domain";

  output Modelica.Units.SI.Radius r_RP[4] "Positions of radial reference points {tl,tr,bl,br}";

protected
  Modelica.Units.SI.Radius r_tl;
  Modelica.Units.SI.Radius r_tr;
  Modelica.Units.SI.Radius r_bl;
  Modelica.Units.SI.Radius r_br;

algorithm

if n_r_RP[1]==0 then
  r_tl := r_l;
  r_tr := r_vec[n_r_RP[2]];
elseif n_r_RP[2]==-1 then
  r_tl := r_vec[n_r_RP[1]];
  r_tr := r_r;
else
  r_tl := r_vec[n_r_RP[1]];
  r_tr := r_vec[n_r_RP[2]];
end if;

r_bl := r_tl;
r_br := r_tr;

r_RP := {r_tl,r_tr,r_bl,r_br};

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
end getRadialPositions;
