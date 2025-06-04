within LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses;
model PartialGridSegment_Rect "Partial grid segment with rectangular cross-section"
  extends Icons.GroundDomain.GridUnits.GridSegment_Rect;

// Dimensions and coordinates
  parameter Modelica.Units.SI.Radius r_le(fixed=false) "Radial distance to left boundary (inner radius)";
  final parameter Modelica.Units.SI.Radius r_le_act = if r_le==0 then Modelica.Constants.eps else r_le  "Radial distance to left boundary (inner radius) (actual value)" annotation(HideResult=true);
  parameter Modelica.Units.SI.Radius r_ri(fixed=false) "Radial distance to right boundary (outer radius)";

  final parameter Modelica.Units.SI.Length dr = r_ri-r_le_act "Size in radial direction";

  parameter Modelica.Units.SI.Position z_to_glo(fixed=false) "Axial distance to top boundary (w.r.t. global coordinate system)";
  parameter Modelica.Units.SI.Position z_bo_glo(fixed=false) "Axial distance to bottom boundary (w.r.t. global coordinate system)";

  final parameter Modelica.Units.SI.Length dz = z_bo_glo-z_to_glo "Size in axial direction";

  final parameter Modelica.Units.SI.Area A_r_le = sum(nodes[1,:].A_r_le)
    "Left boundary surface perpendicular to radial direction (inner lateral area)";
  final parameter Modelica.Units.SI.Area A_r_ri = sum(nodes[end,:].A_r_ri)
    "Right boundary area perpendicular to the radial direction (outer lateral area)";
  final parameter Modelica.Units.SI.Area A_z = sum(nodes[:,1].A_z) "Top and bottom surface perpendicular to axial direction";

  final parameter Modelica.Units.SI.Volume V = sum(nodes.V) "Volume";

// Grid parameters
  parameter Integer M_r(min=1) = 10 "Number of nodes in radial direction";

  parameter Real GR_r(min=1) = 1 "Growth rate between adjacent nodes in radial direction (1: equidistant)";
  parameter Boolean reversedDir_GR_r = false
    "Growth rate direction, = false(default): node size increases from left to right, = true: node size increases from right to left";
  final parameter Real GR_r_act = if reversedDir_GR_r then 1/GR_r else GR_r
    "Actual growth rate in radial direction used for further calculations" annotation(HideResult=true);

  parameter Integer N_z(min=1) = 10 "Number of nodes in axial direction";

  parameter Real GR_z(min=1) = 1 "Growth rate between adjacent nodes in axial direction (1: equidistant)";
  parameter Boolean reversedDir_GR_z = false
    "Growth rate direction, = false(default): node size increases from top to bottom, = true: node size increases from bottom to top";
  final parameter Real GR_z_act = if reversedDir_GR_z then 1/GR_z else GR_z
    "Actual growth rate in axial direction used for further calculations" annotation(HideResult=true);

  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.SegmentLayout_Rect gridLayout(M_r=M_r, N_z=N_z)
    "Individual node dimensions of grid layout";

// Thermophysical properties
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermalProp
    "Thermophysical properties of the solid material (uniform for all nodes)" annotation (choicesAllMatching=true);

