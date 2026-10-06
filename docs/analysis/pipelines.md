# Bioinformatic Pipelines

This page lists automated workflows and multi-step pipelines used for standard group analyses.

| Pipeline Name | Workflow Engine | Description | Maintainer / Link |
| :--- | :--- | :--- | :--- |
| **De Novo Assembly** | Nextflow | Read QA/QC, contig assembly, polishing, and BUSCO assessment | TBD |
| **Short-Read Resequencing** | Snakemake | Read alignment, duplicate marking, BCFtools/GATK variant calling | TBD |
| **Hi-C Contact Matrix** | Bash / Snakemake | Alignment of Hi-C reads, filtering, and sparse contact matrix construction | TBD |
| **K-mer Profiling** | Nextflow | KMC database generation and genome size estimation | TBD |

---

## Executing Pipelines on HPRC

For pipeline submission and cluster execution templates, see the [HPRC SLURM Support](../hprc/slurm_support.md) guide.