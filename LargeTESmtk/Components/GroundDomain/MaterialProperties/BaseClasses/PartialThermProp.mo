within LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses;
record PartialThermProp "Partial record for thermophysical properties"
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.ThermalConductivity k "Thermal conductivity";
  parameter Modelica.Units.SI.SpecificHeatCapacity c "Specific heat capacity";
  parameter Modelica.Units.SI.Density d(displayUnit="kg/m3") "Density";

  annotation (Icon(coordinateSystem(preserveAspectRatio=true)), Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end PartialThermProp;
