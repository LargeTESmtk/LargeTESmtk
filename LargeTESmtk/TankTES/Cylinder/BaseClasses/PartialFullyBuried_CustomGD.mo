within LargeTESmtk.TankTES.Cylinder.BaseClasses;
model PartialFullyBuried_CustomGD "Partial model for a fully buried TTES with cylindrical fluid and customizable ground domain"
  extends LargeTESmtk.BaseClasses.TESModels.PartialXTES_Cylinder_FullyBuried_CustomGD(
    final z_FD_to_glo_in=dz_Co,
    final useTopGridArea=useCapCover,
    final gridAreaPar_To_z(
      final N_Sec_z=1,
      final z_Sec_bo_glo_input,
      useEquidistantGrid_z=useEquidistantGrid_Co_z,
      dz_smallestNo=dz_Co_smallestNo,
      GR_z=GR_Co_z,
      reversedDir_GR_z=reversedDir_GR_Co_z,
      N_Nodes_z=N_Co_Nodes_z),
    final useUnifThermProp_FlTo=true,
    final thermProp_FlTo_unif=thermProp_Co_unif,
    final thermProp_FlTo_spec,
    final T_FlTo_init_unif=T_Co_init_unif,
    final U_Co_partial=U_Co,
    final r_TMP_FlTo=r_TMP_Co,
    final z_TMP_FlTo=z_TMP_Co);

  /*
  parameter Giga_TES.LargeTESmtk.Components.FluidDomain.BaseClasses.SegmentDim_Cylinder_v4_0_0 fluidDomDim_(
    r=34.5,
    dz(fixed=true)=27,
    final z_to_glo(fixed=true)=dz_Co,
    final z_to_glo_TopNode=fluidDomDim.z_to_glo) "Fluid domain dimensions" annotation (Dialog(tab="Fluid domain",group="Dimensions"));
    */

// Ground domain
  // Surface heat transfer
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_GD_conv = 25 "Convective heat transfer coefficient"
    annotation (Dialog(tab="Ground domain",group="Surface heat transfer"));

  parameter Boolean useRadHeatTransfer_GD = true
    "= true: convective and radiate heat transfer are considered, = false: only convective heat transfer is considered"
    annotation (Dialog(tab="Ground domain",group="Surface heat transfer"));
  parameter Modelica.Units.SI.SpectralAbsorptionFactor alpha_GD_solar = 0.8 if useRadHeatTransfer_GD
    "Solar absorptivity of surface" annotation (Dialog(tab="Ground domain",group="Surface heat transfer",enable=useRadHeatTransfer_GD));
  parameter Modelica.Units.SI.Emissivity eps_GD = 0.95 if useRadHeatTransfer_GD
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
  parameter Boolean useEquidistantGrid_Co_z = true if useCapCover
    "= false(default): increasing node size according to defined growth rate, = true: uniform node size in entire grid zone (i.e., equidistant grid spacing)"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=useCapCover));
  parameter Modelica.Units.SI.Length dz_Co_smallestNo = 0.10 if useCapCover
    "Axial size of smallest node of entire grid zone"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=not useEquidistantGrid_Co_z and useCapCover),HideResult=useEquidistantGrid_Co_z);
  parameter Real GR_Co_z = 1.1 if useCapCover
    "Growth rate between adjacent nodes in axial direction (1: equidistant)"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=not useEquidistantGrid_Co_z and useCapCover),HideResult=useEquidistantGrid_Co_z);
  parameter Boolean reversedDir_GR_Co_z = false if useCapCover
    "Growth rate direction, = false(default): node size increases from top to bottom, = true: node size increases from bottom to top"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=not useEquidistantGrid_Co_z and useCapCover),HideResult=useEquidistantGrid_Co_z);
  parameter Integer N_Co_Nodes_z = 5 if useCapCover
    "Number of nodes in axial direction"
    annotation (Dialog(tab="Cover",group="Grid parameters",enable=useEquidistantGrid_Co_z and useCapCover),HideResult=not useEquidistantGrid_Co_z);

  // Thermophysical properties
  replaceable parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_Co_unif if useCapCover
    "Uniform thermophysical properties of cover"
    annotation (
    Dialog(
      tab="Cover",
      group="Thermal properties",
      enable=useCapCover),
    HideResult=false,
    choicesAllMatching=true);

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_Co = 0.1  if not useCapCover
    "U-value of cover (when cover is only considered as thermal resistance w/o capacitance)"
    annotation (Dialog(tab="Cover",group="Thermal properties",enable=not useCapCover));

  // Initialization
  parameter Modelica.Units.SI.Temperature T_Co_init_unif = 273.15 + 10 if useCapCover
    "Uniform initial temperature for all nodes of cover"
    annotation (Dialog(tab="Cover",group="Initialization",enable=useCapCover));

  // Surface heat transfer
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_Co_conv = 25 "Convective heat transfer coefficient"
    annotation (Dialog(tab="Cover",group="Surface heat transfer"));

  parameter Boolean useRadHeatTransfer_Co = true
    "= true: convective and radiate heat transfer are considered, = false: only convective heat transfer is considered"
    annotation (Dialog(tab="Cover",group="Surface heat transfer"));
  parameter Modelica.Units.SI.SpectralAbsorptionFactor alpha_Co_solar = 0.8 if useRadHeatTransfer_Co
    "Solar absorptivity of surface" annotation (Dialog(tab="Cover",group="Surface heat transfer",enable=useRadHeatTransfer_Co));
  parameter Modelica.Units.SI.Emissivity eps_Co = 0.95 if useRadHeatTransfer_Co
    "Emissivity of surface" annotation (Dialog(tab="Cover",group="Surface heat transfer",enable=useRadHeatTransfer_Co));

  // Insulation extension
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_InsExt = 0.3
    "U-value of insulation extension (exclusive convective and radiative heat transfer to ambient)"
     annotation (Dialog(tab="Cover",group="Insulation extension"));
  parameter Integer M_InsExt_r = 2
    "Number of ground nodes to be covered with insulation, i.e., radial expansion of insulation extension (0: no insulation extension)"
    annotation (Dialog(tab="Cover",group="Insulation extension"));

