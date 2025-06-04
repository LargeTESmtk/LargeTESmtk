within LargeTESmtk.Components.GroundDomain.MaterialProperties.Ground;
record Gravel_watersat "Gravel/stones, water-saturated"
  extends LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialGround(
    k=1.8,
    c=2.4e6/2100,
    d=2100);
  annotation (Documentation(info="<html>

<p>
Thermpophysical properties of water-saturated gravel/stones according to EN 17522:2023.
The values in the standard are adopted from VDI 4640-1. 
</p>

<p>
The defined values in the record are either the specified typical values (for thermal conductivity) or the mean values if a range is specified (for specific heat capacity and density).
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
end Gravel_watersat;
