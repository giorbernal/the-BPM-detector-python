BPM Detector in Python
=======================
Implementation of a Beats Per Minute (BPM) detection algorithm, as presented in the paper of G. Tzanetakis, G. Essl and P. Cook titled: "Audio Analysis using the Discrete Wavelet Transform".

You can find it here: http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.63.5712

Based on the work done in the MATLAB code located at github.com/panagiop/the-BPM-detector-python.

Process .wav file to determine the Beats Per Minute.

Dependencies: scipy, numpy, pywavelets, matplotlib, pandas

# How to use

You can detect bpm in your files by one of these methods:

## Direct Mode

You just need to execute the tool:
```bash
> phython bpm_detector/bpm_detector.py
```
and follow the usage instructions.

## Scanning your music library (.wav and .mp3)

You can scan your .wav or .mp3 music library following nexts steps (NOTE: Only tested in macOS and Linux)

Pre-requisite: Install [Docker](https://docs.docker.com/get-docker/).

* Download this project with git client or download it from [here](https://github.com/giorbernal/the-BPM-detector-python/archive/master.zip) and get into the main folder.
* Build the docker image:
```bash
> utils/build.sh
```

From now on, let's assume a file structure like this:
```
/User/myuser/music
   /artist1
        /a1song01.mp3
        /a1song02.mp3
        ...
   /artist2
        /a2song01.mp3
        /a2song02.mp3
        ...
```
* Initialize the container:
```bash
> utils/start.sh /User/myuser/music
```
* Index your library totally:
```bash
> utils/index.sh /
```
or partially
```bash
> utils/index.sh artist1
> utils/index.sh artist2
...
```
* Search songs filtering by tempo and a margin:
```bash
> utils/search.sh / 144 2
<see results>
```
* Clean the indexation metainfo:
```bash
> utils/clean.sh /
```

If you are going to stop using this software do not forget to stop the container
````
> utils/stop.sh
````
(to use it again, just initialize the container again. It is not necessary to scan again)

If you are going to update the version of this software do not forget to stop the container and destroy the image before the new installation:
````
> utils/stop.sh
> utils/destroy.sh
````

Enjoy!.
