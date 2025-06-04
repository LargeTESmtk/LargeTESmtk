within LargeTESmtk.Components.GroundDomain.GridUnits;
model Node_Interior "Interior node model with heat ports at boundaries"
  extends BaseClasses.PartialNode_Interior_HeatPorts(
    r_le(fixed=true) = 1,
    r_ri(fixed=true) = 2,
    z_to(fixed=true) = 1,
    z_bo(fixed=true) = 2,
    z_to_glo(fixed=true) = 10,
    T_init(fixed=true) = 283.15);

  annotation (defaultComponentName="interiorNode", Documentation(info="<html>

<p>
Interior node (volume element) model with heat ports at the boundaries. 
</p>

<p>
This a standalone version (i.e., corresponding parameters are set to <code>fixed=true</code>) of the 
<a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses.PartialNode_Interior_HeatPorts\"> 
PartialNode_Interior_HeatPorts</a> model, which is the intended model version for application in a higher-level grid segment model 
(i.e., corresponding parameters are set to <code>fixed=false</code>).
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
end Node_Interior;
