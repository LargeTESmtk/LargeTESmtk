within LargeTESmtk.BaseClasses.TESModels;
model PartialXTES_Cylinder_FullyBuried_CustomGD "Partial model for a fully buried TES with cylindrical fluid geometry and customizable ground domain"

// Fluid domain
  // Dimensions
  parameter Modelica.Units.SI.Position z_FD_to_glo_in = 0.5
    "Depth to top of fluid domain (i.e., axial distance to top boundary w.r.t. global coordinate system) (user input)"
    annotation (Dialog(tab="Fluid domain",group="Dimensions",enable=useTopGridArea),HideResult=true);
  final parameter Modelica.Units.SI.Position z_FD_to_glo = if useTopGridArea then z_FD_to_glo_in else 0
    "Depth to top of fluid domain (i.e., axial distance to top boundary w.r.t. global coordinate system)";

  parameter LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim.SegDim_Cylinder fluidDomDim(
    r=34.5,
    dz(fixed=true) = 27,
    final z_to_glo(fixed=true) = z_FD_to_glo,
    final z_to_glo_TopNode=fluidDomDim.z_to_glo) "Fluid domain dimensions" annotation (Dialog(tab="Fluid domain", group="Dimensions"));

  // Grid parameters
  parameter Integer N_FD_z = 50 "Number of (axial) nodes" annotation (Dialog(tab="Fluid domain",group="Grid parameters"));

  // Storage medium properties
  replaceable package storageMedium = Modelica.Media.Interfaces.PartialMedium "Storage medium"
     annotation (choices(
     choice(redeclare package storageMedium = LargeTESmtk.Components.FluidDomain.StorageMedia.Water_ConstProp                 "Water w/ constant properties")),
     Dialog(tab="Fluid domain",group="Storage medium properties"));

  // Heat transfer
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_FD_top = 1000
    "Heat transfer coefficent (HTC) at top boundary surface (inner convective HTC or overall HTC, depending on consideration of cover structure)"
    annotation (Dialog(tab="Fluid domain",group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_FD_sid = 75
    "Heat transfer coefficent (HTC) at side boundary surface (inner convective HTC or overall HTC, depending on consideration of side wall structure)"
    annotation (Dialog(tab="Fluid domain",group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_FD_bot = 75
    "Heat transfer coefficent (HTC) at bottom boundary surface (inner convective HTC or overall HTC, depending on consideration of bottom structure)"
    annotation (Dialog(tab="Fluid domain",group="Heat transfer"));

  // Buoyancy model
  parameter Modelica.Units.SI.Time tau_buo = 1
    "Time constant of buoyancy model (determines how fast the temperature compensation between adjacent fluid layers occurs)"
    annotation (Dialog(tab="Fluid domain",group="Buoyancy model"));

  // Nominal conditions
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate (used to improve numerical properties)" annotation (Dialog(tab="Fluid domain",group="Nominal conditions"));

  // Initialization
  parameter Modelica.Media.Interfaces.Types.Temperature T_FD_init_unif = 273.15 + 10
    "Uniform initial temperature for all nodes" annotation (Dialog(tab="Fluid domain",group="Initialization"));
  parameter Modelica.Units.SI.Temperature T_FD_init[N_FD_z] = fluidDom.T_init_unif*ones(fluidDom.N_z)
    "Individual initial temperature for each node, with T_init[1] being the top node" annotation (Dialog(tab="Fluid domain",group="Initialization"));

  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start = fluidDom.Medium.p_default
    "Start value of pressure" annotation (Dialog(tab="Fluid domain",group="Initialization"));
/*
  parameter Modelica.Units.SI.Temperature T_F_ReInit[N_FD_z] = fill(273.15+50,
      fluidDomain.n_z)
    "Reinitialization temperature after reinitialization time";
  parameter Modelica.Units.SI.Time t_F_ReInit = 0
    "Reinitialization time; if t_ReInit=0 -> no reinitialization";
*/

/*
  parameter Modelica.Units.SI.Time t_PreDefT = 0
    "Duration of preheating period; if t_PreDefT=0 -> no preheating applied";
*/

// Ground domain
  // Overall dimensions
  parameter Modelica.Units.SI.Radius r_GD_bou = fluidDomDim.r+50
    "Radial far-field boundary of ground domain (Distance/radius between fluid domain centerline and far-field boundary)"
    annotation (Dialog(tab="Ground domain",group="Dimensions"));
  parameter Modelica.Units.SI.Distance z_GD_bou = fluidDomDim.z_bo_glo+50
    "Axial far-field boundary of ground domain (Distance between ground surface and far-field boundary)"
    annotation (Dialog(tab="Ground domain",group="Dimensions"));

  // Grid areas in radial direction
    // Fluid (Fl)
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Radial_Parameters gridAreaPar_Fl_r(
    final r_le=0,
    final r_ri=groundDom.fluidDomainPar.r,
    M_Sec_r=2,
    dr_Sec_input={groundDom.fluidDomainPar.r - 5},
    dr_smallestNo=0.10,
    GR_r=1.3,
    reversedDir_GR_r=true) "Radial grid area parameters: 'Fluid' (Fl)"
    annotation (Dialog(tab="Ground domain", group="Grid parameters: Grid areas in radial direction"));

    // Right (Ri)
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Radial_Parameters gridAreaPar_Ri_r(
    final r_le=groundDom.fluidDomainPar.r,
    final r_ri=r_GD_bou,
    M_Sec_r=2,
    dr_Sec_input={5},
    dr_smallestNo=0.10,
    GR_r=1.3,
    reversedDir_GR_r=false) "Radial grid area parameters: 'Right' (Ri)"
    annotation (Dialog(tab="Ground domain", group="Grid parameters: Grid areas in radial direction"));

  // Grid areas in axial direction
    // Top (To)
  parameter Boolean useTopGridArea = true "= true(default): adds top grid area (i.e., two grid zones) above fluid domain"
    annotation(Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters gridAreaPar_To_z(
    final z_to_glo=0,
    final z_bo_glo=groundDom.fluidDomainPar.z_to_glo,
    N_Sec_z=1,
    useEquidistantGrid_z=true,
    dz_smallestNo=0.10,
    GR_z=1.00001,
    reversedDir_GR_z=false,
    N_Nodes_z=5) if useTopGridArea "Axial grid area parameters: 'Top' (To)"
    annotation (Dialog(
      tab="Ground domain",
      group="Grid parameters: Grid areas in axial direction",
      enable=useTopGridArea));

    // Fluid (Fl)
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters gridAreaPar_Fl_z(
    final z_to_glo=groundDom.fluidDomainPar.z_to_glo,
    final z_bo_glo=groundDom.fluidDomainPar.z_bo_glo,
    N_Sec_z=3,
    z_Sec_bo_glo_input={15,20},
    final useEquidistantGrid_z=true,
    final dz_smallestNo,
    final GR_z,
    final reversedDir_GR_z,
    final N_Nodes_z=groundDom.fluidDomainPar.N_z) "Axial grid area parameters: 'Fluid' (Fl)"
    annotation (Dialog(tab="Ground domain", group="Grid parameters: Grid areas in axial direction"));

    // Bottom (Bo)
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters gridAreaPar_Bo_z(
    final z_to_glo=groundDom.fluidDomainPar.z_bo_glo,
    final z_bo_glo=z_GD_bou,
    N_Sec_z=2,
    z_Sec_bo_glo_input={groundDom.fluidDomainPar.z_bo_glo + 5},
    useEquidistantGrid_z=false,
    dz_smallestNo=0.10,
    GR_z=1.3) "Axial grid area parameters: 'Bottom' (Bo)"
    annotation (Dialog(tab="Ground domain", group="Grid parameters: Grid areas in axial direction"));

  // Thermophysical properties

  /*
      (Matrix format to be used:    
        [segment[1,1], segment[2,1], segment[3,1];
         segment[1,2], segment[2,2], segment[3,2]])
   */

    // Fluid-Top (FlTo)
  parameter Boolean useUnifThermProp_FlTo = true if useTopGridArea
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties",enable=useTopGridArea));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlTo_unif if useTopGridArea
    "Uniform thermophysical properties of all segments in grid zone" annotation (
    Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_FlTo and useTopGridArea),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlTo_spec[gridAreaPar_To_z.N_Sec_z,
    gridAreaPar_Fl_r.M_Sec_r](
    each k=thermProp_FlTo_unif.k,
    each c=thermProp_FlTo_unif.c,
    each d=thermProp_FlTo_unif.d) if useTopGridArea "Specified thermophysical properties of individual segments in grid zone" annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_FlTo and useTopGridArea), HideResult=true);

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_Co_partial = 0.1  if not useTopGridArea
    "U-value of cover (when cover is only considered as thermal resistance w/o capacitance)"
    annotation (Dialog(tab="Ground domain",group="Thermal properties",enable=not useTopGridArea));

    // Right-Top (RiTo)
  parameter Boolean useUnifThermProp_RiTo = true if useTopGridArea
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties",enable=useTopGridArea));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiTo_unif if useTopGridArea
    "Uniform thermophysical properties of all segments in grid zone" annotation (
    Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_RiTo and useTopGridArea),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiTo_spec[gridAreaPar_To_z.N_Sec_z,
    gridAreaPar_Ri_r.M_Sec_r](
    each k=thermProp_RiTo_unif.k,
    each c=thermProp_RiTo_unif.c,
    each d=thermProp_RiTo_unif.d) if useTopGridArea "Specified thermophysical properties of individual segments in grid zone" annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_RiTo and useTopGridArea), HideResult=true);

    // Right-Fluid (RiFl)
  parameter Boolean useUnifThermProp_RiFl = true
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties"));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiFl_unif
    "Uniform thermophysical properties of all segments in grid zone" annotation (
    Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_RiFl),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiFl_spec[gridAreaPar_Fl_z.N_Sec_z,
    gridAreaPar_Ri_r.M_Sec_r](
    each k=thermProp_RiFl_unif.k,
    each c=thermProp_RiFl_unif.c,
    each d=thermProp_RiFl_unif.d) "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_RiFl), HideResult=true);

    // Fluid-Bottom (FlBo)
  parameter Boolean useUnifThermProp_FlBo = true
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties"));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlBo_unif
    "Uniform thermophysical properties of all segments in grid zone" annotation (
    Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_FlBo),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlBo_spec[gridAreaPar_Bo_z.N_Sec_z,
    gridAreaPar_Fl_r.M_Sec_r](
    each k=thermProp_FlBo_unif.k,
    each c=thermProp_FlBo_unif.c,
    each d=thermProp_FlBo_unif.d) "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_FlBo), HideResult=true);

    // Right-Bottom (RiBo)
  parameter Boolean useUnifThermProp_RiBo = true
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties"));
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiBo_unif
    "Uniform thermophysical properties of all segments in grid zone" annotation (
    Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_RiBo),
    HideResult=true,
    choicesAllMatching=true);
  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiBo_spec[gridAreaPar_Bo_z.N_Sec_z,
    gridAreaPar_Ri_r.M_Sec_r](
    each k=thermProp_RiBo_unif.k,
    each c=thermProp_RiBo_unif.c,
    each d=thermProp_RiBo_unif.d) "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_RiBo), HideResult=true);

  // Heat transfer
    // To be specified in higher-level model

  // Initialization
    // Fluid-Top (FlTo)
  parameter Modelica.Units.SI.Temperature T_FlTo_init_unif = 273.15+10 if useTopGridArea
    "Uniform initial temperature for all nodes in grid zone 'Fluid-Top'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Right-Top (RiTo)
  parameter Modelica.Units.SI.Temperature T_RiTo_init_unif = 273.15+10  if useTopGridArea
    "Uniform initial temperature for all nodes in grid zone 'Right-Top'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Right-Fluid (RiFl)
  parameter Modelica.Units.SI.Temperature T_RiFl_init_unif = 273.15+10 "Uniform initial temperature for all nodes in grid zone 'Right-Fluid'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Fluid-Bottom (FlBo)
  parameter Modelica.Units.SI.Temperature T_FlBo_init_unif = 273.15+10 "Uniform initial temperature for all nodes in grid zone 'Fluid-Bottom'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Right-Bottom (RiBo)
  parameter Modelica.Units.SI.Temperature T_RiBo_init_unif = 273.15+10 "Uniform initial temperature for all nodes in grid zone 'Right-Bottom'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

