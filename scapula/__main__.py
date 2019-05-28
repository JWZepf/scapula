import shoulder
import os
import pkgutil
import shutil

import scapula.generator
from scapula.filter import filters
from scapula.transform import transforms

# Scapula-specific constants
scapula_pkg_dir = os.getcwd()
scapula_output_dir = os.path.join(scapula_pkg_dir, "output")

# Shoulder configs
shoulder.config.shoulder_output_dir = scapula_output_dir

# Main
regs = shoulder.parser.parse_registers(shoulder.config.xml_register_dir)

for key, g in scapula.generator.generators.items():
    sub_outdir = os.path.abspath(os.path.join(scapula_output_dir, str(g.__class__.__name__)))
    if os.path.exists(sub_outdir):
        shutil.rmtree(sub_outdir)

    if os.path.exists(shoulder.config.shoulder_include_dir):
        shutil.copytree(shoulder.config.shoulder_include_dir, sub_outdir)

    g.generate(regs, sub_outdir)
