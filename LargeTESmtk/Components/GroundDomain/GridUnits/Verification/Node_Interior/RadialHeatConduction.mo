within LargeTESmtk.Components.GroundDomain.GridUnits.Verification.Node_Interior;
model RadialHeatConduction "Verification of radial heat conduction"
  extends Modelica.Icons.Example;
  extends LargeTESmtk.Utilities.TestFrameworks.TestFrameworkLayout_Verification;

  LargeTESmtk.Components.GroundDomain.GridUnits.Node_Interior interiorNode(redeclare
      LargeTESmtk.Components.GroundDomain.MaterialProperties.Ground.GenericGround thermalProp)
    annotation (Placement(transformation(extent={{-30,20},{30,80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou_T_in(T(displayUnit="degC") = 293.15)
                                                                        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou_T_out(T=283.15)
                                                                         annotation (Placement(transformation(extent={{60,40},{40,60}})));

  Utilities.OneDimSteadyHeatConduction.HollowCylinder heaCon_Cyl(
    L=interiorNode.dz,
    r_1=interiorNode.r_le,
    r_2=interiorNode.r_ri,
    k=interiorNode.thermalProp.k,
    T_1=bou_T_in.T,
    T_2=bou_T_out.T) annotation (Placement(transformation(extent={{-30,-80},{30,-20}})));

  Modelica.Blocks.Sources.RealExpression VC_QFlow_Nod(y=interiorNode.QFlow_le) annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  Modelica.Blocks.Sources.RealExpression VC_QFlow_analyt(y=heaCon_Cyl.QFlow_cond_cyl)
    annotation (Placement(transformation(extent={{20,120},{40,140}})));
equation

  connect(bou_T_in.port, interiorNode.heatPort_le) annotation (Line(points={{-40,50},{-10,50}},color={191,0,0}));
  connect(interiorNode.heatPort_ri, bou_T_out.port) annotation (Line(points={{10,50},{40,50}},color={191,0,0}));

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
      The radial heat flow rate <code>VC_QFlow_Nod</code> must converge with the heat flow rate of the analytical solution <code>VC_QFlow_analyt</code>. 
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
