within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
record NodeDim_Axial "Individual node dimensions of grid segment/zone (axial direction)"
  extends Modelica.Icons.Record;

  parameter Integer N_z(min=1) = 10 "Number of axial nodes" annotation (HideResult=false);

  final parameter Modelica.Units.SI.Distance z_to_glo[N_z](each fixed=false)
    "Axial distances to top boundaries of the individual nodes (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Distance z_bo_glo[N_z](each fixed=false)
    "Axial distances to bottom boundaries of the individual nodes (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Distance z_glo[N_z](each fixed=false)
    "Axial distances to centers of the individual nodes (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Length dz[N_z](each fixed=false) "Sizes of individual nodes in axial direction";

  final parameter Modelica.Units.SI.Distance z_to[N_z](each fixed=false)
    "Axial distances to top boundaries of the individual nodes (w.r.t. local coordinate system)";
  final parameter Modelica.Units.SI.Distance z_bo[N_z](each fixed=false)
    "Axial distances to bottom boundaries of the individual nodes (w.r.t. local coordinate system)";
  final parameter Modelica.Units.SI.Distance z[N_z](each fixed=false)
    "Axial distances to centers of the individual nodes (w.r.t. local coordinate system)";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Record with individual node dimensions and coordinates of a grid segment or zone in axial direction.
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
end NodeDim_Axial;
