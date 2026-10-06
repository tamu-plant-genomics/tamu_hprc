# `myrs`

`myrs` is a custom Rust-based command-line toolkit developed for fast, efficient processing of FASTA/FASTQ genomic sequences, KMC k-mer databases, and Hi-C contact maps.

---

## Installation & Setup

This tool is already installed in the TAMU hprc under the location, `/scratch/group/pgenomics/envs/bin/myrs`. The user need not to install it. However, if you want to build it from source, follow the steps below:

```bash
# clone the repository 
git clone https://github.com/ivasubramanics/myrs.git
cd myrs

# Build optimized release binary
cargo build --release

# Optional: Add to PATH or copy to group binaries directory
cp target/release/myrs ~/.local/bin/

```

---

## Core Commands & Usage

### 1. FASTA Utilities

* **`fa-stats`** — Calculate summary statistics ($N_{50}$, total length, sequence count, overall GC%):
```bash
myrs fa-stats input.fasta

```


* **`fa-length`** — Report lengths for all individual records:
```bash
myrs fa-length input.fasta > lengths.tsv

```


* **`fa-filter`** — Filter sequences based on length or GC content thresholds:
```bash
myrs fa-filter --min-len 1000 --min-gc 40.0 input.fasta > filtered.fasta

```


* **`fa-rename`** — Rename headers using a 2-column TSV mapping file (`old_id\tnew_id`):
```bash
myrs fa-rename --map mapping.tsv input.fasta > renamed.fasta

```



### 2. Sequence Extraction & Indexing

* **`fa-fai`** — Generate a `.fai` index file for fast random access:
```bash
myrs fa-fai input.fasta

```


* **`fa-one-record`** — Rapidly extract a single sequence record using the `.fai` index:
```bash
myrs fa-one-record input.fasta "chr1" > chr1.fasta

```


* **`fa-some-records`** — Extract multiple records specified in a list file:
```bash
myrs fa-some-records --list headers.txt input.fasta > subset.fasta

```



### 3. FASTQ & K-mer Analysis

* **`fq-stats`** — Generate quality and read count summary statistics for FASTQ files:
```bash
myrs fq-stats reads.fastq.gz

```


* **`dump-kmc`** — Convert binary KMC k-mer database outputs to plain text (`kmer\tcount`):
```bash
myrs dump-kmc kmc_db_prefix output_kmers.txt

```


* **`fa-kmer-cov`** — Evaluate k-mer coverage profile across FASTA records using a KMC database:
```bash
myrs fa-kmer-cov --db kmc_db_prefix input.fasta

```



### 4. Chromosome Conformation (Hi-C)

* **`hic-contact-matrix`** — Build a sparse contact matrix from an aligned Hi-C BAM file:
```bash
myrs hic-contact-matrix --bam aligned_hic.bam --bin-size 10000 -o matrix.bedpe

```



---

## Getting Help

To view all command options or subcommand-specific flags:

```bash
myrs --help
myrs <COMMAND> --help

```

---