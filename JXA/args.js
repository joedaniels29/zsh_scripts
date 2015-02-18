ObjC.import('Foundation')


function myArgs(){
  var args = $.NSProcessInfo.processInfo.arguments

  // Build the normal argv/argc
  var argv = []
  var argc = args.count // -[NSArray count]

  for (var i = 0; i < argc; i++) {
      argv.push( ObjC.unwrap( args.objectAtIndex(i) ) ) // -[NSArray objectAtIndex:]
  }

  return argv.slice(4)

}
