within LargeTESmtk.PitTES;
package TrunCone "[under construction] PTES models with inverted truncated cone fluid domain geometry"
  extends Icons.Pkg_TrunConeFD;
  extends Icons.BaseClasses.Frame_Package;

  extends Modelica.Icons.UnderConstruction;

  annotation (Documentation(info="<html>

<p>
This package includes PTES models with an inverted truncated cone as fluid domain geometry. 
The individual models are named (categorized) after the storage construction type (i.e., partially or fully buried). 
</p>

<p>
Additional suffixes indicate distinctive model versions, features, or configurations:

<ul> 
<li>Models with the suffix <code>_Basic</code> (e.g., <code>FullyBuried_Basic</code>) are the most basic model versions, offering limited flexibility (e.g., uniform ground properties).</li>
<li>Models with the suffix <code>_CustomGD</code> (e.g., <code>FullyBuried_CustomGD</code>) have customizable ground domains. 
This allows users, for example, to specify different horizontal ground layers.</li>
</ul> 

  
</p>

</html>"));
end TrunCone;
