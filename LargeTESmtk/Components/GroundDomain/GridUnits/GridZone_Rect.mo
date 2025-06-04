within LargeTESmtk.Components.GroundDomain.GridUnits;
model GridZone_Rect "Grid zone with rectangular cross-section"
  extends Icons.GroundDomain.GridUnits.GridZone_Rect;

// Grid zone layout and parameters
  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Radial_Parameters zoneLayoutPar_r
    "Grid zone layout parameters in radial direction" annotation (Placement(transformation(extent={{-90,110},{-70,130}})));
  LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Radial zoneLayout_r(zoneLayoutPar_r=zoneLayoutPar_r)
    "Grid zone layout in radial direction" annotation (Placement(transformation));

  parameter LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial_Parameters zoneLayoutPar_z
    "Grid zone layout parameters in axial direction" annotation (Placement(transformation(extent={{-130,76},{-110,96}})));
  LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.ZoneLayout_Axial zoneLayout_z(zoneLayoutPar_z=zoneLayoutPar_z)
    "Grid zone layout in axial direction" annotation (Placement(transformation));

  // Thermophysical properties
  parameter Boolean useUnifThermProp = true
    "= true(default): uniform thermophysical properties for all segments in grid zone are used, = false: properties can be specified individually for each segment"
    annotation(Dialog(group="Ground properties"));

  replaceable parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_unif
    "Uniform thermophysical properties of all segments in grid zone"
    annotation (
    Dialog(group="Ground properties", enable=useUnifThermProp),
    HideResult=true,
    choicesAllMatching=true);
  final parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_unif_matrix[zoneLayoutPar_r.M_Sec_r,
    zoneLayoutPar_z.N_Sec_z](
    each k=thermProp_unif.k,
    each c=thermProp_unif.c,
    each d=thermProp_unif.d) "Uniform thermophysical properties of all segments in grid zone (matrix)"
    annotation (Dialog(enable=useUnifThermProp), HideResult=true);

  parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp_spec[zoneLayoutPar_z.N_Sec_z,
    zoneLayoutPar_r.M_Sec_r](
    each k=thermProp_unif.k,
    each c=thermProp_unif.c,
    each d=thermProp_unif.d) "Specified thermophysical properties of individual segments in grid zone"
    annotation (Dialog(group="Ground properties", enable=not useUnifThermProp), HideResult=true);

  final parameter LargeTESmtk.Components.GroundDomain.MaterialProperties.BaseClasses.PartialThermProp thermProp[zoneLayoutPar_r.M_Sec_r,
    zoneLayoutPar_z.N_Sec_z]=if useUnifThermProp then thermProp_unif_matrix else transpose(thermProp_spec)
    "Thermophysical properties of indivdiual segments in grid zone" annotation (Dialog(group="Ground properties"));

  // Temperatures
  parameter Modelica.Units.SI.Temperature T_init_unif = 273.15+10 "Uniform initial temperature for all nodes of the zone";

// Grid segments
  LargeTESmtk.Components.GroundDomain.GridUnits.BaseClasses.PartialGridSegment_Rect segments[zoneLayout_r.M_Sec_r,zoneLayout_z.N_Sec_z](
    M_r=LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.create_ArrayWithNoOfRadialNodes(
        zoneLayout_r.M_Sec_r,
        zoneLayout_z.N_Sec_z,
        zoneLayout_r.M_nodesPerSec),
    N_z=LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GridUnitsLayout.create_ArrayWithNoOfAxialNodes(
        zoneLayout_r.M_Sec_r,
        zoneLayout_z.N_Sec_z,
        zoneLayout_z.N_nodesPerSec),
    each GR_r=zoneLayout_r.GR_r,
    each reversedDir_GR_r=zoneLayout_r.reversedDir_GR_r,
    each GR_z=zoneLayout_z.GR_z,
    each reversedDir_GR_z=zoneLayout_z.reversedDir_GR_z,
    thermalProp=thermProp,
    each T_init_unif=T_init_unif) "Grid segments in grid zone" annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

