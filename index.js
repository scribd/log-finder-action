const core = require('@actions/core');
const fs = require('fs');

try {
  var content = core.getInput('content') || "";
  const contentPath = core.getInput('content-path');
  var fileType = core.getInput('file-suffix').split("\n").join("|");


  // load the contents of each passed in file to content
  if (contentPath) {
    for (filePath of contentPath.split("\n")) {
      if (fs.existsSync(filePath)) {
        fileContents = fs.readFileSync(filePath);
        content += fileContents.toString();
      } else {
      	console.error(`No file found at path: ${filePath}`);
      }
    }
  }

  // find all file paths of expected type inside content string 
  const regexp = RegExp(`[^ ]*\\.(${fileType})\\b`,'gm');
  var logFiles = [];
  for (line of content.split("\n")) {
    let matches = line.match(regexp);
    if (matches) {
      for (match of matches) {
        logFiles.push(match);
      }
    }
  }

  core.setOutput("log-files", logFiles.join("\n"));
} catch (error) {
  core.setFailed(error.message);
}
