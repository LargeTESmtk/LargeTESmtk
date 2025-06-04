within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout;
function create_ArrayWithNoOfAxialNodes
  input Integer Nsections_r = 3 "No. of radial sections of sub-domain";
  input Integer Nsections_z = 5 "No. of axial sections of sub-domain";
  input Integer N_R_z[Nsections_z] = {5,6,7,8,9} "No of nodes of axial sections";

  output Integer N_R_z_Array[Nsections_r, Nsections_z] "Array w/ no. of axial nodes for all sections";

algorithm

  for m in 1:Nsections_r loop
    for n in 1:Nsections_z loop
      N_R_z_Array[m, n] :=N_R_z[n];
    end for;
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
end create_ArrayWithNoOfAxialNodes;
