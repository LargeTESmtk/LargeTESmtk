within LargeTESmtk.TankTES.Cylinder;
model FullyBuried_Basic "Fully buried TTES with cylindrical fluid geometry (Basic version)"
  extends Icons.TankTES.TTES_Cylinder_FB_Basic;
  extends LargeTESmtk.TankTES.Cylinder.BaseClasses.PartialFullyBuried_CustomGD(
    gridAreaPar_Fl_r(final M_Sec_r=1, final dr_Sec_input),
    gridAreaPar_Ri_r(final M_Sec_r=1, final dr_Sec_input),
    final gridAreaPar_Fl_z(final N_Sec_z=1, final z_Sec_bo_glo_input),
    gridAreaPar_Bo_z(final N_Sec_z=1, final z_Sec_bo_glo_input),
    final useUnifThermProp_RiTo=true,
    final thermProp_RiTo_unif=thermProp_GD_unif,
    final thermProp_RiTo_spec,
    final useUnifThermProp_RiFl=true,
    final thermProp_RiFl_unif=thermProp_GD_unif,
    final thermProp_RiFl_spec,
    final useUnifThermProp_FlBo=true,
    final thermProp_FlBo_unif=thermProp_GD_unif,
    final thermProp_FlBo_spec,
    final useUnifThermProp_RiBo=true,
    final thermProp_RiBo_unif=thermProp_GD_unif,
    final thermProp_RiBo_spec);

  parameter Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_GD_unif
    "Uniform thermophysical properties of entire ground domain" annotation (Dialog(tab="Ground domain", group="Thermal properties"));

  annotation (
    defaultComponentName="tankTES",
    Documentation(info="<html>

<p>
Model of a fully buried TTES with cylindrical fluid domain geometry.
</p>

<p>
This is a basic model version with uniform ground properties and limited flexibility. 
For a more cusomizable model in terms of ground properties and layers, wall structures, etc., use 
<a href=\"modelica://LargeTESmtk.TankTES.Cylinder.FullyBuried_CustomGD\">LargeTESmtk.TankTES.Cylinder.FullyBuried_CustomGD</a>.
</p>

<h4>Grid Parameters</h4>
<p>
As the model results depend on the used grid parameters, a grid convergence/independence study is highly recommended for accurate results. 
A comprehensive grid convergence study methodology can be found in [<a href=\"modelica://LargeTESmtk.UserGuide.References\">Reisenbichler2025</a>].
</p>

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

</html>"),
    Diagram(coordinateSystem(extent={{-160,-120},{160,120}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end FullyBuried_Basic;
