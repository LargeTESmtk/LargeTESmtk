within LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer;
model ConvRadHeatTransfer_SingleNo "Convective and radiative heat transfer model (for a single surface node)"
  extends Icons.GroundDomain.ConvRadHeatTransfer_SingleNo;

// Dimensions
  parameter Modelica.Units.SI.Area A = 1 "Surface area"
    annotation(Dialog(group="Dimensions"));

// Coefficients
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h_conv = 25 "Convective heat transfer coefficient"
    annotation(Dialog(group="Coefficients"));

  parameter Boolean useRadHeatTransfer = true
    "= true: convective and radiate heat transfer are considered, = false: only convective heat transfer is considered"
    annotation(Dialog(group="Coefficients"));

  parameter Modelica.Units.SI.SpectralAbsorptionFactor alpha_solar = 0.8 if useRadHeatTransfer "Solar absorptivity of surface"
    annotation(Dialog(group="Coefficients",enable=useRadHeatTransfer));
  parameter Modelica.Units.SI.Emissivity eps = 0.95 if useRadHeatTransfer "Emissivity of surface"
    annotation(Dialog(group="Coefficients",enable=useRadHeatTransfer));

// Solar radiation
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarRadiation if useRadHeatTransfer
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-60,10})));

  Modelica.Blocks.Interfaces.RealInput G_solar if useRadHeatTransfer "Solar irradiation in [W/m2] (Horziontal global radiation)"
     annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120})));
  Modelica.Blocks.Math.Gain gain(k=alpha_solar*A) if useRadHeatTransfer
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-60,50})));

// Athmospheric radiation
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation atmosphericRadiation(Gr=eps*A) if useRadHeatTransfer
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,10})));

  Modelica.Blocks.Interfaces.RealInput T_sky if useRadHeatTransfer
    "Sky temperature in [K]"                                   annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),  iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemp_T_sky if useRadHeatTransfer
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,50})));

// Convection
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={60,10})));

  Modelica.Blocks.Interfaces.RealInput T_air "Air temperature in [K]"
                                                               annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemp_T_air
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,50})));
  Modelica.Blocks.Sources.RealExpression realExpr_h_conv(y=h_conv*A)
                                                              annotation (Placement(transformation(extent={{100,0},{80,20}})));

// Surface
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=if useRadHeatTransfer then 3 else 1) annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort_surface
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));

equation
  connect(prescribedTemp_T_sky.T, T_sky) annotation (Line(points={{2.22045e-15,62},{0,62},{0,120}}, color={0,0,127}));
  connect(atmosphericRadiation.port_a, prescribedTemp_T_sky.port) annotation (Line(points={{0,20},{0,40}}, color={191,0,0}));
  connect(thermalCollector.port_b, heatPort_surface) annotation (Line(points={{0,-80},{0,-100}}, color={191,0,0}));
  connect(G_solar, gain.u) annotation (Line(points={{-60,120},{-60,62}}, color={0,0,127}));
  connect(gain.y, solarRadiation.Q_flow) annotation (Line(points={{-60,39},{-60,20}}, color={0,0,127}));
  connect(realExpr_h_conv.y, convection.Gc) annotation (Line(points={{79,10},{70,10}}, color={0,0,127}));
  connect(prescribedTemp_T_air.T, T_air) annotation (Line(points={{60,62},{60,120}}, color={0,0,127}));
  connect(prescribedTemp_T_air.port, convection.fluid) annotation (Line(points={{60,40},{60,20}}, color={191,0,0}));
  connect(convection.solid, thermalCollector.port_a[1]) annotation (Line(points={{60,0},{60,-40},{0,-40},{0,-60}}, color={191,0,0}));
  connect(atmosphericRadiation.port_b, thermalCollector.port_a[2])
    annotation (Line(points={{-1.77636e-15,-3.55271e-15},{-1.77636e-15,-30},{0,-30},{0,-60}}, color={191,0,0}));
  connect(solarRadiation.port, thermalCollector.port_a[3]) annotation (Line(points={{-60,0},{-60,-40},{0,-40},{0,-60}}, color={191,0,0}));
  annotation (defaultComponentName="surfaceHeatTransfer",Icon(coordinateSystem(preserveAspectRatio=true), graphics={Text(
          extent={{-150,-110},{150,-150}},
          lineColor={0,0,255},
          textString="%name",
          fontName="Times New Roman")}),                                                                   Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This model considers the convective and radiative heat transfer on a ground surface (for a single surface node). 
The consideration of radiative heat transfer is optional in the model. 
</p>

<p>
See Çengel and Ghajar (2015, pp. 742) and Incropera et al. (2007, pp. 770) for the theoretical background.  
</p>

<p>
<em>[Further model documentation to be added.]</em>
</p>

<h4>References</h4>
<p>
Çengel, Yunus A., and Afshin J. Ghajar.
<i>
Heat and Mass Transfer: Fundamentals & Applications.
</i>
5th ed. New York (US): McGraw-Hill Education, 2015.
</p>

<p>
Incropera, Frank P., David P. Dewitt, Theodore L. Bergman, and Adrienne S. Lavine. 
<i>
Fundamentals of Heat and Mass Transfer. 
</i>
6th ed. Hoboken, NJ: John Wiley, 2007.
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
end ConvRadHeatTransfer_SingleNo;
