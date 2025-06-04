within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
model ZoneLayout_Axial "Grid zone layout (axial direction)"
  //extends Modelica.Icons.Record;

  parameter Boolean useEquidistantGrid_z = zoneLayoutPar_z.useEquidistantGrid_z
    "= true: uniform node size in entire grid zone (i.e., equidistant grid spacing), = false(default): increasing node size according to defined growth rate";

// Dimensions and coordinates
  // Grid zone
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters zoneLayoutPar_z
    "Grid zone layout parameters in axial direction";

  parameter Modelica.Units.SI.Position z_to_glo = zoneLayoutPar_z.z_to_glo "Axial distance to top boundary (w.r.t. global coordinate system)";
  parameter Modelica.Units.SI.Position z_bo_glo = zoneLayoutPar_z.z_bo_glo "Axial distance to bottom boundary (w.r.t. global coordinate system)";

  final parameter Modelica.Units.SI.Length dz = z_bo_glo-z_to_glo "Size in axial direction";

  // Sections
  parameter Integer N_Sec_z = zoneLayoutPar_z.N_Sec_z "No. of axial sections in grid zone";
  parameter Modelica.Units.SI.Position z_Sec_bo_glo_input[:] = zoneLayoutPar_z.z_Sec_bo_glo_input
    "Axial distance to bottom boundary of each section (w.r.t. global coordinate system) except the last section, which is equivalent to the axial distance of the entire grid zone";
  final parameter Modelica.Units.SI.Position z_Sec_bo_glo_set[N_Sec_z]=
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_SizeVectorWCondition_ForGridZoneRiFl_z(
      N_Sec_z,
      z_Sec_bo_glo_input,
      z_bo_glo) "Axial distance to bottom boundary of each section (w.r.t. global coordinate system) (setpoint)";

  final parameter Modelica.Units.SI.Length dz_Sec_GR[N_Sec_z]=
    LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_dz_Sec(            z_to_glo,z_Sec_bo_glo_set)
      "Size of each section in axial direction when using an increasing node size according to defined growth rate" annotation(HideResult=true);
  final parameter Modelica.Units.SI.Length dz_Sec[N_Sec_z]= if useEquidistantGrid_z
    then
    LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_RealAxialSizeOfSecOfGridZone(
    N_nodesPerSec, dz_Node_Eq)
    else
    dz_Sec_GR
      "Size of each section in axial direction";

  parameter Modelica.Units.SI.Position z_Sec_to[N_Sec_z] = z_Sec_to_glo-fill(z_to_glo,N_Sec_z)
    "Axial distance to top boundary of each section (w.r.t. local coordinate system)";
  parameter Modelica.Units.SI.Position z_Sec_bo[N_Sec_z] = z_Sec_bo_glo-fill(z_to_glo,N_Sec_z) "Axial distance to bottom boundary of each section (w.r.t. local coordinate system)";

  final parameter Modelica.Units.SI.Position z_Sec_to_glo[N_Sec_z]=
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_TopBouOfSecOfGridZone(
      dz_Sec,
      z_to_glo) "Axial distance to top boundary of each section (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Position z_Sec_bo_glo[N_Sec_z]=
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_BottomBouOfSecOfGridZone(
      dz_Sec,
      z_to_glo) "Axial distance to bottom boundary of each section (w.r.t. global coordinate system)";

// Grid parameters
  parameter Modelica.Units.SI.Length dz_smallestNo = if useEquidistantGrid_z then dz_Node_Eq else zoneLayoutPar_z.dz_smallestNo
    "Axial size of smallest node of entire grid zone" annotation(HideResult=useEquidistantGrid_z);

  parameter Integer N_Nodes_z_Eq(min=1) = zoneLayoutPar_z.N_Nodes_z "Number of nodes in axial direction when using an equidistant grid" annotation(HideResult=true);
  final parameter Modelica.Units.SI.Length dz_Node_Eq = dz/N_Nodes_z_Eq "Axial size of each node in grid zone when using an equidistant grid" annotation(HideResult=true);

  parameter Real GR_z(min=1) = if useEquidistantGrid_z then 1 else zoneLayoutPar_z.GR_z "Growth rate between adjacent nodes in axial direction (1: equidistant)";
  // TBD ADD ERROR: Hast to be greater than 1
  parameter Boolean reversedDir_GR_z = zoneLayoutPar_z.reversedDir_GR_z
    "Growth rate direction, = false(default): node size increases from top to bottom, = true: node size increases from bottom to top" annotation(HideResult=useEquidistantGrid_z);
  final parameter Real GR_z_act = if reversedDir_GR_z then 1/GR_z else GR_z
    "Actual growth rate in axial direction used for further calculations" annotation(HideResult=true);

  final parameter Integer N_nodesPerSec[N_Sec_z]=
    if useEquidistantGrid_z
      then
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_RealNoOfAxialNodes(
      N_Sec_z,
      N_Nodes_z_Eq,
      dz,
      z_to_glo,
      z_Sec_bo_glo_set) else
      (if reversedDir_GR_z then integer(Modelica.Math.Vectors.reverse(
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_NoOfNodes_OfAllSections(
      GR_z,
      N_Sec_z,
      Modelica.Math.Vectors.reverse(dz_Sec_GR),
      dz_smallestNo))) else
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_NoOfNodes_OfAllSections(
      GR_z,
      N_Sec_z,
      dz_Sec_GR,
      dz_smallestNo)) "Number of axial nodes of each section; Hast to be determined with a function: 'You cannot have arrays with variable size at 
    runtime in Modelica. All array sizes need to be known at compile time, so the sizes need to be parameters or constants.'
    e.g., see: https://stackoverflow.com/questions/42457828/initialising-array-with-unknown-size-in-modelica 
    ";

