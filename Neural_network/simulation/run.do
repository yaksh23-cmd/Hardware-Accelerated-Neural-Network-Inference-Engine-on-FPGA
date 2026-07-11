quietly set ACTELLIBNAME PolarFireSoC
quietly set PROJECT_DIR "C:/Microchip_projects/personal/Neural_network"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap polarfire "C:/Microchip/Libero_SoC_2025.2/Libero_SoC/Designer/lib/modelsimpro/precompiled/vlog/polarfire"

vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/axi_lite_wrapper.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/relu.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/Sig_ROM.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/Weight_Memory.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/neuron.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/Layer_1.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/Layer_2.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/Layer_3.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/Layer_4.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/maxFinder.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -sv -work presynth "${PROJECT_DIR}/hdl/zynet.v"
vlog "+incdir+${PROJECT_DIR}/hdl" "+incdir+${PROJECT_DIR}/stimulus" -sv -work presynth "${PROJECT_DIR}/stimulus/top_sim.v"

vsim -L polarfire -L presynth  -t 1ps -pli C:/Microchip/Libero_SoC_2025.2/Libero_SoC/Designer/lib/modelsimpro/pli/pf_crypto_win_me_pli.dll presynth.top_sim
add wave /top_sim/*
run 1000ns
