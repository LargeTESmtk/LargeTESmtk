within LargeTESmtk.Components.GroundDomain.Utilities.FluidDomPar;
record FluidDomPar_Cylinder "Fluid domain dimensions and grid parameters (cylinder geometry)"
  extends FluidDomain.Utilities.SegmentDim.SegDim_Cylinder(
    z_to_glo(fixed=true),
    dz(fixed=true),
    final z_to_glo_TopNode=z_to_glo);

  parameter Integer N_z(min=2) = 50 "Number of (axial) nodes" annotation (Dialog(group="Grid parameters"));

annotation(defaultComponentName="fluidDomainPar", Documentation(info="<html>

<p>
Record with fluid domain dimensions, coordinates, and grid parameters with cylindrical geometry.
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
end FluidDomPar_Cylinder;