// Model results/output
  // General
  parameter Modelica.Units.SI.Temperature T_ref = 273.15 + 10 "Reference temperature for internal energy (Q_int) calculation"
    annotation (Dialog(tab="Results",group="General"));

  parameter Boolean HideAllRes_GD = true
    "= true(default): ground domain model variables/parameters will be hidden (i.e., not included) in the result file to avoid extremly large result files"
    annotation (Dialog(tab="Results",group="General"));
    //   parameter Boolean HideVarRes_GD = true;

  // Ground temperature monitoring points
    // Fluid-Top (FlTo)
  parameter Modelica.Units.SI.Radius r_TMP_FlTo[:] = fill(0, 0) if useTopGridArea
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Fluid-Top'",enable=useTopGridArea));
  parameter Modelica.Units.SI.Distance z_TMP_FlTo[:] = fill(0, 0) if useTopGridArea
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Fluid-Top'",enable=useTopGridArea));
  Modelica.Units.SI.Temperature T_TMP_FlTo[groundDom.zone_FlTo.N_TMP] = groundDom.T_TMP_FlTo if useTopGridArea
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

     // Right-Top (RiTo)
  parameter Modelica.Units.SI.Radius r_TMP_RiTo[:] = fill(0, 0) if useTopGridArea
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Top'",enable=useTopGridArea));
  parameter Modelica.Units.SI.Distance z_TMP_RiTo[:] = fill(0, 0) if useTopGridArea
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Top'",enable=useTopGridArea));
  Modelica.Units.SI.Temperature T_TMP_RiTo[groundDom.zone_RiTo.N_TMP] = groundDom.T_TMP_RiTo if useTopGridArea
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

     // Right-Fluid (RiFl)
  parameter Modelica.Units.SI.Radius r_TMP_RiFl[:] = fill(0, 0)
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Fluid'"));
  parameter Modelica.Units.SI.Distance z_TMP_RiFl[:] = fill(0, 0)
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Fluid'"));
  Modelica.Units.SI.Temperature T_TMP_RiFl[groundDom.zone_RiFl.N_TMP] = groundDom.T_TMP_RiFl
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

     // Fluid-Bottom (FlBo)
  parameter Modelica.Units.SI.Radius r_TMP_FlBo[:] = fill(0, 0)
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Fluid-Bottom'"));
  parameter Modelica.Units.SI.Distance z_TMP_FlBo[:] = fill(0, 0)
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Fluid-Bottom'"));
  Modelica.Units.SI.Temperature T_TMP_FlBo[groundDom.zone_FlBo.N_TMP] = groundDom.T_TMP_FlBo
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

     // Right-Bottom (RiBo)
  parameter Modelica.Units.SI.Radius r_TMP_RiBo[:] = fill(0, 0)
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Bottom'"));
  parameter Modelica.Units.SI.Distance z_TMP_RiBo[:] = fill(0, 0)
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Bottom'"));
  Modelica.Units.SI.Temperature T_TMP_RiBo[groundDom.zone_RiBo.N_TMP] = groundDom.T_TMP_RiBo
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

