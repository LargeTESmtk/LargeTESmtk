within LargeTESmtk.Components.FluidDomain;
model TrunCone "Fluid domain model (inverted truncated cone geometry)"
  extends Icons.FluidDomain.FluidDom_TrunCone;
  extends LargeTESmtk.Components.FluidDomain.BaseClasses.PartialFluidDomain(redeclare
      LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim.SegDim_TrunCone fluidDomDim(r_to(fixed=true), r_bo(fixed=true)), redeclare final
      LargeTESmtk.Components.FluidDomain.Utilities.SegmentDim.SegDim_TrunCone nodeDim);

initial equation

  for n in 1:N_z loop
    nodeDim[n].r_to = fluidDomDim.r_bo+(fluidDomDim.dz-nodeDim[n].z_to)/tan(fluidDomDim.alpha);
    nodeDim[n].r_bo = fluidDomDim.r_bo+(fluidDomDim.dz-nodeDim[n].z_bo)/tan(fluidDomDim.alpha);
  end for;

  annotation (
    defaultComponentName="fluidDom",
    Documentation(info="<html>

<p>
Fluid domain model with inverted truncated cone geometry.
</p>

<h4>Buoyancy Model</h4>
<p>
See <a href=\"modelica://LargeTESmtk.Components.FluidDomain.BaseClasses.Buoyancy\">LargeTESmtk.Components.FluidDomain.BaseClasses.Buoyancy</a>.
</p>

<p>
<em>[Further model documentation to be added.]</em>
</p>

<h4>Original Model</h4>
<p>
The model's base class (partial model) is based on the <code>IBPSA.Fluid.Storage.BaseClasses.PartialStratified</code> model of the Modelica 
<a href=\"https://github.com/ibpsa/modelica-ibpsa/\">IBPSA</a> library. For further information, see 
documentation of <a href=\"modelica://LargeTESmtk.Components.FluidDomain.BaseClasses.PartialFluidDomain\">PartialFluidDomain</a> model.
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

</html>"),
    Icon(graphics={Line(
          points={{20,90},{20,38}},
          color={191,0,0},
          thickness=1,
          pattern=LinePattern.Dash), Line(
          points={{90,0},{70,0}},
          color={191,0,0},
          thickness=1,
          pattern=LinePattern.Dash),
                   Line(
          points={{20,-40},{20,-90}},
          color={191,0,0},
          thickness=1,
          pattern=LinePattern.Dash)}));
end TrunCone;
