within LargeTESmtk.Components.FluidDomain.Examples.TrunCone.Parameters;
record ModelParameters "Record with common model parameters for example models"

  parameter Modelica.Units.SI.Radius r_to = 59.5 "Radius of top boundary surface";
  parameter Modelica.Units.SI.Radius r_bo = 27.5 "Radius of bottom boundary surface";

  extends LargeTESmtk.Components.FluidDomain.Examples.Parameters.PartialModelParameters_FluidDom(dz=16);

  annotation (defaultComponentName="modelPar",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This record can be used to globally define the corresponding parameters for all example models. Alternatively, the parameters can also be defined individually in each model. 
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
end ModelParameters;
