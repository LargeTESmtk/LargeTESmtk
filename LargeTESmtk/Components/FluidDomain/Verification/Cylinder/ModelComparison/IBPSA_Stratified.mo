within LargeTESmtk.Components.FluidDomain.Verification.Cylinder.ModelComparison;
model IBPSA_Stratified "Model comparison test case (IBPSA model)"
  extends LargeTESmtk.Components.FluidDomain.Examples.TestFrameworks.PartialTestFramework(thermColl_sid(m=1), redeclare
      LargeTESmtk.Components.FluidDomain.Verification.Cylinder.ModelComparison.Parameters.ModelParameters modelPar);

  Modelica.Blocks.Sources.RealExpression QFlow_loss_tot(y=fluidDomain.Ql_flow)
    annotation (Placement(transformation(extent={{244,52},{264,70}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_tot
    annotation (Placement(transformation(extent={{270,54},{284,68}})));
  Modelica.Blocks.Sources.RealExpression QFlow_EnBalErr(y=QFlow_ch.y + QFlow_dis.y - QFlow_loss_tot.y - dQ_int_dt)
    annotation (Placement(transformation(extent={{176,52},{196,70}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_tot_Y(use_reset=true)
    annotation (Placement(transformation(extent={{286,48},{290,52}})));
  Modelica.Blocks.Continuous.Integrator H_top
    annotation (Placement(transformation(extent={{134,124},{148,138}})));
  Modelica.Blocks.Continuous.Integrator H_bot
    annotation (Placement(transformation(extent={{134,76},{148,90}})));
  Modelica.Blocks.Sources.RealExpression HFlow_top(y=sens_HFlow_top.H_flow)
                          annotation (Placement(transformation(extent={{108,122},{128,140}})));
  Modelica.Blocks.Sources.RealExpression HFlow_bot(y=sens_HFlow_bot.H_flow)
                          annotation (Placement(transformation(extent={{108,74},{128,92}})));
  Modelica.Blocks.Sources.RealExpression QFlow_ch(y=max(HFlow_top.y + HFlow_bot.y, 0))
    annotation (Placement(transformation(extent={{176,122},{196,140}})));
  Modelica.Blocks.Sources.RealExpression QFlow_dis(y=min(HFlow_top.y + HFlow_bot.y, 0))
    annotation (Placement(transformation(extent={{176,98},{196,116}})));
  Modelica.Blocks.Continuous.Integrator Q_ch
    annotation (Placement(transformation(extent={{202,124},{216,138}})));
  Modelica.Blocks.Continuous.Integrator Q_dis
    annotation (Placement(transformation(extent={{202,100},{216,114}})));
  Modelica.Blocks.Sources.SampleTrigger     yearlyReseter(period=3600*8760)
    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={196,30})));
  Modelica.Blocks.Continuous.Integrator Q_ch_Y(use_reset=true) annotation (Placement(transformation(extent={{218,118},{222,122}})));
  Modelica.Blocks.Continuous.Integrator Q_dis_Y(use_reset=true) annotation (Placement(transformation(extent={{218,94},{222,98}})));
  Modelica.Blocks.Continuous.Integrator H_top_Y(use_reset=true) annotation (Placement(transformation(extent={{150,118},{154,122}})));
  Modelica.Blocks.Continuous.Integrator H_bot_Y(use_reset=true) annotation (Placement(transformation(extent={{150,70},{154,74}})));
  Modelica.Blocks.Sources.RealExpression dQint_dt_Block(y=dQ_int_dt) annotation (Placement(transformation(extent={{176,74},{196,92}})));
  Modelica.Blocks.Continuous.Integrator deltaQ_int_Y(use_reset=true) annotation (Placement(transformation(extent={{218,70},{222,74}})));
  Modelica.Blocks.Continuous.Integrator deltaQ_int annotation (Placement(transformation(extent={{202,76},{216,90}})));

  IBPSA.Fluid.Storage.Stratified                                     fluidDomain(
    redeclare package Medium = storageFluid,
    m_flow_nominal=m_flow_nominal,
    VTan=modelPar.r^2*Modelica.Constants.pi*modelPar.dz,
    hTan=modelPar.dz,
    dIns=1e-5,
    kIns=modelPar.U_top*fluidDomain.dIns,
    nSeg=modelPar.N_z,
    T_start=modelPar.T_init_unif,
    tau=modelPar.tau_buo)
                       annotation (Placement(transformation(extent={{-40,-40},{40,40}})));

  Modelica.Units.SI.Temperature T_fl[modelPar.N_z] = fluidDomain.vol.T "Fluid node temperatures";

  parameter Modelica.Units.SI.Temperature T_ref = modelPar.T_ref "Reference temperature for internal energy calculation";
  Modelica.Units.SI.Energy Q_int = loadProfilePar.d_fl_const*loadProfilePar.cp_fl_const*fluidDomain.vol.V*(T_fl-fill(T_ref,modelPar.N_z)) "Internal energy of fluid";
  Modelica.Units.SI.HeatFlowRate dQ_int_dt = der(Q_int) "Internal energy change of fluid (Temporal derivation of internal energy)";

equation

  connect(QFlow_loss_tot.y,Q_loss_tot. u) annotation (Line(points={{265,61},{268.6,61}},
                                               color={0,0,127}));
  connect(QFlow_loss_tot.y,Q_loss_tot_Y. u) annotation (Line(points={{265,61},{266,61},{266,50},{285.6,50}},
                                                               color={0,0,127}));
  connect(HFlow_top.y,H_top. u)
    annotation (Line(points={{129,131},{132.6,131}}, color={0,0,127}));
  connect(HFlow_bot.y,H_bot. u)
    annotation (Line(points={{129,83},{132.6,83}},   color={0,0,127}));
  connect(QFlow_ch.y,Q_ch. u)
    annotation (Line(points={{197,131},{200.6,131}}, color={0,0,127}));
  connect(QFlow_dis.y,Q_dis. u)
    annotation (Line(points={{197,107},{200.6,107}}, color={0,0,127}));
  connect(Q_loss_tot_Y.reset,yearlyReseter. y) annotation (Line(points={{289.2,47.6},{290,47.6},{290,30},{202.6,30}},
                                                                                                                    color={255,0,255}));
  connect(QFlow_ch.y,Q_ch_Y. u) annotation (Line(points={{197,131},{198,131},{198,120},{217.6,120}}, color={0,0,127}));
  connect(QFlow_dis.y,Q_dis_Y. u) annotation (Line(points={{197,107},{198,107},{198,96},{217.6,96}}, color={0,0,127}));
  connect(HFlow_top.y,H_top_Y. u) annotation (Line(points={{129,131},{129,120},{149.6,120}}, color={0,0,127}));
  connect(HFlow_bot.y,H_bot_Y. u) annotation (Line(points={{129,83},{130,83},{130,72},{149.6,72}}, color={0,0,127}));
  connect(Q_ch_Y.reset,yearlyReseter. y) annotation (Line(points={{221.2,117.6},{221.2,104},{232,104},{232,30},{202.6,30}},
                                                                                                                          color={255,0,255}));
  connect(Q_dis_Y.reset,yearlyReseter. y) annotation (Line(points={{221.2,93.6},{221.2,82},{230,82},{230,30},{202.6,30}},
                                                                                                                        color={255,0,255}));
  connect(H_top_Y.reset,yearlyReseter. y)
    annotation (Line(points={{153.2,117.6},{153.2,112},{164,112},{164,42},{218,42},{218,30},{202.6,30}},
                                                                                                       color={255,0,255}));
  connect(H_bot_Y.reset,yearlyReseter. y) annotation (Line(points={{153.2,69.6},{153.2,62},{164,62},{164,42},{212,42},{212,30},{202.6,30}},
                                                                                                                        color={255,0,255}));
  connect(dQint_dt_Block.y,deltaQ_int_Y. u) annotation (Line(points={{197,83},{217.6,83},{217.6,72}}, color={0,0,127}));
  connect(yearlyReseter.y,deltaQ_int_Y. reset)
    annotation (Line(points={{202.6,30},{222,30},{222,68},{221.2,68},{221.2,69.6}},                 color={255,0,255}));
  connect(dQint_dt_Block.y,deltaQ_int. u) annotation (Line(points={{197,83},{200.6,83}}, color={0,0,127}));

  connect(sens_HFlow_top.port_b, fluidDomain.fluPorVol[modelPar.n_InOut_top])
    annotation (Line(points={{-120,20},{-80,20},{-80,34},{-20,34},{-20,0}},
                                                                          color={0,127,255}));
  connect(sens_HFlow_bot.port_b, fluidDomain.fluPorVol[modelPar.n_InOut_bot])
    annotation (Line(points={{-120,-20},{-80,-20},{-80,-32},{-20,-32},{-20,0}},
                                                          color={0,127,255}));

  connect(bou_T_G.port, fluidDomain.heaPorBot) annotation (Line(points={{-160,-90},{8,-90},{8,-29.6}},
                                                                                                     color={191,0,0}));

  connect(bou_T_amb.port, fluidDomain.heaPorTop) annotation (Line(points={{-160,100},{8,100},{8,29.6}},
                                                                                                      color={191,0,0}));
  connect(fluidDomain.heaPorSid, thermColl_sid.port_a[1]) annotation (Line(
        points={{22.4,0},{60,0},{60,-90},{50,-90}}, color={191,0,0}));
  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"), Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end IBPSA_Stratified;
