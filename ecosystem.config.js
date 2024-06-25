module.exports = {
  apps: [
    {
      name: 'nextjs-app',
      script: 'yarn',
      args: 'start',
      env: {
        NODE_ENV: 'development',
        PORT: 3000, // Specify the port for development
      },
      env_production: {
        NODE_ENV: 'production',
        PORT: 3000, // Specify the port for production
      },
    },
  ],
};
