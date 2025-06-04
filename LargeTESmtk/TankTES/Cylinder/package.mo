within LargeTESmtk.TankTES;
package Cylinder "TTES models with cylindrical fluid domain geometry"
  extends Icons.Pkg_CylinderFD;
  extends Icons.BaseClasses.Frame_Package;

  annotation (Documentation(info="<html>

<p>
This package includes TTES models with a cylinder as fluid domain geometry. 
The individual models are named (categorized) after the storage construction type (i.e., aboveground (freestanding), partially buried, and fully buried). 
</p>

<p>
Additional suffixes indicate distinctive model versions, features, or configurations:

<ul> 
<li>Models with the suffix <code>_Basic</code> (e.g., <code>FullyBuried_Basic</code>) are the most basic model versions, offering limited flexibility (e.g., uniform ground properties).</li>
<li>Models with the suffix <code>_CustomGD</code> (e.g., <code>FullyBuried_CustomGD</code>) have customizable ground domains. 
This allows users, for example, to specify different horizontal ground layers or to consider multi-layered storage walls.</li>
</ul> 

  
</p>

</html>"));
end Cylinder;
