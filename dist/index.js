// src/index.ts
var PUBLIC_PATH = "./public";
process.on("SIGTERM", () => {
  console.log("Received exit signal SIGTERM, exiting...");
  process.exit(0);
});
var server = Bun.serve({
  port: 8080,
  async fetch(request) {
    let path = `${PUBLIC_PATH}${new URL(request.url).pathname}`;
    if (path.endsWith("/")) {
      path = `${path}index.html`;
    }
    console.log(`serving file: ${path}`);
    const file = Bun.file(path);
    return new Response(file);
  },
  error() {
    return new Response("not found", { status: 404 });
  }
});
console.log(`Listening on ${server.url}`);
