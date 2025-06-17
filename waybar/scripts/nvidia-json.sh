#!/bin/bash

FIELDS=("name" "fan_speed" "pstate" "memory_used" "utilization_gpu" "temperature_gpu" "power_draw_average")

nvidia-smi --query-gpu=name,fan.speed,pstate,memory.used,utilization.gpu,temperature.gpu,power.draw.average --format=csv,noheader,nounits |
  awk -F', ' -v fields="${FIELDS[*]}" '
  BEGIN {
    split(fields, f, " ");
  }
  {
    printf "{";
    for (i = 1; i <= NF; i++) {
      printf "\"%s\":\"%s\"", f[i], $i;
      if (i < NF) printf ",";
    }
    print "}";
  }' | jq --unbuffered --compact-output '.'

