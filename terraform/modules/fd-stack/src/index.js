export const handler = async (event) => {
  console.log(`Running app version: ${process.env.version} on environment ${process.env.environment}...`)
};
