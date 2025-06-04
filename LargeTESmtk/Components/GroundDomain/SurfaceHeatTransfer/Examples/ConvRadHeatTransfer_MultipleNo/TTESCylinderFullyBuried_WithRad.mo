within LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.Examples.ConvRadHeatTransfer_MultipleNo;
model TTESCylinderFullyBuried_WithRad "TTES with radiative and convective surface heat transfer"
  extends LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.RadiativeHeatTransfer.WithRadiation;
  annotation (Documentation(info="<html>

<p>
This example model demonstrates a TTES
(<a href=\"modelica://LargeTESmtk.TankTES.Cylinder.FullyBuried_Basic\">LargeTESmtk.TankTES.Cylinder.FullyBuried_Basic</a>) 
with radiative and convective heat transfer at the cover and ground surfaces.
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
end TTESCylinderFullyBuried_WithRad;