// Heat ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_to[M_r] "Heat ports at top boundary" annotation (Placement(transformation(extent={{-10,100},
            {10,80}}),iconTransformation(extent={{-8,108},{8,92}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_bo[M_r] "Heat ports at bottom boundary" annotation (Placement(transformation(extent={{-10,
            -100},{10,-80}}),
                            iconTransformation(extent={{-8,-108},{8,-92}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_le[N_z] "Heat ports at left boundary" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-90,0}), iconTransformation(
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={-100,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_ri[N_z] "Heat ports at right boundary" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,0}), iconTransformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={100,0})));

// Temperatures
  parameter Modelica.Units.SI.Temperature T_init_unif = 273.15+10 "Uniform initial temperature for all nodes";
  parameter Modelica.Units.SI.Temperature T_init[M_r,N_z] = fill(T_init_unif, M_r, N_z) "Individual initial temperatures";

  PartialNode_Interior nodes[M_r,N_z](each thermalProp=thermalProp) "Individual nodes of grid segment"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

//   parameter Boolean HideVarRes = true;

initial equation

  // TBD ERROR: Revise/check
  assert(r_le_act < r_ri, "Error: Model requires r_le < r_ri");
  assert(0 < r_le_act,   "Error: Model requires r_le > 0");

  // TBD ERROR: Revise/check
  assert(dz > 0, "Error: Model requires dz > 0");

// Grid segment layout
  // Radial direction
  gridLayout.r_le[1] = r_le_act;
  gridLayout.r_ri[M_r] = r_ri;

  if GR_r_act==1 then
    for m in 2:M_r loop
      gridLayout.r_le[m] = gridLayout.r_le[m-1] + dr / M_r;
      gridLayout.r_ri[m-1] = gridLayout.r_le[m];
    end for;
  else
    for m in 2:M_r loop
      gridLayout.r_le[m] = gridLayout.r_le[m-1] + dr * (1-GR_r_act)/(1-GR_r_act^(M_r)) * GR_r_act^(m-2);
      gridLayout.r_ri[m-1] = gridLayout.r_le[m];
    end for;
  end if;

  for m in 1:M_r loop
    gridLayout.r[m] = (gridLayout.r_le[m]+gridLayout.r_ri[m]) / 2;
    gridLayout.dr[m] = gridLayout.r_ri[m] - gridLayout.r_le[m];
  end for;

  // Axial direction
  gridLayout.z_to[1] = 0;
  gridLayout.z_bo[N_z] = dz;

  if GR_z_act==1 then
    for n in 2:N_z loop
      gridLayout.z_to[n] = gridLayout.z_to[n-1] + dz / N_z;
      gridLayout.z_bo[n-1] = gridLayout.z_to[n];
    end for;
  else
    for n in 2:N_z loop
      gridLayout.z_to[n] = gridLayout.z_to[n-1] + dz  * (1-GR_z_act)/(1-GR_z_act^(N_z)) * GR_z_act^(n-2);
      gridLayout.z_bo[n-1] = gridLayout.z_to[n];
    end for;
  end if;

  for n in 1:N_z loop
    gridLayout.z[n] = (gridLayout.z_to[n]+gridLayout.z_bo[n])/2;
    gridLayout.dz[n] = gridLayout.z_bo[n] - gridLayout.z_to[n];

    gridLayout.z_to_glo[n] = z_to_glo + gridLayout.z_to[n];
    gridLayout.z_bo_glo[n] = z_to_glo + gridLayout.z_bo[n];
    gridLayout.z_glo[n] = z_to_glo + gridLayout.z[n];
  end for;

// Assigment of dimensions to nodes
  for m in 1:M_r loop
    for n in 1:N_z loop
      nodes[m,n].r_le = gridLayout.r_le[m];
      nodes[m,n].r_ri = gridLayout.r_ri[m];

      nodes[m,n].z_to = gridLayout.z_to[n];
      nodes[m,n].z_bo = gridLayout.z_bo[n];

      nodes[m,n].z_to_glo = gridLayout.z_to_glo[n];

      // Initialization
        nodes[m,n].T_init = T_init[m,n];
    end for;
  end for;

// Thermal conductance values
  // Interior nodes
  for m in 2:M_r-1 loop
    for n in 2:N_z-1 loop
      nodes[m,n].G_to = thermalProp.k * nodes[m,n].A_z / (nodes[m,n].z - nodes[m,n-1].z);
      nodes[m,n].G_bo = nodes[m,n+1].G_to;

      nodes[m,n].G_le = thermalProp.k * 2 * Modelica.Constants.pi * nodes[m,n].dz / Modelica.Math.log(nodes[m,n].r / nodes[m-1,n].r);
      nodes[m,n].G_ri = nodes[m+1,n].G_le;
    end for;
  end for;

  // Top & bottom boundary nodes
  for m in 1:M_r loop
    // Top
    nodes[m,1].G_to = thermalProp.k * nodes[m,1].A_z / (nodes[m,1].z - nodes[m,1].z_to);
    nodes[m,1].G_bo = nodes[m,2].G_to;

    // Bottom
    nodes[m,end].G_to = thermalProp.k * nodes[m,end].A_z / (nodes[m,end].z - nodes[m,end-1].z);
    nodes[m,end].G_bo = thermalProp.k * nodes[m,end].A_z / (nodes[m,end].z_bo - nodes[m,end].z);
  end for;

  for m in 2:M_r-1 loop
    // Top
    nodes[m,1].G_le = thermalProp.k * 2 * Modelica.Constants.pi * nodes[m,1].dz / Modelica.Math.log(nodes[m,1].r / nodes[m-1,1].r);
    nodes[m,1].G_ri = nodes[m+1,1].G_le;

    // Bottom
    nodes[m,end].G_le = thermalProp.k * 2 * Modelica.Constants.pi * nodes[m,end].dz / Modelica.Math.log(nodes[m,end].r / nodes[m-1,end].r);
    nodes[m,end].G_ri = nodes[m+1,end].G_le;
  end for;

  // Left & right boundary nodes
  for n in 1:N_z loop
    // Left
    nodes[1,n].G_le = thermalProp.k * 2 * Modelica.Constants.pi * nodes[1,n].dz / Modelica.Math.log(nodes[1,n].r / nodes[1,n].r_le);
    nodes[1,n].G_ri = nodes[2,n].G_le;

    // Right
    nodes[end,n].G_le = thermalProp.k * 2 * Modelica.Constants.pi * nodes[end,n].dz / Modelica.Math.log(nodes[end,n].r / nodes[end-1,n].r);
    nodes[end,n].G_ri = thermalProp.k * 2 * Modelica.Constants.pi * nodes[end,n].dz / Modelica.Math.log(nodes[end,n].r_ri / nodes[end,n].r);
  end for;

  for n in 2:N_z-1 loop
    // Left
    nodes[1,n].G_to = thermalProp.k * nodes[1,n].A_z / (nodes[1,n].z - nodes[1,n-1].z);
    nodes[1,n].G_bo = nodes[1,n+1].G_to;

    // Right
    nodes[end,n].G_to = thermalProp.k * nodes[end,n].A_z / (nodes[end,n].z - nodes[end,n-1].z);
    nodes[end,n].G_bo = nodes[end,n+1].G_to;
  end for;

equation

// Connecting boundary nodes w/ heat ports at boundaries
  // Top & bottom
  for m in 1:M_r loop
    heatPorts_to[m].Q_flow = +nodes[m,1].QFlow_to;
    heatPorts_bo[m].Q_flow = +nodes[m,end].QFlow_bo;
  end for;

  // Left & right
  for n in 1:N_z loop
    heatPorts_le[n].Q_flow = +nodes[1,n].QFlow_le;
    heatPorts_ri[n].Q_flow = +nodes[end,n].QFlow_ri;
  end for;

// Connecting individual nodes
  // Interior nodes
  for m in 2:M_r-1 loop
    for n in 2:N_z-1 loop
      nodes[m,n].QFlow_to = nodes[m,n].G_to * (nodes[m,n-1].T - nodes[m,n].T);
      nodes[m,n].QFlow_bo = -nodes[m,n+1].QFlow_to;

      nodes[m,n].QFlow_le = nodes[m,n].G_le * (nodes[m-1,n].T - nodes[m,n].T);
      nodes[m,n].QFlow_ri = -nodes[m+1,n].QFlow_le;
    end for;
  end for;

  // Top & bottom boundary nodes
  for m in 1:M_r loop
    // Top
    nodes[m,1].QFlow_to = nodes[m,1].G_to * (heatPorts_to[m].T - nodes[m,1].T);
    nodes[m,1].QFlow_bo = -nodes[m,2].QFlow_to;

    // Bottom
    nodes[m,end].QFlow_to = nodes[m,end].G_to * (nodes[m,end-1].T - nodes[m,end].T);
    nodes[m,end].QFlow_bo = nodes[m,end].G_bo * (heatPorts_bo[m].T - nodes[m,end].T);
  end for;

  for m in 2:M_r-1 loop
    // Top
    nodes[m,1].QFlow_le = nodes[m,1].G_le * (nodes[m-1,1].T - nodes[m,1].T);
    nodes[m,1].QFlow_ri = -nodes[m+1,1].QFlow_le;

    // Bottom
    nodes[m,end].QFlow_le = nodes[m,end].G_le * (nodes[m-1,end].T - nodes[m,end].T);
    nodes[m,end].QFlow_ri = -nodes[m+1,end].QFlow_le;
  end for;

  // Left & right boundary nodes
  for n in 1:N_z loop
    // Left
    nodes[1,n].QFlow_le = nodes[1,n].G_le * (heatPorts_le[n].T - nodes[1,n].T);
    nodes[1,n].QFlow_ri = -nodes[2,n].QFlow_le;

    // Right
    nodes[end,n].QFlow_le = nodes[end,n].G_le * (nodes[end-1,n].T - nodes[end,n].T);
    nodes[end,n].QFlow_ri = nodes[end,n].G_ri * (heatPorts_ri[n].T - nodes[end,n].T);
  end for;

  for n in 2:N_z-1 loop
    // Left
    nodes[1,n].QFlow_to = nodes[1,n].G_to * (nodes[1,n-1].T - nodes[1,n].T);
    nodes[1,n].QFlow_bo = -nodes[1,n+1].QFlow_to;

    // Right
    nodes[end,n].QFlow_to = nodes[end,n].G_to * (nodes[end,n-1].T - nodes[end,n].T);
    nodes[end,n].QFlow_bo = -nodes[end,n+1].QFlow_to;
  end for;

// Energy balance of each node
  for m in 1:M_r loop
    for n in 1:N_z loop
      nodes[m,n].C*der(nodes[m,n].T) = nodes[m,n].QFlow_to + nodes[m,n].QFlow_bo + nodes[m,n].QFlow_le + nodes[m,n].QFlow_ri;
    end for;
  end for;

  annotation (
    defaultComponentName="rectangGridSeg",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-150,152},{150,112}},
          lineColor={0,0,255},
          textString="%name",
          fontName="Times New Roman")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,-140},{140,140}}), graphics={
        Rectangle(
          extent={{-90,90},{90,-90}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-120,100},{-120,124}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-100,120},{-124,120}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-112,120},{-92,110}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="r, m"),
        Text(
          extent={{-120,110},{-100,100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="z, n"),
        Ellipse(
          extent={{-122,118},{-118,122}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,-30},{90,-30}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-90,30},{90,30}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{30,90},{30,-90}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-30,90},{-30,-90}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Text(
          extent={{-70,110},{-50,98}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{-10,110},{10,98}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="m"),
        Text(
          extent={{50,110},{70,98}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="M"),
        Text(
          extent={{-114,66},{-94,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{-114,6},{-94,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="n"),
        Text(
          extent={{-114,-54},{-94,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="N"),
        Rectangle(
          extent={{-30,30},{30,-30}},
          lineColor={244,125,35},
          lineThickness=0.5,
          pattern=LinePattern.Dash,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Text(
          extent={{-70,66},{-50,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[1, 1]"),
        Text(
          extent={{-12,68},{8,52}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[m, 1]"),
        Text(
          extent={{50,66},{70,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[M, 1]"),
        Text(
          extent={{50,6},{70,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[M, n]"),
        Text(
          extent={{-70,6},{-50,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[1, n]"),
        Text(
          extent={{-70,-54},{-50,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[1, N]"),
        Text(
          extent={{-8,-54},{12,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[m, N]"),
        Text(
          extent={{50,-54},{70,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[M, N]"),
        Text(
          extent={{-70,72},{-50,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Node"),
        Text(
          extent={{50,-48},{70,-54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Node")}),
    Documentation(info="<html>

<p>
Partial grid (mesh) segment model with rectangular cross-section. 
</p>

<p>
The corresponding equations for the heat flows and the energy balance of the single nodes are defined in this model (i.e., at superordinate level) and not at individual node level.  
Usually, this model is faster than the alternative implementation with internal heat ports at the individual node boundaries
(see <a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses.Alternative.PartialGridSegment_Rect_IntHeatPorts\">PartialGridSegment_Rect_IntHeatPorts</a>), 
since it has less equations to be solved.     
</p>

<p>
This model is intended for application in a higher-level grid zone model
(i.e., corresponding parameters are set to <code>fixed=false</code> and can therefore be defined in the initial equation section of the higher-level model).
</p>

<p>
<em>[Further model documentation to be added.]</em>
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
end PartialGridSegment_Rect;