/*
// Fluid domain: Temperatures and positions of fluid segments
  Modelica.Units.SI.Temperature T_F[N_FD_z] = fluidDomain.vol.T "Fluid temperatures";
  final parameter Modelica.Units.SI.Distance z_F[N_FD_z] = fluidDomain.FluidSegments.z
    "Depths of the centers of the fluid segments (relative to the top fluid boundary)";
*/

/*
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_PreDefT1[size(
    fluidDomain.port_PreDefT, 1)] annotation (Placement(transformation(extent={{-104,-156},{-88,-140}}),
                            iconTransformation(extent={{-4,-20},{4,-12}})));
*/

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_FD_top(m=size(groundDom.heatPorts_FlTo_bo, 1))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-10})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_FD_bo(m=size(groundDom.heatPorts_FlBo_to, 1))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-90})));

  LargeTESmtk.Components.GroundDomain.Cylinder.FullyBuried_CustomGD groundDom(
    z_FD_to_glo_in=fluidDomDim.z_to_glo,
    fluidDomainPar(
      r=fluidDomDim.r,
      dz=fluidDomDim.dz,
      N_z=N_FD_z),
    r_GD_bou=r_GD_bou,
    z_GD_bou=z_GD_bou,
    gridAreaPar_Fl_r=gridAreaPar_Fl_r,
    gridAreaPar_Ri_r=gridAreaPar_Ri_r,
    useTopGridArea=useTopGridArea,
    gridAreaPar_To_z=gridAreaPar_To_z,
    gridAreaPar_Fl_z=gridAreaPar_Fl_z,
    gridAreaPar_Bo_z=gridAreaPar_Bo_z,
    useUnifThermProp_FlTo=useUnifThermProp_FlTo,
    thermProp_FlTo_unif=thermProp_FlTo_unif,
    thermProp_FlTo_spec=thermProp_FlTo_spec,
    U_Co=U_Co_partial,
    useUnifThermProp_RiTo=useUnifThermProp_RiTo,
    thermProp_RiTo_unif=thermProp_RiTo_unif,
    thermProp_RiTo_spec=thermProp_RiTo_spec,
    useUnifThermProp_RiFl=useUnifThermProp_RiFl,
    thermProp_RiFl_unif=thermProp_RiFl_unif,
    thermProp_RiFl_spec=thermProp_RiFl_spec,
    useUnifThermProp_FlBo=useUnifThermProp_FlBo,
    thermProp_FlBo_unif=thermProp_FlBo_unif,
    thermProp_FlBo_spec=thermProp_FlBo_spec,
    useUnifThermProp_RiBo=useUnifThermProp_RiBo,
    thermProp_RiBo_unif=thermProp_RiBo_unif,
    thermProp_RiBo_spec=thermProp_RiBo_spec,
    T_FlTo_init_unif=T_FlTo_init_unif,
    T_RiTo_init_unif=T_RiTo_init_unif,
    T_RiFl_init_unif=T_RiFl_init_unif,
    T_FlBo_init_unif=T_FlBo_init_unif,
    T_RiBo_init_unif=T_RiBo_init_unif,
    r_TMP_FlTo=r_TMP_FlTo,
    z_TMP_FlTo=z_TMP_FlTo,
    r_TMP_RiTo=r_TMP_RiTo,
    z_TMP_RiTo=z_TMP_RiTo,
    r_TMP_RiFl=r_TMP_RiFl,
    z_TMP_RiFl=z_TMP_RiFl,
    r_TMP_FlBo=r_TMP_FlBo,
    z_TMP_FlBo=z_TMP_FlBo,
    r_TMP_RiBo=r_TMP_RiBo,
    z_TMP_RiBo=z_TMP_RiBo) "Ground domain model (cylinder geometry, fully buried)"
    annotation (Placement(transformation(extent={{20,-92},{140,28}})), HideResult=HideAllRes_GD);

  LargeTESmtk.Components.FluidDomain.Cylinder fluidDom(
    final allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    final m_flow_small,
    final show_T,
    redeclare package storageMedium = storageMedium,
    fluidDomDim=fluidDomDim,
    h_top=h_FD_top,
    h_sid=h_FD_sid,
    h_bot=h_FD_bot,
    N_z=N_FD_z,
    final energyDynamics,
    p_start=p_start,
    T_init_unif=T_FD_init_unif,
    T_init=T_FD_init,
    final X_start,
    final C_start,
    tau_buo=tau_buo,
    T_ref=T_ref) "Fluid domain model (cylinder geometry)" annotation (Placement(transformation(extent={{-90,-80},{-30,-20}})));
  Modelica.Fluid.Interfaces.FluidPorts_a fluidPorts_Nod[N_FD_z](redeclare package Medium = storageMedium)
    "Fluid ports connected to individual fluid nodes (to be used as inlet/outlet ports)"
    annotation (Placement(transformation(extent={{-114,-60},{-94,20}}),   iconTransformation(extent={{-30,-46},{-20,-6}})));

  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts_FluidNod[N_FD_z] "Heat ports directly connected to individual fluid nodes" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-104,-80}), iconTransformation(
        extent={{-10,0},{10,5}},
        rotation=90,
        origin={46,-26})));

