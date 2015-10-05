#!/bin/bash

#SBATCH -p mb

#SBATCH -J ictp-test
#SBATCH -o ictp_%j.out
#SBATCH -e ictp_%j.err

#SBATCH --ntasks=1
#SBATCH --nodes=1

#SBATCH --time=00:06:00
#SBATCH --gres=gpu

# Print the node list
echo "Running on nodes: $SLURM_JOB_NODELIST" 

# Get Epoch time stamp at the beginning
DATE_S=`date +%s`

# loop over frequencies: 1.6 GHz and 0.8 GHz
for f in 1600 800 ; do
  # loop over number of threads: 1 or 2
  for t in 1 2 ; do
    export OMP_NUM_THREADS=$t
    echo "======================================================================="
    echo "$OMP_NUM_THREADS core(s) / Freq = $f MHz / NO GPU"
    srun --cpu-freq=${f}000 /home/ictp17/bagus/es1
    srun --cpu-freq=200000 sleep 10
  done
done

export OMP_NUM_THREADS=1

# Run on 1 core @ 1.6 GHz + GPU
f=1600
echo "======================================================================="
echo "$OMP_NUM_THREADS core(s) / Freq = $f MHz / GPU"
srun --cpu-freq=${f}000 /home/ictp17/bagus/es2
srun --cpu-freq=200000 sleep 10

# Run on 1 core @ 0.8 GHz + GPU
f=800
echo "======================================================================="
echo "$OMP_NUM_THREADS core(s) / Freq = $f MHz / GPU"
srun --cpu-freq=${f}000 /home/ictp17/bagus/es2
srun --cpu-freq=200000 sleep 10

# Get Epoch time stamp at the end
DATE_E=`date +%s`

# Print start and end timestamps for retrieving power data
echo "Job start / end: $DATE_S $DATE_E"

echo "For getting power data of this job run: "
echo "  dcdbquery -h mb.mont.blanc -r $SLURM_JOB_NODELIST-PWR $DATE_S $DATE_E"


