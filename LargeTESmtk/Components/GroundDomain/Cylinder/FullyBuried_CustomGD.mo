within LargeTESmtk.Components.GroundDomain.Cylinder;
model FullyBuried_CustomGD "Ground domain model for fully buried TTES with cylindrical fluid geometry (Customizable ground domain)"
  extends Icons.GroundDomain.GroundDom_Cylinder_FB_CustomGD;

// Fluid domain
  // Dimension and grid parameters
  parameter Modelica.Units.SI.Position z_FD_to_glo_in = 0.5
    "Depth to top of fluid domain (i.e., axial distance to top boundary w.r.t. global coordinate system) (user input)"
    annotation (Dialog(group="Dimensions",enable=useTopGridArea),HideResult=true);
  final parameter Modelica.Units.SI.Position z_FD_to_glo = if useTopGridArea then z_FD_to_glo_in else 0
    "Depth to top of fluid domain (i.e., axial distance to top boundary w.r.t. global coordinate system)";

  parameter LargeTESmtk.Components.GroundDomain.Utilities.FluidDomPar.FluidDomPar_Cylinder fluidDomainPar(
    r=34.5,
    dz=27,
    final z_to_glo=z_FD_to_glo,
    N_z=50) "Dimensions and grid parameters of fluid domain"
    annotation (Dialog(group="Dimensions"), Placement(transformation(extent={{-80,-16},{-40,24}})));

// Ground domain
  // Overall dimensions
  parameter Modelica.Units.SI.Radius r_GD_bou = fluidDomainPar.r+50
    "Radial far-field boundary of ground domain (Distance/radius between fluid domain centerline and far-field boundary)" annotation (Dialog(group="Dimensions"));
  parameter Modelica.Units.SI.Distance z_GD_bou = fluidDomainPar.z_bo_glo+50
    "Axial far-field boundary of ground domain (Distance between ground surface and far-field boundary)" annotation (Dialog(group="Dimensions"));

// Grid areas in radial direction
  // Fluid (Fl)
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Radial_Parameters gridAreaPar_Fl_r(
    final r_le=0,
    final r_ri=fluidDomainPar.r,
    M_Sec_r=3,
    dr_Sec_input={fluidDomainPar.r - 10,5},
    dr_smallestNo=0.10,
    GR_r=1.3,
    reversedDir_GR_r=true) "Radial grid area parameters: 'Fluid' (Fl)"
    annotation (Dialog(group="Grid areas in radial direction"), Placement(transformation(extent={{-70,-250},{-50,-230}})));

  // Right (Ri)
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Radial_Parameters gridAreaPar_Ri_r(
    final r_le=fluidDomainPar.r,
    final r_ri=r_GD_bou,
    M_Sec_r=2,
    dr_Sec_input={5},
    dr_smallestNo=0.10,
    GR_r=1.3,
    reversedDir_GR_r=false) "Radial grid area parameters: 'Right' (Ri)"
    annotation (Dialog(group="Grid areas in radial direction"), Placement(transformation(extent={{50,-250},{70,-230}})));

