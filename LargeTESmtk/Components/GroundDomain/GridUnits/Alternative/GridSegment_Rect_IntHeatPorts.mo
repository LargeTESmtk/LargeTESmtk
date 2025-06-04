within LargeTESmtk.Components.GroundDomain.GridUnits.Alternative;
model GridSegment_Rect_IntHeatPorts "Grid segment with rectangular cross-section and internal heat ports"
  extends BaseClasses.Alternative.PartialGridSegment_Rect_IntHeatPorts(
    r_le(fixed=true) = 10,
    r_ri(fixed=true) = 20,
    z_to_glo(fixed=true) = 10,
    z_bo_glo(fixed=true) = 20,
    GR_r(fixed=true) = 1,
    GR_z(fixed=true) = 1,
    T_init_unif(fixed=true) = 283.15);

annotation (defaultComponentName="rectangGridSeg", Documentation(info="<html>

<p>
Grid (mesh) segment model with rectangular cross-section and internal heat ports at individual node boundaries.
</p>

<p>
The corresponding equations for the heat flows and energy balances are defined in the individual node models.  
Usually, this model is slower than the model without internal heat ports 
(see <a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.GridSegment_Rect\">GridSegment_Rect</a>), 
since it has more equations to be solved.  
</p>

<p>
This a standalone version (i.e., corresponding parameters are set to <code>fixed=true</code>) of the 
<a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses.Alternative.PartialGridSegment_Rect_IntHeatPorts\"> 
PartialGridSegment_Rect_IntHeatPorts</a> model, which is the intended model version for application in a higher-level grid zone model 
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
end GridSegment_Rect_IntHeatPorts;
