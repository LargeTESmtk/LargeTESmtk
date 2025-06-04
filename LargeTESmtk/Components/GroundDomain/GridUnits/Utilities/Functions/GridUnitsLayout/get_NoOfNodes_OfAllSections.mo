within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_NoOfNodes_OfAllSections
  input Real SF_r = 1.10 "Radial scaling factor";
  input Integer Nsections_r = 3 "No. of radial sections of sub-domain";
  input Modelica.Units.SI.Distance dr[Nsections_r] = {10,20,20} "Radial size of sections";
  input Modelica.Units.SI.Distance dr_FC_tot = 0.10 "Radial size of first cell of sub-domain";

  output Integer N_r[Nsections_r] "Number of radial nodes of sections";

protected
  Modelica.Units.SI.Distance dr_LC_real[Nsections_r] "Real radial size of last cells";
  Modelica.Units.SI.Distance dr_FC[Nsections_r] "Given radial size of first cells";

algorithm

  dr_FC[1] :=dr_FC_tot;
  N_r[1] :=get_NoOfNodes(
    SF_r,
    dr_FC[1],
    dr[1]);
  dr_LC_real[1] :=get_SizeOfLastNode(
    SF_r,
    dr[1],
    N_r[1]);

  for i in 2:Nsections_r loop
    dr_FC[i] :=dr_LC_real[i-1]*SF_r;
    N_r[i] :=get_NoOfNodes(
      SF_r,
      dr_FC[i],
      dr[i]);
    dr_LC_real[i] :=get_SizeOfLastNode(
      SF_r,
      dr[i],
      N_r[i]);
  end for;

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
end get_NoOfNodes_OfAllSections;
