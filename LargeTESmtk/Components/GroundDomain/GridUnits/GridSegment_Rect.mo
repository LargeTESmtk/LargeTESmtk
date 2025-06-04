within LargeTESmtk.Components.GroundDomain.GridUnits;
model GridSegment_Rect "Grid segment with rectangular cross-section"
  extends BaseClasses.PartialGridSegment_Rect(
    r_le(fixed=true) = 10,
    r_ri(fixed=true) = 20,
    z_to_glo(fixed=true) = 10,
    z_bo_glo(fixed=true) = 20);

annotation (defaultComponentName="rectangGridSeg", Documentation(info="<html>

<p>
Grid (mesh) segment model with rectangular cross-section. 
</p>

<p>
The corresponding equations for the heat flows and the energy balance of the single nodes are defined in this model (i.e., at superordinate level) and not at individual node level.  
Usually, this model is faster than the alternative implementation with internal heat ports at the individual node boundaries
(see <a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.Alternative.GridSegment_Rect_IntHeatPorts\">GridSegment_Rect_IntHeatPorts</a>), 
since it has less equations to be solved.     
</p>

<p>
This a standalone version (i.e., corresponding parameters are set to <code>fixed=true</code>) of the 
<a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses.PartialGridSegment_Rect\"> 
PartialGridSegment_Rect</a> model, which is the intended model version for application in a higher-level grid zone model 
(i.e., corresponding parameters are set to <code>fixed=false</code>).
</p>

<p>
<em>[Further model documentation to be added.]</em>
</p>

<h4>Acknowledgment</h4>
<p>
An early version of this model was inspired by the <code>Buildings.HeatTransfer.Conduction.SingleLayerCylinder</code> model of the 
Modelica <a href=\"https://github.com/lbl-srg/modelica-buildings\">Buildings</a> library. 
</p>

<p>
In particular, the equation for the grid spacing (considering a growth rate/factor) was indirectly adopted:
</p>

<p>
<code>r[i]= r[i-1] + ( r_b - r_a)  * (1-griFac)/(1-griFac^(nSta)) * griFac^(i-2)</code>
</p>

<p>
Many thanks to the authors for sharing their valuable work. 
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
end GridSegment_Rect;
