within LargeTESmtk.Utilities.TestFrameworks;
model PartialTestFramework_LoadProfile_Simple "Partial model adding simple load profile to framework"
//   extends Giga_TES.LargeTESmtk.Utilities.TestFrameworks.PartialTestFramework_BoundCond_Simple_v4_0_0_int;

  package storageFluid = LargeTESmtk.Components.FluidDomain.StorageMedia.Water_ConstProp(
    d_const=loadProfilePar.d_fl_const,
    cp_const=loadProfilePar.cp_fl_const,
    lambda_const=loadProfilePar.k_fl_const) "Medium model of storage fluid";

/*
  Modelica.Units.SI.SpecificHeatCapacity cp_fl_ctr = storageFluid.cp_const "Specific heat capacity of storage fluid (to control propagation)";
  Modelica.Units.SI.Density d_fl_ctr = storageFluid.d_const "Density of storage fluid (to control propagation)";
  Modelica.Units.SI.ThermalConductivity k_fl_ctr = storageFluid.lambda_const "Thermal conductivity of storage fluid (to control propagation)";
*/

  replaceable parameter LargeTESmtk.Utilities.TestFrameworks.PartialParRecords.PartialSimpleLoadProfilePar loadProfilePar
    annotation (Placement(transformation(extent={{140,-80},{180,-40}})));

  SimpleLoadProfile sou_LoadProfile_simple(
    T_ch_in=loadProfilePar.T_ch_in,
    T_dis_in=loadProfilePar.T_dis_in,
    VFlow_ch_in=loadProfilePar.VFlow_ch_in,
    VFlow_dis_in=loadProfilePar.VFlow_dis_in,
    t_ch=loadProfilePar.t_ch,
    t_store=loadProfilePar.t_store,
    t_dis=loadProfilePar.t_dis,
    t_idle=loadProfilePar.t_idle,
    t_ch_start=loadProfilePar.t_ch_start) annotation (Placement(transformation(extent={{-280,-30},{-260,-10}})));
  IBPSA.Fluid.Sources.MassFlowSource_T bou_InOutlet_top(
    redeclare package Medium = storageFluid,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    m_flow=0,
    T=333.15) annotation (Placement(transformation(extent={{-200,10},{-180,30}})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort    sens_T_top(redeclare package Medium =
        storageFluid,
    m_flow_nominal=m_flow_nominal,
    tau=0)
    annotation (Placement(transformation(extent={{-168,12},{-152,28}})));
  IBPSA.Fluid.Sensors.EnthalpyFlowRate sens_HFlow_top(redeclare package Medium =
               storageFluid, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  IBPSA.Fluid.Sources.Boundary_pT bou_InOutlet_bot(
    redeclare package Medium = storageFluid,
    use_T_in=true,
    nPorts=1,
    T=333.15) annotation (Placement(transformation(extent={{-200,-30},{-180,-10}})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort    sens_T_bot(redeclare package Medium =
        storageFluid,
    m_flow_nominal=m_flow_nominal,
    tau=0)
    annotation (Placement(transformation(extent={{-168,-28},{-152,-12}})));
  IBPSA.Fluid.Sensors.EnthalpyFlowRate sens_HFlow_bot(redeclare package Medium =
               storageFluid, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));

  Modelica.Blocks.Math.Gain m3ps_to_kgps(k=storageFluid.d_const) annotation (Placement(transformation(extent={{-234,-4},{-226,4}})));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal = storageFluid.d_const*loadProfilePar.VFlow_ch_in
    "Nominal mass flow rate, used for regularization near zero flow";

equation

  connect(bou_InOutlet_top.ports[1], sens_T_top.port_a) annotation (Line(points={{-180,20},{-168,20}},   color={0,127,255}));
  connect(sens_T_top.port_b, sens_HFlow_top.port_a)
    annotation (Line(points={{-152,20},{-140,20}},   color={0,127,255}));
  connect(bou_InOutlet_bot.ports[1], sens_T_bot.port_a) annotation (Line(points={{-180,-20},{-168,-20}},   color={0,127,255}));
  connect(sens_T_bot.port_b, sens_HFlow_bot.port_a)
    annotation (Line(points={{-152,-20},{-140,-20}}, color={0,127,255}));

  connect(sou_LoadProfile_simple.y[1], m3ps_to_kgps.u)
    annotation (Line(points={{-259,-20},{-240,-20},{-240,0},{-234.8,0}},         color={0,0,127}));
  connect(sou_LoadProfile_simple.y[2], bou_InOutlet_top.T_in)
    annotation (Line(points={{-259,-20},{-210,-20},{-210,24},{-202,24}},     color={0,0,127}));
  connect(sou_LoadProfile_simple.y[3], bou_InOutlet_bot.T_in)
    annotation (Line(points={{-259,-20},{-210,-20},{-210,-16},{-202,-16}},     color={0,0,127}));
  if loadProfilePar.useLoadProfileFromFile then
  else
    connect(bou_InOutlet_top.m_flow_in, m3ps_to_kgps.y) annotation (Line(points={{-202,28},{-220,28},{-220,0},{-225.6,0}},         color={0,0,127}));
  end if;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,-160},{300,160}})),
    experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>

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
end PartialTestFramework_LoadProfile_Simple;
