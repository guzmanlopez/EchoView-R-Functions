##################################################################################
### Extract regions from EchoView Region (v.4.2) definitions (.evr) text files ###
### and make a new file.                                                       ### 
###################################################################################
### INPUTS:

## regionFilepath: file path to echoview region definition file (.evr)
# example: filepath = "/home/user/Documents/RegionsExportedFromEchoview.evr"
## regionVector: r vector of class character
# example: regionVector <- c('Region20221', 'Region20222', 'Region20223', 'Region20224')
## newRegionClassName: rename class name (if it's null or empty the default class name is used)
# example: "NewClassName"
## newRegionDefinitionFileName: name of the output file (without file extension)
# example: "NewRegionDefinitionFile"

### OUTPUT:
# write an Echoview Region Definition file to working directory. 

## Practical example:
# ExtractRegions(regionFilepath = /home/user/Documents/RegionsExportedFromEchoview.evr, 
#                regionVector = c('Region20221', 'Region20222', 'Region20223', 'Region20224'),
#                newRegionClassName = "FishTrack-Big",
#                newRegionDefinitionFileName = "BigFishesRegions")

###########################################################################

ExtractRegions <- function(regionFilepath, regionVector, newRegionClassName, newRegionDefinitionFileName) {
  
  # Read lines from file
  t = file(regionFilepath, "r")
  lines = scan(file = t, what = "raw", sep = ",")
  head = lines[1]
  regionNameFields = data.frame("RegionName" = lines[seq(7, length(lines), 5)], "LineNumber" = seq(7, length(lines), 5))
  close(t)
  
  # Find region name line number
  regionLines = data.frame("RegionName" = NA, "LineNumber" = NA)
  j = 1;
  
  for(i in 1:length(regionVector)) {
    
    regionFound = FALSE
    regionNameSearched = regionVector[i]
    
    while(!regionFound && j < nrow(regionNameFields)) {
      
      if(regionNameSearched == regionNameFields$RegionName[j]) {
        
        regionLines[i, 1] = as.character(regionNameFields$RegionName[j])
        regionLines[i, 2] = as.numeric(as.character(regionNameFields$LineNumber[j]))
        regionFound = TRUE
        
      }
      
      j = j + 1
      
    }
  }
  
  
  if(!is.null(regionLines) && nrow(regionLines) > 0) {
    
    # Get all region lines 
    
    ClassName = newRegionClassName
    region = list()
    region[1:2] = c(head, nrow(regionLines))
    j = 1
    
    for(i in seq(1, 5 * nrow(regionLines), 5))  {
      
      region[i + 2] = lines[regionLines$LineNumber[j] - 4]
      region[i + 3] = lines[regionLines$LineNumber[j] - 3]
      
      if(nchar(ClassName) > 1) {
        
        region[i + 4] = ClassName
        
      } else {
        
        region[i + 4] = lines[regionLines$LineNumber[j] - 2]
      }
      
      region[i + 5] = lines[regionLines$LineNumber[j] - 1]
      region[i + 6] = lines[regionLines$LineNumber[j]]
      
      j = j + 1
    }
  }
  
  # Add empty lines
  end = length(region) * 1.2 - 1
  
  for(i in seq(from = 2, to = end, by = 6)) {
    region = append(x = region, values = list(""), after = i)
  }
  
  # Write file
  filename = paste(newRegionDefinitionFileName, ".evr", sep = "")
  
  writefile = lapply(region, function(x) cat(c(x), file = filename, sep = "\n", append = TRUE))
  
  # Output message
  if(!is.null(writefile)) {
    
    message = paste("A new Echoview Region Definition file was written to ", getwd(), "/", filename, sep = "")
    message = paste(message, "\n", "- ", nrow(regionLines), " regions of ", nrow(regionNameFields)," regions were found.", sep = "")
    
    return(cat(message))  
  }
}
