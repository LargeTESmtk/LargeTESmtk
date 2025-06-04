within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.GridErrorEval;
record ErrorMetrics "Error metrics used in grid error evaluation"
  extends Modelica.Icons.Record;

  parameter Real setValue(fixed=false) "Setpoint";
  parameter Real actValue(fixed=false) "Actual value";

  parameter Real Err(fixed=false) "Error (difference) between actual value and setpoint";
  parameter Real relErr(fixed=false) "Relative error between actual value and setpoint in percent";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end ErrorMetrics;
