const { exec } = require('pkg');
const childProcess = require('child_process');
exec(['index.js', '--target', 'host', '--output', 'release/TangoTransportTrackerRichPresence.exe', '--assets', './clientconfiguration.json'])

// childProcess.execFile('./resource_hacker/ResourceHacker.exe',
//     ["-addoverwrite",
//         "release/TangoTransportTrackerRichPresence.exe",
//         "release/TangoTransportTrackerRichPresence.exe",
//         "assets/vtrpc.ico",
//         "ICONGROUP",
//         "MAINICON",
//         0],
//     (err, stdout, stderr) => {
//         if (err) {
//             console.log(err.stack);
//         }
//         console.log('Child Process STDOUT: ' + stdout); console.log('Child Process STDERR: ' + stderr);
//     });



