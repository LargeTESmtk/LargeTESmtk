within LargeTESmtk.Utilities.Scripts.BaseClasses;
function PartialScript4SimRuns "Partial script for automatic simulation runs of selected models"

// Define protected variables
protected
  Boolean simulationSuccess;
  String modelName;
  String resultFileName;
  String par_Modif;

algorithm

// Fixed parameter modifier creation
  if parName[1]=="" then
    par_Modif := "";
  else
    for i in 1:size(parValue, 1) loop
      par_Modif := par_Modif + parName[i] + "=" + String(parValue[i])
         + (if i == size(parName, 1) then "" else ",");
    end for;
  end if;

  //Setting working directory and directory for sim results
  //cd(Directory);

// Run simulations with defined inputs
  for i in 1:size(solver, 1) loop
    for j in 1:size(solverTol, 1) loop
      for k in 1:size(modelNameBase, 1) loop
        for l in 1:size(modelNameSuffix, 1) loop

          experimentSetupOutput(events=false,equidistant=true); // To get equidistant time output

          modelName := modelNameBase[k] + modelNameSuffix[l];

          resultFileName := modelName + (if par_Modif == "" then "" else "_" + resultNameSuffix) + (if size(solver, 1) > 1 or size(solverTol, 1) > 1 then "_" + solver[i] + "_tol" + String(solverTol[j]) else "");

          simulationSuccess :=
          simulateModel(
            modelDir + "." + modelName +
            (if par_Modif == "" then "" else "(" + par_Modif + ")"),
            startTime = t_start,
            stopTime = t_stop,
            method = solver[i],
            tolerance = solverTol[j],
            outputInterval = dt_out,
            resultFile = resultFileName);

          if simulationSuccess then
            Modelica.Utilities.Streams.print("Simulation of "+resultFileName+" successful");
          else
            Modelica.Utilities.Streams.print("Simulation of "+resultFileName+" failed");
          end if;

          // plot({"thermColl_le.port_b.Q_flow"});
        end for;
      end for;
    end for;
  end for;

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
end PartialScript4SimRuns;
