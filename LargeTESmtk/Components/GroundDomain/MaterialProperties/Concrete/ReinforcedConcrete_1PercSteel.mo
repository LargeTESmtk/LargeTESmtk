within LargeTESmtk.Components.GroundDomain.MaterialProperties.Concrete;
record ReinforcedConcrete_1PercSteel "Reinforced concrete (1% steel)"
  extends LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialInsulation(
    k=2.3,
    c=1000,
    d=2300);
  annotation (Documentation(info="<html>

<p>
Thermpophysical properties of reinforced concrete (with 1% steel) according to VDI Heat Atlas (Spitzner, 2019, pp. 704). 
</p>


<h4>References</h4>
<p>
Spitzner, Martin H.
<i>
D6.5 Wärmeleitfähigkeit von Erdreich, Holz, Holzwerkstoffen, allgemeinen Baustoffen und Mauerwerk.
</i>
In VDI-Wärmeatlas, edited by Peter Stephan, S. Kabelac, M. Kind, D. Mewes, K. Schaber, and T. Wetzel, 687–706.
Springer Reference Technik. Berlin, Heidelberg: Springer Berlin Heidelberg, 2019.  
<a href=\"http://link.springer.com/10.1007/978-3-662-52989-8_34\">http://link.springer.com/10.1007/978-3-662-52989-8_34</a>. 
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
end ReinforcedConcrete_1PercSteel;
