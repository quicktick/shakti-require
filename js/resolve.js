import path from 'path'
import yargs from 'yargs'

console.log(path.resolve(...yargs.argv._))
