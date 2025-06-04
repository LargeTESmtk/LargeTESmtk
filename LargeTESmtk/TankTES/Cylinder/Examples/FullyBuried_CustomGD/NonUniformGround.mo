within LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_CustomGD;
model NonUniformGround "Model with specified vertical and horizontal ground layers"
  extends LargeTESmtk.TankTES.Cylinder.Examples.TestFrameworks.TestFramework(redeclare
      LargeTESmtk.TankTES.Cylinder.Examples.FullyBuried_CustomGD.Parameters.ModelParameters modelPar, redeclare
      LargeTESmtk.TankTES.Cylinder.FullyBuried_CustomGD storage(
      fluidDomDim(r=modelPar.r_FD, dz=modelPar.dz_FD),
      N_FD_z=modelPar.N_FD_z,
      redeclare package storageMedium = storageFluid,
      h_FD_top=modelPar.h_FD_top,
      h_FD_sid=modelPar.h_FD_sid,
      h_FD_bot=modelPar.h_FD_bot,
      tau_buo=modelPar.tau_buo,
      m_flow_nominal=m_flow_nominal,
      T_FD_init_unif=modelPar.T_FD_init_unif,
      r_GD_bou=modelPar.r_GD_bou,
      z_GD_bou=modelPar.z_GD_bou,
      gridAreaPar_Fl_r(
        M_Sec_r=modelPar.M_Fl_Sec_r,
        dr_Sec_input=modelPar.dr_Fl_Sec_input,
        dr_smallestNo=modelPar.dr_Fl_smallestNo,
        GR_r=modelPar.GR_Fl_r,
        reversedDir_GR_r=modelPar.reversedDir_GR_Fl_r),
      gridAreaPar_Ri_r(
        M_Sec_r=modelPar.M_Ri_Sec_r,
        dr_Sec_input=modelPar.dr_Ri_Sec_input,
        dr_smallestNo=modelPar.dr_Ri_smallestNo,
        GR_r=modelPar.GR_Ri_r,
        reversedDir_GR_r=modelPar.reversedDir_GR_Ri_r),
      gridAreaPar_Fl_z(N_Sec_z=modelPar.N_Fl_Sec_z, z_Sec_bo_glo_input=modelPar.z_Fl_Sec_bo_glo_input),
      gridAreaPar_Bo_z(
        N_Sec_z=modelPar.N_Bo_Sec_z,
        z_Sec_bo_glo_input=modelPar.z_Bo_Sec_bo_glo_input,
        useEquidistantGrid_z=modelPar.useEquidistantGrid_Bo_z,
        dz_smallestNo=modelPar.dz_Bo_smallestNo,
        GR_z=modelPar.GR_Bo_z,
        reversedDir_GR_z=modelPar.reversedDir_GR_Bo_z),
      useUnifThermProp_RiTo=modelPar.useUnifThermProp_RiTo,
      thermProp_RiTo_unif=modelPar.thermProp_RiTo_unif,
      thermProp_RiTo_spec=modelPar.thermProp_RiTo_spec,
      useUnifThermProp_RiFl=modelPar.useUnifThermProp_RiFl,
      thermProp_RiFl_unif=modelPar.thermProp_RiFl_unif,
      thermProp_RiFl_spec=modelPar.thermProp_RiFl_spec,
      useUnifThermProp_FlBo=modelPar.useUnifThermProp_FlBo,
      thermProp_FlBo_unif=modelPar.thermProp_FlBo_unif,
      thermProp_FlBo_spec=modelPar.thermProp_FlBo_spec,
      useUnifThermProp_RiBo=modelPar.useUnifThermProp_RiBo,
      thermProp_RiBo_unif=modelPar.thermProp_RiBo_unif,
      thermProp_RiBo_spec=modelPar.thermProp_RiBo_spec,
      T_RiTo_init_unif=modelPar.T_RiTo_init_unif,
      T_RiFl_init_unif=modelPar.T_RiFl_init_unif,
      T_FlBo_init_unif=modelPar.T_FlBo_init_unif,
      T_RiBo_init_unif=modelPar.T_RiBo_init_unif,
      T_ref=modelPar.T_ref,
      h_GD_conv=modelPar.h_GD_conv,
      useRadHeatTransfer_GD=modelPar.useRadHeatTransfer_GD,
      alpha_GD_solar=modelPar.alpha_GD_solar,
      eps_GD=modelPar.eps_GD,
      useCapCover=modelPar.useCapCover,
      U_Co=modelPar.U_Co,
      h_Co_conv=modelPar.h_Co_conv,
      useRadHeatTransfer_Co=modelPar.useRadHeatTransfer_Co,
      alpha_Co_solar=modelPar.alpha_Co_solar,
      eps_Co=modelPar.eps_Co,
      U_InsExt=modelPar.U_InsExt,
      M_InsExt_r=modelPar.M_InsExt_r,
      r_TMP_Co=modelPar.r_TMP_Co,
      z_TMP_Co=modelPar.z_TMP_Co,
      r_TMP_RiTo=modelPar.r_TMP_RiTo,
      z_TMP_RiTo=modelPar.z_TMP_RiTo,
      r_TMP_RiFl=modelPar.r_TMP_RiFl,
      z_TMP_RiFl=modelPar.z_TMP_RiFl,
      r_TMP_FlBo=modelPar.r_TMP_FlBo,
      z_TMP_FlBo=modelPar.z_TMP_FlBo,
      r_TMP_RiBo=modelPar.r_TMP_RiBo,
      z_TMP_RiBo=modelPar.z_TMP_RiBo,
      dz_Co=modelPar.dz_Co,
      useEquidistantGrid_Co_z=modelPar.useEquidistantGrid_Co_z,
      dz_Co_smallestNo=modelPar.dz_Co_smallestNo,
      GR_Co_z=modelPar.GR_Co_z,
      reversedDir_GR_Co_z=modelPar.reversedDir_GR_Co_z,
      N_Co_Nodes_z=modelPar.N_Co_Nodes_z,
      thermProp_Co_unif=modelPar.thermProp_Co_unif,
      T_Co_init_unif=modelPar.T_Co_init_unif));

  annotation (experiment(
      StartTime=13046400,
      StopTime=63072000,
      Interval=3600,
      Tolerance=1e-09,
      __Dymola_Algorithm="Dopri45"), Documentation(info="<html>

<p>
This an example model that demonstrates the customizable ground domain model with one vertical ground layer (next to the fluid domain) and one horizontal ground layer 
(below the fluid domain) with deviating thermal properties compared to the remaining ground domain.
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
end NonUniformGround;