// Summary of section and node parameters
  LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.SegmentLayout_Axial sections[N_Sec_z](
    z_to_glo=z_Sec_to_glo,
    z_bo_glo=z_Sec_bo_glo,
    z_to=z_Sec_to,
    z_bo=z_Sec_bo,
    N_z=N_nodesPerSec,
    each GR_z_act=GR_z_act) "Dimensions and coordinates of each section (and the corresponding nodes) of the grid zone in axial direction";

  final parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.NodeDim_Axial nodeDim_Zone(N_z=sum(N_nodesPerSec))
    "Dimensions and coordinates of all nodes of the grid zone in axial direction";

// Grid error metrics
  final parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.GridErrorPar_Axial gridErrMetr(N_Sec_z=N_Sec_z)
    "Grid error metrics";

initial equation

// Assigment of node dimensions and coordinates
  for n in 1:N_Sec_z loop
    nodeDim_Zone.z_to_glo[(if n==1 then 1 else sum(N_nodesPerSec[1:n-1])+1):sum(N_nodesPerSec[1:n])] = sections[n].nodeDim.z_to_glo;
    nodeDim_Zone.z_bo_glo[(if n==1 then 1 else sum(N_nodesPerSec[1:n-1])+1):sum(N_nodesPerSec[1:n])] = sections[n].nodeDim.z_bo_glo;
    nodeDim_Zone.z_glo[(if n==1 then 1 else sum(N_nodesPerSec[1:n-1])+1):sum(N_nodesPerSec[1:n])] = sections[n].nodeDim.z_glo;
    nodeDim_Zone.dz[(if n==1 then 1 else sum(N_nodesPerSec[1:n-1])+1):sum(N_nodesPerSec[1:n])] = sections[n].nodeDim.dz;

    nodeDim_Zone.z_to[(if n==1 then 1 else sum(N_nodesPerSec[1:n-1])+1):sum(N_nodesPerSec[1:n])] = sections[n].nodeDim.z_to+
      (if n==1 then fill(0,N_nodesPerSec[n]) else fill(sections[n-1].z_bo,N_nodesPerSec[n]));
    nodeDim_Zone.z_bo[(if n==1 then 1 else sum(N_nodesPerSec[1:n-1])+1):sum(N_nodesPerSec[1:n])] = sections[n].nodeDim.z_bo+
      (if n==1 then fill(0,N_nodesPerSec[n]) else fill(sections[n-1].z_bo,N_nodesPerSec[n]));
    nodeDim_Zone.z[(if n==1 then 1 else sum(N_nodesPerSec[1:n-1])+1):sum(N_nodesPerSec[1:n])] = sections[n].nodeDim.z+
      (if n==1 then fill(0,N_nodesPerSec[n]) else fill(sections[n-1].z_bo,N_nodesPerSec[n]));
  end for;

