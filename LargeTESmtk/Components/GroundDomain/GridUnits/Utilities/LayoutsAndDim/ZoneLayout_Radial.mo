within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
model ZoneLayout_Radial "Grid zone layout (radial direction)"
  //extends Modelica.Icons.Record;

// Dimensions and coordinates
  // Grid zone
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Radial_Parameters zoneLayoutPar_r
    "Grid zone layout parameters in radial direction";

  parameter Modelica.Units.SI.Radius r_le = zoneLayoutPar_r.r_le "Radial distance to left boundary (inner radius)";
  final parameter Modelica.Units.SI.Radius r_le_act = if r_le==0 then Modelica.Constants.eps else r_le  "Radial distance to left boundary (inner radius) (actual value)" annotation(HideResult=true);
  parameter Modelica.Units.SI.Radius r_ri = zoneLayoutPar_r.r_ri "Radial distance to right boundary (outer radius)";

  final parameter Modelica.Units.SI.Length dr = r_ri-r_le_act "Size in radial direction";

  // Sections
  parameter Integer M_Sec_r = zoneLayoutPar_r.M_Sec_r "No. of radial sections in grid zone";
  parameter Modelica.Units.SI.Length dr_Sec_input[:] = zoneLayoutPar_r.dr_Sec_input
    "Radial size of each section except the last section, which results from the size of the entire grid zone";
    // TBD ADD ERROR: To avoid that sum of dr_Sec_input is greater than dr of entire grid zone
  final parameter Modelica.Units.SI.Length dr_Sec[M_Sec_r] = LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_SizeVectorWCondition(
    M_Sec_r,
    dr_Sec_input,
    dr) "Size of each section in radial direction";

  final parameter Modelica.Units.SI.Radius r_Sec_le[M_Sec_r]=
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_LeftBouOfSecOfGridZone(
      dr_Sec,
      r_le_act) "Radii of left boundaries of sections";
  final parameter Modelica.Units.SI.Radius r_Sec_ri[M_Sec_r]=
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_RightBouOfSecOfGridZone(
      dr_Sec,
      r_le_act) "Radii of right boundaries of sections";

// Grid parameters
  parameter Modelica.Units.SI.Length dr_smallestNo = zoneLayoutPar_r.dr_smallestNo "Radial size of smallest node of entire grid zone";

  parameter Real GR_r(min=1) =  zoneLayoutPar_r.GR_r "Growth rate between adjacent nodes in radial direction (1: equidistant)";
  // TBD ADD ERROR: Hast to be greater than 1
  // TBD ADD ERROR: To avoid that GR_r or dr_smallestNo are too large so that the no. of nodes for a section would be lower than 1 OR add condition that no. of nodes is at least 1 and add warning if it's just one for a section
  parameter Boolean reversedDir_GR_r = zoneLayoutPar_r.reversedDir_GR_r
    "Growth rate direction, = false(default): node size increases from left to right, = true: node size increases from right to left";
  final parameter Real GR_r_act = if reversedDir_GR_r then 1/GR_r else GR_r
    "Actual growth rate in radial direction used for further calculations" annotation(HideResult=true);

  final parameter Integer M_nodesPerSec[M_Sec_r] = if reversedDir_GR_r then integer(Modelica.Math.Vectors.reverse(
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_NoOfNodes_OfAllSections(
      GR_r,
      M_Sec_r,
      Modelica.Math.Vectors.reverse(dr_Sec),
      dr_smallestNo))) else
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.get_NoOfNodes_OfAllSections(
      GR_r,
      M_Sec_r,
      dr_Sec,
      dr_smallestNo) "Number of radial nodes of each section; Hast to be determined with a function: 'You cannot have arrays with variable size at 
    runtime in Modelica. All array sizes need to be known at compile time, so the sizes need to be parameters or constants.'
    e.g., see: https://stackoverflow.com/questions/42457828/initialising-array-with-unknown-size-in-modelica 
    ";

// Summary of section and node parameters
  LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.SegmentLayout_Radial sections[M_Sec_r](
    r_le=r_Sec_le,
    r_ri=r_Sec_ri,
    M_r=M_nodesPerSec,
    each GR_r_act=GR_r_act) "Dimensions and coordinates of each section (and the corresponding nodes) of the grid zone in radial direction";

  final parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.NodeDim_Radial nodeDim_Zone(M_r=sum(M_nodesPerSec))
    "Dimensions and coordinates of all nodes of the grid zone in radial direction";

