
.require.cache:: ("nothing";())!(1;())

.require.initialize: {[nodeModulesFolder]
  .require.nodeModulesFolder:: $[nodeModulesFolder;nodeModulesFolder;"./node_modules/"]}


.require.drop: {[string; n]
  result: n _ string
  $[count[result] = 1; result[0]; result]}

.require.endsWith: {[string; suffix] .require.drop[string;(count[string] - count[suffix])] ~ suffix}

.require.directory: {[filePath] (. "\\node --no-warnings ./node_modules/shakti-require/js/dirName.js ",filePath)[0]}

.require.currentFileDirectory: $[.require.endsWith[.z.x[0];".k"];.require.directory[.z.x[0]];"."]

.require.resolveFilePath: {[filePath]
  filePathWithExtension: $[.require.endsWith[filePath;".k"];filePath;filePath,"/index.k"]
  fullFilePath: $[*filePathWithExtension = ".";.require.currentFileDirectory,"/",filePathWithExtension;.require.nodeModulesFolder,filePathWithExtension]
  result: . "\\node --no-warnings ./node_modules/shakti-require/js/resolve.js ",fullFilePath
  result[0]}

.require.requireWithoutCache: {[filePath]
  resolvedFilePath: .require.resolveFilePath[filePath]
  oldCurrentFileDirectory: .require.currentFileDirectory
  .require.currentFileDirectory::.require.directory[resolvedFilePath]
  . "\\l ",resolvedFilePath
  .require.currentFileDirectory: oldCurrentFileDirectory
  1}

.require.insertIntoDict: {[dict;newDict] ((! dict),(! newDict))!((. dict),(. newDict))}

.require.require:{[filePath]
  resolvedFilePath: .require.resolveFilePath[filePath]
  if[~(.require.cache[resolvedFilePath] = 1);.require.cache:: .require.insertIntoDict[.require.cache; (resolvedFilePath;())!(.require.requireWithoutCache[filePath]; ())]]}
