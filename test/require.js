import assert from 'assert'
import { runShakti } from 'shakti-node'

const defaultShaktiOptions = {
  commandToExecute: 'cd test-module && ../node_modules/@kparc/k/bin/k',
}

const initializeRequire = '. "\\\\l ../require.k";.require.initialize[];'

describe('runShakti', () => {
  describe('parseResults', () => {
    const testCases = [
      { kCode: `${initializeRequire}require["./exampleModule.k"];result: .exampleModule.x`, expectedResult: 'exampleModule', baseDirectory: './test-module' },
      { kCode: `${initializeRequire}require["./math.k"];result: .math.add[1;2]`, expectedResult: 3, baseDirectory: './test-module' },
      { kCode: `${initializeRequire}require["./moreMath.k"];result: .moreMath.addOne[5]`, expectedResult: 6, baseDirectory: './test-module' },
      { kCode: `${initializeRequire}require["./folder"];result: .folder.y`, expectedResult: 'folderImport', baseDirectory: './test-module' },
      { kCode: `${initializeRequire}require["example-module"];result: .exampleModule.x`, expectedResult: 10, baseDirectory: './test-module' },
      { kCode: `${initializeRequire}require["example-module/folder"];result: .exampleModule.folder`, expectedResult: 'another one', baseDirectory: './test-module' },
      { kCode: `${initializeRequire}require["./moreMath.k"];require["./moreMath.k"];result: .moreMath.addOne[5]`, expectedResult: 6, baseDirectory: './test-module' },
      { kCode: `${initializeRequire}require["../exampleModule.k"];result: .exampleModule.x`, expectedResult: 'exampleModule', baseDirectory: './test-module/folder' },
    ]
    testCases.forEach(({ kCode, expectedResult, baseDirectory }) => {
      it(`${kCode} returns ${JSON.stringify(expectedResult)}`, () => {
        const shaktiOptions = { ...defaultShaktiOptions, baseDirectory: baseDirectory, debug: true }
        assert.deepEqual(runShakti(kCode, shaktiOptions), expectedResult)
      })
    })
  })
})
