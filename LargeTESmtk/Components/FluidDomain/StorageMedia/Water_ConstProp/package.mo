within LargeTESmtk.Components.FluidDomain.StorageMedia;
package Water_ConstProp "Incompressible water with constant properties"
//   extends Modelica.Media.Water.ConstantPropertyLiquidWater;
  extends Modelica.Media.Water.ConstantPropertyLiquidWater(
    final cv_const=cp_const);
  annotation (Documentation(info="<html>

<p>
Storage medium model for incompressible (liquid) water with constant properties (constant densitiy, specific heat capacity, thermal conductivity, etc.).
</p>


<p>
The model is identical to (inherited from) <a href=\"modelica://Modelica.Media.Water.ConstantPropertyLiquidWater\">Modelica.Media.Water.ConstantPropertyLiquidWater</a>, 
but the specific heat capacity at constant volume is set equal to the specific heat capacity at constant pressure (<code>cv_const=cp_const</code>). 
This implementation leads to an equalized energy balance, as shown in 
<a href=\"modelica://LargeTESmtk.Components.FluidDomain.Verification.Cylinder.EnergyBalance\">LargeTESmtk.Components.FluidDomain.Verification.Cylinder.EnergyBalance</a>.
</p>

<p>
See <a href=\"modelica://LargeTESmtk.Utilities.TestFrameworks.PartialTestFramework_LoadProfile_Simple\">LargeTESmtk.Utilities.TestFrameworks.PartialTestFramework_LoadProfile_Simple</a> 
for an implementation with customized thermophysical properties (density, specific heat capacity, and thermal conductivity).
</p>

<p>
As an alternative medium model, <a href=\"modelica://IBPSA.Media.Water\">IBPSA.Media.Water</a> can be used.
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
end Water_ConstProp;
