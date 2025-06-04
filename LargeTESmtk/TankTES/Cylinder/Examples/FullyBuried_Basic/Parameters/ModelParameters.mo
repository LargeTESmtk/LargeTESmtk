within LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.Parameters;
record ModelParameters "Record with common model parameters for example models"
  extends Utilities.TestFrameworks.PartialParRecords.PartialModelParameters;

// Fluid domain
  // Dimensions
  parameter Modelica.Units.SI.Radius r_FD = 34.5 "Radius" annotation (Dialog(tab="Fluid domain",group="Dimensions"));
  parameter Modelica.Units.SI.Length dz_FD = 27 "Size in axial direction (i.e., height/depth of fluid domain)" annotation (Dialog(tab="Fluid domain",group="Dimensions"));
  final parameter Modelica.Units.SI.Position z_FD_to_glo = if useCapCover then dz_Co else 0 "Axial distance to top boundary (w.r.t. global coordinate system)";

  // Grid parameters
  parameter Integer N_FD_z = 50 "Number of (axial) nodes" annotation (Dialog(tab="Fluid domain",group="Grid parameters"));

  // Inlet/outlet ports
  parameter Integer n_InOut_top = 2 "Position of top inlet/outlet fluid port (n=1: top fluid node)"
    annotation (Dialog(tab="Fluid domain",group="Inlet/outlet ports "));
  final parameter Modelica.Units.SI.Position z_InOut_top = (n_InOut_top-0.5)*dz_FD/N_FD_z
    "Distance between the top inlet/outlet fluid port and the top fluid domain boundary";

  parameter Integer n_InOut_bot = N_FD_z-1 "Position of bottom inlet/outlet fluid port (n=1: top fluid node)"
    annotation (Dialog(tab="Fluid domain",group="Inlet/outlet ports "));
  final parameter Modelica.Units.SI.Position z_InOut_bot = (n_InOut_bot-0.5)*dz_FD/N_FD_z
    "Distance between the bottom inlet/outlet fluid port and the top fluid domain boundary";

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

  // Initialization
  parameter Modelica.Media.Interfaces.Types.Temperature T_FD_init_unif = 273.15 + 10
    "Uniform initial temperature for all nodes" annotation (Dialog(tab="Fluid domain",group="Initialization"));

// Ground domain
  // Overall dimensions
  parameter Modelica.Units.SI.Radius r_GD_bou = r_FD+50
    "Radial far-field boundary of ground domain (Distance/radius between fluid domain centerline and far-field boundary)"
    annotation (Dialog(tab="Ground domain",group="Dimensions"));
  parameter Modelica.Units.SI.Distance z_GD_bou = z_FD_to_glo+dz_FD+50
    "Axial far-field boundary of ground domain (Distance between ground surface and far-field boundary)"
    annotation (Dialog(tab="Ground domain",group="Dimensions"));

  // Grid areas in radial direction
    // Fluid (Fl)
  parameter Integer M_Fl_Sec_r = 3 "No. of radial sections in grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));
  parameter Modelica.Units.SI.Length dr_Fl_Sec_input[:] = {r_FD - 10,5}
    "Radial size of each section except the last section, which results from the size of the entire grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));
  parameter Modelica.Units.SI.Length dr_Fl_smallestNo = 0.10 "Radial size of smallest node of entire grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));
  parameter Real GR_Fl_r = 1.3 "Growth rate between adjacent nodes in radial direction (1: equidistant)"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));
  parameter Boolean reversedDir_GR_Fl_r = true
    "Growth rate direction, = false(default): node size increases from left to right, = true: node size increases from right to left"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));

  final parameter Modelica.Units.SI.Length dr_Sec_Fl_r_OldMo[:] = Modelica.Math.Vectors.reverse(cat(1,dr_Fl_Sec_input, {r_FD-sum(dr_Fl_Sec_input)}))
    "Parameter for older models up to v3";
  final parameter Modelica.Units.SI.Length dr_Sec_input_Fl_r_OldMo[:] = dr_Sec_Fl_r_OldMo[1:end-1]
    "Parameter for older models up to v3";

    // Right (Ri)
  parameter Integer M_Ri_Sec_r = 2 "No. of radial sections in grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));
  parameter Modelica.Units.SI.Length dr_Ri_Sec_input[:] = {5}
    "Radial size of each section except the last section, which results from the size of the entire grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));
  parameter Modelica.Units.SI.Length dr_Ri_smallestNo = 0.10 "Radial size of smallest node of entire grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));
  parameter Real GR_Ri_r = 1.3 "Growth rate between adjacent nodes in radial direction (1: equidistant)"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));
  parameter Boolean reversedDir_GR_Ri_r = false
    "Growth rate direction, = false(default): node size increases from left to right, = true: node size increases from right to left"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in radial direction"));

  // Grid areas in axial direction
    // Top (To)