equation

/*
  connect(fluidDomain.port_PreDefT, port_PreDefT1) annotation (Line(points={{-76,-113.6},{-68,-113.6},{-68,-148},{-96,-148}},
                                                       color={191,0,0}));
 */

  connect(thermColl_FD_bo.port_a, groundDom.heatPorts_FlBo_to)
    annotation (Line(points={{-10,-90},{0,-90},{0,-60},{89.6,-60},{89.6,-60.8}},                       color={191,0,0}));
  connect(thermColl_FD_top.port_a, groundDom.heatPorts_FlTo_bo)
    annotation (Line(points={{-10,-10},{0,-10},{0,-36},{90,-36},{90,-35.6},{89.6,-35.6}},
                                                                                   color={191,0,0}));
  connect(fluidDom.fluidPorts_Nod, fluidPorts_Nod)
    annotation (Line(points={{-67.5,-50},{-67.5,-20},{-104,-20}},                     color={0,127,255}));
  connect(fluidDom.heatPort_bot, thermColl_FD_bo.port_b) annotation (Line(points={{-54,-80},{-54,-90},{-30,-90}},           color={191,0,0}));
  connect(fluidDom.heatPorts_sid, groundDom.heatPorts_RiFl_le)
    annotation (Line(points={{-30,-50},{0,-50},{0,-47.6},{101.6,-47.6}},                         color={191,0,0}));
  connect(fluidDom.heatPort_top, thermColl_FD_top.port_b)
    annotation (Line(points={{-54,-20},{-54,-10},{-30,-10}},                                     color={191,0,0}));

  connect(fluidDom.heatPorts_Nod, heatPorts_FluidNod)
    annotation (Line(points={{-52.5,-50},{-52,-50},{-52,-64},{-68,-64},{-68,-80},{-104,-80}}, color={127,0,0}));
    annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-150,-110},{150,-150}},
          lineColor={0,0,255},
          fontName="Times New Roman",
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{160,120}})),
    Documentation(info="<html>

<p>
This is a partial model for a fully buried TES with cylindrical fluid domain geometry and customizable ground domain.
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
end PartialXTES_Cylinder_FullyBuried_CustomGD;
