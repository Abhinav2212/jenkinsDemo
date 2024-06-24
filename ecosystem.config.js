module.exports = {
    apps: [
      {
        name: 'nextjs-app',
        script: 'yarn',
        args: 'start',
        env: {
          NODE_ENV: 'development',
        },
        env_production: {
          NODE_ENV: 'production',
        },
      },
    ],
  };
  