// Grid areas in axial direction
  // Top (To)
  parameter Boolean useTopGridArea = true "= true(default): adds top grid area (i.e., two grid zones) above fluid domain"
    annotation(Dialog(group="Grid areas in axial direction"));
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters gridAreaPar_To_z(
    final z_to_glo=0,
    final z_bo_glo=fluidDomainPar.z_to_glo,
    N_Sec_z=1,
    useEquidistantGrid_z=true,
    dz_smallestNo=0.10,
    GR_z=1.00001,
    reversedDir_GR_z=false,
    N_Nodes_z=10) if useTopGridArea "Axial grid area parameters: 'Top' (To)"
    annotation (Dialog(group="Grid areas in axial direction", enable=useTopGridArea), Placement(transformation(extent={{170,110},{190,130}})));

  // Fluid (Fl)
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters gridAreaPar_Fl_z(
    final z_to_glo=fluidDomainPar.z_to_glo,
    final z_bo_glo=fluidDomainPar.z_bo_glo,
    N_Sec_z=3,
    z_Sec_bo_glo_input={15,20},
    final useEquidistantGrid_z=true,
    final dz_smallestNo,
    final GR_z,
    final reversedDir_GR_z,
    final N_Nodes_z=fluidDomainPar.N_z) "Axial grid area parameters: 'Fluid' (Fl)"
    annotation (Dialog(group="Grid areas in axial direction"), Placement(transformation(extent={{170,-10},{190,10}})));

  // Bottom (Bo)
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters gridAreaPar_Bo_z(
    final z_to_glo=fluidDomainPar.z_bo_glo,
    final z_bo_glo=z_GD_bou,
    N_Sec_z=3,
    z_Sec_bo_glo_input={fluidDomainPar.z_bo_glo + 5,fluidDomainPar.z_bo_glo + 10},
    useEquidistantGrid_z=false,
    dz_smallestNo=0.10,
    GR_z=1.3) "Axial grid area parameters: 'Bottom' (Bo)"
    annotation (Dialog(group="Grid areas in axial direction"), Placement(transformation(extent={{170,-130},{190,-110}})));

