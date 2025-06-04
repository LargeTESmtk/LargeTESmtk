within LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses;
model PartialNode_Interior "Partial interior node model"
  extends Icons.GroundDomain.GridUnits.Node_Interior;

// Dimensions and coordinates
  parameter Modelica.Units.SI.Radius r_le(fixed=false) "Radial distance to left boundary (inner radius)";
  final parameter Modelica.Units.SI.Radius r_le_act = if r_le==0 then Modelica.Constants.eps else r_le  "Radial distance to left boundary (inner radius) (actual value)" annotation(HideResult=true);
  parameter Modelica.Units.SI.Radius r_ri(fixed=false) "Radial distance to right boundary (outer radius)";

  final parameter Modelica.Units.SI.Radius r = (r_le_act+r_ri)/2 "Radial distance to center";
  final parameter Modelica.Units.SI.Length dr = r_ri-r_le_act "Size in radial direction";

  parameter Modelica.Units.SI.Distance z_to(fixed=false) "Axial distance to top boundary (w.r.t. (local) grid segment)";
  parameter Modelica.Units.SI.Distance z_bo(fixed=false) "Axial distance to bottom boundary (w.r.t. (local) grid segment)";

  final parameter Modelica.Units.SI.Distance z = (z_to+z_bo)/2 "Axial distance to center (w.r.t. (local) grid segment)";
  final parameter Modelica.Units.SI.Length dz = z_bo-z_to "Size in axial direction";

  parameter Modelica.Units.SI.Position z_to_glo(fixed=false) "Axial distance to top boundary (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Position z_bo_glo = z_to_glo+dz "Axial distance to bottom boundary (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Position z_glo = (z_to_glo+z_bo_glo)/2 "Axial distance to center (w.r.t. global coordinate system)";

  final parameter Modelica.Units.SI.Area A_r_le(fixed=false) "Left boundary surface perpendicular to radial direction (inner lateral area)";
  final parameter Modelica.Units.SI.Area A_r_ri(fixed=false) "Right boundary surface perpendicular to the radial direction (outer lateral area)";
  final parameter Modelica.Units.SI.Area A_z(fixed=false) "Top and bottom surface perpendicular to axial direction";

  final parameter Modelica.Units.SI.Volume V(fixed=false) "Volume";

// Thermophysical properties
  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermalProp
    "Thermophysical properties of the solid material" annotation (choicesAllMatching=true);

  final parameter Modelica.Units.SI.HeatCapacity C(fixed=false) "Heat capacity";

// Heat flow rates, etc.
  final parameter Modelica.Units.SI.ThermalConductance G_to(fixed=false) "Thermal conductance between top boundary and center";
  final parameter Modelica.Units.SI.ThermalConductance G_bo(fixed=false) "Thermal conductance between bottom boundary and center";
  final parameter Modelica.Units.SI.ThermalConductance G_le(fixed=false) "Thermal conductance between left boundary and center";
  final parameter Modelica.Units.SI.ThermalConductance G_ri(fixed=false) "Thermal conductance between right boundary and center";

  Modelica.Units.SI.HeatFlowRate QFlow_to "Heat flow from the top";
  Modelica.Units.SI.HeatFlowRate QFlow_bo "Heat flow from the bottom";
  Modelica.Units.SI.HeatFlowRate QFlow_le "Heat flow from the left";
  Modelica.Units.SI.HeatFlowRate QFlow_ri "Heat flow from the right";

// Temperatures
  parameter Modelica.Units.SI.Temperature T_init(fixed=false) "Initial temperature";

  Modelica.Units.SI.Temperature T "Temperature";

//   parameter Boolean HideVarRes = true;

initial equation

  A_r_le = Modelica.Constants.pi * 2 * r_le_act * dz;
  A_r_ri = Modelica.Constants.pi * 2 * r_ri * dz;
  A_z = Modelica.Constants.pi * (r_ri^2 - r_le_act^2);

  V = A_z * dz;

  C = V * thermalProp.d * thermalProp.c;

  T = T_init;

  annotation (
    defaultComponentName="interiorNode",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-90,-90},{90,90}}), graphics={Text(
          extent={{-152,140},{148,100}},
          lineColor={0,0,255},
          textString="%name",
          fontName="Times New Roman")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-60,20},{-20,-20}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-20,60},{20,20}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{20,20},{60,-20}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-20,-20},{20,-60}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash),
        Ellipse(
          extent={{-42,-2},{-38,2}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,38},{2,42}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,-42},{2,-38}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,-2},{42,2}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,60},{20,50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          textString="top",
          fontName="Times New Roman"),
        Line(
          points={{-80,60},{-80,84}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-60,80},{-84,80}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-72,80},{-52,70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="r, m"),
        Text(
          extent={{-80,70},{-60,60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="z, n"),
        Line(
          points={{-36,0},{-26,0}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-6,-1},{4,-1}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={-1,-30},
          rotation=90),
        Line(
          points={{4,-5},{4,5}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={31,-4},
          rotation=90),
        Line(
          points={{-1,-6},{-1,4}},
          color={191,0,0},
          arrow={Arrow.None,Arrow.Filled},
          origin={-1,30},
          rotation=180),
        Text(
          extent={{-20,-50},{20,-60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="bottom"),
        Text(
          extent={{-20,5},{20,-5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="left",
          origin={-55,0},
          rotation=90),
        Text(
          extent={{-20,5},{20,-5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          origin={55,0},
          rotation=90,
          textString="right"),
        Ellipse(
          extent={{-82,78},{-78,82}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,20},{20,-20}},
          lineColor={0,140,72},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,-2},{2,2}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>

<p>
Partial interior node (volume element) model.   
</p>

<p>
This model is intended for application in a higher-level grid segment model
(i.e., corresponding parameters are set to <code>fixed=false</code> and can therefore be defined in the initial equation section of the higher-level model).
</p>

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
end PartialNode_Interior;
