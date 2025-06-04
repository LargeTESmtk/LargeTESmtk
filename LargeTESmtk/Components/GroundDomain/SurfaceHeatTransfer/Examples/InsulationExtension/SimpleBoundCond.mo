within LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.Examples.InsulationExtension;
model SimpleBoundCond "Cover insulation extension model under simplified boundary conditions"
  extends Modelica.Icons.Example;

  LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.InsulationExtension insExtension(M_InsExt_r=3)
    annotation (Placement(transformation(extent={{-24,-10},{16,30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tempBou_T_surf(T=313.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-90})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_surf(m=insExtension.M_Nod_r)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.ConvRadHeatTransfer_MultipleNo convRadHeatTransfer(
    N_Nod=insExtension.M_Nod_r,
    A_Nod=insExtension.A_Nod,
    useRadHeatTransfer=false) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression T_air(y=273.15 + 30)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,90})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor sens_QFlow
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-60})));
equation
  connect(insExtension.heatPorts_surface, thermColl_surf.port_a) annotation (Line(points={{0,-10},{0,-20}}, color={191,0,0}));
  connect(convRadHeatTransfer.heatPorts_surface, insExtension.heatPorts_amb) annotation (Line(points={{0,40},{0,30}},color={191,0,0}));
  connect(T_air.y, convRadHeatTransfer.T_air) annotation (Line(points={{0,79},{0,70},{6,70},{6,62}},                       color={0,0,127}));
  connect(sens_QFlow.port_b, tempBou_T_surf.port)
    annotation (Line(points={{-6.10623e-16,-70},{-6.10623e-16,-75},{5.55112e-16,-75},{5.55112e-16,-80}}, color={191,0,0}));
  connect(sens_QFlow.port_a, thermColl_surf.port_b) annotation (Line(points={{6.10623e-16,-50},{6.10623e-16,-40},{0,-40}}, color={191,0,0}));
  annotation (Documentation(info="<html>

<p>
This example model demonstrates the use of the <a href=\"modelica://LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.InsulationExtension\">InsulationExtension</a> model 
together with the <a href=\"modelica://LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.ConvRadHeatTransfer_MultipleNo\">ConvRadHeatTransfer_MultipleNo</a> model under simplified boundary 
conditions without consideration of the storage model.
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
end SimpleBoundCond;
