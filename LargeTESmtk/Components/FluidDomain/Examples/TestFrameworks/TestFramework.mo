within LargeTESmtk.Components.FluidDomain.Examples.TestFrameworks;
model TestFramework "Test framework for example models"
  extends PartialTestFramework;

  Modelica.Blocks.Sources.RealExpression QFlow_loss_bot(y=fluidDom.QFlow_loss_bot) annotation (Placement(transformation(extent={{244,76},{264,94}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_bot
    annotation (Placement(transformation(extent={{270,78},{284,92}})));
  Modelica.Blocks.Sources.RealExpression QFlow_loss_sid(y=fluidDom.QFlow_loss_sid)
    annotation (Placement(transformation(extent={{244,100},{264,118}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_sid
    annotation (Placement(transformation(extent={{270,102},{284,116}})));
  Modelica.Blocks.Sources.RealExpression QFlow_loss_top(y=fluidDom.QFlow_loss_top)
    annotation (Placement(transformation(extent={{244,124},{264,142}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_top
    annotation (Placement(transformation(extent={{270,126},{284,140}})));
  Modelica.Blocks.Sources.RealExpression QFlow_loss_tot(y=fluidDom.QFlow_loss_tot) annotation (Placement(transformation(extent={{244,52},{264,70}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_tot
    annotation (Placement(transformation(extent={{270,54},{284,68}})));
  Modelica.Blocks.Sources.RealExpression QFlow_EnBalErr(y=QFlow_ch.y - QFlow_dis.y - QFlow_loss_tot.y - dQint_dt_Block.y)
    annotation (Placement(transformation(extent={{176,52},{196,70}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_bot_Y(use_reset=true)
    annotation (Placement(transformation(extent={{286,72},{290,76}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_sid_Y(use_reset=true)
    annotation (Placement(transformation(extent={{286,96},{290,100}})));
  Modelica.Blocks.Continuous.Integrator Q_loss_top_Y(use_reset=true)
    annotation (Placement(transformation(extent={{286,120},{290,124}})));
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
  Modelica.Blocks.Sources.RealExpression QFlow_dis(y=-min(HFlow_top.y + HFlow_bot.y, 0))
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
  Modelica.Blocks.Sources.RealExpression dQint_dt_Block(y=fluidDom.dQ_int_dt) annotation (Placement(transformation(extent={{176,74},{196,92}})));
  Modelica.Blocks.Continuous.Integrator deltaQ_int_Y(use_reset=true) annotation (Placement(transformation(extent={{218,70},{222,74}})));
  Modelica.Blocks.Continuous.Integrator deltaQ_int annotation (Placement(transformation(extent={{202,76},{216,90}})));

  replaceable LargeTESmtk.Components.FluidDomain.BaseClasses.PartialFluidDomain fluidDom(
    m_flow_nominal=m_flow_nominal,
    h_top=modelPar.U_top,
    h_sid=modelPar.U_sid,
    h_bot=modelPar.U_bot,
    N_z=modelPar.N_z,
    T_init_unif=modelPar.T_init_unif,
    tau_buo=modelPar.tau_buo,
    T_ref=modelPar.T_ref) annotation (Placement(transformation(extent={{-60,-60},{60,60}})));

equation

  connect(QFlow_loss_bot.y,Q_loss_bot. u)
    annotation (Line(points={{265,85},{268.6,85}},   color={0,0,127}));
  connect(QFlow_loss_sid.y,Q_loss_sid. u)
    annotation (Line(points={{265,109},{268.6,109}}, color={0,0,127}));
  connect(QFlow_loss_top.y,Q_loss_top. u)
    annotation (Line(points={{265,133},{268.6,133}}, color={0,0,127}));
  connect(QFlow_loss_tot.y,Q_loss_tot. u) annotation (Line(points={{265,61},{268.6,61}},
                                               color={0,0,127}));
  connect(QFlow_loss_top.y,Q_loss_top_Y. u) annotation (Line(points={{265,133},{266,133},{266,122},{285.6,122}},
                                                               color={0,0,127}));
  connect(QFlow_loss_bot.y,Q_loss_bot_Y. u) annotation (Line(points={{265,85},{266,85},{266,74},{285.6,74}},
                                                               color={0,0,127}));
  connect(QFlow_loss_sid.y,Q_loss_sid_Y. u) annotation (Line(points={{265,109},{266,109},{266,98},{285.6,98}},
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
  connect(Q_loss_top_Y.reset,yearlyReseter. y)
    annotation (Line(points={{289.2,119.6},{289.2,118},{296,118},{296,30},{202.6,30}},
                                                                                     color={255,0,255}));
  connect(Q_loss_sid_Y.reset,yearlyReseter. y) annotation (Line(points={{289.2,95.6},{289.2,94},{296,94},{296,30},{202.6,30}},color={255,0,255}));
  connect(Q_loss_bot_Y.reset,yearlyReseter. y) annotation (Line(points={{289.2,71.6},{289.2,70},{296,70},{296,30},{202.6,30}},
                                                                                                                             color={255,0,255}));
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
    annotation (Line(points={{202.6,30},{222,30},{222,66},{221.2,66},{221.2,69.6}},                 color={255,0,255}));
  connect(dQint_dt_Block.y,deltaQ_int. u) annotation (Line(points={{197,83},{200.6,83}}, color={0,0,127}));

  connect(sens_HFlow_top.port_b, fluidDom.fluidPorts_Nod[modelPar.n_InOut_top])
    annotation (Line(points={{-120,20},{-80,20},{-80,14},{-16,14},{-16,0},{-15,0}}, color={0,127,255}));
  connect(sens_HFlow_bot.port_b, fluidDom.fluidPorts_Nod[modelPar.n_InOut_bot])
    annotation (Line(points={{-120,-20},{-80,-20},{-80,-14},{-16,-14},{-16,0},{-15,0}}, color={0,127,255}));

  connect(bou_T_G.port, fluidDom.heatPort_bot) annotation (Line(points={{-160,-90},{12,-90},{12,-60}}, color={191,0,0}));
  connect(thermColl_sid.port_a, fluidDom.heatPorts_sid) annotation (Line(points={{50,-90},{70,-90},{70,0},{60,0}}, color={191,0,0}));

  connect(bou_T_amb.port, fluidDom.heatPort_top) annotation (Line(points={{-160,100},{12,100},{12,60}}, color={191,0,0}));
  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"),
                                   Documentation(info="<html>

<p>
This model provides a common framework for building the correspoding test cases for the example/testing models. 
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
end TestFramework;