// Model results/output
  // Temperature monitoring points
    // Cover (Co)
  parameter Modelica.Units.SI.Radius r_TMP_Co[:] = fill(0, 0) if useCapCover
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Cover",enable=useCapCover));
  parameter Modelica.Units.SI.Distance z_TMP_Co[:] = fill(0, 0) if useCapCover
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)"
    annotation(Dialog(tab="Results",group="Temp. monitoring points: Cover",enable=useCapCover));
  Modelica.Units.SI.Temperature T_TMP_Co[groundDom.zone_FlTo.N_TMP] = T_TMP_FlTo if useCapCover
    "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

  Components.GroundDomain.SurfaceHeatTransfer.ConvRadHeatTransfer_MultipleNo heatTrans_GroundSurf(
    N_Nod=groundDom.zone_RiFl.zoneLayout_r.nodeDim_Zone.M_r,
    A_Nod=groundDom.zone_RiFl.zoneLayout_r.nodeDim_Zone.A_z,
    h_conv=h_GD_conv,
    useRadHeatTransfer=useRadHeatTransfer_GD,
    alpha_solar=alpha_GD_solar,
    eps=eps_GD) "Ground surface heat transfer model" annotation (Placement(transformation(extent={{120,30},{140,50}})));
  Components.GroundDomain.SurfaceHeatTransfer.InsulationExtension insExtension(
    M_Nod_r=groundDom.zone_RiFl.zoneLayout_r.nodeDim_Zone.M_r,
    A_Nod=groundDom.zone_RiFl.zoneLayout_r.nodeDim_Zone.A_z,
    r_le=groundDom.zone_RiFl.zoneLayout_r.nodeDim_Zone.r_le,
    r_ri=groundDom.zone_RiFl.zoneLayout_r.nodeDim_Zone.r_ri,
    U_InsExt=U_InsExt,
    M_InsExt_r=M_InsExt_r) annotation (Placement(transformation(extent={{120,0},{140,20}})));
  Components.GroundDomain.SurfaceHeatTransfer.ConvRadHeatTransfer_MultipleNo heatTrans_CoverSurf(
    N_Nod=groundDom.zone_FlTo.zoneLayout_r.nodeDim_Zone.M_r,
    A_Nod=groundDom.zone_FlTo.zoneLayout_r.nodeDim_Zone.A_z,
    h_conv=h_Co_conv,
    useRadHeatTransfer=useRadHeatTransfer_Co,
    alpha_solar=alpha_Co_solar,
    eps=eps_Co) if useCapCover "Cover surface heat transfer model" annotation (Placement(transformation(extent={{80,30},{100,50}})));

