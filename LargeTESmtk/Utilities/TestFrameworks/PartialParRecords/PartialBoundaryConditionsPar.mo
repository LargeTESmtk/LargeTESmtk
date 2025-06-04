within LargeTESmtk.Utilities.TestFrameworks.PartialParRecords;
record PartialBoundaryConditionsPar "Partial record with common boundary conditions for test framework"
  extends Modelica.Icons.Record;

// Ambient temperature
  // Placeholder parameters for future feature
  final parameter Boolean useAmbCondFromFile = false "[Placeholder for future feature] = true, if ambient boundary conditions from file are to be used";

  // Simplified ambient temparuter profile (cosine curve)
  parameter Real T_amb_amplitude = 12 "Amplitude of cosine curve" annotation(Dialog(group="Ambient temperature profile"));
  parameter Modelica.Units.SI.Frequency f_amb = 1/(365*24*3600) "Frequency of cosine wave" annotation(Dialog(group="Ambient temperature profile"));
  parameter Real T_amb_offset = 283.15 "Offset of cosine curve" annotation(Dialog(group="Ambient temperature profile"));
  parameter Modelica.Units.SI.Time T_amb_startTime=-172*24*3600 "Phase shift of cosine curve" annotation(Dialog(group="Ambient temperature profile"));

/*
// Storage (heat transfer) fluid properties
  constant Modelica.Units.SI.SpecificHeatCapacity cp_fl_const = 4181
    "Specific heat capacity of storage fluid" annotation(Dialog(group="Storage (heat transfer) fluid properties"));
  constant Modelica.Units.SI.Density d_fl_const = 988.1
    "Density of storage fluid" annotation(Dialog(group="Storage (heat transfer) fluid properties"));
  constant Modelica.Units.SI.ThermalConductivity k_fl_const = 0.66
    "Thermal conductivity of storage fluid" annotation(Dialog(group="Storage (heat transfer) fluid properties"));
  */

  annotation (defaultComponentName="boundCondPar",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="", revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end PartialBoundaryConditionsPar;
