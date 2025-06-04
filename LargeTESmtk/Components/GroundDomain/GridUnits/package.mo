within LargeTESmtk.Components.GroundDomain;
package GridUnits "Grid unit models for the ground domain model grid"
     extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>

<p>
This package includes the grid unit models that constitute the ground domain model grid, as well as their verification and example models, utility and base classes. 
</p>

<p>
The grid of the ground domain model is composed as follows:
<ul> 
<li>The smallest entities of the grid are the <strong>nodes</strong> (see <a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.Node_Interior\">Node_Interior</a>).</li>
<li>Several nodes form a single  <strong>grid segment</strong> (see <a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.GridSegment_Rect\">GridSegment_Rect</a>).</li>
<li>Several grid segments form a single  <strong>grid zone</strong> (see <a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.GridZone_Rect\">GridZone_Rect</a>).</li>
<li>Ultimately, several interconnected grid zone models then form the grid of the <strong>ground domain model</strong> 
(see, e.g., <a href=\"modelica://LargeTESmtk.Components.GroundDomain.Cylinder.FullyBuried_CustomGD\">FullyBuried_CustomGD</a>).</li>
</ul> 
</p>

</html>"));
end GridUnits;
