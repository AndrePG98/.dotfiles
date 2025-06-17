#!/usr/bin/env python3
import subprocess
import csv
import json
from io import StringIO

fields = [
    "name", "fan.speed", "pstate",
    "memory.used", "utilization.gpu",
    "temperature.gpu", "power.draw.average"
]

display_names = [
    "name", "fan_speed", "pstate", "memory_used",
    "utilization_gpu", "temperature_gpu", "power_draw_average"
]

cmd = [
    "nvidia-smi",
    "--query-gpu=" + ",".join(fields),
    "--format=csv,noheader,nounits"
]

output = subprocess.check_output(cmd).decode("utf-8")
reader = csv.reader(StringIO(output))

# Only use first GPU (Waybar expects one JSON object)
for row in reader:
    gpu = dict(zip(display_names, row))
    util = int(gpu["utilization_gpu"])

    result = {
        "text": f"{util}%",
        "alt": f"{util}%",
        "tooltip": (
            f"{gpu['name']}\n"
            f"Perf: {gpu['pstate']}\n"
            f"Mem: {gpu['memory_used']} MiB\n"
            f"Temp: {gpu['temperature_gpu']}°C\n"
            f"Power: {gpu['power_draw_average']} W"
        ),
        "class": "gpu-util",
        "percentage": util
    }

    print(json.dumps(result))
    break  # only first GPU

