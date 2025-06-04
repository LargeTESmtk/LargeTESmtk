within LargeTESmtk.Utilities.TestFrameworks;
model PartialTestFramework_BoundCond_Simple "Partial model adding simple boundary conditions to framework"
//   extends Giga_TES.LargeTESmtk.Utilities.TestFrameworks.PartialTestFramework_ModelPar_v4_0_0_int;

  replaceable parameter LargeTESmtk.Utilities.TestFrameworks.PartialParRecords.PartialBoundaryConditionsPar boundCondPar
    annotation (Placement(transformation(extent={{140,-140},{180,-100}})));

  Modelica.Blocks.Sources.Cosine sou_T_amb(
    amplitude=boundCondPar.T_amb_amplitude,
    f=boundCondPar.f_amb,
    offset=boundCondPar.T_amb_offset,
    startTime=boundCondPar.T_amb_startTime)
                            annotation (Placement(transformation(extent={{-240,90},{-220,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature bou_T_amb annotation (Placement(transformation(extent={{-180,90},{-160,110}})));

  parameter Modelica.Units.SI.Frequency f_amb=1/(365*24*3600) "Frequency of cosine wave";
equation

  connect(sou_T_amb.y, bou_T_amb.T) annotation (Line(points={{-219,100},{-182,100}}, color={0,0,127}));
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
end PartialTestFramework_BoundCond_Simple;
