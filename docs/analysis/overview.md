# Analysis Overview

Welcome to the TAMU Plant Genomics Group analysis hub. This section documents our standard bioinformatic workflows, analytical tools, and software utilities used across projects.

## Common Workflows & Objectives

Below is a quick overview of primary analysis pipelines and their standard entry points:

| Analysis Category | Primary Objective | Key Pipelines / Frameworks |
| :--- | :--- | :--- |
| **Genome Assembly & QC** | Reference assembly, scaffolding, and quality metrics | Nextflow Assembly Pipeline, `myrs` |
| **Variant Calling** | Short and long-read variant identification | Snakemake Resequencing Pipeline |
| **Comparative Genomics** | Synteny mapping and gene family evolution | Custom scripts & standard alignment tools |
| **Hi-C / Chromosome Structure** | Scaffolding and 3D contact matrix generation | Hi-C Contact Pipeline, `myrs` |

---

## Quick Links

* [Pipelines Reference](pipelines.md) — Automated, multi-step workflows (Nextflow, Snakemake, WDL)
* [Tools Reference](tools.md) — Standalone software, custom binaries, and utilities
* [`myrs` Documentation](myrs.md) — Group-developed Rust toolkit