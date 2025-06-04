within LargeTESmtk.Components.FluidDomain;
package Examples "Example models demonstrating model functionality and application"
  extends Modelica.Icons.ExamplesPackage;
  annotation (Documentation(info="<html>

<p>
This package includes different example/testing models that demonstrate the functionality and application of the models. 
These example models can also be used for regression testing when new model versions are developed.
</p>


<h4>Test Case Scenario</h4>
<p>
The test case scenario consists of a storage with one inlet/outlet at the top and one at the bottom, a simplfied charge and discharge profile (load profile), 
and a sinusoidal ambient temperature profile. The load profile parameters (i.e., charge/discharge period durations, volume flow rates, and temperatures) 
and the ambient temperature profile parameters can be defined globally for all example models (see 
<a href=\"modelica://LargeTESmtk.Components.FluidDomain.Examples.Parameters.SimpleLoadProfilePar\">SimpleLoadProfilePar</a> and
<a href=\"modelica://LargeTESmtk.Components.FluidDomain.Examples.Parameters.BoundaryConditionsPar\">BoundaryConditionsPar</a>) or separately in each model. 
</p>

<p>
<em>[Further model documentation to be added.]</em>
</p>

</html>"));
end Examples;
