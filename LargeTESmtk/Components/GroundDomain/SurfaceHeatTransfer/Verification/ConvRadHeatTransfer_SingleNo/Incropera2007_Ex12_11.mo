within LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.Verification.ConvRadHeatTransfer_SingleNo;
model Incropera2007_Ex12_11
  extends LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.Verification.TestFrameworks.TestFramework;
  extends Modelica.Icons.Example;
  LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.ConvRadHeatTransfer_SingleNo convRadHeatTransfer(
    h_conv=0.22*(120 - 30)^(1/3),
    useRadHeatTransfer=true,
    alpha_solar=0.95,
    eps=0.1) annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.ConvRadHeatTransfer_SingleNo convHeatTransfer(
    A=convRadHeatTransfer.A,
    h_conv=convRadHeatTransfer.h_conv,
    useRadHeatTransfer=false) annotation (Placement(transformation(extent={{10,-20},{50,20}})));
equation
  connect(G_solar.y, convRadHeatTransfer.G_solar) annotation (Line(points={{-60,79},{-60,40},{-42,40},{-42,24}}, color={0,0,127}));
  connect(T_sky.y, convRadHeatTransfer.T_sky) annotation (Line(points={{0,79},{0,40},{-30,40},{-30,24}}, color={0,0,127}));
  connect(T_air.y, convRadHeatTransfer.T_air) annotation (Line(points={{60,79},{60,32},{-18,32},{-18,24}}, color={0,0,127}));
  connect(convHeatTransfer.T_air, T_air.y) annotation (Line(points={{42,24},{42,32},{60,32},{60,79}}, color={0,0,127}));
  connect(convHeatTransfer.heatPort_surface, sens_QFlow_Conv.port_a) annotation (Line(points={{30,-20},{30,-40}}, color={191,0,0}));
  connect(convRadHeatTransfer.heatPort_surface, sens_QFlow_ConvRad.port_a) annotation (Line(points={{-30,-20},{-30,-40}}, color={191,0,0}));
  annotation (Documentation(info="<html>
        <p>
        This model is verified by comparing the simulation results with the results of <em>Example 12.11</em> in Incropera et al. (2007, pp. 774). 
        A further verification example can be found in Çengel and Ghajar (2015, pp. 746).  
        </p>
        <h4>References</h4>
        <p>
        Incropera, Frank P., David P. Dewitt, Theodore L. Bergman, and Adrienne S. Lavine. 
        <i>
        Fundamentals of Heat and Mass Transfer. 
        </i>
        6th ed. Hoboken, NJ: John Wiley, 2007.
        </p>
        <p>
        Çengel, Yunus A., and Afshin J. Ghajar.
        <i>
        Heat and Mass Transfer: Fundamentals & Applications.
        </i>
        5th ed. New York (US): McGraw-Hill Education, 2015.
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
end Incropera2007_Ex12_11;
