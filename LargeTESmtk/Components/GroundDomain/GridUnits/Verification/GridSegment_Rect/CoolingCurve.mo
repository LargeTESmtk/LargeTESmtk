within LargeTESmtk.Components.GroundDomain.GridUnits.Verification.GridSegment_Rect;
model CoolingCurve "Verification of cooling curve according to lumped system analysis"
  extends Modelica.Icons.Example;
  extends LargeTESmtk.Utilities.TestFrameworks.TestFrameworkLayout_Verification;

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h = 10 "Heat transfer coefficient";

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou_T_amb(T=283.15)
                                                                         annotation (Placement(transformation(extent={{-100,-54},{-80,-34}})));

  LargeTESmtk.Components.GroundDomain.GridUnits.GridSegment_Rect rectangGridSeg(
    T_init_unif=293.15,
    T_init(each displayUnit="degC"),
    redeclare LargeTESmtk.Components.GroundDomain.MaterialProperties.Ground.GenericGround thermalProp(k=1e6),
    r_le=1,
    r_ri=2,
    z_to_glo=10,
    z_bo_glo=11) annotation (Placement(transformation(extent={{-20,10},{20,50}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conBot[rectangGridSeg.M_r]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-8})));
  Modelica.Blocks.Sources.RealExpression G_bot[rectangGridSeg.M_r](y=h*rectangGridSeg.nodes[:, end].A_z)
    annotation (Placement(transformation(extent={{40,-18},{20,2}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conTop[rectangGridSeg.M_r]
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,76})));
  Modelica.Blocks.Sources.RealExpression G_top[rectangGridSeg.M_r](y=h*rectangGridSeg.nodes[:, 1].A_z)
    annotation (Placement(transformation(extent={{40,66},{20,86}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conLeft[rectangGridSeg.N_z]
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-40,30})));
  Modelica.Blocks.Sources.RealExpression G_left[rectangGridSeg.N_z](y=h*rectangGridSeg.nodes[1,:].A_r_le)
    annotation (Placement(transformation(extent={{-66,42},{-46,62}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conRight[rectangGridSeg.N_z]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={38,30})));
  Modelica.Blocks.Sources.RealExpression G_right[rectangGridSeg.N_z](y=h*rectangGridSeg.nodes[end, :].A_r_ri)
    annotation (Placement(transformation(extent={{66,42},{46,62}})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor lumpElement(C=sum(rectangGridSeg.nodes.C), T(start=rectangGridSeg.T_init_unif, fixed=true))
    annotation (Placement(transformation(extent={{-10,-78},{10,-98}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conLump
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,-62})));
  Modelica.Blocks.Sources.RealExpression G_lump(y=h*(2*rectangGridSeg.A_z + rectangGridSeg.A_r_le + rectangGridSeg.A_r_ri))
    annotation (Placement(transformation(extent={{40,-72},{20,-52}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_to(m=rectangGridSeg.M_r)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-50,80})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_ri(m=rectangGridSeg.N_z)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={64,30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_le(m=rectangGridSeg.N_z)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-70,30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_bo(m=rectangGridSeg.M_r)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-40,-26})));
  Modelica.Blocks.Sources.RealExpression VC_T_GridSeg(y=rectangGridSeg.nodes[1, 1].T)
    annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  Modelica.Blocks.Sources.RealExpression VC_T_LumpElem(y=lumpElement.T) annotation (Placement(transformation(extent={{20,120},{40,140}})));
equation

  connect(lumpElement.port, conLump.solid) annotation (Line(points={{0,-78},{0,-72},{-1.83187e-15,-72}}, color={191,0,0}));
  connect(G_lump.y, conLump.Gc) annotation (Line(points={{19,-62},{10,-62}}, color={0,0,127}));
  connect(bou_T_amb.port, conLump.fluid) annotation (Line(points={{-80,-44},{1.83187e-15,-44},{1.83187e-15,-52}}, color={191,0,0}));
  connect(G_bot.y, conBot.Gc) annotation (Line(points={{19,-8},{10,-8}},   color={0,0,127}));
  connect(G_top.y, conTop.Gc) annotation (Line(points={{19,76},{10,76}}, color={0,0,127}));
  connect(G_left.y, conLeft.Gc) annotation (Line(points={{-45,52},{-40,52},{-40,40}}, color={0,0,127}));
  connect(G_right.y, conRight.Gc) annotation (Line(points={{45,52},{38,52},{38,40}}, color={0,0,127}));
  connect(conLeft.solid, rectangGridSeg.heatPorts_le) annotation (Line(points={{-30,30},{-20,30}}, color={191,0,0}));
  connect(conLeft.fluid, thermColl_le.port_a) annotation (Line(points={{-50,30},{-60,30}}, color={191,0,0}));
  connect(thermColl_le.port_b, bou_T_amb.port) annotation (Line(points={{-80,30},{-90,30},{-90,0},{-70,0},{-70,-44},{-80,-44}}, color={191,0,0}));
  connect(conTop.solid, rectangGridSeg.heatPorts_to)
    annotation (Line(points={{-1.83187e-15,66},{-1.83187e-15,62},{20,62},{20,52},{0,52},{0,50}}, color={191,0,0}));
  connect(conTop.fluid, thermColl_to.port_a)
    annotation (Line(points={{1.83187e-15,86},{1.83187e-15,92},{-30,92},{-30,80},{-40,80}}, color={191,0,0}));
  connect(thermColl_to.port_b, bou_T_amb.port) annotation (Line(points={{-60,80},{-90,80},{-90,0},{-70,0},{-70,-44},{-80,-44}}, color={191,0,0}));
  connect(rectangGridSeg.heatPorts_ri, conRight.solid) annotation (Line(points={{20,30},{28,30}}, color={191,0,0}));
  connect(conRight.fluid, thermColl_ri.port_a) annotation (Line(points={{48,30},{54,30}}, color={191,0,0}));
  connect(thermColl_ri.port_b, bou_T_amb.port) annotation (Line(points={{74,30},{90,30},{90,-44},{-80,-44}}, color={191,0,0}));
  connect(bou_T_amb.port, thermColl_bo.port_b) annotation (Line(points={{-80,-44},{-70,-44},{-70,-26},{-50,-26}}, color={191,0,0}));
  connect(thermColl_bo.port_a, conBot.fluid) annotation (Line(points={{-30,-26},{-1.77636e-15,-26},{-1.77636e-15,-18}}, color={191,0,0}));
  connect(conBot.solid, rectangGridSeg.heatPorts_bo) annotation (Line(points={{1.77636e-15,2},{1.77636e-15,5},{0,5},{0,10}}, color={191,0,0}));
  annotation (
    experiment(
      StopTime=360000,
      Interval=600,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
        <p>
        Comparison against the cooling curve of a corresponding lumped element (thermal mass) according to lumped system analysis (Çengel and Ghajar, 2015, pp. 238).  
        </p>
        <h4>Verification criterion</h4>
        <p>
        The temperatures <code>VC_T_GridSeg</code> (i.e., any node temperature) and <code>VC_T_LumpElem</code> must be identical.  
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
