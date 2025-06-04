within LargeTESmtk.Components.GroundDomain.GridUnits.Examples.Alternative.GridSegment_Rect_IntHeatPorts;
model SimpleBoundCond "Example model with simplified boundary conditions"
  extends Modelica.Icons.Example;

  LargeTESmtk.Components.GroundDomain.GridUnits.Alternative.GridSegment_Rect_IntHeatPorts rectangGridSeg(
    M_r=modelPar.M_r,
    reversedDir_GR_r=modelPar.reversedDir_GR_r,
    N_z=modelPar.N_z,
    reversedDir_GR_z=modelPar.reversedDir_GR_z,
    thermalProp=modelPar.thermalProp_unif,
    T_init_unif=modelPar.T_init_unif,
    T_init(each displayUnit="degC"),
    GR_r=modelPar.GR_r,
    GR_z=modelPar.GR_z,
    r_le=modelPar.r_le,
    r_ri=modelPar.r_ri,
    z_to_glo=modelPar.z_to_glo,
    z_bo_glo=modelPar.z_bo_glo) annotation (Placement(transformation(extent={{40,-60},{80,-20}})));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h = 25 "Heat transfer coefficient";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature bou_T_fl annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));

  Modelica.Thermal.HeatTransfer.Components.Convection conTop[rectangGridSeg.M_r]
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={60,10})));
  Modelica.Blocks.Sources.RealExpression G_top[rectangGridSeg.M_r](y=h*rectangGridSeg.nodes[:, 1].A_z)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_to(m=rectangGridSeg.M_r)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={8,40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_le(m=rectangGridSeg.N_z)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={10,-40})));
  Modelica.Blocks.Sources.Sine T_fl(
    amplitude=20,
    f=1/(3600*24*5),
    offset=273.15 + 70) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Sine T_amb(
    amplitude=10,
    f=1/(3600*8760),
    offset=273.15 + 15,
    startTime=-3/4*(8760*3600)) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature bou_T_amb annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  LargeTESmtk.Components.GroundDomain.GridUnits.Examples.Alternative.GridSegment_Rect_IntHeatPorts.Parameters.ModelParameters modelPar
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation

  connect(G_top.y, conTop.Gc) annotation (Line(points={{41,10},{45.5,10},{45.5,10},{50,10}},
                                                                         color={0,0,127}));
  connect(thermColl_le.port_b, bou_T_fl.port) annotation (Line(points={{0,-40},{-20,-40}}, color={191,0,0}));
  connect(conTop.solid, rectangGridSeg.heatPorts_to)
    annotation (Line(points={{60,1.77636e-15},{60,-20}},                                         color={191,0,0}));
  connect(conTop.fluid, thermColl_to.port_a)
    annotation (Line(points={{60,20},{60,40},{18,40}},                                      color={191,0,0}));
  connect(thermColl_le.port_a, rectangGridSeg.heatPorts_le) annotation (Line(points={{20,-40},{40,-40}}, color={191,0,0}));
  connect(T_fl.y, bou_T_fl.T) annotation (Line(points={{-59,-40},{-42,-40}}, color={0,0,127}));
  connect(thermColl_to.port_b, bou_T_amb.port) annotation (Line(points={{-2,40},{-20,40}}, color={191,0,0}));
  connect(T_amb.y, bou_T_amb.T) annotation (Line(points={{-59,40},{-42,40}}, color={0,0,127}));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"),
      Documentation(info="<html>

<p>
This example model demonstrates the model's application under a simplified fluid temperature profile at the left boundary surface and 
a simplified ambient temperature profile at the top surface.
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
