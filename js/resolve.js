import path from 'path'
import yargs from 'yargs'

// nodeModulesFolder = path.join(process.cwd(), 'node_modules')
// console.log(nodeModulesFolder)
// console.log(argv._[0])
console.log(path.resolve(...yargs.argv._))
