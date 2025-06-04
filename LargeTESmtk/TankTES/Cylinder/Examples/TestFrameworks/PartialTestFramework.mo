within LargeTESmtk.TankTES.Cylinder.Examples.TestFrameworks;
model PartialTestFramework "Partial test framework for example models"
  extends Utilities.TestFrameworks.TestFrameworkLayout;
  extends Utilities.TestFrameworks.PartialTestFramework_ModelPar;
  extends Utilities.TestFrameworks.PartialTestFramework_BoundCond_Simple(redeclare parameter
      LargeTESmtk.TankTES.Cylinder.Examples.Parameters.BoundaryConditionsPar boundCondPar);
  extends Utilities.TestFrameworks.PartialTestFramework_LoadProfile_Simple(redeclare parameter
      LargeTESmtk.TankTES.Cylinder.Examples.Parameters.SimpleLoadProfilePar loadProfilePar);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,-160},{300,160}})),
    experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>

<p>
This is a partial model for a test framework used in example/testing models.
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
end PartialTestFramework;
