within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getAxialPositions

  input Integer n_z_RP[4] "Indices of axial positions of reference points";
  input Modelica.Units.SI.Distance z_vec[:] "Given axial grid";
  input Modelica.Units.SI.Distance z_t "Top boundary of mesh domain";
  input Modelica.Units.SI.Distance z_b "Bottom boundary of mesh domain";

  output Modelica.Units.SI.Distance z_RP[4] "Positions of axial reference points {tl,tr,bl,br}";

protected
  Modelica.Units.SI.Distance z_tl;
  Modelica.Units.SI.Distance z_tr;
  Modelica.Units.SI.Distance z_bl;
  Modelica.Units.SI.Distance z_br;

algorithm

if n_z_RP[1]==0 then
  z_tl := z_t;
  z_bl := z_vec[n_z_RP[3]];
elseif n_z_RP[3]==-1 then
  z_tl := z_vec[n_z_RP[1]];
  z_bl := z_b;
else
  z_tl := z_vec[n_z_RP[1]];
  z_bl := z_vec[n_z_RP[3]];
end if;

z_tr := z_tl;
z_br := z_bl;

z_RP := {z_tl,z_tr,z_bl,z_br};

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
end getAxialPositions;
