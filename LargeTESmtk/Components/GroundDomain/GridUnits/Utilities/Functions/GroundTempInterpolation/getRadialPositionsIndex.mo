within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getRadialPositionsIndex

  input Modelica.Units.SI.Radius r "Radial position of wanted temperature";
  input Modelica.Units.SI.Radius r_vec[:] "Given radial grid";
  input Modelica.Units.SI.Radius r_l "Left boundary of mesh domain";
  input Modelica.Units.SI.Radius r_r "Right boundary of mesh domain";

  output Integer n_r_RP[4] "Indices of radial reference points {tl,tr,bl,br}; n=0: left boundary, n=-1: right boundary";

protected
  Integer n;

  Integer n_tl;
  Integer n_tr;
  Integer n_bl;
  Integer n_br;

algorithm

assert(r>=r_l, "r_WantedTemperature < r_l_MeshDomain: Position of wanted temperature is outside of the mesh domain boundary!", AssertionLevel.error);
assert(r<=r_r, "r_WantedTemperature > r_r_MeshDomain: Position of wanted temperature is outside of the mesh domain boundary!", AssertionLevel.error);

n := 1;

while r > r_vec[n] loop

  if n == size(r_vec,1) then
   break;
  end if;

  n := n+1;
end while;

if n == size(r_vec,1) then
  n_tl := n;
  n_tr := -1;
else
  n_tl := n-1;
  n_tr := n_tl+1;
end if;

n_bl := n_tl;
n_br := n_tr;

n_r_RP := {n_tl,n_tr,n_bl,n_br};

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
end getRadialPositionsIndex;
