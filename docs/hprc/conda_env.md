# HPRC Conda Environments accessible to TAMU Plant Genomics Group

Under the plant genomics group we are hoping to maintain a single location for all conda environments that are accessible to all group members. This will allow us to share environments and avoid duplication and storage issues. The environments will be stored in a shared location on the HPRC cluster and can be accessed by all group members.

The environments will be maintained and updated as needed to ensure that they are always up-to-date and functional by the group admin/PI. 

The location of the binary `micromamba` is by default added to the group local bin directory, so that it can be used by all group members. The `micromamba` binary is a lightweight version of `conda` that allows for faster environment creation and management.

As part of the bashrc configuration we have included few aliases and bash functions to access and manage the conda environments. The following aliases and functions are available to group members (some of them would not have write permission, mentioned otherwise):

The conda root directory is set by default as `/scratch/group/pgenomics/envs/conda` and the user can use the environments installed under this root.

| command | description | example usage |
| ------- | ----------- | ------------- |
| `mls`| micromamba list all enviroments| `mls`|
| `ma` | micromamba activate an environment | `ma utils`|
| `mr` | micromamba run command under an environment | `mr utils python script.py`|
