within LargeTESmtk.Icons.GroundDomain.GridUnits;
partial class GridZone_Rect

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,100},{-70,40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{10,40},{100,40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-100,-40},{-70,-40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-70,40},{10,-40}},
          lineColor={244,125,35},
          lineThickness=0.5,
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-64,10},{4,-10}},
          lineColor={244,125,35},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={215,215,215}),
        Text(
          extent={{-60,10},{0,-10}},
          lineColor={0,0,0},
          fontName="Times New Roman",
          textString="Segment"),
        Line(
          points={{-70,-40},{-70,-100}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{10,-40},{100,-40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{10,100},{10,40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{10,-40},{10,-100}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-100,40},{-70,40}},
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
end GridZone_Rect;
