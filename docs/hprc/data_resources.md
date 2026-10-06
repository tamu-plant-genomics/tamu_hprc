# HPRC Data Resources

This directory stores shared genomic datasets, alignment indices, and reference databases for the group on TAMU HPRC. Centralizing these resources prevents redundant downloads and conserves group storage space.

## Root Directory Location for the PGenomics Group 

```bash
/scratch/group/pgenomics/
```
```text
├── EXTERNAL            # External datasets
├── INTERNAL            # Internal datasets (sequence data, libraried etc.)
├── PG1                 # Group members working directories
│   ├── jayakodi
│   ├── lee
│   ├── selvanayagam
│   └── senthil
├── envs                # Shared Conda environments, tools, binaries, and workflows
│   ├── bin
│   ├── cargo
│   ├── conda
│   ├── containers
│   ├── imgs
│   ├── pgbin
│   ├── pgenv
│   ├── pip
│   ├── rlib
│   ├── rustup
│   ├── tamu_hprc
│   ├── tools
│   └── workflows
└── resources           # Shared genomic datasets, reference genomes, and sequence databases
    ├── db
    └── genome
```


---

## Current Directory Structure for data resources

```text
resources/
├── db/                   # Shared sequence databases (e.g., BLAST, Kraken)
│   ├── blast/
│   └── kraken/
│       ├── 08212026/
│       └── latest -> /scratch/group/pgenomics/resources/db/kraken/08212026
└── genome/               # Reference genomes and annotations by species
    ├── ath/              # Arabidopsis thaliana
    ├── gmax/             # Glycine max (Soybean)
    ├── lsal/             # Lactuca saligna
    ├── lsat/             # Lactuca sativa (Lettuce)
    ├── lser/             # Lactuca serriola
    ├── lvir/             # Lactuca virosa
    ├── maize/            # Zea mays
    └── rice/             # Oryza sativa
        └── japonica/

```

---

## Quick Usage Guidelines

1. **Read-Only Access:** Do not alter, move, or delete files inside `resources/` unless updating shared databases.
2. **Version Control & Symlinks:** Always update or create a `latest` symlink when adding a new database version so workflow scripts remain uninterrupted (only for the group admin/PI).
```bash
ln -sfn /path/to/new_version resources/db/<db_name>/latest

```



---

## Adding New Resources (Only for the Group Admin/PI)

When adding a new species or database, follow the existing structure:

* **Genomes:** Place under `resources/genome/<species_code>/<source>/` using standard shortcodes (e.g., `lsat` for *Lactuca sativa*). Include the assembly version and source (NCBI, Phytozome, etc.) in file names or subdirectories.
* **Databases:** Place under `resources/db/<db_type>/<MMDDYYYY>/` and update the `latest` symlink.

---