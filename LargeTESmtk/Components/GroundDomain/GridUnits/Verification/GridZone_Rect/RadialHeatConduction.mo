within LargeTESmtk.Components.GroundDomain.GridUnits.Verification.GridZone_Rect;
model RadialHeatConduction "Verification of radial heat conduction"
  extends Modelica.Icons.Example;
  extends LargeTESmtk.Utilities.TestFrameworks.TestFrameworkLayout_Verification;

  LargeTESmtk.Components.GroundDomain.GridUnits.GridZone_Rect rectangGridZone(
    zoneLayoutPar_r=zoneLayoutPar_r,
    zoneLayoutPar_z=zoneLayoutPar_z,
    redeclare LargeTESmtk.Components.GroundDomain.MaterialProperties.Ground.GenericGround thermProp_unif)
    annotation (Placement(transformation(extent={{-30,10},{30,70}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou_T_in(T=293.15)
                                                                        annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou_T_out(T=283.15)
                                                                         annotation (Placement(transformation(extent={{100,30},{80,50}})));

  Utilities.OneDimSteadyHeatConduction.HollowCylinder heaCon_Cyl(
    L=rectangGridZone.zoneLayout_z.dz,
    r_1=rectangGridZone.zoneLayout_r.r_le,
    r_2=rectangGridZone.zoneLayout_r.r_ri,
    k=rectangGridZone.thermProp_unif.k,
    T_1=bou_T_in.T,
    T_2=bou_T_out.T) annotation (Placement(transformation(extent={{-30,-90},{30,-30}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_in(m=sum(rectangGridZone.zoneLayout_z.N_nodesPerSec))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-60,40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_out(m=sum(rectangGridZone.zoneLayout_z.N_nodesPerSec))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,40})));
  parameter Utilities.LayoutsAndDim.ZoneLayout_Radial_Parameters zoneLayoutPar_r(
    r_le=1,
    r_ri=2,
    M_Sec_r=3,
    dr_Sec_input={0.25,0.5},
    dr_smallestNo=0.05,
    GR_r=1.1,
    reversedDir_GR_r=true) annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  parameter Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters zoneLayoutPar_z(
    z_to_glo=10,
    z_bo_glo=11,
    N_Sec_z=3,
    z_Sec_bo_glo_input={10.25,10.5},
    N_Nodes_z=10) annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.RealExpression VC_QFlow_GridZone(y=thermColl_in.port_b.Q_flow)
    annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  Modelica.Blocks.Sources.RealExpression VC_QFlow_analyt(y=heaCon_Cyl.QFlow_cond_cyl)
    annotation (Placement(transformation(extent={{20,120},{40,140}})));
equation

  connect(thermColl_in.port_a, rectangGridZone.heatPorts_le) annotation (Line(points={{-50,40},{-30,40}}, color={191,0,0}));
  connect(thermColl_in.port_b, bou_T_in.port) annotation (Line(points={{-70,40},{-80,40}}, color={191,0,0}));
  connect(thermColl_out.port_a, rectangGridZone.heatPorts_ri) annotation (Line(points={{50,40},{50,40},{30,40}}, color={191,0,0}));
  connect(thermColl_out.port_b, bou_T_out.port) annotation (Line(points={{70,40},{80,40}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,160}})),
    experiment(
      StopTime=7200000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
      <p>
      Comparison against the analytical solution of one-dimensional steady-state heat conduction trough a hollow cylinder.  
      </p>
      <h4>Verification criterion</h4>
      <p>
      The radial heat flow rate <code>VC_QFlow_GridZone</code> must converge with the heat flow rate of the analytical solution <code>VC_QFlow_analyt</code>. 
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
end RadialHeatConduction;
