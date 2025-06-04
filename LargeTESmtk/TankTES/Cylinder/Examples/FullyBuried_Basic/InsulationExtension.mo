within LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic;
model InsulationExtension "Model demonstrating the application of a cover insulation extension"
  extends LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.UniformGround(modelPar(M_InsExt_r=10));
  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"), Documentation(info="<html>

<p>
This is the same example model as <a href=\"modelica://LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.UniformGround\">UniformGround</a>, 
but demonstrating the application of an insulation extension (i.e., an extension/overlap of the cover insulation on the ground surface beyond the storage edge).
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
end InsulationExtension;
