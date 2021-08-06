#!/bin/bash
#SBATCH -J prueba 
#SBATCH -o test.o%j
#SBATCH -n 4
#SBATCH --ntasks-per-node=4
#SBATCH -p comp
#SBATCH -t 01:00:00

echo $SLURM_JOB_ID
echo $SLURM_PRUEBA
echo $SLURM_JOB_NUM_NODES

# Load Intel Parallel Studio
module load compilers/devtoolset/4
module load tools/intel/impi/5.0.2.044
module load compilers/intel/parallel_studio_xe_2015/15.0.1

# Build the code
mpicxx main.cpp -std=c++0x -O3 -mavx  -pthread -o mpi

date;

# Run de program
time mpirun -np 4 mpi > mpi-simple.out

date;


exit 0;
