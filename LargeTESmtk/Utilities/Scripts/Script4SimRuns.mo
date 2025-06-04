within LargeTESmtk.Utilities.Scripts;
function Script4SimRuns "Script for automatic simulation runs of selected models"
  extends LargeTESmtk.Utilities.Scripts.BaseClasses.PartialScript4SimRuns;

// Directory and model names
  input String modelDir = "LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_Basic"
    "Directory of models to be simulated" annotation(Dialog(group="Directory and model names"));

  input String modelNameBase[:] = {""}
    "Base name of models to be simulated"  annotation(Dialog(group="Directory and model names"));

  input String modelNameSuffix[:]=
    {"UniformGround",
     "InsulationExtension",
     "CoverThermResist"}
    "Suffixes of models to be simulated"  annotation(Dialog(group="Directory and model names"));

// General simulation setup
  input Modelica.Units.SI.Time t_start = 0 "Start time of simulation" annotation(Dialog(group="General simulation setup"));
  input Modelica.Units.SI.Time t_stop = 8760*3600 "Simulation time" annotation(Dialog(group="General simulation setup"));

  input Modelica.Units.SI.Time dt_out = 1*3600 "Output time interval" annotation(Dialog(group="General simulation setup"));

  //input String Directory= "C:/Folder/Folder" "Directory for sim results";

// Solver settings
  input String solver[:] = {"dopri45"}
    "Solvers to be used (e.g., lsodar, dassl, radau, esdirk23a, dopri45, sdirk34hw, cerk23, cvode;)" annotation(Dialog(group="Solver settings"));
  input Real solverTol[:] = {1e-9}
    "Solver tolerances to be used" annotation(Dialog(group="Solver settings")); //e.g.{1e-9,1e-8,1e-7,1e-6,1e-5}

// Modified parameters for all models and simulation runs
  input String parName[:] = {""}
    "Name of parameters (if not used insert empty string)" annotation(Dialog(group="Modified parameters for all models and simulation runs")); //e.g. {"N_InsExt_r}
  input Real parValue[:] = {0}
    "Value of parameters" annotation(Dialog(group="Modified parameters for all models and simulation runs")); //e.g. {0}

  input String resultNameSuffix = ""
    "Result file name suffix to be added for changed parameters" annotation(Dialog(group="Modified parameters for all models and simulation runs"));

  annotation (Documentation(revisions="<html>

<p>
<ul>
<li>
June 03, 2025 by Michael Reisenbichler-S.:<br/>
First published version.
</li>
</ul>
</p>

</html>",
        info="<html>

<p>
This script can be used for automatic simulation runs of selected models. 
Additionally, the script allows simulation runs with varying solver settings and modified model parameters.
</p>

<p>
<em>[Further model documentation to be added.]</em>
</p>

</html>"));
end Script4SimRuns;
