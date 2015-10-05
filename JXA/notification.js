ObjC.import('Foundation')


function myArgs(){
  var args = $.NSProcessInfo.processInfo.arguments

  // Build the normal argv/argc
  var argv = [ ]
  var argc = args.count // -[NSArray count]

  for (var i = 2; i < argc; i++) {

   argv.push( ObjC.unwrap( args.objectAtIndex(i) ) ) // -[NSArray objectAtIndex:]
  }

  console.log(argv)


  return argv
}

function notify(){
  var app = Application.currentApplication();
  var ar = myArgs()

  app.includeStandardAdditions = true;

  app.displayNotification(ar[0], { withTitle: ar[1], subtitle: ar[2]})
}

notify();
