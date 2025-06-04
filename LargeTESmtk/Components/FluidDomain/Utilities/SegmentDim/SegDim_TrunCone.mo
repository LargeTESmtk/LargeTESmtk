within LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim;
record SegDim_TrunCone "Record with truncated cone volume segment dimensions"

  parameter Modelica.Units.SI.Radius r_to(fixed=false) "Radius of top boundary surface";
  parameter Modelica.Units.SI.Radius r_bo(fixed=false) "Radius of bottom boundary surface";

  extends LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim.PartialSegDim(
    final A_r=dz/sin(alpha)*Modelica.Constants.pi*(r_to + r_bo),
    final A_z_to=r_to^2*Modelica.Constants.pi,
    final A_z_bo=r_bo^2*Modelica.Constants.pi,
    final A=A_z_to + A_z_bo + A_r,
    final V=1/3*dz*Modelica.Constants.pi*(r_to^2 + r_to*r_bo + r_bo^2));

  final parameter Modelica.Units.SI.Angle alpha = atan(dz/(r_to-r_bo)) "Slope angle";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This record includes the dimensional parameters for a inverted truncated cone volume segment to be used in a fluid domain model.  
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
end SegDim_TrunCone;
