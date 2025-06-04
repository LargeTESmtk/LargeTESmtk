within LargeTESmtk.Utilities.TestFrameworks;
block SimpleLoadProfile "Modified 'CombiTimeTable' with simplified load profile"
  extends Modelica.Blocks.Sources.CombiTimeTable(
    final table=[0,VFlow_ch_in,T_ch_in,T_dis_in; t_ch,VFlow_ch_in,T_ch_in,T_dis_in; t_ch,0,T_ch_in,T_dis_in; t_ch + t_store,0,T_ch_in,T_dis_in; t_ch +
        t_store,-VFlow_dis_in,T_ch_in,T_dis_in; t_ch + t_store + t_dis,-VFlow_dis_in,T_ch_in,T_dis_in; t_ch + t_store + t_dis,0,T_ch_in,
        T_dis_in; t_ch + t_store + t_dis + t_idle,0,T_ch_in,T_dis_in],
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    final shiftTime=t_ch_start,
    final tableOnFile,
    final tableName,
    final fileName,
    final verboseRead,
    final columns,
    final timeScale,
    final offset,
    final startTime,
    final timeEvents,
    final verboseExtrapolation);

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
  parameter Modelica.Units.SI.Temperature T_dis_in = (273.15) + 42
    "Inlet temperature during discharging" annotation(Dialog(group="Temperatures"));

// Volume flow rates
  parameter Modelica.Units.SI.VolumeFlowRate VFlow_ch_in = (1/3600) * 500
    "Inlet volume flow rate during charging" annotation(Dialog(group="Volume flow rates"));
  parameter Modelica.Units.SI.VolumeFlowRate VFlow_dis_in = (1/3600) * 500
    "Inlet volume flow rate during discharging" annotation(Dialog(group="Volume flow rates"));

  annotation(Documentation(info="<html>

<p>
<em>[Further model documentation to be added.]</em>
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
end SimpleLoadProfile;
