# HPRC Slurm Support for TAMU Plant Genomics Group

This manual provides reference documentation for the environment module helpers and Slurm workflow wrappers available in the TAMU Plant Genomics cluster environment. These utilities simplify job submission, queue management, module control, and interactive node requests on HPRC clusters.

---

## 1. Environment Module Helpers

Environment modules manage software compilers, libraries, and tools installed on the HPRC infrastructure.

### `module-list`

List all environment modules currently loaded in your active session.

* **Usage:** `module-list`
* **Underlying Command:** `module list`

### `module-find`

Search for available software modules across the cluster using Lmod `spider` or `avail`.

* **Usage:** `module-find <keyword>`
* **Examples:**
```bash
module-find samtools
module-find GCC

```



### `module-load`

Safely load one or more environment modules and display the updated list of loaded modules upon completion.

* **Usage:** `module-load <module_name> [module_name2 ...]`
* **Examples:**
```bash
module-load GCC/12.3.0
module-load WebProxy/0000 samtools/1.17

```



### `module-purge`

Unload all currently active environment modules to reset your environment state.

* **Usage:** `module-purge`
* **Underlying Command:** `module purge`

### `module-save` & `module-restore`

Save your current loaded module collection as default, or restore your saved default collection.

* **Save State:** `module-save`
* **Restore State:** `module-restore`

---

## 2. Queue & Job Management Commands

### `slurm-queue`

Displays a clean, custom-formatted table of your queued and running Slurm jobs.

* **Usage:** `slurm-queue`
* **Output Fields:** `JOBID`, `NAME`, `STATE`, `CPUS`, `MIN_MEMORY`, `TIME_USED`, `TIME_LEFT`, `NODELIST(REASON)`

### `slurm-history`

Queries `sacct` to display job execution history and timestamp details for completed, failed, or canceled jobs.

* **Usage:** `slurm-history [days]` *(Default: 3 days)*
* **Examples:**
```bash
slurm-history       # View history for the past 3 days
slurm-history 7     # View history for the past 7 days

```



### `slurm-cancel-last`

Finds your most recently submitted job ID and interactively prompts for confirmation before canceling it via `scancel`.

* **Usage:** `slurm-cancel-last`

### `slurm-job-eff`

Inspects the CPU and memory resource utilization efficiency of a finished Slurm job via `seff`.

* **Usage:** `slurm-job-eff <job_id>`
* **Example:** `slurm-job-eff 12345678`

### `slurm-log`

Locates and streams (`tail -f`) the output log file for an active or completed job. If no `job_id` is passed, it automatically targets your most recently submitted job.

* **Usage:** `slurm-log [job_id]`
* **Examples:**
```bash
slurm-log          # Tail the log of your most recent job
slurm-log 12345678 # Tail the log of a specific job

```



---

## 3. Interactive Compute Sessions

### `slurm-shell`

Requests an interactive compute node session using `srun`. Supports flexible time/memory formatting and optional automatic Conda environment activation.

* **Usage:**
```bash
slurm-shell [-p cpus] [-m mem] [-t time] [-n nodes] [-e conda_env] [-h]

```


* **Options:**
| Flag | Option | Description | Default |
| --- | --- | --- | --- |
| `-p` | `<cpus>` | Number of CPU cores requested | `2` |
| `-m` | `<mem>` | Memory allocation (plain numbers default to GB) | `8G` |
| `-t` | `<time>` | Time limit (supports `d`, `h`, `m` suffixes, e.g., `12h`, `2d`, `30m`) | `2h` |
| `-n` | `<nodes>` | Number of compute nodes requested | `1` |
| `-e` | `<env>` | Conda/Micromamba environment to activate on load | *None* |
| `-h` |  | Display help message |  |


* **Examples:**
```bash
# Standard 4 CPU, 16GB memory session for 4 hours
slurm-shell -p 4 -m 16 -t 4h

# Interactive session with automatic 'utils' Conda activation
slurm-shell -p 8 -m 32G -t 1d -e utils

```



---

## 4. Scriptless Batch Job Submission

### `slurm-submit`

Submits a background batch job via `sbatch` directly from the command line without requiring a manual `.job` or `.sh` batch script file.

The tool automatically injects logging, timestamp headers, module loading, Conda initialization, and email notifications.

* **Usage:**
```bash
slurm-submit -j <job_name> -c <command> [-M "modules"] [-e conda_env] [-t time] [-m mem] [-p cpus] [-n nodes] [-E email] [-h]

```


* **Options:**
| Flag | Required | Option | Description | Default |
| --- | --- | --- | --- | --- |
| `-j` | **Yes** | `<job_name>` | Name of the job (determines `<job_name>_%j.out` log name) | *None* |
| `-c` | **Yes** | `<command>` | Bash command or script to execute | *None* |
| `-M` | No | `<modules>` | Space-separated list of modules to load | *None* |
| `-e` | No | `<conda_env>` | Conda/Micromamba environment to activate | *None* |
| `-t` | No | `<time>` | Time limit (supports `d`, `h`, `m` suffixes) | `12h` |
| `-m` | No | `<mem>` | Memory limit in GB | `32G` |
| `-p` | No | `<cpus>` | Number of CPU cores | `8` |
| `-n` | No | `<nodes>` | Number of compute nodes | `1` |
| `-E` | No | `<email>` | Email for completion/failure alerts | `$MYEMAIL` |


* **Examples:**
**Running a alignment script with a Conda environment:**
```bash
slurm-submit -j align_job -c "minimap2 -t 16 ref.fa reads.fq > out.sam" -e utils -p 16 -m 64 -t 8h

```


**Loading system modules and executing a pipeline command:**
```bash
slurm-submit -j blast_search -M "GCC/12.3.0 WebProxy/0000" -c "blastn -query q.fa -db nt -out res.txt" -p 32 -m 128G -t 2d

```

---

Please contact the group admin/PI for any support, or issues.
