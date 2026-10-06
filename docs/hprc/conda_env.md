# HPRC Conda Environments accessible to TAMU Plant Genomics Group

To prevent storage duplication and simplify software access across the cluster, the Plant Genomics Group maintains a central repository of shared `micromamba` Conda environments on HPRC. These environments are stored in a shared group directory and accessible to all group members for data analysis and Slurm job submission.

Centralized maintenance, environment creation, and package updates are managed by the group administrator/PI to ensure reproducibility and stability across group workflows.

---

## 1. Environment Setup & Configuration

* **Shared Conda Root:** `/scratch/group/pgenomics/envs/conda`
* **Default Package Channels:** `conda-forge`, `bioconda`
* **Binary Access:** The `micromamba` executable is located in the group's local `bin` directory (`/scratch/group/pgenomics/local/bin` or similar), which is loaded into your `PATH` via the group `.bashrc` settings.

---

## 2. Core Micromamba Aliases & Helper Commands

Standard shortcuts for environment navigation and package management:

| Command | Category | Description | Example Usage | Note |
| --- | --- | --- | --- | --- |
| `mls` | Navigation | List all available shared environments | `mls` | Read-only |
| `ma` | Navigation | Activate a specific environment | `ma utils` | Read-only |
| `md` | Navigation | Deactivate the currently active environment | `md` | Read-only |
| `mr` | Execution | Run a single command inside an environment | `mr utils python script.py` | Read-only |
| `mc` | Management | Create a new environment using default channels | `mc my_env python=3.11` | Admin/Write Perms |
| `mi` | Management | Install package(s) into active environment | `mi samtools bedtools` | Admin/Write Perms |
| `mrme` | Management | Remove an existing environment | `mrme my_env` | Admin/Write Perms |
| `mclean` | Cleanup | Clear package caches and tarballs | `mclean` | Free up scratch space |

---

## 3. Tool Direct Wrappers (`m.<tool>`)

To run specific bioinformatics tools without explicitly activating their parent environments, use the `m.<tool>` function wrappers.

The underlying runner (`_mrun_exec`) automatically verifies if the binary is accessible in the target environment before executing, giving clear diagnostic feedback if a package is missing.

### System & Disk Utilities (`pgbase` Environment)

| Command Wrapper | Target Environment | Underlying Tool | Primary Use Case |
| --- | --- | --- | --- |
| `m.ouch` | `pgbase` | `ouch` | Decompressing archive files (`.zip`, `.tar.gz`, `.bz2`, `.zst`) |
| `m.ncdu` | `pgbase` | `ncdu` | Interactive disk usage analyzer for scratch space |

### Data Download Utilities (`datasets`, `sra` Environments)

| Command Wrapper | Target Environment | Underlying Tool | Primary Use Case |
| --- | --- | --- | --- |
| `m.datasets` | `datasets` | `datasets` | NCBI Datasets CLI tool for downloading genomes/annotations |
| `m.fasterq_dump` | `sra` | `fasterq-dump` | Fast extraction of FASTQ files from SRA accessions |

### Sequence Manipulation & Aligners (`utils` Environment)

| Command Wrapper | Target Environment | Underlying Tool | Primary Use Case |
| --- | --- | --- | --- |
| `m.seqkit` | `utils` | `seqkit` | Fast FASTA/FASTQ manipulation and stats |
| `m.seqtk` | `utils` | `seqtk` | Subsampling, converting, and processing sequence data |
| `m.minimap2` | `utils` | `minimap2` | Pairwise alignment for long reads and assemblies |
| `m.samtools` | `utils` | `samtools` | SAM/BAM file sorting, indexing, and stats |
| `m.bcftools` | `utils` | `bcftools` | Calling and manipulating VCF/BCF variant files |
| `m.bedtools` | `utils` | `bedtools` | Genomic interval manipulation and overlap analysis |
| `m.mmseqs` | `utils` | `mmseqs` | Ultra-fast sequence searching and clustering |
| `m.mummer` | `utils` | `mummer` | Whole-genome alignment package |
| `m.nucmer` | `utils` | `nucmer` | Nucleotide sequence alignment (part of MUMmer) |

### BLAST & Homology Search Tools (`utils` Environment)

| Command Wrapper | Target Environment | Underlying Tool | Primary Use Case |
| --- | --- | --- | --- |
| `m.makeblastdb` | `utils` | `makeblastdb` | Constructing local BLAST databases |
| `m.blastn` | `utils` | `blastn` | Nucleotide-Nucleotide BLAST |
| `m.blastp` | `utils` | `blastp` | Protein-Protein BLAST |
| `m.blastx` | `utils` | `blastx` | Translated Nucleotide to Protein BLAST |
| `m.tblastn` | `utils` | `tblastn` | Protein to Translated Nucleotide BLAST |
| `m.tblastx` | `utils` | `tblastx` | Translated Nucleotide to Translated Nucleotide BLAST |
| `m.diamond` | `utils` | `diamond` | High-throughput protein and translation alignment |

---

## 4. Usage Examples & Best Practices

### In Interactive Shell

```bash
# Direct tool execution without activation
m.seqkit stats input.fasta
m.blastn -query query.fa -db genome_db -out results.fmt6

# Running a script in an environment
mr utils python process_counts.py

```

### In Slurm Batch Scripts (`.job` / `.sh`)

When submitting jobs to Grace or ACES, using direct wrappers avoids module conflicts and eliminates the need to source `conda.sh` inside batch scripts:

```bash
#!/bin/bash
#SBATCH --job-name=align_reads
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=32G

# Align reads directly using the wrapper
m.minimap2 -t 16 -ax map-hifi ref.fa reads.fastq.gz | m.samtools sort -@ 4 -o aligned.bam
m.samtools index aligned.bam

```
