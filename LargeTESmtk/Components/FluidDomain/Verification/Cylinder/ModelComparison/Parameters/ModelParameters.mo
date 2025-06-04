within LargeTESmtk.Components.FluidDomain.Verification.Cylinder.ModelComparison.Parameters;
record ModelParameters "Record with common model parameters used in model comparison"
  extends Examples.Cylinder.Parameters.ModelParameters;
  annotation (Documentation(info="<html>

<p>
This record can be used to globally define the corresponding parameters for the model comparison.
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
