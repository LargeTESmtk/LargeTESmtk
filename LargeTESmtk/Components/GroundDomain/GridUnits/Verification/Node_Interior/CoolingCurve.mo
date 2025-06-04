within LargeTESmtk.Components.GroundDomain.GridUnits.Verification.Node_Interior;
model CoolingCurve "Verification of cooling curve according to lumped system analysis"
  extends Modelica.Icons.Example;
  extends LargeTESmtk.Utilities.TestFrameworks.TestFrameworkLayout_Verification;

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h = 10 "Heat transfer coefficient";

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou_T_amb(T(displayUnit="degC") = 283.15)
                                                                         annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));

  LargeTESmtk.Components.GroundDomain.GridUnits.Node_Interior interiorNode(T_init(displayUnit="degC") = 293.15, redeclare
      LargeTESmtk.Components.GroundDomain.MaterialProperties.Ground.GenericGround thermalProp(k=1e6))
    annotation (Placement(transformation(extent={{-30,0},{30,60}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conBot
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-10})));
  Modelica.Blocks.Sources.RealExpression G_bot(y=h*interiorNode.A_z) annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conTop
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,80})));
  Modelica.Blocks.Sources.RealExpression G_top(y=h*interiorNode.A_z) annotation (Placement(transformation(extent={{40,70},{20,90}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conLeft
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-40,30})));
  Modelica.Blocks.Sources.RealExpression G_left(y=h*interiorNode.A_r_le) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conRight
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={40,30})));
  Modelica.Blocks.Sources.RealExpression G_right(y=h*interiorNode.A_r_ri) annotation (Placement(transformation(extent={{74,0},{54,20}})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor lumpElement(C=interiorNode.C, T(start=interiorNode.T_init, fixed=true))
    annotation (Placement(transformation(extent={{-10,-72},{10,-92}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conLump
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,-50})));
  Modelica.Blocks.Sources.RealExpression G_lump(y=h*(2*interiorNode.A_z + interiorNode.A_r_le + interiorNode.A_r_ri))
    annotation (Placement(transformation(extent={{40,-60},{20,-40}})));

  Modelica.Blocks.Sources.RealExpression VC_T_Nod(y=interiorNode.T) annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  Modelica.Blocks.Sources.RealExpression VC_T_LumpElem(y=lumpElement.T) annotation (Placement(transformation(extent={{20,120},{40,140}})));
equation

  connect(lumpElement.port, conLump.solid) annotation (Line(points={{0,-72},{0,-60},{-1.77636e-15,-60}}, color={191,0,0}));
  connect(G_lump.y, conLump.Gc) annotation (Line(points={{19,-50},{10,-50}}, color={0,0,127}));
  connect(bou_T_amb.port, conLump.fluid) annotation (Line(points={{-40,-30},{1.83187e-15,-30},{1.83187e-15,-40}}, color={191,0,0}));
  connect(G_bot.y, conBot.Gc) annotation (Line(points={{19,-10},{10,-10}}, color={0,0,127}));
  connect(G_top.y, conTop.Gc) annotation (Line(points={{19,80},{10,80}}, color={0,0,127}));
  connect(conTop.fluid, bou_T_amb.port)
    annotation (Line(points={{1.83187e-15,90},{0,90},{0,94},{-80,94},{-80,0},{-20,0},{-20,-30},{-40,-30}}, color={191,0,0}));
  connect(conBot.fluid, bou_T_amb.port) annotation (Line(points={{-1.77636e-15,-20},{-1.77636e-15,-30},{-40,-30}}, color={191,0,0}));
  connect(G_left.y, conLeft.Gc) annotation (Line(points={{-49,50},{-40,50},{-40,40}}, color={0,0,127}));
  connect(conLeft.fluid, bou_T_amb.port) annotation (Line(points={{-50,30},{-80,30},{-80,0},{-20,0},{-20,-30},{-40,-30}}, color={191,0,0}));
  connect(G_right.y, conRight.Gc) annotation (Line(points={{53,10},{40,10},{40,20}}, color={0,0,127}));
  connect(conRight.fluid, bou_T_amb.port) annotation (Line(points={{50,30},{80,30},{80,-30},{-40,-30}}, color={191,0,0}));
  connect(conLeft.solid, interiorNode.heatPort_le) annotation (Line(points={{-30,30},{-10,30}},color={191,0,0}));
  connect(interiorNode.heatPort_bo, conBot.solid) annotation (Line(points={{0,20},{0,17},{0,17},{0,0}},                     color={191,0,0}));
  connect(interiorNode.heatPort_ri, conRight.solid) annotation (Line(points={{10,30},{30,30}},color={191,0,0}));
  connect(interiorNode.heatPort_to, conTop.solid) annotation (Line(points={{0,40},{0,44},{30,44},{30,64},{0,64},{0,70}}, color={191,0,0}));
  annotation (
    experiment(
      StopTime=360000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
        <p>
        Comparison against the cooling curve of a corresponding lumped element (thermal mass) according to lumped system analysis (Çengel and Ghajar, 2015, pp. 238).  
        </p>
        <h4>Verification criterion</h4>
        <p>
        The temperatures <code>VC_T_Nod</code> and <code>VC_T_LumpElem</code> must be identical.  
        </p>
        <h4>References</h4>
        <p>
        Çengel, Yunus A., and Afshin J. Ghajar.
        <i>
        Heat and Mass Transfer: Fundamentals & Applications.
        </i>
        5th ed. New York (US): McGraw-Hill Education, 2015.
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
    Diagram(coordinateSystem(extent={{-100,-160},{100,160}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end CoolingCurve;
