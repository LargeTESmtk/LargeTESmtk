within LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer;
model ConvRadHeatTransfer_MultipleNo "Convective and radiative heat transfer model (for multiple surface nodes)"
  extends Icons.GroundDomain.ConvRadHeatTransfer_MultipleNo;

// Dimensions
  parameter Integer N_Nod(min=1) = 10 "Number of nodes at surface"
    annotation(Dialog(group="Dimensions"));

  parameter Modelica.Units.SI.Area A_Nod[N_Nod] = fill(0.1,N_Nod) "Surface areas of individual nodes"
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

// Heat transfer model
  ConvRadHeatTransfer_SingleNo convRadHeatTransfer[N_Nod](
    each useRadHeatTransfer=useRadHeatTransfer,
    each alpha_solar=alpha_solar,
    each eps=eps,
    each h_conv=h_conv,
    A=A_Nod) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));

// Interfaces
  Modelica.Blocks.Interfaces.RealInput G_solar if useRadHeatTransfer "Solar irradiation in [W/m2] (Horziontal global radiation)"
                                  annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120})));
  Modelica.Blocks.Routing.Replicator repl_G_solar(nout=N_Nod) if useRadHeatTransfer
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60,30})));

  Modelica.Blocks.Interfaces.RealInput T_sky if useRadHeatTransfer "Sky temperature in [K]"
                             annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),  iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Routing.Replicator repl_T_sky(nout=N_Nod) if useRadHeatTransfer
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,30})));

  Modelica.Blocks.Interfaces.RealInput T_air "Air temperature in [K]"
                              annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120})));
  Modelica.Blocks.Routing.Replicator repl_T_air(nout=N_Nod)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,30})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_surface[N_Nod]
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));

equation
  connect(G_solar, repl_G_solar.u) annotation (Line(points={{-60,120},{-60,42},{-60,42}}, color={0,0,127}));
  connect(T_sky, repl_T_sky.u) annotation (Line(points={{0,120},{8.88178e-16,120},{8.88178e-16,42}}, color={0,0,127}));
  connect(T_air, repl_T_air.u) annotation (Line(points={{60,120},{60,120},{60,42}}, color={0,0,127}));
  connect(repl_G_solar.y, convRadHeatTransfer.G_solar) annotation (Line(points={{-60,19},{-60,0},{-6,0},{-6,-18}}, color={0,0,127}));
  connect(repl_T_sky.y, convRadHeatTransfer.T_sky) annotation (Line(points={{0,19},{0,-18}}, color={0,0,127}));
  connect(repl_T_air.y, convRadHeatTransfer.T_air) annotation (Line(points={{60,19},{60,0},{6,0},{6,-18}}, color={0,0,127}));
  connect(convRadHeatTransfer.heatPort_surface, heatPorts_surface) annotation (Line(points={{0,-40},{0,-100}}, color={191,0,0}));
  annotation (defaultComponentName="surfaceHeatTransfer",Icon(coordinateSystem(preserveAspectRatio=true), graphics={Text(
          extent={{-150,-110},{150,-150}},
          lineColor={0,0,255},
          textString="%name",
          fontName="Times New Roman")}),                                                                   Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This model considers the convective and radiative heat transfer on a ground surface (for multiple surface nodes). 
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
end ConvRadHeatTransfer_MultipleNo;
