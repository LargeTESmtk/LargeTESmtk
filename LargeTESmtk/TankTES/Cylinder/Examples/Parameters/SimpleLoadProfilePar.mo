within LargeTESmtk.TankTES.Cylinder.Examples.Parameters;
record SimpleLoadProfilePar "Record with common load profile parameters for example models"
  extends Utilities.TestFrameworks.PartialParRecords.PartialSimpleLoadProfilePar;

  annotation (defaultComponentName="loadProfilePar",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

<p>
This record can be usd to globally define the corresponding parameters for all example models. Alternatively, the parameters can also be defined individually in each model. 
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
end SimpleLoadProfilePar;
