within LargeTESmtk.Icons.GroundDomain;
partial class Pkg_SurfaceHeatTransfer
  extends LargeTESmtk.Icons.BaseClasses.Background_SkySun;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Rectangle(
          extent={{-100,-60},{100,-100}},
          fillColor={166,83,0},
          fillPattern=FillPattern.Solid,
          lineColor={166,83,0}),
        Line(
          points={{-20,-20},{-20,70}},
          color={191,0,0},
          thickness=1),
        Line(
          points={{20,-50},{20,60}},
          color={191,0,0},
          thickness=1),
        Polygon(
          points={{20,70},{36,30},{4,30},{20,70}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-50},{-4,-10},{-36,-10},{-20,-50}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}),                     Diagram(coordinateSystem(preserveAspectRatio=true)),
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
end Pkg_SurfaceHeatTransfer;
