
// TODO(rms): this code is in javascript because if we use `window.onMessage`
// from a Dart `main` function we miss early messages; open a dartbug on that.
// Also, if we made it a Dart file we'd need to process it through dart2js.
window.addEventListener("message", function(event) {
    event.source.postMessage('echo: ' + event.data, event.origin);
});
