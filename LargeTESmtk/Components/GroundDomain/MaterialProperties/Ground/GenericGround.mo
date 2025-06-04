within LargeTESmtk.Components.GroundDomain.MaterialProperties.Ground;
record GenericGround "Generic ground derived from clay/silt, sand, and gravel properties"
  extends LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialGround(
    k=1.2,
    c=2000e3/2000,
    d=2000);
  annotation (Documentation(info="<html>

<p>
Generic ground properties derived from standard values for unconsolidated rock consisting of clay/silt, 
sand, and gravel under dry and water-saturated conditions, according to EN 17522:2023 and VDI 4640-1.
</p>

<h4>References</h4>
<p>
EN 17522:2023.
<i>
Design and construction of backfilled and grouted borehole heat exchangers.
</i>
CEN. European Norm, 2023.  
</p>

<p>
VDI 4640 Part 1.
<i>
Thermal use of the underground - Fundamentals, approvals, environmental aspects.
</i>
Verein Deutscher Ingenieure. Beuth Publishing, June 2010. 
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
end GenericGround;
