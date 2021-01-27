#!/usr/bin/env node

/**
 * IDEA: convert json array of objects into raw markup for a jira table
 *
 * 1. slurp json array over stdin
 * 2. get a list of all possible keys
 * 3. render header row with all keys (if easy: common keys first)
 * 4. render rows
 */

function parseStdinJsonArray() {
  return new Promise((resolve, reject) => {
    const chunks = [];
    process.stdin.setEncoding("utf-8");

    process.stdin.on("readable", () => {
      let chunk;
      // Use a loop to make sure we read all available data.
      while ((chunk = process.stdin.read()) !== null) {
        chunks.push(chunk);
      }
    });

    process.stdin.on("error", (err) => {
      reject(err);
    });

    process.stdin.on("end", () => {
      resolve(
        JSON.parse(chunks.join())
      );
    });
  });
}

function getAllHeaders(inputArray) {
  const headerOccurenceMap = inputArray.reduce((acc, inputItem) => {
    Object.keys(inputItem).forEach((header) => {
      if (!acc.has(header)) {
        acc.set(header, 1);
      } else {
        acc.set(header, acc.get(header) + 1);
      }
    });
    return acc;
  }, new Map());

  return Array.from(headerOccurenceMap)
    .sort((a, b) => (b[1] - a[1]))
    .map((occurence) => occurence[0])
}

async function main() {
  const isDebug = !!process.env["DEBUG"];

  const inputArray = await parseStdinJsonArray();

  if (isDebug) {
    console.error(inputArray);
  }

  console.error(`Slurped in ${inputArray.length} items.`);

  const allHeaders = getAllHeaders(inputArray);

  if (isDebug) {
    console.error(allHeaders);
  }

  console.log(`||${allHeaders.join("||")}||`);

  for (const inputItem of inputArray) {
    const rowValues = allHeaders.map((header) => inputItem[header] || "---");
    console.log(`|${rowValues.join("|")}|`);
  }
}

main().catch((err) => {
  console.error("Uncatched error in main!");
  console.error(err);
  process.exit(1);
})
