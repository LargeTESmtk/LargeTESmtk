within LargeTESmtk.Utilities.TestFrameworks.PartialParRecords;
record PartialSimpleLoadProfilePar "Partial record with common load profile parameters for test framework"
  extends Modelica.Icons.Record;

// Placeholder parameter for future implementation
  final parameter Boolean useLoadProfileFromFile = false
    "= true: Mass flow from file is to be used; = false: Volume flow rates given below are to be used" annotation(HideResult=true);

// Parameters of simplified load profile
  // Storage phases
  parameter Modelica.Units.SI.Time t_ch = (24*3600) * 122
    "Duration of charging phase per cycle (default: June-Sept)" annotation(Dialog(group="Storage phases"));
  parameter Modelica.Units.SI.Time t_store = (24*3600) * 61
    "Duration of storage phase (in charged state) per cycle (default: Oct-Nov)" annotation(Dialog(group="Storage phases"));
  parameter Modelica.Units.SI.Time t_dis = (24*3600) * 100
    "Duration of discharging phase per cycle (default: starting w/ Dec)" annotation(Dialog(group="Storage phases"));
  parameter Modelica.Units.SI.Time t_idle = (24*3600) * 365 - (t_ch+t_store+t_dis)
    "Duration of idle phase (in discharged state) per cycle" annotation(Dialog(group="Storage phases"));

  parameter Modelica.Units.SI.Time t_ch_start = (24*3600) * 151
    "Start time of charging phase (= time shift of load profile) (default: June 1 00:00)" annotation(Dialog(group="Storage phases"));

  // Temperatures
  parameter Modelica.Units.SI.Temperature T_ch_in = (273.15) + 95
    "Inlet temperature during charging" annotation(Dialog(group="Temperatures"));
  parameter Modelica.Units.SI.Temperature T_dis_in = (273.15) + 55
    "Inlet temperature during discharging" annotation(Dialog(group="Temperatures"));

  // Volume flow rates
  parameter Modelica.Units.SI.VolumeFlowRate VFlow_ch_in = (1/3600) * 60
    "Inlet volume flow rate during charging" annotation(Dialog(group="Volume flow rates"));
  parameter Modelica.Units.SI.VolumeFlowRate VFlow_dis_in = (1/3600) * 60
    "Inlet volume flow rate during discharging" annotation(Dialog(group="Volume flow rates"));

// Storage (heat transfer) fluid properties
  constant Modelica.Units.SI.SpecificHeatCapacity cp_fl_const = 4179
    "Specific heat capacity of storage fluid" annotation(Dialog(group="Storage (heat transfer) fluid properties"));
  constant Modelica.Units.SI.Density d_fl_const = 990
    "Density of storage fluid" annotation(Dialog(group="Storage (heat transfer) fluid properties"));
  constant Modelica.Units.SI.ThermalConductivity k_fl_const = 0.64
    "Thermal conductivity of storage fluid" annotation(Dialog(group="Storage (heat transfer) fluid properties"));

  annotation (defaultComponentName="loadProfilePar",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
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
end PartialSimpleLoadProfilePar;
