within LargeTESmtk.Components.FluidDomain.BaseClasses;
model Buoyancy "Model that accounts for buoyancy-induced natural convection in the storage"
  extends Modelica.Blocks.Icons.Block;

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model"  annotation (
      choicesAllMatching = true);

/* Diff
  /* Orig: 
    parameter Modelica.Units.SI.Volume V "Volume";
  /* Mod: */
    parameter Modelica.Units.SI.Volume V[nSeg] "Volume of segments";

  parameter Integer nSeg(min=2) = 2 "Number of volume segments";
  parameter Modelica.Units.SI.Time tau(min=0) "Time constant for mixing";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSeg] heatPort
    "Heat input into the volumes"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Units.SI.HeatFlowRate[nSeg - 1] Q_flow
    "Heat flow rate from segment i+1 to i";

/* Diff
  /* Orig: 
    protected
  /* Mod: */
    //protected

   parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(T=Medium.T_default,
         p=Medium.p_default, X=Medium.X_default[1:Medium.nXi])
    "Medium state at default properties";
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid mass";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(sta_default) "Specific heat capacity";

/* Diff
  /* Orig: 
    parameter Real k(unit="W/K") = V*rho_default*cp_default/tau/nSeg
      "Proportionality constant, since we use dT instead of dH";
  /* Mod: */
    parameter Real k[nSeg](each unit="W/K") = {V[n] * rho_default * cp_default / tau for n in 1:nSeg}
      "Proportionality constants, since we use dT instead of dH";

  Modelica.Units.SI.TemperatureDifference dT[nSeg - 1]
    "Temperature difference between adjoining volumes";
equation
  for i in 1:nSeg-1 loop
    dT[i] = heatPort[i+1].T-heatPort[i].T;

/* Diff
  /* Orig: 
    Q_flow[i] = k*noEvent(smooth(1, if dT[i]>0 then dT[i]^2 else 0));
  /* Mod: */
    Q_flow[i] = k[i+1]*noEvent(smooth(1, if dT[i]>0 then dT[i]^2 else 0));

  end for;

  heatPort[1].Q_flow = -Q_flow[1];
  for i in 2:nSeg-1 loop
       heatPort[i].Q_flow = -Q_flow[i]+Q_flow[i-1];
  end for;
  heatPort[nSeg].Q_flow = Q_flow[nSeg-1];
  annotation (Documentation(info="<html>

<p>
This buoyancy model accounts for buoyancy-induced natural convection in the storage when temperature inversion occurs 
(i.e., a higher fluid layer has a lower temperature than the layer below). Instead of the buoyancy-induced volume flow into the adjacent fluid volume 
above that occurs in reality, this volume flow is emulated by adding a corresponding heat flow rate to the fluid volume.
</p>

<h4>Parameterization</h4>
<p>
The model's parameter <code>tau_buo</code> is a time constant that determines how fast the temperature compensation between the fluid layers occurs. 
Usually <code>tau_buo=1s</code> provides solid results. 
</p>

<p>
<em>[Further model documentation to be added.]</em>
</p>

<h4>Original model</h4>
<p>
This model is based on the <code>IBPSA.Fluid.Storage.BaseClasses.Buoyancy</code> model of the Modelica 
<a href=\"https://github.com/ibpsa/modelica-ibpsa/\">IBPSA</a> library.
</p>                

<p>
<strong>Version:</strong> <code>4.0.0 (dev status)</code>  <br>
<strong>Branch:</strong> <code>master</code>  <br>
<strong>Commit:</strong> <a href=\"https://github.com/ibpsa/modelica-ibpsa/commit/e6de2f3eb075d20452092441f78ee36adfaf5824\">e6de2f3</a> <br>
<strong>Date:</strong> <code>2025-02-16</code>  <br>
</p>

<p>
Changes to the original code have been highlighted in the updated code.
</p> 

<h5>Third Party License</h5>
<p>
Modelica IBPSA Library. Copyright (c) 1998-2022
Modelica Association,
International Building Performance Simulation Association (IBPSA) and
contributors.
All rights reserved.
</p>
<p>
Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
</p>
<ol>
<li>
Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.
</li>
<li>
Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.
</li>
<li>
Neither the name of the copyright holder nor the names of its contributors may be used
to endorse or promote products derived from this software
without specific prior written permission.
</li>
</ol>
<p>
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
</p>
<p>
You are under no obligation whatsoever to provide any bug fixes, patches,
or upgrades to the features, functionality or performance of the source code
(\"Enhancements\") to anyone; however, if you choose to make your Enhancements
available either publicly, or directly to its copyright holders,
without imposing a separate written license agreement for such
Enhancements, then you hereby grant the following license: a non-exclusive,
royalty-free perpetual license to install, use, modify, prepare derivative
works, incorporate into other computer software, distribute, and sublicense
such enhancements or derivative works thereof, in binary and source code form.
</p>
<p>
Note: The license is a revised 3 clause BSD license with an ADDED paragraph
at the end that makes it easy to accept improvements.
</p>

<h4>Acknowledgment</h4>
<p>
Many thanks to the authors of the original model for sharing their valuable work. 
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
Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-44,68},{36,28}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,-26},{38,-66}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{26,10},{32,-22}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{28,22},{22,10},{36,10},{36,10},{28,22}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-32,22},{-26,-10}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-28,-18},{-36,-6},{-22,-6},{-22,-6},{-28,-18}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}));
end Buoyancy;
