within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_SizeVectorWCondition_ForGridZoneRiFl_z

  input Integer Nsections_R_z = 5 "No. of axial sections of sub-domain";
  input Modelica.Units.SI.Distance z_R_b_global_minusLast[:] = {2,4,6,25}
    "Global depth of bottom boundary of (Nsections_R_z-1) sections";
  input Modelica.Units.SI.Distance z_R_b_global_Last = 40.3 "Global depth of bottom boundary of last section in sub-domain";

  output Modelica.Units.SI.Distance z_R_b_global[Nsections_R_z] "Depth of bottom boundary of sections";

algorithm

  if Nsections_R_z>1 then
    assert(size(z_R_b_global_minusLast,1)==Nsections_R_z-1, "The given vector (z_R_b_global_minusLast) must have the dimension of the number of sections in the sub-domain minus 1 (Nsections_R_z-1)", level = AssertionLevel.error);
    z_R_b_global := cat(1,z_R_b_global_minusLast,{z_R_b_global_Last});
  else
    z_R_b_global := {z_R_b_global_Last};
  end if;

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
end get_SizeVectorWCondition_ForGridZoneRiFl_z;
