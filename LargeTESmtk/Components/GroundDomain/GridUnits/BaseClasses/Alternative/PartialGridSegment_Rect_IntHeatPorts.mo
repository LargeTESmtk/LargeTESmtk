within LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses.Alternative;
model PartialGridSegment_Rect_IntHeatPorts "Partial grid segment with rectangular cross-section and internal heat ports"
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

  parameter Real GR_r(min=1,fixed=false) "Growth rate between adjacent nodes in radial direction (1: equidistant)";
  parameter Boolean reversedDir_GR_r = false
    "Growth rate direction, = false(default): node size increases from left to right, = true: node size increases from right to left";
  final parameter Real GR_r_act = if reversedDir_GR_r then 1/GR_r else GR_r
    "Actual growth rate in radial direction used for further calculations";

  parameter Integer N_z(min=1) = 10 "Number of nodes in radial direction";

  parameter Real GR_z(min=1,fixed=false) "Growth rate between adjacent nodes in axial direction (1: equidistant)";
  parameter Boolean reversedDir_GR_z = false
    "Growth rate direction, = false(default): node size increases from top to bottom, = true: node size increases from bottom to top";
  final parameter Real GR_z_act = if reversedDir_GR_z then 1/GR_z else GR_z
    "Actual growth rate in axial direction used for further calculations";

  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.SegmentLayout_Rect gridLayout(M_r=M_r, N_z=N_z)
    "Individual node dimensions of grid layout";

// Thermophysical properties
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermalProp
    "Thermophysical properties of the solid material (uniform for all nodes)" annotation (choicesAllMatching=true);

// Heat ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_to[M_r] "Heat ports at top boundary" annotation (Placement(transformation(extent={{-10,90},
            {10,70}}),iconTransformation(extent={{-8,108},{8,92}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_bo[M_r] "Heat ports at bottom boundary" annotation (Placement(transformation(extent={{-10,-90},
            {10,-70}}),     iconTransformation(extent={{-8,-108},{8,-92}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_le[N_z] "Heat ports at left boundary" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,0}), iconTransformation(
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={-100,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_ri[N_z] "Heat ports at right boundary" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,0}), iconTransformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={100,0})));

// Temperatures
  parameter Modelica.Units.SI.Temperature T_init_unif(fixed=false) "Uniform initial temperature for all nodes";
  parameter Modelica.Units.SI.Temperature T_init[M_r,N_z] = fill(T_init_unif, M_r, N_z) "Individual initial temperatures";

  PartialNode_Interior_HeatPorts nodes[M_r,N_z](each thermalProp=thermalProp) "Individual nodes of grid segment"
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));

initial equation

  // TBD ERROR: Revise/check
  assert(r_le_act < r_ri, "Error: Model requires r_le < r_ri of the domain");
  assert(0 < r_le_act,   "Error: Model requires r_le > 0 of the domain");

  // TBD ERROR: Revise/check
  assert(dz > 0, "Error: Model requires dz > 0 of the domain");

// Grid layout
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

equation

// Connecting individual nodes
  for m in 1:M_r-1 loop
    for n in 1:N_z loop
      connect(nodes[m,n].heatPort_ri, nodes[m+1,n].heatPort_le);
    end for;
  end for;

  for m in 1:M_r loop
    for n in 1:N_z-1 loop
      connect(nodes[m,n].heatPort_bo, nodes[m,n+1].heatPort_to);
    end for;
  end for;

// Connecting boundary nodes w/ heat ports at boundaries
  for m in 1:M_r loop
    connect(nodes[m,1].heatPort_to, heatPorts_to[m]);
    connect(nodes[m,end].heatPort_bo, heatPorts_bo[m]);
  end for;

  for n in 1:N_z loop
    connect(nodes[1,n].heatPort_le, heatPorts_le[n]);
    connect(nodes[end,n].heatPort_ri, heatPorts_ri[n]);
  end for;

  annotation (
    defaultComponentName="rectangGridSeg",
    Icon(coordinateSystem(preserveAspectRatio=true)),
    Diagram(coordinateSystem(preserveAspectRatio=true), graphics={
        Line(
          points={{-80,60},{-80,84}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-60,80},{-84,80}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-72,80},{-52,70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="r, m"),
        Text(
          extent={{-80,70},{-60,60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="z, n"),
        Ellipse(
          extent={{-82,78},{-78,82}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>

<p>
Partial grid (mesh) segment model with rectangular cross-section and internal heat ports at individual node boundaries.
</p>

<p>
The corresponding equations for the heat flows and energy balances are defined in the individual node models.  
Usually, this model is slower than the model without internal heat ports 
(see <a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses.PartialGridSegment_Rect\">PartialGridSegment_Rect</a>), 
since it has more equations to be solved.  
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
end PartialGridSegment_Rect_IntHeatPorts;
