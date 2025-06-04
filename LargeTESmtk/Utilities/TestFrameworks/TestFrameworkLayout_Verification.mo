within LargeTESmtk.Utilities.TestFrameworks;
model TestFrameworkLayout_Verification "Graphical layout for verification models"

  annotation (Diagram(coordinateSystem(extent={{-300,-160},{300,160}}), graphics={
        Rectangle(
          extent={{-94,160},{94,106}},
          lineColor={0,140,72},
          lineThickness=1,
          pattern=LinePattern.Dot),
        Text(
          extent={{-94,160},{94,140}},
          lineColor={0,140,72},
          textStyle={TextStyle.Bold,TextStyle.Italic},
          fontSize=14,
          fontName="Times New Roman",
          textString=" Verification Criteria"),
        Rectangle(
          extent={{-94,-106},{94,-160}},
          lineColor={0,140,72},
          lineThickness=1,
          pattern=LinePattern.Dot)}), Icon(coordinateSystem(extent={{-120,-100},{100,100}})),
    Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>"));
end TestFrameworkLayout_Verification;
