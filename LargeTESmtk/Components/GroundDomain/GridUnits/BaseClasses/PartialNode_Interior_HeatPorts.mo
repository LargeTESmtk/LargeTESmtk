within LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses;
model PartialNode_Interior_HeatPorts "Partial interior node model with heat ports at boundaries"
  extends PartialNode_Interior;

// Heat ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_to "Heat port at top boundary" annotation (Placement(transformation(extent={{-6,26},
            {6,14}}), iconTransformation(extent={{-6,36},{6,24}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_bo "Heat port at bottom boundary" annotation (Placement(transformation(extent={{-6,
            -26},{6,-14}}), iconTransformation(extent={{-6,-36},{6,-24}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_le "Heat port at left boundary"
                                                                                              annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-20,0}), iconTransformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-30,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_ri "Heat port at right boundary"
                                                                                               annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={20,0}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={30,0})));

initial equation

  G_to = thermalProp.k * A_z / (z - z_to);
  G_bo = thermalProp.k * A_z / (z_bo - z);
  G_le = thermalProp.k * 2 * Modelica.Constants.pi * dz / Modelica.Math.log(r / r_le);
  G_ri = thermalProp.k * 2 * Modelica.Constants.pi * dz / Modelica.Math.log(r_ri / r);

equation

// Heat flow rates
  heatPort_to.Q_flow = +QFlow_to;
  heatPort_bo.Q_flow = +QFlow_bo;
  heatPort_le.Q_flow = +QFlow_le;
  heatPort_ri.Q_flow = +QFlow_ri;

  QFlow_to = G_to * (heatPort_to.T - T);
  QFlow_bo = G_bo * (heatPort_bo.T - T);
  QFlow_le = G_le * (heatPort_le.T - T);
  QFlow_ri = G_ri * (heatPort_ri.T - T);

// Energy balance
  C*der(T) = QFlow_to + QFlow_bo + QFlow_le + QFlow_ri;

  annotation (Documentation(info="<html>

<p>
Partial interior node (volume element) model with heat ports at the boundaries.
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
end PartialNode_Interior_HeatPorts;