/*
  parameter Integer N_To_Sec_z = 1 "No. of axial sections in grid zone"
    annotation(Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Modelica.Units.SI.Position z_To_Sec_bo_glo_input[:] = {20,30}
    "Axial distance to bottom boundary of each section (w.r.t. global coordinate system) except the last section, which is equivalent to the axial distance of the entire grid zone"
    annotation(Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Boolean useEquidistantGrid_To_z = true
    "= false(default): increasing node size according to defined growth rate, = true: uniform node size in entire grid zone (i.e., equidistant grid spacing)"
    annotation(Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Integer N_To_Nodes_z = 5 "Number of nodes in axial direction"
    annotation(Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
*/
    // Fluid (Fl)
  parameter Integer N_Fl_Sec_z = 3 "No. of axial sections in grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Modelica.Units.SI.Position z_Fl_Sec_bo_glo_input[:] = {15,20}
    "Axial distance to bottom boundary of each section (w.r.t. global coordinate system) except the last section, which is equivalent to the axial distance of the entire grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));

    // Bottom (Bo)
  parameter Integer N_Bo_Sec_z = 3 "No. of axial sections in grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Modelica.Units.SI.Position z_Bo_Sec_bo_glo_input[:] = {z_FD_to_glo+dz_FD + 5,z_FD_to_glo+dz_FD + 10}
    "Axial distance to bottom boundary of each section (w.r.t. global coordinate system) except the last section, which is equivalent to the axial distance of the entire grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Boolean useEquidistantGrid_Bo_z = false
    "= false(default): increasing node size according to defined growth rate, = true: uniform node size in entire grid zone (i.e., equidistant grid spacing)"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Modelica.Units.SI.Length dz_Bo_smallestNo = 0.10 "Axial size of smallest node of entire grid zone"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Real GR_Bo_z = 1.3 "Growth rate between adjacent nodes in axial direction (1: equidistant)"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));
  parameter Boolean reversedDir_GR_Bo_z = false
    "Growth rate direction, = false(default): node size increases from top to bottom, = true: node size increases from bottom to top"
    annotation (Dialog(tab="Ground domain",group="Grid parameters: Grid areas in axial direction"));

  final parameter Modelica.Units.SI.Length dz_Sec_Bo_z_oldMo[:] = if size(z_Bo_Sec_bo_glo_input,1)>1 then
    cat(1,{z_Bo_Sec_bo_glo_input[1]-(z_FD_to_glo+dz_FD)},
    {z_Bo_Sec_bo_glo_input[i+1]-z_Bo_Sec_bo_glo_input[i] for i in 1:size(z_Bo_Sec_bo_glo_input,1)-1})
    else {z_Bo_Sec_bo_glo_input[1]-(z_FD_to_glo+dz_FD)}
    "Parameter for older models up to v3";

  // Thermophysical properties
  final parameter Components.GroundDomain.MaterialProperties.Ground.GenericGround gP_Uniform;

  final parameter Components.GroundDomain.MaterialProperties.Ground.GenericGround gP_Adiabat(
    k=1e-8,
    c=1e8,
    d=1e8);

  final parameter Components.GroundDomain.MaterialProperties.Ground.ClaySilt_dry gP_VertLay;

  final parameter Components.GroundDomain.MaterialProperties.Ground.Gravel_watersat gP_HoriLay;

    // Right-Top (RiTo)
  parameter Boolean useUnifThermProp_RiTo = false
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties",enable=useCapCover));
  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiTo_unif=gP_Uniform
    "Uniform thermophysical properties of all segments in grid zone" annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_RiTo and useCapCover), choicesAllMatching=true);
  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiTo_spec[:,:]=[gP_Uniform,gP_VertLay]
    "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_RiTo and useCapCover));

    // Right-Fluid (RiFl)
  parameter Boolean useUnifThermProp_RiFl = false
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties"));
  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiFl_unif=gP_Uniform
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_RiFl));
  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiFl_spec[:,:]=[gP_Uniform,gP_VertLay; gP_HoriLay,
      gP_VertLay; gP_Uniform,gP_VertLay] "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_RiFl));

    // Fluid-Bottom (FlBo)
  parameter Boolean useUnifThermProp_FlBo = false
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties"));
  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlBo_unif=gP_Uniform
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_FlBo));
  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_FlBo_spec[:,:]=[gP_Uniform,gP_VertLay,gP_Uniform;
      gP_HoriLay,gP_HoriLay,gP_HoriLay; gP_Uniform,gP_VertLay,gP_Uniform] "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_FlBo));

    // Right-Bottom (RiBo)
  parameter Boolean useUnifThermProp_RiBo = false
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation (Dialog(tab="Ground domain",group="Thermal properties"));
  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiBo_unif=gP_Uniform
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=useUnifThermProp_RiBo));
  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_RiBo_spec[:,:]=[gP_Uniform,gP_VertLay; gP_HoriLay,
      gP_HoriLay; gP_Uniform,gP_VertLay] "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(
      tab="Ground domain",
      group="Thermal properties",
      enable=not useUnifThermProp_RiBo));

  // Initialization
  parameter Modelica.Units.SI.Temperature T_GD_init_unif = 273.15+10 "Uniform initial temperature for all nodes in ground domain"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Fluid-Top (FlTo)
  parameter Modelica.Units.SI.Temperature T_FlTo_init_unif = T_GD_init_unif "Uniform initial temperature for all nodes in grid zone 'Fluid-Top'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Right-Top (RiTo)
  parameter Modelica.Units.SI.Temperature T_RiTo_init_unif = T_GD_init_unif "Uniform initial temperature for all nodes in grid zone 'Right-Top'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Right-Fluid (RiFl)
  parameter Modelica.Units.SI.Temperature T_RiFl_init_unif = T_GD_init_unif "Uniform initial temperature for all nodes in grid zone 'Right-Fluid'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Fluid-Bottom (FlBo)
  parameter Modelica.Units.SI.Temperature T_FlBo_init_unif = T_GD_init_unif "Uniform initial temperature for all nodes in grid zone 'Fluid-Bottom'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

    // Right-Bottom (RiBo)
  parameter Modelica.Units.SI.Temperature T_RiBo_init_unif = T_GD_init_unif "Uniform initial temperature for all nodes in grid zone 'Right-Bottom'"
    annotation (Dialog(tab="Ground domain",group="Initialization"));

  // Surface heat transfer
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_GD_conv = 25 "Convective heat transfer coefficient"
    annotation (Dialog(tab="Ground domain",group="Surface heat transfer"));

  parameter Boolean useRadHeatTransfer_GD = false
    "= true: convective and radiate heat transfer are considered, = false: only convective heat transfer is considered"
    annotation (Dialog(tab="Ground domain",group="Surface heat transfer"));
  parameter Modelica.Units.SI.SpectralAbsorptionFactor alpha_GD_solar = 0.8
    "Solar absorptivity of surface" annotation (Dialog(tab="Ground domain",group="Surface heat transfer",enable=useRadHeatTransfer_GD));
  parameter Modelica.Units.SI.Emissivity eps_GD=0.95
    "Emissivity of surface" annotation (Dialog(tab="Ground domain",group="Surface heat transfer",enable=useRadHeatTransfer_GD));

