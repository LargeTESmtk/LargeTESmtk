within LargeTESmtk.Components.GroundDomain.GridUnits.Examples.GridZone_Rect;
model SimpleBoundCond_Rect "Example model with simplified boundary conditions"
  extends Modelica.Icons.Example;

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer h = 25 "Heat transfer coefficient";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature bou_T_fl annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));

  LargeTESmtk.Components.GroundDomain.GridUnits.GridZone_Rect rectangGridZone(
    zoneLayoutPar_r=zoneLayoutPar_r,
    zoneLayoutPar_z=zoneLayoutPar_z,
    useUnifThermProp=modelPar.useUnifThermProp,
    thermProp_unif=modelPar.thermalProp_unif,
    T_init_unif=modelPar.T_init_unif,
    r_TMP=modelPar.r_TMP,
    z_TMP=modelPar.z_TMP) annotation (Placement(transformation(extent={{40,-60},{80,-20}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conTop[sum(rectangGridZone.zoneLayout_r.M_nodesPerSec)]
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={60,10})));
  Modelica.Blocks.Sources.RealExpression G_top[sum(rectangGridZone.zoneLayout_r.M_nodesPerSec)](y=h*rectangGridZone.zoneLayout_r.nodeDim_Zone.A_z)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_to(m=sum(rectangGridZone.zoneLayout_r.M_nodesPerSec))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={8,40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermColl_le(m=sum(rectangGridZone.zoneLayout_z.N_nodesPerSec))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={10,-40})));
  Modelica.Blocks.Sources.Sine T_fl(
    amplitude=20,
    f=1/(3600*24*5),
    offset=273.15 + 70) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Sine T_amb(
    amplitude=10,
    f=1/(3600*8760),
    offset=273.15 + 15,
    startTime=-3/4*(8760*3600)) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature bou_T_amb annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Examples.GridZone_Rect.Parameters.ModelParameters modelPar
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter Utilities.LayoutsAndDim.ZoneLayout_Radial_Parameters zoneLayoutPar_r(
    r_le=modelPar.r_le,
    r_ri=modelPar.r_ri,
    M_Sec_r=modelPar.M_Sec_r,
    dr_Sec_input=modelPar.dr_Sec_input,
    dr_smallestNo=modelPar.dr_smallestNo,
    GR_r=modelPar.GR_r,
    reversedDir_GR_r=modelPar.reversedDir_GR_r) annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  parameter Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters zoneLayoutPar_z(
    z_to_glo=modelPar.z_to_glo,
    z_bo_glo=modelPar.z_bo_glo,
    N_Sec_z=modelPar.N_Sec_z,
    z_Sec_bo_glo_input=modelPar.z_Sec_bo_glo_input,
    useEquidistantGrid_z=modelPar.useEquidistantGrid_z,
    dz_smallestNo=modelPar.dz_smallestNo,
    GR_z=modelPar.GR_z,
    reversedDir_GR_z=modelPar.reversedDir_GR_z,
    N_Nodes_z=modelPar.N_z) annotation (Placement(transformation(extent={{60,-100},{80,-80}})));

  parameter Modelica.Units.SI.Area A_z_to[sum(rectangGridZone.zoneLayout_r.M_nodesPerSec)](each fixed=false);

initial equation
  for m in 1:rectangGridZone.zoneLayout_r.M_Sec_r loop
    A_z_to[(if m==1 then 1 else sum(rectangGridZone.zoneLayout_r.M_nodesPerSec[1:m-1])+1):sum(rectangGridZone.zoneLayout_r.M_nodesPerSec[1:m])]
      = rectangGridZone.segments[m,1].nodes[:,1].A_z;
  end for;

equation

  connect(G_top.y, conTop.Gc) annotation (Line(points={{41,10},{45.5,10},{45.5,10},{50,10}},
                                                                         color={0,0,127}));
  connect(thermColl_le.port_b, bou_T_fl.port) annotation (Line(points={{0,-40},{-20,-40}}, color={191,0,0}));
  connect(conTop.solid, rectangGridZone.heatPorts_to) annotation (Line(points={{60,1.77636e-15},{60,-20}}, color={191,0,0}));
  connect(conTop.fluid, thermColl_to.port_a)
    annotation (Line(points={{60,20},{60,40},{18,40}},                                      color={191,0,0}));
  connect(thermColl_le.port_a, rectangGridZone.heatPorts_le) annotation (Line(points={{20,-40},{40,-40}}, color={191,0,0}));
  connect(T_fl.y, bou_T_fl.T) annotation (Line(points={{-59,-40},{-42,-40}}, color={0,0,127}));
  connect(thermColl_to.port_b, bou_T_amb.port) annotation (Line(points={{-2,40},{-20,40}}, color={191,0,0}));
  connect(T_amb.y, bou_T_amb.T) annotation (Line(points={{-59,40},{-42,40}}, color={0,0,127}));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"),
      Documentation(info="<html>

<p>
This example model demonstrates the model's application under a simplified fluid temperature profile at the left boundary surface and 
a simplified ambient temperature profile at the top surface.
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
end SimpleBoundCond_Rect;
