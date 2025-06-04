within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function get_RealNoOfAxialNodes
  input Integer Nsections_z = 3 "No. of axial sections of sub-domain";
  input Integer N_z_tot = 101 "Total no. of axial nodes of sub-domain";
  input Modelica.Units.SI.Distance dz_tot = 30 "Total axial size of sub-domain";
  input Modelica.Units.SI.Distance z_t_global = 0 "Global depth of top boundary of sub-domain";
  input Modelica.Units.SI.Distance z_b_global[Nsections_z] = {10,25,30} "Global depth of bottom boundary of sections";

  output Integer N_z_real[Nsections_z] "Real no. of axial nodes of sections";

protected
  Real dz_rel[Nsections_z] "Relative axial size of sections";
  Integer N_z_real_interim[Nsections_z] "Real no. of axial nodes of sections (interim step)";
  Modelica.Units.SI.Distance z_b[Nsections_z] "Depth of bottom boundary of sections";
  Modelica.Units.SI.Distance dz[Nsections_z] "Size of sections";

algorithm

  z_b := z_b_global-fill(z_t_global,Nsections_z); // This step is necessary, as otherwise the calculation of dz is not precise so that the condition dz[Nsections_z-i+1]==max(dz) is not properly working
  dz[1] := z_b[1];
  for i in 2:Nsections_z loop
    dz[i] := z_b[i] - z_b[i-1];
  end for;

  for i in 1:Nsections_z loop
//       dz[Nsections_z-i+1] := i;
    if dz[Nsections_z-i+1]==max(dz) then
      dz[Nsections_z-i+1] := 0;
      break;
    end if;
  end for;

  for i in 1:Nsections_z loop
    dz_rel[i] := dz[i]/dz_tot;
    N_z_real_interim[i] := integer(IBPSA.Utilities.Math.Functions.round(dz_rel[i]*N_z_tot,0));
  end for;

  for i in 1:Nsections_z loop
    N_z_real[i] := (if N_z_real_interim[i]==0 then N_z_tot-sum(N_z_real_interim) else N_z_real_interim[i]);
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
end get_RealNoOfAxialNodes;
