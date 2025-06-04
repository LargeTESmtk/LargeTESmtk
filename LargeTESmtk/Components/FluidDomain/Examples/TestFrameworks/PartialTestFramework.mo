within LargeTESmtk.Components.FluidDomain.Examples.TestFrameworks;
model PartialTestFramework "Partial test framework for example models"
  extends LargeTESmtk.Utilities.TestFrameworks.TestFrameworkLayout;
  extends LargeTESmtk.Utilities.TestFrameworks.PartialTestFramework_ModelPar;
  extends LargeTESmtk.Utilities.TestFrameworks.PartialTestFramework_BoundCond_Simple(           redeclare parameter
      LargeTESmtk.Components.FluidDomain.Examples.Parameters.BoundaryConditionsPar boundCondPar);
  extends LargeTESmtk.Utilities.TestFrameworks.PartialTestFramework_LoadProfile_Simple(           redeclare parameter
      LargeTESmtk.Components.FluidDomain.Examples.Parameters.SimpleLoadProfilePar loadProfilePar);

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou_T_G(T(displayUnit="K") = boundCondPar.T_G_const)
    annotation (Placement(transformation(extent={{-180,-100},{-160,-80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_sid(m=modelPar.N_z)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-90})));

equation

  connect(bou_T_G.port, thermColl_sid.port_b) annotation (Line(points={{-160,-90},{30,-90}}, color={191,0,0}));

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
This is a partial model for a test framework used in example/testing models.
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
end PartialTestFramework;
