within LargeTESmtk.Components.GroundDomain;
package Cylinder "Ground domain models for cylindrical fluid domain geometry"
  extends Icons.Pkg_CylinderFD;
  extends Icons.BaseClasses.Frame_Package;
  annotation (Documentation(info="<html>

<p>
This package includes different ground domain models for a cylindrical fluid domain geometry. 
The individual models are named (categorized) after the storage construction type (i.e., aboveground (freestanding), partially buried, and fully buried). 
</p>

<p>
Additional suffixes indicate distinctive model versions, features, or configurations:

<ul> 
<li>Models with the suffix <code>_CustomGD</code> (e.g., <code>FullyBuried_CustomGD</code>) have customizable ground domains. 
This allows users, for example, to specify different horizontal ground layers or to consider multi-layered storage walls.</li>
</ul> 

</p>

</html>"));
end Cylinder;
