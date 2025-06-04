within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_SizeVectorWCondition
  input Integer Nsections = 3 "No. of sections of sub-domain";
  input Modelica.Units.SI.Distance dx_minusLast[:] = {5,20} "Size of (Nsections-1) sections in sub-domain";
  input Modelica.Units.SI.Distance dx_tot = 50 "Size of the whole sub-domain";

  output Modelica.Units.SI.Distance dx[Nsections] "Size of all sections in sub-domain";

algorithm

  if Nsections>1 then
    assert(size(dx_minusLast,1)==Nsections-1, "The given vector (dx_minusLast) must have the dimension of the number of sections in the sub-domain minus 1 (Nsections-1)", level = AssertionLevel.error);
    dx := cat(1,dx_minusLast,{dx_tot-sum(dx_minusLast)});
  else
    dx := {dx_tot};
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
end get_SizeVectorWCondition;
