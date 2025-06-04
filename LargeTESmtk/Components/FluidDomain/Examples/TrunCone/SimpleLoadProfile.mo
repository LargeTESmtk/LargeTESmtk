within LargeTESmtk.Components.FluidDomain.Examples.TrunCone;
model SimpleLoadProfile "Example model with simplified load profile"
  extends LargeTESmtk.Components.FluidDomain.Examples.TestFrameworks.TestFramework(redeclare
      LargeTESmtk.Components.FluidDomain.Examples.TrunCone.Parameters.ModelParameters modelPar, redeclare LargeTESmtk.Components.FluidDomain.TrunCone
      fluidDom(
      redeclare package storageMedium = storageFluid,
      fluidDomDim(
        r_to=modelPar.r_to,
        r_bo=modelPar.r_bo,
        dz=modelPar.dz,
        z_to_glo=modelPar.z_to_glo),
      T_ref(displayUnit="degC")));

  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"),
                                   __Dymola_experimentSetupOutput(events=false),
    __Dymola_experimentFlags(
      Advanced(
        GenerateAnalyticJacobian=false,
        GenerateVariableDependencies=true,
        OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Documentation(info="<html>

<p>
This example model demonstrates the model's application under a simplified charge/discharge (load) profile.
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

end SimpleLoadProfile;
