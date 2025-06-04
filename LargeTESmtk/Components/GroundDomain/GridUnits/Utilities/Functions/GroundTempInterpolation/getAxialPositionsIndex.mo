within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getAxialPositionsIndex

  input Modelica.Units.SI.Distance z "Axial position of wanted temperature";
  input Modelica.Units.SI.Distance z_vec[:] "Given axial grid";
  input Modelica.Units.SI.Distance z_t "Top boundary of mesh domain";
  input Modelica.Units.SI.Distance z_b "Bottom boundary of mesh domain";

  output Integer n_z_RP[4] "Indices of axial reference points {tl,tr,bl,br}; n=0: top boundary, n=-1: bottom boundary";

protected
  Integer n;

  Integer n_tl;
  Integer n_tr;
  Integer n_bl;
  Integer n_br;

algorithm

assert(z>=z_t, "z_WantedTemperature < z_t_MeshDomain: Position of wanted temperature is outside of the mesh domain boundary!", AssertionLevel.error);
assert(z<=z_b, "z_WantedTemperature > z_b_MeshDomain: Position of wanted temperature is outside of the mesh domain boundary!", AssertionLevel.error);

n := 1;

while z > z_vec[n] loop

  if n == size(z_vec,1) then
   break;
  end if;

  n := n+1;
end while;

if n == size(z_vec,1) then
  n_tl := n;
  n_bl := -1;
else
  n_tl := n-1;
  n_bl := n_tl+1;
end if;

n_tr := n_tl;
n_br := n_bl;

n_z_RP := {n_tl,n_tr,n_bl,n_br};

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
end getAxialPositionsIndex;
