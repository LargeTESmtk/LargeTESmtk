within LargeTESmtk.Components.FluidDomain.Verification.TrunCone;
model EnergyBalance "Energy balance verification test case"
  extends LargeTESmtk.Components.FluidDomain.Examples.TrunCone.SimpleLoadProfile;
  extends LargeTESmtk.Utilities.TestFrameworks.TestFrameworkLayout_Verification;

  Modelica.Blocks.Sources.RealExpression VC_QFlow_EnBalErr(y=QFlow_EnBalErr.y) annotation (Placement(transformation(extent={{-10,120},{10,140}})));
  annotation (Documentation(info="<html>

<p>
This verification test case checks the conservation of energy (i.e., the energy balance) within the storage model. 
</p>

<h4>Verification Criterion</h4>
<p>
The energy balance error <code>VC_QFlow_EnBalErr</code> must be close to zero during the entire simulation period.  
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
end EnergyBalance;
