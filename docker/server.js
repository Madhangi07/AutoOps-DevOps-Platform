const express = require('express');
const os = require('os');
const app = express();

app.get('/', (req, res) => {
  const data = {
    hostname: os.hostname(),
    platform: os.platform(),
    uptime_seconds: os.uptime(),
    cpu_count: os.cpus().length,
    total_memory_gb: (os.totalmem() / 1e9).toFixed(2),
    free_memory_gb: (os.freemem() / 1e9).toFixed(2),
    load_average: os.loadavg()
  };

  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>AutoOps Dashboard</title>
      <style>
        body { font-family: Arial; background: #0f0f0f; color: #00ff88; padding: 40px; }
        h1 { color: #00ff88; }
        .card { background: #1a1a1a; border: 1px solid #00ff88; 
                border-radius: 8px; padding: 20px; margin: 10px 0; }
        .label { color: #888; font-size: 13px; }
        .value { font-size: 22px; font-weight: bold; }
      </style>
    </head>
    <body>
      <h1>🚀 AutoOps — System Metrics Dashboard</h1>
      <div class="card"><div class="label">Hostname</div>
        <div class="value">${data.hostname}</div></div>
      <div class="card"><div class="label">Platform</div>
        <div class="value">${data.platform}</div></div>
      <div class="card"><div class="label">Uptime</div>
        <div class="value">${Math.floor(data.uptime_seconds / 60)} minutes</div></div>
      <div class="card"><div class="label">CPU Cores</div>
        <div class="value">${data.cpu_count}</div></div>
      <div class="card"><div class="label">Total Memory</div>
        <div class="value">${data.total_memory_gb} GB</div></div>
      <div class="card"><div class="label">Free Memory</div>
        <div class="value">${data.free_memory_gb} GB</div></div>
      <div class="card"><div class="label">Load Average</div>
        <div class="value">${data.load_average.map(l => l.toFixed(2)).join(' | ')}</div></div>
    </body>
    </html>
  `);
});

app.listen(3001, () => console.log('AutoOps Dashboard running on port 3001'));