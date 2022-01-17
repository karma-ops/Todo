double calculateProgress(data) {
  var trues = 0;
  for (int i = 0; i < data.taskList.length; i++) {
    if (data.taskList[i].status!) {
      trues++;
    }
  }
  var progress = trues / data.taskList.length * 100;
  if (progress == 0.0) {
    return 0;
  } else if (progress == 100.0) {
    return 100;
  } else {
    return progress;
  }
}
