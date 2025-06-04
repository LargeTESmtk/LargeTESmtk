within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.OneDimSteadyHeatConduction;
model PlaneWall "One-dimensional steady-state heat conduction trough a plane wall"

  parameter Modelica.Units.SI.Thickness L = 1 "Thickness";

  parameter Modelica.Units.SI.Area A = 1 "Surface area";

  parameter Modelica.Units.SI.ThermalConductivity k = 1.2 "Thermal conductivity";

  parameter Modelica.Units.SI.Temperature T_1 = 293.15 "Inner surface temperature";
  parameter Modelica.Units.SI.Temperature T_2 = 283.15 "Outer surface temperature";

  Modelica.Units.SI.HeatFlowRate QFlow_cond_wall "Heat flow rate through wall";

equation

  QFlow_cond_wall = k * A * (T_1 - T_2) / L;

  annotation (defaultComponentName = "heaCon_Wal", Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(
          extent={{-150,150},{150,110}},
          lineColor={0,0,255},
          textString="%name",
          fontName="Times New Roman"),
        Rectangle(
          extent={{-40,100},{40,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,80},{60,80}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5),
        Line(
          points={{-60,40},{60,40}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5),
        Line(
          points={{-60,0},{60,0}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5),
        Line(
          points={{-60,-40},{60,-40}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5),
        Line(
          points={{-60,-80},{60,-80}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5)}),                                     Diagram(coordinateSystem(preserveAspectRatio=true)), Documentation(info="<html>
<p>
Model for the analytical solution of one-dimensional steady-state heat conduction trough a plane wall according to Çengel and Ghajar (2015, pp. 143).
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

</html>"));
end PlaneWall;
