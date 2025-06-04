within LargeTESmtk.Icons.GroundDomain.GridUnits;
partial class GridSegment_Rect

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={244,125,35},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,-32},{20,-100}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-80,100},{-80,-100}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-100,80},{100,80}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-100,56},{100,56}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-100,20},{-40,20}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-100,-32},{-40,-32}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-40,-32},{-40,-100}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-40,20},{20,-32}},
          lineColor={0,140,72},
          lineThickness=0.5,
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-34,4},{14,-16}},
          lineColor={244,125,35},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={215,215,215}),
        Text(
          extent={{-30,4},{10,-16}},
          lineColor={0,0,0},
          fontName="Times New Roman",
          textString="Node"),
        Line(
          points={{20,20},{100,20}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{20,100},{20,20}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-40,100},{-40,20}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{20,-32},{100,-32}},
          color={0,0,0},
          pattern=LinePattern.Dash)}), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end GridSegment_Rect;