// Grid error metrics
  if reversedDir_GR_z then
    gridErrMetr.dz_Sec_smallestNo[end].setValue = dz_smallestNo;
    for n in 1:N_Sec_z-1 loop
      gridErrMetr.dz_Sec_smallestNo[n].setValue = gridErrMetr.auxValues.dz_Sec_largestNo_act[n+1]*GR_z;
    end for;

    for n in 1:N_Sec_z loop
      gridErrMetr.auxValues.dz_Sec_largestNo_act[n] = sections[n].nodeDim.dz[1];
      gridErrMetr.dz_Sec_smallestNo[n].actValue = sections[n].nodeDim.dz[N_nodesPerSec[n]];
    end for;

    for n in 1:N_Sec_z-1 loop
      gridErrMetr.GR_betwSec[n].actValue = gridErrMetr.dz_Sec_smallestNo[n].actValue/gridErrMetr.auxValues.dz_Sec_largestNo_act[n+1];
    end for;
  else
    gridErrMetr.dz_Sec_smallestNo[1].setValue = dz_smallestNo;
    for n in 2:N_Sec_z loop
      gridErrMetr.dz_Sec_smallestNo[n].setValue = gridErrMetr.auxValues.dz_Sec_largestNo_act[n-1]*GR_z;
    end for;

    for n in 1:N_Sec_z loop
      gridErrMetr.auxValues.dz_Sec_largestNo_act[n] = sections[n].nodeDim.dz[N_nodesPerSec[n]];
      gridErrMetr.dz_Sec_smallestNo[n].actValue = sections[n].nodeDim.dz[1];
    end for;

    for n in 1:N_Sec_z-1 loop
      gridErrMetr.GR_betwSec[n].actValue = gridErrMetr.dz_Sec_smallestNo[n+1].actValue/gridErrMetr.auxValues.dz_Sec_largestNo_act[n];
    end for;
  end if;

  for n in 1:N_Sec_z loop
    gridErrMetr.dz_Sec_smallestNo[n].Err = gridErrMetr.dz_Sec_smallestNo[n].actValue-gridErrMetr.dz_Sec_smallestNo[n].setValue;
    gridErrMetr.dz_Sec_smallestNo[n].relErr = (gridErrMetr.dz_Sec_smallestNo[n].actValue/gridErrMetr.dz_Sec_smallestNo[n].setValue-1)*100;
  end for;

  for n in 1:N_Sec_z-1 loop
    gridErrMetr.GR_betwSec[n].setValue = GR_z;

    gridErrMetr.GR_betwSec[n].Err = gridErrMetr.GR_betwSec[n].actValue-gridErrMetr.GR_betwSec[n].setValue;
    gridErrMetr.GR_betwSec[n].relErr = (gridErrMetr.GR_betwSec[n].actValue/gridErrMetr.GR_betwSec[n].setValue-1)*100;
  end for;

  gridErrMetr.z_Sec_to_glo[1].setValue = z_to_glo;
  for n in 2:N_Sec_z loop
    gridErrMetr.z_Sec_to_glo[n].setValue = z_Sec_bo_glo_set[n-1];
  end for;

  for n in 1:N_Sec_z loop
    gridErrMetr.z_Sec_bo_glo[n].setValue = z_Sec_bo_glo_set[n];
    gridErrMetr.dz_Sec[n].setValue = gridErrMetr.z_Sec_bo_glo[n].setValue-gridErrMetr.z_Sec_to_glo[n].setValue;

    gridErrMetr.z_Sec_to_glo[n].actValue = z_Sec_to_glo[n];
    gridErrMetr.z_Sec_bo_glo[n].actValue = z_Sec_bo_glo[n];
    gridErrMetr.dz_Sec[n].actValue = dz_Sec[n];
  end for;

  for n in 1:N_Sec_z loop
    // TBD ADD WARNING: That relative error is not calculated as division by zero
    gridErrMetr.z_Sec_to_glo[n].Err = gridErrMetr.z_Sec_to_glo[n].actValue-gridErrMetr.z_Sec_to_glo[n].setValue;
    gridErrMetr.z_Sec_to_glo[n].relErr = if gridErrMetr.z_Sec_to_glo[n].setValue <> 0 then (gridErrMetr.z_Sec_to_glo[n].actValue/gridErrMetr.z_Sec_to_glo[
      n].setValue - 1)*100 else 0;

    gridErrMetr.z_Sec_bo_glo[n].Err = gridErrMetr.z_Sec_bo_glo[n].actValue-gridErrMetr.z_Sec_bo_glo[n].setValue;
    gridErrMetr.z_Sec_bo_glo[n].relErr = if gridErrMetr.z_Sec_bo_glo[n].setValue <> 0 then (gridErrMetr.z_Sec_bo_glo[n].actValue/gridErrMetr.z_Sec_bo_glo[
      n].setValue - 1)*100 else 0;

    gridErrMetr.dz_Sec[n].Err = gridErrMetr.dz_Sec[n].actValue-gridErrMetr.dz_Sec[n].setValue;
    gridErrMetr.dz_Sec[n].relErr = (gridErrMetr.dz_Sec[n].actValue/gridErrMetr.dz_Sec[n].setValue-1)*100;
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Grid zone layout, i.e., the reference framework of the grid zone that defines the dimensions and coordinates of the individual grid segments in axial direction.
</p>

</html>",
        revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end ZoneLayout_Axial;
