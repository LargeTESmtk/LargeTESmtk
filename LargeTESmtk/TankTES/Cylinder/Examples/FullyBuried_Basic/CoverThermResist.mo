within LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic;
model CoverThermResist "Model with the cover considered only as thermal resistance without capacitance"
  extends LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.UniformGround(modelPar(useCapCover=false));
  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"), Documentation(info="<html>

<p>
This is the same example model as <a href=\"modelica://LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.UniformGround\">UniformGround</a>, but with the cover considered only as thermal resistance, without considering its thermal capacitance (i.e., the thermal mass of the cover is neglected).
</p>

<p>
When using the model like this, it is recommended to define a cover insulation extension, as demonstrated in 
<a href=\"modelica://LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.InsulationExtension\">InsulationExtension</a>, to avoid an unrealistic thermal bridge effect at the storage edge.
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
end CoverThermResist;