// Grid zones
  // Fluid-Top (FlTo)
  LargeTESmtk.Components.GroundDomain.GridUnits.GridZone_Rect zone_FlTo(
    zoneLayoutPar_r=gridAreaPar_Fl_r,
    zoneLayoutPar_z=gridAreaPar_To_z,
    useUnifThermProp=useUnifThermProp_FlTo,
    thermProp_unif=thermProp_FlTo_unif,
    thermProp_spec=thermProp_FlTo_spec,
    T_init_unif=T_FlTo_init_unif,
    r_TMP=r_TMP_FlTo,
    z_TMP=z_TMP_FlTo) if useTopGridArea "Grid zone: 'Fluid-Top' (FlTo)" annotation (Placement(transformation(extent={{-100,80},{-20,160}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermCon_Co(G=fluidDomainPar.A_z_to*U_Co) if not useTopGridArea
    "Thermal conductor of cover (when cover is only considered as thermal resistance w/o capacitance)";

  // Right-Top (RiTo)
  LargeTESmtk.Components.GroundDomain.GridUnits.GridZone_Rect zone_RiTo(
    zoneLayoutPar_r=gridAreaPar_Ri_r,
    zoneLayoutPar_z=gridAreaPar_To_z,
    useUnifThermProp=useUnifThermProp_RiTo,
    thermProp_unif=thermProp_RiTo_unif,
    thermProp_spec=thermProp_RiTo_spec,
    T_init_unif=T_RiTo_init_unif,
    r_TMP=r_TMP_RiTo,
    z_TMP=z_TMP_RiTo) if useTopGridArea "Grid zone: 'Right-Top' (RiTo)" annotation (Placement(transformation(extent={{20,80},{100,160}})));

  // Right-Fluid (RiFl)
  LargeTESmtk.Components.GroundDomain.GridUnits.GridZone_Rect zone_RiFl(
    zoneLayoutPar_r=gridAreaPar_Ri_r,
    zoneLayoutPar_z=gridAreaPar_Fl_z,
    useUnifThermProp=useUnifThermProp_RiFl,
    thermProp_unif=thermProp_RiFl_unif,
    thermProp_spec=thermProp_RiFl_spec,
    T_init_unif=T_RiFl_init_unif,
    r_TMP=r_TMP_RiFl,
    z_TMP=z_TMP_RiFl) "Grid zone: 'Right-Fluid' (RiFl)" annotation (Placement(transformation(extent={{20,-40},{100,40}})));

  // Fluid-Bottom (FlBo)
  LargeTESmtk.Components.GroundDomain.GridUnits.GridZone_Rect zone_FlBo(
    zoneLayoutPar_r=gridAreaPar_Fl_r,
    zoneLayoutPar_z=gridAreaPar_Bo_z,
    useUnifThermProp=useUnifThermProp_FlBo,
    thermProp_unif=thermProp_FlBo_unif,
    thermProp_spec=thermProp_FlBo_spec,
    T_init_unif=T_FlBo_init_unif,
    r_TMP=r_TMP_FlBo,
    z_TMP=z_TMP_FlBo) "Grid zone: 'Fluid-Bottom' (FlBo)" annotation (Placement(transformation(extent={{-100,-160},{-20,-80}})));

  // Right-Bottom (RiBo)
  LargeTESmtk.Components.GroundDomain.GridUnits.GridZone_Rect zone_RiBo(
    zoneLayoutPar_r=gridAreaPar_Ri_r,
    zoneLayoutPar_z=gridAreaPar_Bo_z,
    useUnifThermProp=useUnifThermProp_RiBo,
    thermProp_unif=thermProp_RiBo_unif,
    thermProp_spec=thermProp_RiBo_spec,
    T_init_unif=T_RiBo_init_unif,
    r_TMP=r_TMP_RiBo,
    z_TMP=z_TMP_RiBo) "Grid zone: 'Right-Bottom' (RiBo)" annotation (Placement(transformation(extent={{20,-160},{100,-80}})));

// Thermophysical properties

/*
    (Matrix format to be used:    
      [segment[1,1], segment[2,1], segment[3,1];
       segment[1,2], segment[2,2], segment[3,2]])
 */

  // Fluid-Top (FlTo)
  parameter Boolean useUnifThermProp_FlTo = true if useTopGridArea
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(group="Ground properties",enable=useTopGridArea));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlTo_unif if useTopGridArea
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (
    Dialog(group="Ground properties", enable=useUnifThermProp_FlTo and useTopGridArea),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlTo_spec[gridAreaPar_To_z.N_Sec_z,
    gridAreaPar_Fl_r.M_Sec_r](
    each k=thermProp_FlTo_unif.k,
    each c=thermProp_FlTo_unif.c,
    each d=thermProp_FlTo_unif.d) if useTopGridArea "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(group="Ground properties", enable=not useUnifThermProp_FlTo and useTopGridArea), HideResult=true);

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_Co = 0.1  if not useTopGridArea
    "U-value of cover (when cover is only considered as thermal resistance w/o capacitance)"
    annotation (Dialog(group="Ground properties",enable=not useTopGridArea));

  // Right-Top (RiTo)
  parameter Boolean useUnifThermProp_RiTo = true if useTopGridArea
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(group="Ground properties",enable=useTopGridArea));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiTo_unif if useTopGridArea
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (
    Dialog(group="Ground properties", enable=useUnifThermProp_RiTo and useTopGridArea),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiTo_spec[gridAreaPar_To_z.N_Sec_z,
    gridAreaPar_Ri_r.M_Sec_r](
    each k=thermProp_RiTo_unif.k,
    each c=thermProp_RiTo_unif.c,
    each d=thermProp_RiTo_unif.d) if useTopGridArea "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(group="Ground properties", enable=not useUnifThermProp_RiTo and useTopGridArea), HideResult=true);

  // Right-Fluid (RiFl)
  parameter Boolean useUnifThermProp_RiFl = true
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(group="Ground properties"));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiFl_unif
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (
    Dialog(group="Ground properties", enable=useUnifThermProp_RiFl),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiFl_spec[gridAreaPar_Fl_z.N_Sec_z,
    gridAreaPar_Ri_r.M_Sec_r](
    each k=thermProp_RiFl_unif.k,
    each c=thermProp_RiFl_unif.c,
    each d=thermProp_RiFl_unif.d) "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(group="Ground properties", enable=not useUnifThermProp_RiFl), HideResult=true);

  // Fluid-Bottom (FlBo)
  parameter Boolean useUnifThermProp_FlBo = true
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(group="Ground properties"));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlBo_unif
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (
    Dialog(group="Ground properties", enable=useUnifThermProp_FlBo),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlBo_spec[gridAreaPar_Bo_z.N_Sec_z,
    gridAreaPar_Fl_r.M_Sec_r](
    each k=thermProp_FlBo_unif.k,
    each c=thermProp_FlBo_unif.c,
    each d=thermProp_FlBo_unif.d) "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(group="Ground properties", enable=not useUnifThermProp_FlBo), HideResult=true);

  // Right-Bottom (RiBo)
  parameter Boolean useUnifThermProp_RiBo = true
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(group="Ground properties"));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiBo_unif
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (
    Dialog(group="Ground properties", enable=useUnifThermProp_RiBo),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiBo_spec[gridAreaPar_Bo_z.N_Sec_z,
    gridAreaPar_Ri_r.M_Sec_r](
    each k=thermProp_RiBo_unif.k,
    each c=thermProp_RiBo_unif.c,
    each d=thermProp_RiBo_unif.d) "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(group="Ground properties", enable=not useUnifThermProp_RiBo), HideResult=true);

// Heat ports
  // Fluid-Top (FlTo)
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_FlTo_to[if useTopGridArea then size(zone_FlTo.heatPorts_to, 1) else 1]
    "Heat ports at top boundary"
    annotation (Placement(transformation(extent={{-70,180},{-50,200}}),iconTransformation(extent={{12,28},{20,36}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_FlTo_bo[if useTopGridArea then size(zone_FlTo.heatPorts_bo, 1) else 1]
    "Heat ports at bottom boundary"
    annotation (Placement(transformation(extent={{-70,30},{-50,50}}),  iconTransformation(extent={{12,-10},{20,-2}})));

  // Right-Top (RiTo)
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_Ri_to[size(zone_RiFl.heatPorts_to, 1)] "Heat ports at top boundary"
    annotation (Placement(transformation(extent={{50,180},{70,200}}),  iconTransformation(extent={{72,28},{80,36}})));

  // Right-Fluid (RiFl)
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_RiFl_le[size(zone_RiFl.heatPorts_le, 1)] "Heat ports at left boundary"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}}),
                                                                    iconTransformation(extent={{32,-30},{40,-22}})));

  // Fluid-Bottom (FlBo)
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_FlBo_to[size(zone_FlBo.heatPorts_to, 1)] "Heat ports at top boundary"
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}}),
                                                                     iconTransformation(extent={{12,-52},{20,-44}})));

