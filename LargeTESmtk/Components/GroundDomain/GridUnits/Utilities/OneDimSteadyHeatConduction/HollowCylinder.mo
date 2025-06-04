within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.OneDimSteadyHeatConduction;
model HollowCylinder "One-dimensional steady-state heat conduction trough a hollow cylinder"

  parameter Modelica.Units.SI.Length L = 1 "Length";

  parameter Modelica.Units.SI.Radius r_1 = 1 "Inner radius";
  parameter Modelica.Units.SI.Radius r_2 = 2 "Outer radius";

  parameter Modelica.Units.SI.ThermalConductivity k = 1.2 "Thermal conductivity";

  parameter Modelica.Units.SI.Temperature T_1 = 293.15 "Inner surface temperature";
  parameter Modelica.Units.SI.Temperature T_2 = 283.15 "Outer surface temperature";

  Modelica.Units.SI.HeatFlowRate QFlow_cond_cyl "Heat flow rate through cylinder";

equation

  QFlow_cond_cyl = 2 * Modelica.Constants.pi * L * k * (T_1 - T_2) / Modelica.Math.log(r_2 / r_1);

  annotation (defaultComponentName = "heaCon_Cyl", Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Ellipse(
          extent={{-90,-90},{90,90}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          lineColor={0,0,255},
          textString="%name",
          fontName="Times New Roman"),
        Line(
          points={{0,50},{0,100}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={0,0},
          rotation=0,
          thickness=0.5),
        Line(
          points={{0,50},{0,100}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={0,0},
          rotation=45,
          thickness=0.5),
        Line(
          points={{0,50},{0,100}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={0,-0},
          rotation=90,
          thickness=0.5),
        Line(
          points={{0,50},{0,100}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={-0,-0},
          rotation=135,
          thickness=0.5),
        Line(
          points={{0,50},{0,100}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={0,-0},
          rotation=180,
          thickness=0.5),
        Line(
          points={{0,50},{0,100}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={0,0},
          rotation=225,
          thickness=0.5),
        Line(
          points={{0,50},{0,100}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={0,-0},
          rotation=270,
          thickness=0.5),
        Line(
          points={{0,50},{0,100}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={0,-0},
          rotation=315,
          thickness=0.5)}),                                     Diagram(coordinateSystem(preserveAspectRatio=true)), Documentation(info="<html>
<p>
Model for the analytical solution of one-dimensional steady-state heat conduction trough a hollow cylinder according to Çengel and Ghajar (2015, pp. 161).
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
end HollowCylinder;
