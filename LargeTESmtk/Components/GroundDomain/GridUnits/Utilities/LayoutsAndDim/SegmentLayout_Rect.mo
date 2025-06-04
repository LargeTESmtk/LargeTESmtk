within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim;
record SegmentLayout_Rect "[revision planned] Rectangular grid segment layout"
  extends Modelica.Icons.UnderConstruction;

  parameter Integer M_r(min=1) = 10 "Number of radial nodes" annotation (HideResult=true);
  parameter Integer N_z(min=1) = 10 "Number of axial nodes" annotation (HideResult=true);

  final parameter Modelica.Units.SI.Radius r_le[M_r](each fixed=false) "Radial distances to left boundaries of the individual nodes";
  final parameter Modelica.Units.SI.Radius r_ri[M_r](each fixed=false) "Radial distances to right boundaries of the individual nodes";
  final parameter Modelica.Units.SI.Radius r[M_r](each fixed=false) "Radial distances to centers of the individual nodes";
  final parameter Modelica.Units.SI.Length dr[M_r](each fixed=false) "Sizes of individual nodes in radial direction";

  final parameter Modelica.Units.SI.Distance z_to[N_z](each fixed=false)
    "Axial distances to top boundaries of the individual nodes (w.r.t. (local) grid segment)";
  final parameter Modelica.Units.SI.Distance z_bo[N_z](each fixed=false)
    "Axial distances to bottom boundaries of the individual nodes (w.r.t. (local) grid segment)";
  final parameter Modelica.Units.SI.Distance z[N_z](each fixed=false)
    "Axial distances to centers of the individual nodes (w.r.t. (local) grid segment)";
  final parameter Modelica.Units.SI.Length dz[N_z](each fixed=false) "Sizes of individual nodes in axial direction";

  final parameter Modelica.Units.SI.Distance z_to_glo[N_z](each fixed=false)
    "Axial distances to top boundaries of the individual nodes (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Distance z_bo_glo[N_z](each fixed=false)
    "Axial distances to bottom boundaries of the individual nodes (w.r.t. global coordinate system)";
  final parameter Modelica.Units.SI.Distance z_glo[N_z](each fixed=false)
    "Axial distances to centers of the individual nodes (w.r.t. global coordinate system)";

  annotation (defaultComponentName="gridLayout",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
Rectangular grid segment layout, i.e., the reference framework of the grid segment that defines the dimensions and coordinates of the individual nodes.
</p>

<h4>Revision planned</h4>
<p>
It is planned to replace this record in a future release with the 
<a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.SegmentLayout_Rect_Radial\">SegmentLayout_Rect_Radial</a> model and 
<a href=\"modelica://LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.LayoutsAndDim.SegmentLayout_Rect_Axial\">SegmentLayout_Rect_Axial</a> model.
This will harmonize the implementation of the grid zone and grid segment models. 
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
end SegmentLayout_Rect;