// Initialization
  // Fluid-Top (FlTo)
  parameter Modelica.Units.SI.Temperature T_FlTo_init_unif = 273.15+10 if useTopGridArea
    "Uniform initial temperature for all nodes in grid zone 'Fluid-Top'"
    annotation (Dialog(group="Initialization"));

  // Right-Top (RiTo)
  parameter Modelica.Units.SI.Temperature T_RiTo_init_unif = 273.15+10 if useTopGridArea
    "Uniform initial temperature for all nodes in grid zone 'Right-Top'"
    annotation (Dialog(group="Initialization"));

  // Right-Fluid (RiFl)
  parameter Modelica.Units.SI.Temperature T_RiFl_init_unif = 273.15+10 "Uniform initial temperature for all nodes in grid zone 'Right-Fluid'"
    annotation (Dialog(group="Initialization"));

  // Fluid-Bottom (FlBo)
  parameter Modelica.Units.SI.Temperature T_FlBo_init_unif = 273.15+10 "Uniform initial temperature for all nodes in grid zone 'Fluid-Bottom'"
    annotation (Dialog(group="Initialization"));

  // Right-Bottom (RiBo)
  parameter Modelica.Units.SI.Temperature T_RiBo_init_unif = 273.15+10 "Uniform initial temperature for all nodes in grid zone 'Right-Bottom'"
    annotation (Dialog(group="Initialization"));