// Cover
  // General
  parameter Boolean useCapCover = true
    "= true(default): capacitance (i.e. thermal mass) of cover is considered, = false: cover is only considered as thermal resistance w/o capacitance"
    annotation(Dialog(tab="Cover",group="General"));

  // Dimensions
  parameter Modelica.Units.SI.Length dz_Co = 0.5 "Total layer thickness of cover"
    annotation (Dialog(tab="Cover",group="Dimensions",enable=useCapCover),HideResult=not useCapCover);

  // Grid parameters
  //parameter Integer N_Co_Sec_z=1 "No. of axial sections in grid zone";
  parameter Boolean useEquidistantGrid_Co_z = true
    "= false(default): increasing node size according to defined growth rate, = true: uniform node size in entire grid zone (i.e., equidistant grid spacing)"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=useCapCover));
  parameter Modelica.Units.SI.Length dz_Co_smallestNo = 0.10
    "Axial size of smallest node of entire grid zone"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=not useEquidistantGrid_Co_z and useCapCover),HideResult=useEquidistantGrid_Co_z);
  parameter Real GR_Co_z = 1.1
    "Growth rate between adjacent nodes in axial direction (1: equidistant)"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=not useEquidistantGrid_Co_z and useCapCover),HideResult=useEquidistantGrid_Co_z);
  parameter Boolean reversedDir_GR_Co_z = false
    "Growth rate direction, = false(default): node size increases from top to bottom, = true: node size increases from bottom to top"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=not useEquidistantGrid_Co_z and useCapCover),HideResult=useEquidistantGrid_Co_z);
  parameter Integer N_Co_Nodes_z = 5
    "Number of nodes in axial direction"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=useEquidistantGrid_Co_z and useCapCover),HideResult=not useEquidistantGrid_Co_z);

  // Thermophysical properties
  parameter Components.GroundDomain.MaterialProperties.Insulation.DronninglundCover thermProp_Co_unif "Uniform thermophysical properties of cover"
    annotation (
    Dialog(
      tab="Cover",
      group="Thermal properties",
      enable=useCapCover),
    HideResult=false,
    choicesAllMatching=true);

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_Co = thermProp_Co_unif.k/dz_Co
    "U-value of cover (when cover is only considered as thermal resistance w/o capacitance)"
    annotation (Dialog(tab="Cover",group="Thermal properties",enable=not useCapCover));

  // Initialization
  parameter Modelica.Units.SI.Temperature T_Co_init_unif = 273.15 + 10
    "Uniform initial temperature for all nodes of cover"
    annotation (Dialog(tab="Cover",group="Initialization",enable=useCapCover));

  // Surface heat transfer
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_Co_conv = 25 "Convective heat transfer coefficient"
    annotation (Dialog(tab="Cover",group="Surface heat transfer"));

  parameter Boolean useRadHeatTransfer_Co = false
    "= true: convective and radiate heat transfer are considered, = false: only convective heat transfer is considered"
    annotation (Dialog(tab="Cover",group="Surface heat transfer"));
  parameter Modelica.Units.SI.SpectralAbsorptionFactor alpha_Co_solar = 0.8
    "Solar absorptivity of surface" annotation (Dialog(tab="Cover",group="Surface heat transfer",enable=useRadHeatTransfer_Co));
  parameter Modelica.Units.SI.Emissivity eps_Co = 0.95
    "Emissivity of surface" annotation (Dialog(tab="Cover",group="Surface heat transfer",enable=useRadHeatTransfer_Co));

  // Insulation extension
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_InsExt = thermProp_Co_unif.k/dz_Co
    "U-value of insulation extension (exclusive convective and radiative heat transfer to ambient)"
     annotation (Dialog(tab="Cover",group="Insulation extension"));
  parameter Integer M_InsExt_r = 0
    "Number of ground nodes to be covered with insulation, i.e., radial expansion of insulation extension (0: no insulation extension)"
    annotation (Dialog(tab="Cover",group="Insulation extension"));

