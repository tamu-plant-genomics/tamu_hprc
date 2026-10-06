# HPRC Getting Started

Welcome to the TAMU Plant Genomics Group! This guide outlines the steps to request access, connect to HPRC clusters, and initialize your customized shell environment.

---

## 1. Account Setup

1. Request an account or join an existing allocation via the [HPRC Portal](https://hprc.tamu.edu).
2. Complete the required cybersecurity training mandated by TAMU.

---

## 2. Connecting via SSH

To log into the Grace cluster:

```bash
ssh <netid>@grace.hprc.tamu.edu

```

---

## 3. Initializing the Plant Genomics Environment

First-time users should run the initialization script to automatically set up the shared group environment configuration.

Run the following command in your terminal upon first login:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/tamu-plant-genomics/tamu_hprc/main/init_env.sh)

```

### What `init_env.sh` Does:

* **Backs up your existing configuration:** Creates a timestamped backup of your current `~/.bashrc`.
* **Configures Shell Environment:** Sets up a customized `.bashrc` tailored for group workflows.
* **Integrates Conda & Micromamba:** Adds access to group-maintained Conda environments and tool wrappers.
* **Loads Slurm Utilities:** Adds custom helpers and shortcuts for Slurm cluster job management.
* **Exports Shared Paths:** Configures environment variables for group-shared resources, databases, and software tools.

After initialization is complete, apply the changes immediately by running:

```bash
source ~/.bashrc

```

---

## 4. Environment Overview & Available Utilities

Once initialized, a helpful summary message will print each time you start a new terminal session (or when you run `pghelp`).

> **Important Warning:** Do **not** install tools or heavy software packages directly into your home directory (`~`). Space is limited. Always utilize shared group environments or build in scratch directories.

### Summary of Built-in Features:

1. **Shared Conda & Tool Wrappers:** Environment & Software Management.
* **Micromamba Shortcuts:** `mls` (list envs), `ma` (activate), `md` (deactivate), `mr` (run command inside env).
* **Direct Tool Wrappers (`m.*`):** Run specific bioinformatics tools directly without activating environments (e.g., `m.samtools`, `m.minimap2`, `m.blastn`, `m.datasets`).
* **Discovery Utilities:** `conda-inspect` and `conda-find <tool>` to search across group environments before installing anything new.


2. **Slurm & Module Helpers:** Cluster Workflows.
* **Module Management:** `module-list`, `module-find <query>`, `module-load`, and `module-save`.
* **Job Monitoring:** `slurm-queue` (view active jobs), `slurm-history` (recent jobs), `slurm-job-eff <job_id>` (inspect CPU/RAM usage), and `slurm-log` (tail job logs).
* **Interactive & Batch Execution:** `slurm-shell` (request an interactive session via `srun`) and `slurm-submit` (scriptless job submission).


3. **System & Shell Utilities:** Productivity Boosters.
* `countfiles`: Visualizes directory trees with file counts per folder.
* `goto <session>`: Quick switcher for `tmux` sessions.
* `backup <file>`: Creates a quick timestamped backup copy of a file or directory.
* `extract` & `compress`: Smart archive manipulation for `.tar`, `.gz`, `.zip`, `.7z`, etc.


4. **Exported Group Paths:** Shared Architecture ($PG_ROOT).
Key group directory environment variables set by default:

* `$PG_ROOT`: Core root (`/scratch/group/pgenomics/`)
* `$PG_ENVS`: Shared executables, Conda root, workflows, Apptainer/Singularity images, and tool builds.
* `$PG_RESOURCES`: Shared static reference databases (`$GENOMES_DIR`, `$DB_DIR`).


---

## 5. Helpful Commands

* **Display Help Screen:** Type `pghelp` anytime to re-display the full environment banner and list of shortcuts.
* **Inspect Function Definitions:** Type `type <command>` (e.g., `type slurm-queue` or `type m.blastn`) to view how any wrapper is implemented.

---