// Ground temperature monitoring points
  // Fluid-Top (FlTo)
  parameter Modelica.Units.SI.Radius r_TMP_FlTo[:] = fill(0, 0) if useTopGridArea
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Fluid-Top",enable=useTopGridArea));
  parameter Modelica.Units.SI.Distance z_TMP_FlTo[:] = fill(0, 0) if useTopGridArea
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Fluid-Top",enable=useTopGridArea));
  Modelica.Units.SI.Temperature T_TMP_FlTo[zone_FlTo.N_TMP] = zone_FlTo.T_TMP if useTopGridArea
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

  // Right-Top (RiTo)
  parameter Modelica.Units.SI.Radius r_TMP_RiTo[:] = fill(0, 0) if useTopGridArea
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Right-Top",enable=useTopGridArea));
  parameter Modelica.Units.SI.Distance z_TMP_RiTo[:] = fill(0, 0) if useTopGridArea
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Right-Top",enable=useTopGridArea));
  Modelica.Units.SI.Temperature T_TMP_RiTo[zone_RiTo.N_TMP] = zone_RiTo.T_TMP if useTopGridArea
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

  // Right-Fluid (RiFl)
  parameter Modelica.Units.SI.Radius r_TMP_RiFl[:] = fill(0, 0)
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Right-Fluid"));
  parameter Modelica.Units.SI.Distance z_TMP_RiFl[:] = fill(0, 0)
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Right-Fluid"));
  Modelica.Units.SI.Temperature T_TMP_RiFl[zone_RiFl.N_TMP] = zone_RiFl.T_TMP
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

  // Fluid-Bottom (FlBo)
  parameter Modelica.Units.SI.Radius r_TMP_FlBo[:] = fill(0, 0)
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Fluid-Bottom"));
  parameter Modelica.Units.SI.Distance z_TMP_FlBo[:] = fill(0, 0)
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Fluid-Bottom"));
  Modelica.Units.SI.Temperature T_TMP_FlBo[zone_FlBo.N_TMP] = zone_FlBo.T_TMP
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

  // Right-Bottom (RiBo)
  parameter Modelica.Units.SI.Radius r_TMP_RiBo[:] = fill(0, 0)
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Right-Bottom"));
  parameter Modelica.Units.SI.Distance z_TMP_RiBo[:] = fill(0, 0)
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Temp. monitoring points",group="Grid zone: Right-Bottom"));
  Modelica.Units.SI.Temperature T_TMP_RiBo[zone_RiBo.N_TMP] = zone_RiBo.T_TMP
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

//   parameter Boolean HideVarRes = true;

equation

// Grid zones
  connect(zone_FlTo.heatPorts_ri, zone_RiTo.heatPorts_le)  annotation (Line(points={{-20,120},{20,120}},                              color={191,0,0}));
  connect(zone_RiFl.heatPorts_to, zone_RiTo.heatPorts_bo) annotation (Line(points={{60,40},{60,80}},                            color={191,0,0}));
  connect(zone_RiBo.heatPorts_to, zone_RiFl.heatPorts_bo) annotation (Line(points={{60,-80},{60,-40}},  color={191,0,0}));
  connect(zone_FlBo.heatPorts_ri, zone_RiBo.heatPorts_le) annotation (Line(points={{-20,-120},{20,-120}},
                                                                                                      color={191,0,0}));

