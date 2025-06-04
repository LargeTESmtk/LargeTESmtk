within LargeTESmtk.Components.FluidDomain.Verification.Cylinder.ModelComparison;
model LargeTESmtk_Cylinder "Model comparison test case (LargeTESmtk model)"
  extends LargeTESmtk.Components.FluidDomain.Examples.Cylinder.SimpleLoadProfile(redeclare
      LargeTESmtk.Components.FluidDomain.Verification.Cylinder.ModelComparison.Parameters.ModelParameters modelPar(U_sid=modelPar.U_top, U_bot=
          modelPar.U_top));
  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"), Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end LargeTESmtk_Cylinder;
