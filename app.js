const http = require('http');

const server = http.createServer((req, res) => {
  res.end(`Hello, World!
    When you are evolving to your higher self, the road seems lonely.
    But you're simply shedding energies that no longer match the frequency of your destiny💞`);
});

server.listen(3000, () => {
  console.log('Server is running on port 3000');
});
