function notify(message, title, subtitle){
  var app = Application.currentApplication();
  app.includeStandardAdditions = true
  app.displayNotification('The file has been converted',
  { withTitle: 'Success', subtitle: 'Done' })
}

notify();
