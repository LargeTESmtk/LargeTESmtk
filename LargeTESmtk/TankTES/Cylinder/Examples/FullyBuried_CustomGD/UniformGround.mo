within LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_CustomGD;
model UniformGround "Model with uniform ground properties"
  extends LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_CustomGD.NonUniformGround(                    modelPar(
      M_Fl_Sec_r=1,
      M_Ri_Sec_r=1,
      N_Fl_Sec_z=1,
      N_Bo_Sec_z=1,
      thermProp_RiTo_spec=[modelPar.gP_Uniform],
      thermProp_RiFl_spec=[modelPar.gP_Uniform],
      thermProp_FlBo_spec=[modelPar.gP_Uniform],
      thermProp_RiBo_spec=[modelPar.gP_Uniform]));
  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"), Documentation(info="<html>

<p>
This an example model of the storage model with customizable ground domain. However, to compare the model results with the basic model version with limited flexibility 
(<a href=\"modelica://LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.UniformGround\">UniformGround</a>), uniform ground properties are specified.   
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
end UniformGround;
