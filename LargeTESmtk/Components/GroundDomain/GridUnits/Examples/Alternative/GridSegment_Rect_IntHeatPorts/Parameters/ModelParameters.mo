within LargeTESmtk.Components.GroundDomain.GridUnits.Examples.Alternative.GridSegment_Rect_IntHeatPorts.Parameters;
record ModelParameters "Record with common model parameters for example models"
  extends GridSegment_Rect.Parameters.ModelParameters;
  annotation (Documentation(info="<html>

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
