# Thesis 
This repo is self-contained for a motor learning skill classifier using ESNs on resting-state EEG. The current version is being tested using Matlab 2016b and EEGLab by UCSD. Each script contains sufficient description of what it does. Here I will mention some important ones to run the whole pipeline:

* If one wants to start everything from scratch, one should start with processData which essentially loads all the data, applies temporal filters and automatically remove artifacts using MARA. The processed data will be stored in `/data/processed`.
* Then it suffices to call 'trainDriver', it will load the data, using the default parameters to train and test. `cross_validate` is helping for selecting parameters using stratified-cross-validation. 
* In the end, to inspect the internal network dynamics, `visuClass` and `visuUnits` can come handy.

## Ref

[1]Mantas Lukosevicius. A practical guide to applying echo state networks. In Neural Networks: Tricks of the Trade, pages 659–686. Springer, 2012.
