import { ObjectId } from 'mongoose'

export interface AudioDTO {
  directory: string
  dateTime: string
}

export async function uploadStroopAudioFile(
  audioFile: AudioDTO,
): Promise<string[]> {
  let urls: string[] = []

  for (let i = 0; i < 3; i++) {
    let fileName: string = `${audioFile.dateTime}_section-${i + 1}`

    let fileNameWAV: string = `${fileName}.wav`

    let filePathWAV: string = `${audioFile.directory}/${fileNameWAV}`

    urls.push(filePathWAV)
  }

  return urls
}
