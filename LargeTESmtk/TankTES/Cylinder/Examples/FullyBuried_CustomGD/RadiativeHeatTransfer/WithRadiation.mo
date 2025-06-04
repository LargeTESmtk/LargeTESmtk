within LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_CustomGD.RadiativeHeatTransfer;
model WithRadiation "Model with enabled radiative heat transfer"
  extends LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_CustomGD.NonUniformGround(                    break sou_T_amb, modelPar(
        useRadHeatTransfer_GD=true, useRadHeatTransfer_Co=true));
  IBPSA.BoundaryConditions.WeatherData.ReaderTMY3     weaDat(filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://IBPSA/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"), computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{-220,100},{-200,120}})));
  IBPSA.BoundaryConditions.WeatherData.Bus     weaBus "Weather data bus"
                       annotation (Placement(transformation(extent={{-180,100},{-160,120}})));
equation
  connect(weaBus,weaDat. weaBus) annotation (Line(
      points={{-170,110},{-200,110}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.HGloHor, storage.G_solar)
    annotation (Line(
      points={{-169.95,110.05},{-9.6,110.05},{-9.6,79.6}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TBlaSky, storage.T_sky)
    annotation (Line(
      points={{-169.95,110.05},{0,110.05},{0,79.6}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, storage.T_air)
    annotation (Line(
      points={{-169.95,110.05},{9.6,110.05},{9.6,79.6}},
      color={255,204,51},
      thickness=0.5));
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
end WithRadiation;
