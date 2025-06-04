within LargeTESmtk.Components.GroundDomain.MaterialProperties.Insulation;
record DronninglundCover "Dronninglund cover insulation (before renewal)"
  extends LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialInsulation(
    k=0.0525,
    c=2300,
    d=28);
  annotation (Documentation(info="<html>

<p>
Thermophysical properties of the PTES in Dronninglund, Denmark. 
The storage cover essentially consisted of three 80 mm thick layers of <em>nomalen 28N</em> insulation mats made 
of a closed-cell structure polyethylene (PE) foam. 
</p>

<p>
The thermal conductivity of the insulation is subject to uncertainty because the operation conditions differed from the manufacturer’s test 
conditions due to exposure to high temperatures and moisture. Additionally, the insulation and the whole cover degraded slowly over the years. Therefore, a range of 
0.045–0.06 W/(m K) was assumed for the thermal conductivity. The specified thermal conductivity in the model is the mean value within this range. 
</p>

<p>
More information on the derived values and the corresponding references can be found in [<a href=\"modelica://LargeTESmtk.UserGuide.References\">Reisenbichler2025</a>], p. 8 and 11.
</p>

<p>
It has to be noted that the indicated values refer to the old cover design. The cover was replaced with a new design between 2020 and 2022. 
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
end DronninglundCover;
