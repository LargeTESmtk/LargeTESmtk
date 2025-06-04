within LargeTESmtk.Components.FluidDomain.Examples.Parameters;
record BoundaryConditionsPar "Record with common boundary conditions for example models"
  extends LargeTESmtk.Utilities.TestFrameworks.PartialParRecords.PartialBoundaryConditionsPar;

// Ground temperature
  parameter Modelica.Units.SI.Temperature T_G_const = 273.15+10 "Constant ground temperature";

  annotation (defaultComponentName="boundCondPar",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This record can be usd to globally define the corresponding parameters for all example models. Alternatively, the parameters can also be defined individually in each model. 
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
end BoundaryConditionsPar;