// Grid error metrics
  final parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval.GridErrorPar_Radial gridErrMetr(M_Sec_r=M_Sec_r)
    "Grid error metrics";

initial equation

// Assigment of node dimensions and coordinates
  for m in 1:M_Sec_r loop
    nodeDim_Zone.r_le[(if m==1 then 1 else sum(M_nodesPerSec[1:m-1])+1):sum(M_nodesPerSec[1:m])] = sections[m].nodeDim.r_le;
    nodeDim_Zone.r_ri[(if m==1 then 1 else sum(M_nodesPerSec[1:m-1])+1):sum(M_nodesPerSec[1:m])] = sections[m].nodeDim.r_ri;
    nodeDim_Zone.r[(if m==1 then 1 else sum(M_nodesPerSec[1:m-1])+1):sum(M_nodesPerSec[1:m])] = sections[m].nodeDim.r;
    nodeDim_Zone.dr[(if m==1 then 1 else sum(M_nodesPerSec[1:m-1])+1):sum(M_nodesPerSec[1:m])] = sections[m].nodeDim.dr;
    nodeDim_Zone.A_z[(if m==1 then 1 else sum(M_nodesPerSec[1:m-1])+1):sum(M_nodesPerSec[1:m])] = sections[m].nodeDim.A_z;
  end for;

// Grid error metrics
  if reversedDir_GR_r then
    gridErrMetr.dr_Sec_smallestNo[end].setValue = dr_smallestNo;
    for m in 1:M_Sec_r-1 loop
      gridErrMetr.dr_Sec_smallestNo[m].setValue = gridErrMetr.auxValues.dr_Sec_largestNo_act[m+1]*GR_r;
    end for;

    for m in 1:M_Sec_r loop
      gridErrMetr.auxValues.dr_Sec_largestNo_act[m] = sections[m].nodeDim.dr[1];
      gridErrMetr.dr_Sec_smallestNo[m].actValue = sections[m].nodeDim.dr[M_nodesPerSec[m]];
    end for;

    for m in 1:M_Sec_r-1 loop
      gridErrMetr.GR_betwSec[m].actValue = gridErrMetr.dr_Sec_smallestNo[m].actValue/gridErrMetr.auxValues.dr_Sec_largestNo_act[m+1];
    end for;
  else
    gridErrMetr.dr_Sec_smallestNo[1].setValue = dr_smallestNo;
    for m in 2:M_Sec_r loop
      gridErrMetr.dr_Sec_smallestNo[m].setValue = gridErrMetr.auxValues.dr_Sec_largestNo_act[m-1]*GR_r;
    end for;

    for m in 1:M_Sec_r loop
      gridErrMetr.auxValues.dr_Sec_largestNo_act[m] = sections[m].nodeDim.dr[M_nodesPerSec[m]];
      gridErrMetr.dr_Sec_smallestNo[m].actValue = sections[m].nodeDim.dr[1];
    end for;

    for m in 1:M_Sec_r-1 loop
      gridErrMetr.GR_betwSec[m].actValue = gridErrMetr.dr_Sec_smallestNo[m+1].actValue/gridErrMetr.auxValues.dr_Sec_largestNo_act[m];
    end for;
  end if;

  for m in 1:M_Sec_r loop
    gridErrMetr.dr_Sec_smallestNo[m].Err = gridErrMetr.dr_Sec_smallestNo[m].actValue-gridErrMetr.dr_Sec_smallestNo[m].setValue;
    gridErrMetr.dr_Sec_smallestNo[m].relErr = (gridErrMetr.dr_Sec_smallestNo[m].actValue/gridErrMetr.dr_Sec_smallestNo[m].setValue-1)*100;
  end for;

  for m in 1:M_Sec_r-1 loop
    gridErrMetr.GR_betwSec[m].setValue = GR_r;

    gridErrMetr.GR_betwSec[m].Err = gridErrMetr.GR_betwSec[m].actValue-gridErrMetr.GR_betwSec[m].setValue;
    gridErrMetr.GR_betwSec[m].relErr = (gridErrMetr.GR_betwSec[m].actValue/gridErrMetr.GR_betwSec[m].setValue-1)*100;
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Grid zone layout, i.e., the reference framework of the grid zone that defines the dimensions and coordinates of the individual grid segments in radial direction.
</p>

</html>", revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end ZoneLayout_Radial;
