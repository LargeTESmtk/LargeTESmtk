within LargeTESmtk.Utilities.TestFrameworks;
model TestFrameworkLayout "Basic graphical layout for test frameworks"
  extends Modelica.Icons.Example;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,-160},{300,160}}),
                        graphics={
        Rectangle(
          extent={{-300,160},{-100,-160}},
          lineColor={0,0,0},
          pattern=LinePattern.Dot,
          lineThickness=0.5),
        Text(
          extent={{-300,160},{-100,140}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold,TextStyle.Italic},
          fontSize=12,
          fontName="Times New Roman",
          textString=" Data Input / Boundary Conditions"),
        Rectangle(
          extent={{100,160},{300,10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          pattern=LinePattern.Dot),
        Text(
          extent={{100,160},{300,140}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold,TextStyle.Italic},
          fontSize=12,
          fontName="Times New Roman",
          textString=" Results"),
        Text(
          extent={{100,-10},{300,-30}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold,TextStyle.Italic},
          fontSize=12,
          fontName="Times New Roman",
          textString=" Parameterization"),
        Rectangle(
          extent={{100,-10},{300,-160}},
          lineColor={0,0,0},
          lineThickness=0.5,
          pattern=LinePattern.Dot)}),
    experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
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
end TestFrameworkLayout;
