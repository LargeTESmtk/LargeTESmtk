within LargeTESmtk.Components.GroundDomain.GridUnits.Utilities.Functions.GroundTempInterpolation;
function getFirstPositionInVector

  input Modelica.Units.SI.Radius x "Global position of wanted temperature";
  input Modelica.Units.SI.Radius x_vec[:] "Given vector";

  output Integer n "Index of vector";

algorithm

n := 1;

while x > x_vec[n] loop
  n := n+1;
end while;

n := n-1;

  annotation (Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end getFirstPositionInVector;
