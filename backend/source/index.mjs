export const handler = async (event) => {
    console.log(event)
    const body = JSON.parse(event.body)
    const name = body?.name ? body.name : 'Alien';
    
    const response = {
      statusCode: 200,
      body: JSON.stringify('Hello ' + name),
    };
    return response;
  };
  