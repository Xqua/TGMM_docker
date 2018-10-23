#!/usr/bin/env bash
nvidia-docker run -v $(pwd)/results:/usr/src/app/TGMM/TGMMruns -it e05d512e9460 0 30 4
