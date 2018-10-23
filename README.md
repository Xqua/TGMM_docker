# TGMM_docker
Docker image for TGMM, using nvidia-docker 

## Requirement 
- CUDA enabled system
- docker
- nvidia-docker: https://github.com/NVIDIA/nvidia-docker

## Testing
./test.sh 

## Usage
nvidia-docker run -v PATH/TO/data:/usr/src/app/TGMM/data -v PATH/TO/results:/usr/src/app/TGMM/TGMMruns -it TGMM FIRST_TP LAST_TP NB_CPU