// Heat ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_to[sum(zoneLayout_r.M_nodesPerSec)] "Heat ports at top boundary" annotation (Placement(transformation(extent={{-10,100},
            {10,80}}),iconTransformation(extent={{-8,108},{8,92}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_bo[sum(zoneLayout_r.M_nodesPerSec)] "Heat ports at bottom boundary" annotation (Placement(transformation(extent={{-10,
            -100},{10,-80}}),
                            iconTransformation(extent={{-8,-108},{8,-92}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_le[sum(zoneLayout_z.N_nodesPerSec)] "Heat ports at left boundary" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-90,0}), iconTransformation(
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={-100,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPorts_ri[sum(zoneLayout_z.N_nodesPerSec)] "Heat ports at right boundary" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,0}), iconTransformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={100,0})));

// Temperature monitoring points
  parameter Modelica.Units.SI.Radius r_TMP[:] = fill(0,0)
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...)";
  final parameter Modelica.Units.SI.Radius r_TMP_act[:] = if N_TMP > 0 then r_TMP + fill(Modelica.Constants.eps, N_TMP) else r_TMP
    "Global radial positions of temperature monitoring points in grid zone (r_TMP[1]: Radial position of monitoring point #1, ...) (actual value)"
    annotation (HideResult=true);
  parameter Modelica.Units.SI.Distance z_TMP[:] = fill(0,0)
    "Global axial positions of temperature monitoring points in grid zone  (z_TMP[1]: Axial position of monitoring point #1, ...)";

  final parameter Integer N_TMP = size(r_TMP,1) "No. of temperature monitoring points in entire grid zone";

  final parameter Integer m_TMP_Sec_r[N_TMP]=
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation.getRadialPosIndex_GridZone_AllTMP(
      r_TMP_act,
      zoneLayout_r.r_Sec_le,
      zoneLayout_r.r_Sec_ri) "Indices of the radial sections of the monitoring point positions";
  final parameter Integer n_TMP_Sec_z[N_TMP]=
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation.getAxialPosIndex_GridZone_AllTMP(
      z_TMP,
      zoneLayout_z.z_Sec_to_glo,
      zoneLayout_z.z_Sec_bo_glo) "Indices of the axial sections of the monitoring point positions";

  final parameter Integer m_TMP_RP_r[N_TMP,4]( each fixed=false, each start=1)
    "Radial indices of interpolation reference points {RP top-left, RP top-right, RP bottom-left, RP bottom-right}, m=0: left boundary, m=-1: right boundary";
  final parameter Integer n_TMP_RP_z[N_TMP,4]( each fixed=false, each start=1)
    "Axial indices of interpolation reference points {RP top-left, RP top-right, RP bottom-left, RP bottom-right}, n=0: top boundary, n=-1: bottom boundary";
  final parameter Modelica.Units.SI.Radius r_TMP_RP[N_TMP,4](  each fixed=false)
    "Radial positions of interpolation reference points {RP top-left, RP top-right, RP bottom-left, RP bottom-right}";
  final parameter Modelica.Units.SI.Distance z_TMP_RP[N_TMP,4](  each fixed=false)
    "Axial positions of interpolation reference points {RP top-left, RP top-right, RP bottom-left, RP bottom-right}";

  Modelica.Units.SI.Temperature T_TMP[N_TMP] "Temperatures of defined monitoring points (T_TMP[1]: Monitoring point #1, ...)";

//   parameter Boolean HideVarRes = true;

initial equation

// Grid segments
  for m in 1:zoneLayoutPar_r.M_Sec_r loop
    for n in 1:zoneLayoutPar_z.N_Sec_z loop
      //segments[m,n].T_init_unif = T_init_unif;
      //segments[m,n].GR_r = zoneLayoutPar_r.GR_r;
      //segments[m,n].GR_z = zoneLayout_z.GR_z;
      segments[m,n].r_le = zoneLayout_r.r_Sec_le[m];
      segments[m,n].r_ri = zoneLayout_r.r_Sec_ri[m];
      segments[m,n].z_to_glo = zoneLayout_z.z_Sec_to_glo[n];
      segments[m,n].z_bo_glo = zoneLayout_z.z_Sec_bo_glo[n];
    end for;
  end for;

// Temperature monitoring points
  for i in 1:size(T_TMP,1) loop
    (m_TMP_RP_r[i, :],n_TMP_RP_z[i, :],r_TMP_RP[i, :],z_TMP_RP[i, :]) =
      LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation.groundTempInterpolGridSegmentRect(
      r=r_TMP_act[i],
      z=z_TMP[i],
      r_vec=segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].gridLayout.r,
      r_l=segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].r_le,
      r_r=segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].r_ri,
      z_vec=segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].gridLayout.z_glo,
      z_t=segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].z_to_glo,
      z_b=segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].z_bo_glo);
  end for;

equation

// Grid segments
  // Internal
  for m in 1:zoneLayoutPar_r.M_Sec_r-1 loop
    for n in 1:zoneLayoutPar_z.N_Sec_z loop
      connect(segments[m,n].heatPorts_ri, segments[m+1,n].heatPorts_le);
    end for;
  end for;

  for m in 1:zoneLayoutPar_r.M_Sec_r loop
    for n in 1:zoneLayoutPar_z.N_Sec_z-1 loop
      connect(segments[m,n].heatPorts_bo, segments[m,n+1].heatPorts_to);
    end for;
  end for;

  // Boundaries
  for m in 1:zoneLayoutPar_r.M_Sec_r loop
    connect(heatPorts_to[(if m==1 then 1 else sum(zoneLayout_r.M_nodesPerSec[1:m-1])+1):sum(zoneLayout_r.M_nodesPerSec[1:m])], segments[m,1].heatPorts_to);
    connect(heatPorts_bo[(if m==1 then 1 else sum(zoneLayout_r.M_nodesPerSec[1:m-1])+1):sum(zoneLayout_r.M_nodesPerSec[1:m])], segments[m,end].heatPorts_bo);
  end for;

  for n in 1:zoneLayoutPar_z.N_Sec_z loop
    connect(heatPorts_le[(if n==1 then 1 else sum(zoneLayout_z.N_nodesPerSec[1:n-1])+1):sum(zoneLayout_z.N_nodesPerSec[1:n])], segments[1,n].heatPorts_le);
    connect(heatPorts_ri[(if n==1 then 1 else sum(zoneLayout_z.N_nodesPerSec[1:n-1])+1):sum(zoneLayout_z.N_nodesPerSec[1:n])], segments[end,n].heatPorts_ri);
  end for;

