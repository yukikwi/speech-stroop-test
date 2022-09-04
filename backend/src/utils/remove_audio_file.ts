import fs from 'fs'

export async function removeAudioFiles(filePaths: Array<fs.PathLike>) {
  filePaths.forEach(async (path) => {
    await fs.unlinkSync(path)
  })
}
