within LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.RadiativeHeatTransfer;
model WithoutRadiation "Model with disabled radiative heat transfer"
  extends LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic.RadiativeHeatTransfer.WithRadiation(
    break connect(weaBus.HGloHor, storage.G_solar),
    break connect(weaBus.TBlaSky, storage.T_sky),
    modelPar(useRadHeatTransfer_GD=false, useRadHeatTransfer_Co=false));

  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"), Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end WithoutRadiation;