// Interfaces
  Modelica.Blocks.Interfaces.RealInput G_solar if useRadHeatTransfer_GD or useRadHeatTransfer_Co "Solar irradiation in [W/m2] (Horziontal global radiation)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,130}),  iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-16,106})));
  Modelica.Blocks.Interfaces.RealInput T_sky if useRadHeatTransfer_GD  or useRadHeatTransfer_Co "Sky temperature in [K]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,130}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={0,106})));
  Modelica.Blocks.Interfaces.RealInput T_air "Air temperature in [K]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={140,130}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={16,106})));

  Modelica.Blocks.Routing.Replicator repl_G_solar(nout=2)     if useRadHeatTransfer_GD  or useRadHeatTransfer_Co
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,90})));
  Modelica.Blocks.Routing.Replicator repl_T_sky(nout=2)     if useRadHeatTransfer_GD  or useRadHeatTransfer_Co
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={110,90})));
  Modelica.Blocks.Routing.Replicator repl_T_air(nout=2)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={140,90})));
        /*
  parameter Integer N_Co_Nod = groundDom.zone_FlTo.zoneLayout_r.nodeDim_Zone.M_r if useTopGridArea "Number of nodes at surface";
  parameter Modelica.Units.SI.Area A_Co_Nod[N_Co_Nod] = groundDom.zone_FlTo.zoneLayout_r.nodeDim_Zone.A_z if useTopGridArea
    "Surface areas of individual nodes";

  parameter Integer N_Co_Nod_wo = 1 if not useTopGridArea "Number of nodes at surface";
  parameter Modelica.Units.SI.Area A_Co_Nod_wo[N_Co_Nod]= {fluidDomDim.A_z_to} if not useTopGridArea
    "Surface areas of individual nodes";
*/
  Components.GroundDomain.SurfaceHeatTransfer.ConvRadHeatTransfer_MultipleNo heatTrans_CoverSurf_ThermRes(
    N_Nod=1,
    A_Nod={fluidDomDim.A_z_to},
    h_conv=h_Co_conv,
    useRadHeatTransfer=useRadHeatTransfer_Co,
    alpha_solar=alpha_Co_solar,
    eps=eps_Co) if not useCapCover "Cover surface heat transfer model (used when cover is only considered as thermal resistance w/o capacitance)";

equation
  connect(insExtension.heatPorts_surface, groundDom.heatPorts_Ri_to) annotation (Line(points={{132,0},{132,-12},{125.6,-12},{125.6,-12.8}},
                                                                                                                                  color={191,0,0}));
  connect(insExtension.heatPorts_amb, heatTrans_GroundSurf.heatPorts_surface) annotation (Line(points={{132,20},{132,26},{130,26},{130,30}},
                                                                                                                           color={191,0,0}));
  connect(heatTrans_CoverSurf.heatPorts_surface, groundDom.heatPorts_FlTo_to)
    annotation (Line(points={{90,30},{90,-12.8},{89.6,-12.8}},                 color={191,0,0}));
  connect(G_solar, repl_G_solar.u) annotation (Line(points={{80,130},{80,102}},                           color={0,0,127}));
  connect(T_sky, repl_T_sky.u) annotation (Line(points={{110,130},{110,102}},                  color={0,0,127}));
  connect(T_air, repl_T_air.u) annotation (Line(points={{140,130},{140,102}},                  color={0,0,127}));
  connect(repl_G_solar.y[1], heatTrans_CoverSurf.G_solar) annotation (Line(points={{80.25,79},{80.25,80},{80,80},{80,60},{84,60},{84,52}},
                                                                                                                               color={0,0,127}));
  connect(repl_T_sky.y[1], heatTrans_CoverSurf.T_sky) annotation (Line(points={{110.25,79},{110.25,80},{110,80},{110,68},{90,68},{90,52}},
                                                                                                                                 color={0,0,127}));
  connect(repl_G_solar.y[2], heatTrans_GroundSurf.G_solar) annotation (Line(points={{79.75,79},{79.75,78},{80,78},{80,72},{124,72},{124,52}},
                                                                                                                              color={0,0,127}));
  connect(repl_T_sky.y[2], heatTrans_GroundSurf.T_sky) annotation (Line(points={{109.75,79},{109.75,80},{110,80},{110,76},{130,76},{130,52}},
                                                                                                                            color={0,0,127}));
  connect(repl_T_air.y[2], heatTrans_GroundSurf.T_air) annotation (Line(points={{139.75,79},{139.75,80},{140,80},{140,60},{136,60},{136,52}},
                                                                                                                color={0,0,127}));
  connect(repl_T_air.y[1], heatTrans_CoverSurf.T_air) annotation (Line(points={{140.25,79},{140.25,78},{140,78},{140,64},{96,64},{96,52}},
                                                                                                                           color={0,0,127}));
  connect(heatTrans_CoverSurf_ThermRes.heatPorts_surface, groundDom.heatPorts_FlTo_to);
  connect(repl_G_solar.y[1], heatTrans_CoverSurf_ThermRes.G_solar);
  connect(repl_T_sky.y[1], heatTrans_CoverSurf_ThermRes.T_sky);
  connect(repl_T_air.y[1], heatTrans_CoverSurf_ThermRes.T_air);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
This is a partial model for a fully buried TTES with cylindrical fluid domain geometry and customizable ground domain.
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

</html>"),
    Diagram(coordinateSystem(extent={{-160,-120},{160,120}})));
end PartialFullyBuried_CustomGD;
