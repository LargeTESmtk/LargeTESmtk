within ;
package LargeTESmtk "Modelica LargeTESmtk (LargeTESModelingToolkit) Library"
  extends LargeTESmtk.Icons.LargeTESmtk_Icon;
  annotation (
    preferredView="info",
    version="0.1.0",
    versionDate="2025-06-04",
    uses(
      Modelica(version="4.0.0"),
    IBPSA(version="4.0.0", dateModified = "2025-02-16 06:30:00Z", revisionId = "e6de2f3"),
    ModelicaServices(version="4.0.0")),
    Documentation(info="<html>

<p align=\"center\">
  <img src=\"modelica://LargeTESmtk/Resources/Images/Library_Logo.png\" alt=\"Library logo\" width=\"200\"/>
</p>

<p>
The <em>LargeTESmtk</em> is a Modelica-based toolkit for the modeling and simulation of large-scale pit (PTES) and tank (TTES) thermal energy storage systems. 
In addition to an easy-to-use Modelica library with pre-built storage models, the toolkit&#39;s features should provide the foundation for developing new storage 
models customized to the wanted application.   
</p>

<p align=\"center\">
  <figure>
    <img src=\"modelica://LargeTESmtk/Resources/Images/LargeTESmtk_Overview.png\" alt=\"LargeTESmtk Overview\" style=\"width: 100%;\"/>
  </figure>
</p>
<p align=\"center\">
  <strong>Figure 1:</strong> Overview of (planned) <i>LargeTESmtk</i> features.
</p>

<p>
Possible applications of the library models are in simulations studies...
</p>
<ul>
<li>...to address relevant storage design questions (e.g., regarding volume, geometry, or insulation)</li>
<li>...to investigate long-term effects (e.g., the development of the storage performance and ground temperatures over the operation period)</li>
<li>...to evaluate the storage interaction in different system integration concepts (e.g., with solar thermal plants, heat pumps, or combined heat and power plants)</li>
<li>...</li>
</ul>

<h4>Development Status and Contributions</h4>
<p>
The library's development is hosted on <a href=\"https://github.com/LargeTESmtk/LargeTESmtk\">GitHub</a>. Visit the GitHub page to find out the current development status.
</p>

<p>
Contributions to the development are greatly appreciated.
You can report any issues using the <a href=\"https://github.com/LargeTESmtk/LargeTESmtk/issues\">Issues</a> section 
or contribute in form of <a href=\"https://github.com/LargeTESmtk/LargeTESmtk/pulls\">Pull requests</a>.
</p>

<h4>License</h4>
<p>
The Modelica <em>LargeTESmtk</em> library is available under the Mozilla Public License (MPL 2.0).
See <a href=\"modelica://LargeTESmtk.UserGuide.License\">License</a> text.
</p>

</html>"));
end LargeTESmtk;
