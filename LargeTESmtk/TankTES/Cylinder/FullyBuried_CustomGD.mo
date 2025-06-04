within LargeTESmtk.TankTES.Cylinder;
model FullyBuried_CustomGD "Fully buried TTES with cylindrical fluid geometry (Customizable ground domain)"
  extends Icons.TankTES.TTES_Cylinder_FB_CustomGD;
  extends LargeTESmtk.TankTES.Cylinder.BaseClasses.PartialFullyBuried_CustomGD;

  annotation (
    defaultComponentName="tankTES",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>

<p>
Model of a fully buried TTES with cylindrical fluid domain geometry.
</p>

<p>
This model has a customizable ground domain model. The model's ground domain can be subdivided into segments, with each segment having its own unique thermophysical properties. 
This allows users, for example, to specify different horizontal ground layers or to consider multi-layered storage walls.
</p>

<h4>Grid Parameters</h4>
<p>
As the model results depend on the used grid parameters, a grid convergence/independence study is highly recommended for accurate results. 
A comprehensive grid convergence study methodology can be found in [<a href=\"modelica://LargeTESmtk.UserGuide.References\">Reisenbichler2025</a>].
</p>

<p>
<em>[Further model documentation to be added.]</em>
</p>

<p>
<em>[Draft]</em>
</p>
<p>
The individual segments are created as follows:

<ul> 
<li>First, the entire ground domain is divided into specified number of sections, both in radial and axial direction.</li> 
<li>Then, the size of each section is specified.</li> 
<li>Based on this information, the number and size of the individual segments is then determined.</li>
</ul>
</p>
<p>
<em>[Draft]</em>
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
    Diagram(coordinateSystem(extent={{-160,-120},{160,120}})));
end FullyBuried_CustomGD;
