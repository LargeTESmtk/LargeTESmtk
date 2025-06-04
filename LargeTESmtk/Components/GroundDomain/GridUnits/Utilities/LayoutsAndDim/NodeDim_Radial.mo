within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
record NodeDim_Radial "Individual node dimensions of grid segment/zone (radial direction)"
  extends Modelica.Icons.Record;

  parameter Integer M_r(min=1) "Number of nodes in radial direction" annotation(HideResult=false);

  final parameter Modelica.Units.SI.Radius r_le[M_r](each fixed=false) "Radial distances to left boundaries of the individual nodes";
  final parameter Modelica.Units.SI.Radius r_ri[M_r](each fixed=false) "Radial distances to right boundaries of the individual nodes";
  final parameter Modelica.Units.SI.Radius r[M_r](each fixed=false) "Radial distances to centers of the individual nodes";
  final parameter Modelica.Units.SI.Length dr[M_r](each fixed=false) "Sizes of individual nodes in radial direction";

  final parameter Modelica.Units.SI.Area A_z[M_r](fixed=false) "Top and bottom surface perpendicular to axial direction of individual nodes";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Record with individual node dimensions and coordinates of a grid segment or zone in radial direction.
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
end NodeDim_Radial;
