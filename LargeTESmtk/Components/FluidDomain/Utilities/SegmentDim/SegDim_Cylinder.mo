within LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim;
record SegDim_Cylinder "Record with cylindrical volume segment dimensions"

  parameter Modelica.Units.SI.Radius r "Radius";

  extends LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim.PartialSegDim(
    final A_r=2*r*Modelica.Constants.pi*dz,
    final A_z_to=r^2*Modelica.Constants.pi,
    final A_z_bo=A_z_to,
    final A=A_z_to + A_z_bo + A_r,
    final V=A_z_to*dz);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This record includes the dimensional parameters for a cylindrical volume segment to be used in a fluid domain model.  
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
end SegDim_Cylinder;
