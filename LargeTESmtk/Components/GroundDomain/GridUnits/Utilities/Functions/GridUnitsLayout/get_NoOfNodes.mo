within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_NoOfNodes
  input Real SF_r = 1.50 "Radial scaling factor";
  input Modelica.Units.SI.Distance dr_FC = 0.10 "Given radial size of first/smallest cell";
  input Modelica.Units.SI.Distance dr_tot = 5 "Total radial size";

  output Integer N "No. of radial nodes";

protected
  Modelica.Units.SI.Radius r_r  "Current radius of right boundary";
  Modelica.Units.SI.Radius dr "Current radial size of the cell";
  Modelica.Units.SI.Radius r_r_pre  "Previous radius (of while-loop) of right boundary";
  Modelica.Units.SI.Radius dr_pre "Previous radial size (of while-loop) of the cell";
algorithm
  r_r := dr_FC;
  dr := dr_FC;

  r_r_pre := 0;
  dr_pre := 0;

  N := 0;

  while abs(dr_tot-r_r)<abs(dr_tot-r_r_pre) loop

    dr := dr*SF_r;
    r_r :=r_r+dr;

    if N==0 then
      dr_pre := dr_FC;
    else
      dr_pre := dr_pre*SF_r;
    end if;
    r_r_pre := r_r_pre+dr_pre;

    N := N+1;

  end while;

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
end get_NoOfNodes;
