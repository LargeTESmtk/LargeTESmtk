within LargeTESmtk.Components.FluidDomain.BaseClasses;
model PartialFluidDomain "Partial fluid domain model"
/* Diff
  /* Orig: 
    extends IBPSA.Fluid.Storage.BaseClasses.PartialTwoPortInterface;
  /* Mod: */
    extends IBPSA.Fluid.Storage.BaseClasses.PartialTwoPortInterface(redeclare final package Medium = storageMedium);
    replaceable package storageMedium =
      Modelica.Media.Interfaces.PartialMedium "Storage medium"
        annotation (choices(
          choice(redeclare package storageMedium =
          LargeTESmtk.Components.FluidDomain.StorageMedia.Water_ConstProp
        "Water w/ constant properties")),
          Dialog(group="Storage medium properties"));

/* Diff
  /* Orig: 
    parameter Modelica.Units.SI.Volume VTan "Tank volume";
    parameter Modelica.Units.SI.Length hTan "Height of tank (without insulation)";
  /* Mod: */
  replaceable parameter LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim.PartialSegDim fluidDomDim(
    z_to_glo(fixed=true),
    dz(fixed=true),
    final z_to_glo_TopNode=fluidDomDim.z_to_glo) "Fluid domain dimensions" annotation (Dialog(group="Dimensions"));
  replaceable parameter LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim.PartialSegDim nodeDim[N_z](each z_to_glo_TopNode=fluidDomDim.z_to_glo_TopNode)
    "Fluid node dimensions";

/* Diff
  /* Orig: 
    parameter Modelica.Units.SI.Length dIns "Thickness of insulation";
    parameter Modelica.Units.SI.ThermalConductivity kIns=0.04
      "Specific heat conductivity of insulation";
  /* Mod: */
    parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_top = 1000
      "Heat transfer coefficent (HTC) at top boundary surface (inner convective HTC or overall HTC, depending on consideration of cover structure)"
      annotation (Dialog(group="Heat transfer"));
    parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_sid = 75
      "Heat transfer coefficent (HTC) at side boundary surface (inner convective HTC or overall HTC, depending on consideration of side wall structure)"
      annotation (Dialog(group="Heat transfer"));
    parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_bot = 75
      "Heat transfer coefficent (HTC) at bottom boundary surface (inner convective HTC or overall HTC, depending on consideration of bottom structure)"
      annotation (Dialog(group="Heat transfer"));

/* Diff
  /* Orig: 
    parameter Integer nSeg(min=2) = 2 "Number of volume segments";
  /* Mod: */
    parameter Integer N_z(min=2) = 10 "Number of (axial) nodes" annotation (Dialog(group="Grid parameters"));

  ////////////////////////////////////////////////////////////////////
  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Formulation of energy balance"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Conservation equations"));

  // Initialization
  parameter Medium.AbsolutePressure p_start = Medium.p_default
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization"));