// Heat ports
  if useTopGridArea then
    connect(zone_RiTo.heatPorts_to, heatPorts_Ri_to) annotation (Line(points={{60,160},{60,190}},           color={191,0,0}));
  else
    connect(heatPorts_Ri_to, zone_RiFl.heatPorts_to);
  end if;

  connect(zone_RiFl.heatPorts_le, heatPorts_RiFl_le) annotation (Line(points={{20,0},{-20,0}},                  color={191,0,0}));
  connect(zone_FlBo.heatPorts_to, heatPorts_FlBo_to) annotation (Line(points={{-60,-80},{-60,-40}},                 color={191,0,0}));
  connect(zone_FlTo.heatPorts_to, heatPorts_FlTo_to) annotation (Line(points={{-60,160},{-60,190}},                     color={191,0,0}));

  connect(zone_FlTo.heatPorts_bo, heatPorts_FlTo_bo) annotation (Line(points={{-60,80},{-60,40}}, color={191,0,0}));
  connect(thermCon_Co.port_a, heatPorts_FlTo_bo[1]);
  connect(thermCon_Co.port_b, heatPorts_FlTo_to[1]);
  annotation (
    defaultComponentName="groundDom",
    Diagram(coordinateSystem(extent={{-200,-260},{200,260}}), graphics={
        Line(points={{48,34}}, color={28,108,200}),
        Line(
          points={{-40,120}},
          color={28,108,200},
          pattern=LinePattern.None),
        Line(
          points={{-180,220},{-180,244}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-160,240},{-184,240}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-172,240},{-152,230}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="r, m"),
        Text(
          extent={{-180,230},{-160,220}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="z, n"),
        Ellipse(
          extent={{-182,238},{-178,242}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,224},{-40,204}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Fl"),
        Line(
          points={{-140,-180},{140,-180}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{40,224},{80,204}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Ri"),
        Text(
          extent={{-174,130},{-134,110}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="To"),
        Text(
          extent={{-174,10},{-134,-10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Fl"),
        Text(
          extent={{-174,-110},{-134,-130}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Bo"),
        Line(
          points={{-120,-60},{-120,-40}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Line(
          points={{32,-190},{32,192}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{130,-136},{-130,-136}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{10,230},{-10,230}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{130,-104},{-130,-104}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{64,-190},{64,192}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{130,16},{0,16}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Text(
          extent={{6,-184},{26,-196}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{38,-184},{58,-196}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="m"),
        Text(
          extent={{82,-184},{102,-196}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="M"),
        Text(
          extent={{-114,-184},{-94,-196}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{-82,-184},{-62,-196}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="m"),
        Text(
          extent={{-38,-184},{-18,-196}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="M"),
        Line(
          points={{130,-16},{0,-16}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-56,-190},{-56,-60}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-88,-190},{-88,-60}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{130,104},{-130,104}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{130,136},{-130,136}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-56,60},{-56,190}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-88,60},{-88,190}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{0,60},{120,40}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-140,60},{140,60}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{0,-60},{120,-80}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-120,-60},{0,-80}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-140,-60},{140,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-120,-60},{-120,-200}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{0,180},{120,160}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-120,180},{0,160}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-140,180},{140,180}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-120,60},{-120,200}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{120,200},{120,-200}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{0,200},{0,-200}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{120,-76},{140,-88}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{120,-114},{140,-126}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="n"),
        Text(
          extent={{120,-152},{140,-164}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="N"),
        Text(
          extent={{120,44},{140,32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{120,6},{140,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="n"),
        Text(
          extent={{120,-32},{140,-44}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="N"),
        Text(
          extent={{120,164},{140,152}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{120,126},{140,114}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="n"),
        Text(
          extent={{120,88},{140,76}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="N"),
        Text(
          extent={{-30,250},{30,230}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Radial areas"),
        Line(
          points={{-170,-12},{-170,8}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-30,10},{30,-10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          origin={-180,-2},
          rotation=90,
          textString="Axial areas"),
        Text(
          extent={{-34,10},{34,-10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          origin={154,120},
          rotation=90,
          textString="Axial sections"),
        Line(
          points={{144,108},{144,128}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-48,-204},{-68,-204}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-96,-204},{-26,-224}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Radial sections"),
        Line(
          points={{-120,40},{-120,60}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5)}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                   Line(
          points={{16,-54},{16,-62}},
          color={191,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
                   Line(
          points={{48,-26},{40,-26}},
          color={191,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
                   Line(
          points={{16,8},{16,0}},
          color={191,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
                   Line(
          points={{16,26},{16,18}},
          color={191,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
                   Line(
          points={{76,26},{76,18}},
          color={191,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Text(
          extent={{-150,-110},{150,-150}},
          lineColor={0,0,255},
          fontName="Times New Roman",
          textString="%name")}),
    Documentation(info="<html>

<p>
Ground domain model for a fully buried TTES with cylindrical fluid domain geometry.
</p>

<p>
This model has a customizable ground domain. The ground domain can be subdivided into segments, with each segment having its own unique thermophysical properties. 
This allows users, for example, to specify different horizontal ground layers or to consider multi-layered storage walls.
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
end FullyBuried_CustomGD;
