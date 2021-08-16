#!/bin/bash
#SBATCH -J motion 
#SBATCH -o motion.o%j
#SBATCH -n 96
#SBATCH --ntasks-per-node=24
#SBATCH -p comp
#SBATCH -t 120:00:00

echo $SLURM_JOB_ID
echo $SLURM_PRUEBA
echo $SLURM_JOB_NUM_NODES

# Load Intel Parallel Studio
source /opt/rh/devtoolset-7/enable
source /software/LNS/intel-parallel-studio-xe-2017/bin/compilervars.sh -arch intel64 -platform linux
source /software/LNS/intel-parallel-studio-xe-2017/impi/2017.4.239/bin64/mpivars.sh
source /software/LNS/intel-parallel-studio-xe-2017/mkl/bin/mklvars.sh intel64

# Build the code
mpicxx main.cpp SimplexAbstract.cpp SimplexAlpha.cpp LocalSearch.cpp Matrix.cpp Covering.hpp RCC.hpp -std=c++0x -O3 -mavx  -pthread -o motion 

date;

# Run de program
time mpirun -np 96 ./motion > motion.out

date;

exit 0;