/* Diff
  /* Orig: 
    parameter Medium.Temperature T_start=Medium.T_default
      "Start value of temperature"
      annotation(Dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.Temperature TFlu_start[nSeg]=T_start*ones(nSeg)
      "Initial temperature of the tank segments, with TFlu_start[1] being the top segment"
      annotation (Dialog(tab="Initialization"));
  /* Mod: */
    parameter Medium.Temperature T_init_unif = Medium.T_default
      "Uniform initial temperature for all nodes"
      annotation(Dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.Temperature T_init[N_z] = T_init_unif*ones(N_z)
      "Individual initial temperature for each node, with T_init[1] being the top node"
      annotation (Dialog(tab="Initialization"));

  parameter Medium.MassFraction X_start[Medium.nX] = Medium.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Start value of trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

  // Dynamics
/* Diff
  /* Orig: 
    parameter Modelica.Units.SI.Time tau=1 "Time constant for mixing";
  /* Mod: */
    parameter Modelica.Units.SI.Time tau_buo = 1
      "Time constant of buoyancy model (determines how fast the temperature compensation between adjacent fluid layers occurs)"
      annotation (Dialog(group="Buoyancy model"));

  ////////////////////////////////////////////////////////////////////
  // Connectors

/* Diff
  /* Orig: 
    Modelica.Blocks.Interfaces.RealOutput Ql_flow
      "Heat loss of tank (positive if heat flows from tank to ambient)"
      annotation (Placement(transformation(extent={{100,62},{120,82}})));
  /* Mod: */
    Modelica.Units.SI.HeatFlowRate QFlow_loss_tot = QFlow_loss_top+QFlow_loss_sid+QFlow_loss_bot
      "Total thermal losses (positive, if heat flow direction from fluid to surroundings)";
    Modelica.Units.SI.HeatFlowRate QFlow_loss_top = sens_QFlow_top.Q_flow
      "Thermal losses through top fluid boundary surface (positive, if heat flow direction from fluid to surroundings)";
    Modelica.Units.SI.HeatFlowRate QFlow_loss_sid = sum(sens_QFlow_sid.Q_flow)
      "Thermal losses through side fluid boundary surface (positive, if heat flow direction from fluid to surroundings)";
    Modelica.Units.SI.HeatFlowRate QFlow_loss_bot = sens_QFlow_bot.Q_flow
      "Thermal losses through bottom fluid boundary surface (positive, if heat flow direction from fluid to surroundings)";

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSeg] heaPorVol
      "Heat port that connects to the control volumes of the tank"
      annotation (Placement(transformation(extent={{-6,-6},{6,6}})));
  /* Mod: */
    Modelica.Fluid.Interfaces.HeatPorts_a[N_z] heatPorts_Nod "Heat ports directly connected to individual fluid nodes"
      annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-10,16}), iconTransformation(
        extent={{0,0},{40,10}},
        rotation=90,
        origin={30,-20})));

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorSid
      "Heat port tank side (outside insulation)"
      annotation (Placement(transformation(extent={{50,-6},{62,6}})));
  /* Mod: */
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_sid[N_z]
      "Heat ports at lateral fluid domain boundary surface
      (outside inner convective HTC or overall HTC, depending on consideration of side wall structure)"
      annotation (Placement(transformation(extent={{50,-6},{62,6}}), iconTransformation(extent={{94,-6},{106,6}})));

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorTop
      "Heat port tank top (outside insulation)"
      annotation (Placement(transformation(extent={{14,68},{26,80}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorBot
      "Heat port tank bottom (outside insulation). Leave unconnected for adiabatic condition"
      annotation (Placement(transformation(extent={{14,-80},{26,-68}})));
  /* Mod: */
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_top
      "Heat port at top fluid domain boundary surface
      (outside inner convective HTC or overall HTC, depending on consideration of cover structure)"
      annotation (Placement(transformation(extent={{14,68},{26,80}}), iconTransformation(extent={{14,94},{26,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_bot
      "Heat port at bottom fluid domain boundary surface
      (outside inner convective HTC or overall HTC, depending on consideration of bottom structure)"
      annotation (Placement(transformation(extent={{14,-80},{26,-68}}), iconTransformation(extent={{14,-106},{26,-94}})));

  // Models

/* Diff
  /* Orig: 
    IBPSA.Fluid.MixingVolumes.MixingVolume[nSeg] vol(
      redeclare each package Medium = Medium,
      each energyDynamics=energyDynamics,
      each massDynamics=energyDynamics,
      each p_start=p_start,
      T_start=TFlu_start,
      each X_start=X_start,
      each C_start=C_start,
      each V=VTan/nSeg,
      each m_flow_nominal=m_flow_nominal,
      each final mSenFac=1,
      each final m_flow_small=m_flow_small,
      each final allowFlowReversal=allowFlowReversal) "Tank segment"
      annotation (Placement(transformation(extent={{6,-16},{26,4}})));
  /* Mod: */
    IBPSA.Fluid.MixingVolumes.MixingVolume[N_z] vol(
      redeclare each package Medium = Medium,
      each energyDynamics=energyDynamics,
      each massDynamics=energyDynamics,
      each p_start=p_start,
      T_start=T_init,
      each X_start=X_start,
      each C_start=C_start,
      V=nodeDim.V,
      each m_flow_nominal=m_flow_nominal,
      each final mSenFac=1,
      each final m_flow_small=m_flow_small,
      each final allowFlowReversal=allowFlowReversal,
      each nPorts=3) "Fluid node volumes"
      annotation (Placement(transformation(extent={{6,-16},{26,4}})));
      // Modifier 'each nPorts=3' was originally included in the higher-level "Stratified" model

/* Diff
  /* Orig: 
    protected 
  /* Mod: */
    // Removed

/* Diff
  /* Orig: 
    parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  /* Mod: */
    final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";

/* Diff
  /* Orig: 
    parameter Modelica.Units.SI.Length hSeg=hTan/nSeg "Height of a tank segment";
    parameter Modelica.Units.SI.Area ATan=VTan/hTan
      "Tank cross-sectional area (without insulation)";
    parameter Modelica.Units.SI.Length rTan=sqrt(ATan/Modelica.Constants.pi)
      "Tank diameter (without insulation)";
  /* Mod: */
    // Removed

/* Diff
  /* Orig: 
    parameter Modelica.Units.SI.ThermalConductance conFluSeg=ATan*
        Medium.thermalConductivity(sta_default)/hSeg
      "Thermal conductance between fluid volumes";
  /* Mod: */
    final parameter Modelica.Units.SI.ThermalConductance G_fl[N_z-1]=
      {nodeDim[n].A_z_bo*Medium.thermalConductivity(sta_default)/(nodeDim[n+1].z_glo-nodeDim[n].z_glo) for n in 1:N_z-1}
      "Thermal conductance between adjacent fluid nodes";

/* Diff
  /* Orig: 
    parameter Modelica.Units.SI.ThermalConductance conTopSeg=ATan*kIns/dIns
      "Thermal conductance from center of top (or bottom) volume through tank insulation at top (or bottom)";
  /* Mod: */
    final parameter Modelica.Units.SI.ThermalConductance G_top = nodeDim[1].A_z_to*h_top
      "Thermal conductance value at top boundary surface";
    final parameter Modelica.Units.SI.ThermalConductance G_sid[N_z] = nodeDim.A_r*h_sid
      "Thermal conductance values at lateral boundary surface";
    final parameter Modelica.Units.SI.ThermalConductance G_bot = nodeDim[end].A_z_bo*h_bot
      "Thermal conductance value at bottom boundary surface";

/* Diff
  /* Orig: 
    IBPSA.Fluid.Storage.BaseClasses.Buoyancy buo(
      redeclare final package Medium = Medium,
      final V=VTan,
      final nSeg=nSeg,
      final tau=tau) "Model to prevent unstable tank stratification" annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  /* Mod: */
  LargeTESmtk.Components.FluidDomain.BaseClasses.Buoyancy buo(
    redeclare final package Medium = Medium,
    final V=nodeDim.V,
    final nSeg=N_z,
    final tau=tau_buo) "Buoyancy model" annotation (Placement(transformation(extent={{-60,50},{-40,70}})));

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor[nSeg - 1] conFlu(
      each G=conFluSeg) "Thermal conductance in fluid between the segments"
      annotation (Placement(transformation(extent={{-56,4},{-42,18}})));
  /* Mod: */
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor[N_z - 1] con_fl(
      G=G_fl) "Thermal conductor between fluid nodes"
      annotation (Placement(transformation(extent={{-56,4},{-42,18}})));

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor[nSeg] conWal(
       each G=2*Modelica.Constants.pi*kIns*hSeg/Modelica.Math.log((rTan+dIns)/rTan))
      "Thermal conductance through tank wall"
      annotation (Placement(transformation(extent={{10,34},{20,46}})));
  /* Mod: */
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor[N_z] con_sid(G=G_sid)
      "Thermal conductors at lateral boundary surface"
      annotation (Placement(transformation(extent={{10,34},{20,46}})));

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor conTop(
       G=conTopSeg) "Thermal conductance through tank top"
      annotation (Placement(transformation(extent={{10,54},{20,66}})));  
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor conBot(
       G=conTopSeg) "Thermal conductance through tank bottom"
      annotation (Placement(transformation(extent={{10,14},{20,26}})));
  /* Mod: */
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_top(
       G=G_top) "Thermal conductor at top boundary surface"
      annotation (Placement(transformation(extent={{10,54},{20,66}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_bot(
       G=G_bot) "Thermal conductor at bottom boundary surface"
      annotation (Placement(transformation(extent={{10,14},{20,26}})));

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloTop
      "Heat flow at top of tank (outside insulation)"
      annotation (Placement(transformation(extent={{30,54},{42,66}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloBot
      "Heat flow at bottom of tank (outside insulation)"
      annotation (Placement(transformation(extent={{30,14},{42,26}})));
  /* Mod: */
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor sens_QFlow_top
      "Heat flow sensor at top fluid domain boundary surface
      (outside inner convective HTC or overall HTC, depending on consideration of cover structure)"
      annotation (Placement(transformation(extent={{30,54},{42,66}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor sens_QFlow_bot
      "Heat flow sensor at bottom fluid domain boundary surface
      (outside inner convective HTC or overall HTC, depending on consideration of bottom structure)"
      annotation (Placement(transformation(extent={{30,14},{42,26}})));

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloSid[nSeg]
      "Heat flow at wall of tank (outside insulation)"
      annotation (Placement(transformation(extent={{30,34},{42,46}})));
  /* Mod: */
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor sens_QFlow_sid[N_z]
      "Heat flow sensors at lateral fluid domain boundary surface
      (outside inner convective HTC or overall HTC, depending on consideration of side wall structure)"
      annotation (Placement(transformation(extent={{30,34},{42,46}})));

/* Diff
  /* Orig: 
    Modelica.Blocks.Routing.Multiplex3 mul(
      n1=1,
      n2=nSeg,
      n3=1) "Multiplex to collect heat flow rates"
      annotation (Placement(transformation(extent={{62,44},{70,54}})));
    Modelica.Blocks.Math.Sum sum1(nin=nSeg + 2)
    annotation (Placement(transformation(extent={{78,42},{90,56}})));
  /* Mod: */
    // Removed

/* Diff
  /* Orig: 
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector theCol(m=nSeg)
      "Connector to assign multiple heat ports to one heat port"
      annotation (Placement(transformation(extent={{46,20},{58,32}})));
  /* Mod: */
    // Removed

/* Diff
  /* Orig: 
    // Was originally included in the higher-level "Stratified" model
  /* Mod: */
    Modelica.Fluid.Interfaces.FluidPorts_a fluidPorts_Nod[N_z](
      redeclare each final package Medium = Medium) "Fluid ports connected to individual fluid nodes (to be used as inlet/outlet ports)"
      annotation (Placement(transformation(extent={{-110,-40},{-90,40}}),
          iconTransformation(extent={{-30,-20},{-20,20}})));

/* Diff
  /* Orig: 
    // Not included in original model
    /* Mod: */
      Modelica.Units.SI.SpecificHeatCapacity cp_fl = Medium.specificHeatCapacityCp(sta_default) "Specific heat capacity of storage fluid";
      Modelica.Units.SI.Density d_fl = Medium.density(sta_default) "Density of storage fluid";
      Modelica.Units.SI.ThermalConductivity k_fl = Medium.thermalConductivity(sta_default) "Thermal conductivity of storage fluid";

      Modelica.Units.SI.Temperature T_fl[N_z] = vol.T "Fluid node temperatures";

      parameter Modelica.Units.SI.Temperature T_ref = 273.15+10
        "Reference temperature for internal energy (Q_int) calculation" annotation (Dialog(tab="Results"));
      Modelica.Units.SI.Energy Q_int = d_fl*cp_fl*nodeDim.V*(T_fl-fill(T_ref,N_z)) "Internal energy of fluid";
      Modelica.Units.SI.HeatFlowRate dQ_int_dt = der(Q_int) "Internal energy change of fluid (Temporal derivation of internal energy)";

/* Diff
  /* Orig: 
    // Not required in original model
  /* Mod: */
initial equation
      nodeDim[1].z_to_glo = fluidDomDim.z_to_glo;
      nodeDim[end].z_bo_glo = fluidDomDim.z_bo_glo;
      for n in 2:N_z loop
        nodeDim[n].z_to_glo = nodeDim[n-1].z_to_glo+fluidDomDim.dz/N_z;
        nodeDim[n-1].z_bo_glo = nodeDim[n].z_to_glo;
      end for;

equation
  connect(buo.heatPort, vol.heatPort)    annotation (Line(
      points={{-40,60},{6,60},{6,-6}},
      color={191,0,0}));

/* Diff
  /* Orig: 
    for i in 1:nSeg-1 loop
    // heat conduction between fluid nodes
      connect(vol[i].heatPort, conFlu[i].port_a)    annotation (Line(points={{6,-6},{
              6,-6},{-60,-6},{-60,10},{-56,10},{-56,11}},    color={191,0,0}));
      connect(vol[i+1].heatPort, conFlu[i].port_b)    annotation (Line(points={{6,-6},{
              -40,-6},{-40,11},{-42,11}},  color={191,0,0}));
    end for;
    connect(vol[1].heatPort, conTop.port_a)    annotation (Line(points={{6,-6},{6,
            60},{-4,60},{10,60}},              color={191,0,0}));
    connect(vol.heatPort, conWal.port_a)    annotation (Line(points={{6,-6},{6,40},
    {10,40}},                      color={191,0,0}));
    connect(conBot.port_a, vol[nSeg].heatPort)    annotation (Line(points={{10,20},
    {10,20},{6,20},{6,-6}},color={191,0,0}));   
  /* Mod: */
    for i in 1:N_z-1 loop
    // heat conduction between fluid nodes
      connect(vol[i].heatPort, con_fl[i].port_a)    annotation (Line(points={{6,-6},{-60,-6},{-60,10},{-56,10},{-56,11}},
                                                             color={191,0,0}));
      connect(vol[i+1].heatPort, con_fl[i].port_b)    annotation (Line(points={{6,-6},{
              -40,-6},{-40,11},{-42,11}},  color={191,0,0}));
    end for;
    connect(vol[1].heatPort, con_top.port_a)    annotation (Line(points={{6,-6},{6,60},{10,60}}, color={191,0,0}));
    connect(vol.heatPort, con_sid.port_a)    annotation (Line(points={{6,-6},{6,40},
          {10,40}},                      color={191,0,0}));
    connect(con_bot.port_a, vol[N_z].heatPort)    annotation (Line(points={{10,20},
            {10,20},{6,20},{6,-6}},
                                 color={191,0,0}));

/* Diff
  /* Orig: 
    connect(vol.heatPort, heaPorVol)    annotation (Line(points={{6,-6},{6,-6},{
        -2.22045e-16,-6},{-2.22045e-16,-2.22045e-16}},
      color={191,0,0}));
  /* Mod: */
    connect(vol.heatPort, heatPorts_Nod)    annotation (Line(points={{6,-6},{-10,-6},{-10,16}},       color={191,0,0}));

/* Diff
  /* Orig: 
    connect(conWal.port_b, heaFloSid.port_a)
      annotation (Line(points={{20,40},{30,40}}, color={191,0,0}));
    connect(conTop.port_b, heaFloTop.port_a)
      annotation (Line(points={{20,60},{30,60}}, color={191,0,0}));
    connect(conBot.port_b, heaFloBot.port_a)
      annotation (Line(points={{20,20},{30,20}}, color={191,0,0}));
  /* Mod: */
  connect(con_top.port_b, sens_QFlow_top.port_a)
    annotation (Line(points={{20,60},{30,60}}, color={191,0,0}));
  connect(con_sid.port_b, sens_QFlow_sid.port_a)
    annotation (Line(points={{20,40},{30,40}}, color={191,0,0}));
  connect(con_bot.port_b, sens_QFlow_bot.port_a)
    annotation (Line(points={{20,20},{30,20}}, color={191,0,0}));

/* Diff
  /* Orig: 
    connect(heaFloTop.port_b, heaPorTop) annotation (Line(points={{42,60},{52,60},
    {52,74},{20,74}}, color={191,0,0}));
     connect(heaFloBot.port_b, heaPorBot) annotation (Line(points={{42,20},{44,20},
          {44,-74},{20,-74}}, color={191,0,0}));
  /* Mod: */
  connect(sens_QFlow_top.port_b, heatPort_top) annotation (Line(points={{42,60},{52,60},
          {52,74},{20,74}}, color={191,0,0}));
  connect(sens_QFlow_bot.port_b, heatPort_bot) annotation (Line(points={{42,20},{44,20},
          {44,-74},{20,-74}}, color={191,0,0}));

/* Diff
  /* Orig: 
    connect(heaFloTop.Q_flow, mul.u1[1]) annotation (Line(points={{36,53.4},{50,53.4},
            {50,52.5},{61.2,52.5}}, color={0,0,127}));
    connect(heaFloSid.Q_flow, mul.u2) annotation (Line(points={{36,33.4},{50,33.4},
            {50,49},{61.2,49}},color={0,0,127}));
    connect(heaFloBot.Q_flow, mul.u3[1]) annotation (Line(points={{36,13.4},{36,10},
            {58,10},{58,45.5},{61.2,45.5}}, color={0,0,127}));
    connect(mul.y, sum1.u) annotation (Line(points={{70.4,49},{76.8,49}}, color={
            0,0,127}));
    connect(sum1.y, Ql_flow) annotation (Line(points={{90.6,49},{98,49},{98,72},{
            110,72}}, color={0,0,127}));
  /* Mod: */
    // Removed

/* Diff
  /* Orig: 
    connect(heaFloSid.port_b, theCol.port_a) annotation (Line(
        points={{42,40},{52,40},{52,32}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(theCol.port_b, heaPorSid) annotation (Line(
        points={{52,20},{52,-2.22045e-16},{56,-2.22045e-16}},
        color={191,0,0},
        smooth=Smooth.None));
  /* Mod: */
      connect(sens_QFlow_sid.port_b, heatPorts_sid) annotation (Line(points={{42,40},{56,40},{56,0}}, color={191,0,0}));

/* Diff
  /* Orig: 
    //This was originally included in the higher-level "Stratified" model
    connect(port_a, vol[1].ports[1]) annotation (Line(points={{0,100},{-80,100},{-80,-20},{16,-20},{16,-16}},
                                         color={0,127,255}));
    connect(vol[nSeg].ports[2], port_b) annotation (Line(points={{16,-16},{20,-16},{20,-20},{90,-20},{90,-100},{0,-100}},
                                               color={0,127,255}));
    for i in 1:(nSeg-1) loop
      connect(vol[i].ports[2], vol[i + 1].ports[1]) annotation (Line(points={{16,-16},
              {16,-32},{14,-32},{14,-16},{16,-16}}, color={0,127,255}));
    end for;
    for i in 1:nSeg loop
      connect(fluPorVol[i], vol[i].ports[3]) annotation (Line(points={{-100,0},{
              -88,0},{-88,-36},{16,-36},{16,-16}},
                                color={0,127,255}));
    end for;
  /* Mod: */
    connect(port_a, vol[1].ports[1]) annotation (Line(points={{0,100},{-80,100},{-80,-20},{14.6667,-20},{14.6667,-16}},
                                         color={0,127,255}));
    connect(vol[N_z].ports[2], port_b) annotation (Line(points={{16,-16},{20,-16},{20,-20},{90,-20},{90,-100},{0,-100}},
                                               color={0,127,255}));
    for n in 1:(N_z-1) loop
      connect(vol[n].ports[2], vol[n + 1].ports[1]) annotation (Line(points={{16,-16},{16,-32},{14,-32},{14,-16},{14.6667,-16}},
                                                    color={0,127,255}));
    end for;
    for n in 1:N_z loop
      connect(fluidPorts_Nod[n], vol[n].ports[3]) annotation (Line(points={{-100,0},{-88,0},{-88,-36},{17.3333,-36},{17.3333,-16}},
                                color={0,127,255}));
    end for;

  annotation (
Documentation(info="<html>

<p>
This is a partial model that can be used as base class for different fluid domain geometries.
</p>

<h4>Nominal Mass Flow Rate</h4>
<code>m_flow_nominal</code> is used to calculate <code>m_flow_small=1E-4*abs(m_flow_nominal)</code> by default. 
<code>m_flow_small</code> is used to improve the numerical properties of the model at small mass flow rates. 
For more details see 'Nominal values' section in <a href=\"https://build.openmodelica.org/Documentation/IBPSA.Fluid.UsersGuide\">
IBPSA.Fluid.UsersGuide</a>.

<p>
<em>[Further model documentation to be added.]</em>
</p>

<h4>Original Model</h4>
<p>
This model is based on the <code>IBPSA.Fluid.Storage.BaseClasses.PartialStratified</code> model of the Modelica 
<a href=\"https://github.com/ibpsa/modelica-ibpsa/\">IBPSA</a> library.
</p>                

<p>
<strong>Version:</strong> <code>4.0.0 (dev status)</code>  <br>
<strong>Branch:</strong> <code>master</code>  <br>
<strong>Commit:</strong> <a href=\"https://github.com/ibpsa/modelica-ibpsa/commit/e6de2f3eb075d20452092441f78ee36adfaf5824\">e6de2f3</a> <br>
<strong>Date:</strong> <code>2025-02-16</code>  <br>
</p>

<p>
Changes to the original code have been highlighted in the updated code.
</p> 

<h5>Third Party License</h5>
<p>
Modelica IBPSA Library. Copyright (c) 1998-2022
Modelica Association,
International Building Performance Simulation Association (IBPSA) and
contributors.
All rights reserved.
</p>
<p>
Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
</p>
<ol>
<li>
Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.
</li>
<li>
Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.
</li>
<li>
Neither the name of the copyright holder nor the names of its contributors may be used
to endorse or promote products derived from this software
without specific prior written permission.
</li>
</ol>
<p>
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
</p>
<p>
You are under no obligation whatsoever to provide any bug fixes, patches,
or upgrades to the features, functionality or performance of the source code
(\"Enhancements\") to anyone; however, if you choose to make your Enhancements
available either publicly, or directly to its copyright holders,
without imposing a separate written license agreement for such
Enhancements, then you hereby grant the following license: a non-exclusive,
royalty-free perpetual license to install, use, modify, prepare derivative
works, incorporate into other computer software, distribute, and sublicense
such enhancements or derivative works thereof, in binary and source code form.
</p>
<p>
Note: The license is a revised 3 clause BSD license with an ADDED paragraph
at the end that makes it easy to accept improvements.
</p>

<h4>Acknowledgment</h4>
<p>
Many thanks to the authors of the original model for sharing their valuable work. 
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

</html>"), Icon(graphics={Text(
          extent={{-150,150},{150,110}},
          lineColor={0,0,255},
          fontName="Times New Roman",
          textString="%name")}));
end PartialFluidDomain;
