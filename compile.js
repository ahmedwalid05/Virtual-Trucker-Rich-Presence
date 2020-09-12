// VIRTUAL TRUCKER RICH PRESENCE

const {
  compile
} = require('nexe')

compile({
  input: './index.js',
  name: './release/TangoTransportTrackerRichPresence',
  ico: './assets/vtrpc.ico',
  build: false,
  // verbose: true, 
  resources: [
    './*',
    './node_modules/**'
  ]
}).then(() => {
  console.log('success')
})

