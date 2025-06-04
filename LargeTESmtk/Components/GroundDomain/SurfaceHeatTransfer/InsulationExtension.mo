within LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer;
model InsulationExtension "Storage cover insulation extension"
  extends Icons.GroundDomain.InsulationExtension;

// Dimensions
  parameter Integer M_Nod_r(min=1) = 5 "Number of nodes at surface"
    annotation(Dialog(group="Dimensions"));

  parameter Modelica.Units.SI.Area A_Nod[M_Nod_r] = {65.97,72.26,78.54,84.82,91.11}
    "Surface areas of individual nodes"
    annotation(Dialog(group="Dimensions"));

  parameter Modelica.Units.SI.Radius r_le[M_Nod_r] = {10,11,12,13,14}
    "Radial distances to left boundaries of the individual surface nodes" annotation(Dialog(group="Dimensions"));
  parameter Modelica.Units.SI.Radius r_ri[M_Nod_r] = {11,12,13,14,15}
    "Radial distances to right boundaries of the individual surface nodes" annotation(Dialog(group="Dimensions"));

// Insulation extension
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_InsExt = 0.3
    "U-value of insulation extension (exclusive convective and radiative heat transfer to ambient)"
    annotation(Dialog(group="Insulation extension"));
  parameter Integer M_InsExt_r = 2
    "Number of ground nodes to be covered with insulation (i.e., radial expansion of insulation extension)"
    annotation(Dialog(group="Insulation extension"));

  final parameter Integer M_woInsExt_r = M_Nod_r-M_InsExt_r "Number of uncovered ground nodes";
  // TBD ADD WARNING: M_InsExt_r has to be smaller than M_Nod_r

  final parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_Node_InsExt[M_Nod_r] = cat(
      1,
      fill(U_InsExt, M_InsExt_r),
      fill(1e8, M_woInsExt_r))
    "U-values of individual nodes (covered and uncovered surface nodes by insulation extension)";

  final parameter Modelica.Units.SI.ThermalConductance G_Nod_InsExt[M_Nod_r] = A_Nod .* U_Node_InsExt
    "Thermal conductance values of individual nodes (covered and uncovered surface nodes by insulation extension)";

  final parameter Modelica.Units.SI.Radius r_InsExt = if M_InsExt_r>0 then r_ri[M_InsExt_r] else r_le[1] "Outer (right) radius of insulation extension";
  final parameter Modelica.Units.SI.Distance dr_InsExt = r_InsExt-r_le[1]
    "Radial expansion of insulation extension";

// Heat transfer model
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_InsExt[M_Nod_r](G=G_Nod_InsExt)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90)));

// Interfaces
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_amb[M_Nod_r] "Heat ports to ambient air"
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{10,90},{30,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_surface[M_Nod_r] "Heat ports to ground surface"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{10,-110},{30,-90}})));

equation
  connect(con_InsExt.port_b, heatPorts_amb) annotation (Line(points={{1.11022e-15,20},{1.11022e-15,60},{0,60},{0,100}},color={191,0,0}));
  connect(con_InsExt.port_a, heatPorts_surface) annotation (Line(points={{-1.11022e-15,-20},{-1.11022e-15,-60},{0,-60},{0,-100}},
                                                                                                              color={191,0,0}));
  annotation (defaultComponentName="insExtension",Icon(coordinateSystem(preserveAspectRatio=true), graphics={
                   Line(
          points={{20,46},{20,-86}},
          color={191,0,0},
          thickness=1,
          pattern=LinePattern.Dash),
                   Line(
          points={{20,86},{20,60}},
          color={191,0,0},
          thickness=1,
          pattern=LinePattern.Dash),
        Text(
          extent={{-150,-50},{150,-90}},
          lineColor={0,0,255},
          textString="%name",
          fontName="Times New Roman")}),                                                            Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This model can be used to consider a storage cover insulation extension
(i.e., an insulation extension beyond the storage edge on the ground surface in order to reduce thermal bridges).  
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
end InsulationExtension;
