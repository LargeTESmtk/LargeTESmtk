within LargeTESmtk.Components.GroundDomain.SurfaceHeatTransfer.Examples.ConvRadHeatTransfer_MultipleNo;
model TTESCylinderFullyBuried_WithoutRad "TTES with only convective surface heat transfer"
  extends LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.RadiativeHeatTransfer.WithoutRadiation;
  annotation (Documentation(info="<html>

<p>
This example model demonstrates a TTES
(<a href=\"modelica://LargeTESmtk.TankTES.Cylinder.FullyBuried_Basic\">LargeTESmtk.TankTES.Cylinder.FullyBuried_Basic</a>) 
with convective heat transfer at the cover and ground surfaces (i.e., radiative heat transer was disabled).
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
end TTESCylinderFullyBuried_WithoutRad;