// Temperature monitoring points
  for i in 1:size(T_TMP,1) loop
    T_TMP[i] =LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation.groundTempInterpolation_AxialRadial(
      r_TMP_act[i],
      z_TMP[i],
      if m_TMP_RP_r[i, 1] == 0 then (if n_TMP_RP_z[i, 1] == 0 then segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_le[1].T else segments[
        m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_le[n_TMP_RP_z[i, 1]].T) elseif n_TMP_RP_z[i, 1] == 0 then segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_to[
        m_TMP_RP_r[i, 1]].T else segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].nodes[m_TMP_RP_r[i, 1], n_TMP_RP_z[i, 1]].T,
      r_TMP_RP[i, 1],
      z_TMP_RP[i, 1],
      if m_TMP_RP_r[i, 2] == -1 then (if n_TMP_RP_z[i, 2] == 0 then segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_ri[1].T else segments[
        m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_ri[n_TMP_RP_z[i, 2]].T) elseif n_TMP_RP_z[i, 2] == 0 then segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_to[
        m_TMP_RP_r[i, 2]].T else segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].nodes[m_TMP_RP_r[i, 2], n_TMP_RP_z[i, 2]].T,
      r_TMP_RP[i, 2],
      z_TMP_RP[i, 2],
      if m_TMP_RP_r[i, 3] == 0 then (if n_TMP_RP_z[i, 3] == -1 then segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_le[end].T else segments[
        m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_le[n_TMP_RP_z[i, 3]].T) elseif n_TMP_RP_z[i, 3] == -1 then segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_bo[
        m_TMP_RP_r[i, 3]].T else segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].nodes[m_TMP_RP_r[i, 3], n_TMP_RP_z[i, 3]].T,
      r_TMP_RP[i, 3],
      z_TMP_RP[i, 3],
      if m_TMP_RP_r[i, 4] == -1 then (if n_TMP_RP_z[i, 4] == -1 then segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_ri[end].T else segments[
        m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_ri[n_TMP_RP_z[i, 4]].T) elseif n_TMP_RP_z[i, 4] == -1 then segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].heatPorts_bo[
        m_TMP_RP_r[i, 4]].T else segments[m_TMP_Sec_r[i], n_TMP_Sec_z[i]].nodes[m_TMP_RP_r[i, 4], n_TMP_RP_z[i, 4]].T,
      r_TMP_RP[i, 4],
      z_TMP_RP[i, 4]);
  end for;

  annotation (
    defaultComponentName="rectangGridZone",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-150,150},{150,110}},
          lineColor={0,0,255},
          textString="%name",
          fontName="Times New Roman")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}}), graphics={
        Rectangle(
          extent={{-90,90},{90,-90}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-120,100},{-120,124}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-100,120},{-124,120}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-112,120},{-92,110}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="r, m"),
        Text(
          extent={{-120,110},{-100,100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="z, n"),
        Ellipse(
          extent={{-122,118},{-118,122}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,-30},{90,-30}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-90,30},{90,30}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{30,90},{30,-90}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-30,90},{-30,-90}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Text(
          extent={{-70,110},{-50,98}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{-10,110},{10,98}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="m"),
        Text(
          extent={{50,110},{70,98}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="M"),
        Text(
          extent={{-114,66},{-94,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="1"),
        Text(
          extent={{-114,6},{-94,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="n"),
        Text(
          extent={{-114,-54},{-94,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="N"),
        Rectangle(
          extent={{-30,30},{30,-30}},
          lineColor={244,125,35},
          lineThickness=0.5,
          pattern=LinePattern.Dash,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Text(
          extent={{-70,66},{-50,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[1, 1]"),
        Text(
          extent={{-12,68},{8,52}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[m, 1]"),
        Text(
          extent={{50,66},{70,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[M, 1]"),
        Text(
          extent={{50,6},{70,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[M, n]"),
        Text(
          extent={{-70,6},{-50,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[1, n]"),
        Text(
          extent={{-70,-54},{-50,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[1, N]"),
        Text(
          extent={{-8,-54},{12,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[m, N]"),
        Text(
          extent={{50,-54},{70,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="[M, N]"),
        Text(
          extent={{-70,78},{-50,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Segment"),
        Text(
          extent={{50,-42},{70,-54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          fontName="Times New Roman",
          textString="Segment")}),
    Documentation(info="<html>

<p>
Grid (mesh) zone model with rectangular cross-section. 
</p>

<p>
<em>[Further model documentation to be added.]</em>
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
end GridZone_Rect;
