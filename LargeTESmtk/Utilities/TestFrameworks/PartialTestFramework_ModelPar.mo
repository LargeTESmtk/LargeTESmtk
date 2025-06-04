within LargeTESmtk.Utilities.TestFrameworks;
model PartialTestFramework_ModelPar "Partial model adding model parameter record to framework"
//   extends Giga_TES.LargeTESmtk.Utilities.TestFrameworks.TestFrameworkLayout_v4_0_0_int;

  replaceable parameter PartialParRecords.PartialModelParameters modelPar annotation (Placement(transformation(extent={{220,-80},{260,-40}})));

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
<em>[Further model documentation to be added.]</em>
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
end PartialTestFramework_ModelPar;