// Model results/output
  // General
  parameter Modelica.Units.SI.Temperature T_ref = 273.15 + 10 "Reference temperature for internal energy (Q_int) calculation"
    annotation (Dialog(tab="Results",group="General"));

  // Ground temperature monitoring points
     // Right-Top (RiTo)
  parameter Modelica.Units.SI.Radius r_TMP_RiTo[:] = {r_FD + 1}
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Top'",enable=useCapCover));
  parameter Modelica.Units.SI.Distance z_TMP_RiTo[:] = {0.15}
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Top'",enable=useCapCover));

     // Right-Fluid (RiFl)
  parameter Modelica.Units.SI.Radius r_TMP_RiFl[:] = {r_FD + 1}
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Fluid'"));
  parameter Modelica.Units.SI.Distance z_TMP_RiFl[:] = {10}
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Fluid'"));

     // Fluid-Bottom (FlBo)
  parameter Modelica.Units.SI.Radius r_TMP_FlBo[:] = {20}
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Fluid-Bottom'"));
  parameter Modelica.Units.SI.Distance z_TMP_FlBo[:] = {z_FD_to_glo+dz_FD + 1}
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Fluid-Bottom'"));

     // Right-Bottom (RiBo)
  parameter Modelica.Units.SI.Radius r_TMP_RiBo[:] = {r_FD + 1}
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Bottom'"));
  parameter Modelica.Units.SI.Distance z_TMP_RiBo[:] = {z_FD_to_glo+dz_FD + 1}
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Grid zone 'Right-Bottom'"));

  // Temperature monitoring points
    // Cover (Co)
  parameter Modelica.Units.SI.Radius r_TMP_Co[:] = {20}
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Cover",enable=useCapCover));
  parameter Modelica.Units.SI.Distance z_TMP_Co[:] = {dz_Co/2}
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Cover",enable=useCapCover));

  annotation (defaultComponentName="modelPar",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This record can be used to globally define the corresponding parameters for all example models. Alternatively, the parameters can also be defined individually in each model. 
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
end ModelParameters;
