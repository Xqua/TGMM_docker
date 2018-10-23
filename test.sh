#!/usr/bin/env bash
nvidia-docker run -v $(pwd)/data:/usr/src/app/TGMM/data -v $(pwd)/results:/usr/src/app/TGMM/TGMMruns -it e05d512e9460 0 30 4
