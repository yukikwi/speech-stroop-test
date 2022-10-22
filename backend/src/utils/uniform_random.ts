export function randomUniformClass(oldResult: Array<String>, resultClass: Array<String>): string{
  let mapTable:Array<any> = []
  let maxN = 0
  let sumN = 0
  // map result class & oldResult
  for(let i = 0; i < resultClass.length; i++){
    const oldResultClassCount = oldResult.filter(oldResultclass => oldResultclass == resultClass[i]).length

    // find maxN
    if(oldResultClassCount > maxN){
      maxN = oldResultClassCount
    }

    // sumation of N
    sumN = sumN + oldResultClassCount

    // push to map table
    mapTable.push({
      class: resultClass[i],
      n: oldResultClassCount
    })
  }

  // max + 1
  maxN = maxN+1

  // update map table with new key
  mapTable = mapTable.map(
    element => (
      {
        ...element,
        maxNMin1MinN: (maxN - element.n)
      }
    )
  )

  // calculate sigma maxNMin1MinN
  const sumMaxNMin1MinN = (maxN * resultClass.length) - sumN

  // random from 0 to sumMaxNMin1MinN
  let random = Math.floor(Math.random() * sumMaxNMin1MinN)

  // assign class
  for(let i = 0; i < mapTable.length; i++){
    // decreasing random with maxNMin1MinN
    random = random - mapTable[i].maxNMin1MinN
    if(random <= 0){
      return mapTable[i].class
    }
  }
}

// test
const testMap:any = {}
const oldResult = ["123", "231", "321", "123"]
for(let i = 0; i < 10000; i++){
  const randomClass = randomUniformClass(oldResult, ["123", "132", "213", "231", "312", "321"])
  if(testMap[randomClass] != undefined){
    testMap[randomClass] += 1
  }
  else{
    testMap[randomClass] = 1
  }
  oldResult.push(randomClass)
}
console.log(testMap)