
.rq.i.cache:: ("nothing";())!(1;())

.rq.init: {[nodeModulesFolder]
  .rq.i.nodeModulesFolder:: $[nodeModulesFolder;nodeModulesFolder;"./node_modules/"]}


.rq.i.drop: {[string; n]
  result: n _ string
  $[count[result] = 1; result[0]; result]}

.rq.i.endsWith: {[string; suffix] .rq.i.drop[string;(count[string] - count[suffix])] ~ suffix}

.rq.i.directory: {[filePath] (. "\\node --no-warnings ./node_modules/shakti-require/js/dirName.js ",filePath)[0]}

.rq.i.currentFileDirectory: $[.rq.i.endsWith[.z.x[0];".k"];.rq.i.directory[.z.x[0]];"."]

.rq.i.resolveFilePath: {[filePath]
  filePathWithExtension: $[.rq.i.endsWith[filePath;".k"];filePath;filePath,"/import.k"]
  fullFilePath: $[*filePathWithExtension = ".";.rq.i.currentFileDirectory,"/",filePathWithExtension;.rq.i.nodeModulesFolder,filePathWithExtension]
  result: . "\\node --no-warnings ./node_modules/shakti-require/js/resolve.js ",fullFilePath
  result[0]}

.rq.requireWithoutCache: {[filePath]
  resolvedFilePath: .rq.i.resolveFilePath[filePath]
  oldCurrentFileDirectory: .rq.i.currentFileDirectory
  .rq.i.currentFileDirectory::.rq.i.directory[resolvedFilePath]
  . "\\l ",resolvedFilePath
  .rq.i.currentFileDirectory: oldCurrentFileDirectory
  1}

.rq.i.insertIntoDict: {[dict;newDict] ((! dict),(! newDict))!((. dict),(. newDict))}

.rq.require:{[filePath]
  resolvedFilePath: .rq.i.resolveFilePath[filePath]
  if[~(.rq.i.cache[resolvedFilePath] = 1);.rq.i.cache:: .rq.i.insertIntoDict[.rq.i.cache; (resolvedFilePath;())!(.rq.requireWithoutCache[filePath]; ())]]}
