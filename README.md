EchoView R Functions
===

This repo contains functions in [R programming language](http://cran.r-project.org/ "R homepage") to handle [Myriax EchoView](https://www.echoview.com/ "echoview homeage") native files or exported ones.

List of functions in sources folder:

### [select-regions-echoview.R:](https://github.com/guzmanlopez/EchoView-R-Functions/blob/master/sources/select-regions-echoview.R "select-regions-echoview.R (code)")

- find regions by name from one echoview region definitions file (*.evr*) and make a new one with matched regions. Tested on Myriax EchoView v.4.2.

##### INPUT

- **regionFilepath:** file path to echoview region definition file (*.evr*).

```R
filepath <- "/home/user/Documents/RegionsExportedFromEchoview.evr"
```
- **regionVector:** vector of class character.

```R
regionVector <- c('Region20221', 'Region20222', 'Region20223', 'Region20224')
```
- **newRegionClassName:** rename class name (if it's null or empty the default class name is used).

```R
newRegionClassName <- "NewClassName"
```
- **newRegionDefinitionFileName:** name of the output file (without file extension)

```R
newRegionDefinitionFileName <- "NewRegionDefinitionFile"
```

##### OUTPUT

- writes an Echoview Region Definition file (*.evr*) to working directory.

##### Example:

```R
ExtractRegions(regionFilepath = /home/user/RegionsExportedFromEchoview.evr,
   regionVector = c('Region20221', 'Region20222', 'Region20223', 'Region20224'),
    newRegionClassName = "FishTrack-Big",
    newRegionDefinitionFileName = "BigFishesRegions")
```
```R
Read 15371 items
A new Echoview Region Definition file was written to /home/user/BigFishesRegions.evr
- 337 regions of 3073 were found.
```
